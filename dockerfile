FROM ubuntu:16.04
ENV http_proxy $HTTP_PROXY
ENV https_proxy $HTTPS_PROXY
ARG OPEN_VINO_PATH=/opt/intel/openvino
ARG VINO_DOWNLOADER_PATH=$OPEN_VINO_PATH/deployment_tools/tools/model_downloade
ARG VINO_MODEL_OPTIMIZER_PATH=$OPEN_VINO_PATH/deployment_tools/model_optimizer
ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/15792/l_openvino_toolkit_p_2019.2.275.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer
COPY src/. /root/.
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    cpio \
    sudo \
    lsb-release && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p $TEMP_DIR && cd $TEMP_DIR && \
    wget -c $DOWNLOAD_LINK && \
    tar xf l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg && \
    rm -rf $TEMP_DIR
RUN $INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh
# build Inference Engine samples
RUN mkdir $INSTALL_DIR/deployment_tools/inference_engine/samples/build && cd $INSTALL_DIR/deployment_tools/inference_engine/samples/build && \
    /bin/bash -c "source $INSTALL_DIR/bin/setupvars.sh && cmake .. && make -j1"

RUN cd /tmp/ && \
    wget https://github.com/libusb/libusb/archive/v1.0.22.zip && \
    unzip v1.0.22.zip && cd libusb-1.0.22 && \
    ./bootstrap.sh && \
    ./configure --disable-udev --enable-shared && \
    make -j4 && make install && \
    rm -rf /tmp/*

RUN alias vino_downloader=$VINO_DOWNLOADER_PATH/downloader.py  && \
    alias mo_caffe=$VINO_MODEL_OPTIMIZER_PATH/mo_caffe.py  && \
    alias mo_tf=$VINO_MODEL_OPTIMIZER_PATH/mo_tf.py  && \
    alias mo_maxnet=$VINO_MODEL_OPTIMIZER_PATH/mo_maxnet.py  && \
    alias mo_onnx=$VINO_MODEL_OPTIMIZER_PATH/mo_onnx.py  && \
    alias mo_kaldi=$VINO_MODEL_OPTIMIZER_PATH/mo_kaldi.py &&\
    source $OPEN_VINO_PATH/bin/setupvars.sh


WORKDIR /root/.
RUN apt-get install python3-pip -y && \
    pip3 install setuptools wheel opencv-python