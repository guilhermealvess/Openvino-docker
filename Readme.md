## Criando a imagem

```
docker build . -t openvino
```

## Instanciando o container

**MODO Movidius™ Neural Compute Stick**

Rodar a sequência de comandos:

```
xhost +
```

```
docker run -it --privileged=true --network=host -v /dev:/dev openvino
```

## Dentro do container

Sequência de comandos:

```
cd ~

source env_config_variables.sh
```

Será perguntado pela pasta base do openvino. Está instalada no caminho:

```
/opt/intel/openvino
```

Scripts de instalação de dependências:

```
cd /opt/intel/openvino/install_dependencies

sudo -E ./install_openvino_dependencies.sh
source install_NCS_udev_rules.sh
source install_NEO_OCL_driver.sh

cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites

sudo -E ./install_prerequisites.sh
```

## Executando o exemplo

```
cd ~

python3 vino_python.py

```
