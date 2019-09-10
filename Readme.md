## Criando a imagem

```
docker build . -t openvino
```

## Instanciando o container

```
docker run -it openvino

# MODO Movidius™ Neural Compute Stick
xhost +
docker run -it --privileged=true --network="host" -v /dev:/dev -e DISPLAY = $DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix openvino
```

## Definindo variáveis de ambiente

```
~/# sh env_config_variables.sh
/opt/intel/openvino

~/# source ~/.bashrc
~/# cd /opt/intel/openvino/install_dependencies
~/# sudo -E ./install_openvino_dependencies.sh
~/# cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
~/# sudo ./install_prerequisites.sh
```

## Executando o exemplo

```
~/# python3 vino_python.py

```
