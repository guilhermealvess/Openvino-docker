FROM ubuntu:16.04
ENV http_proxy $HTTP_PROXY
ENV https_proxy $HTTPS_PROXY
ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/15792/l_openvino_toolkit_p_2019.2.275.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer
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

WORKDIR /root
COPY src/. /root/.
COPY env_config_variables.sh .
COPY variables.txt .
RUN apt-get install python3-pip -y &&\
    pip3 install setuptools wheel opencv-python &&\
    apt-get install nano

#RUN apt-get install unzip &&\
#    wget https://github.com/libusb/libusb/archive/v1.0.22.zip && \
#    unzip v1.0.22.zip &&\
#    cd libusb-1.0.22 &&\
#    ./bootstrap.sh && \
#    ./configure --disable-udev --enable-shared && \
#    make -j4 && make install && \
#    rm -rf /tmp/*