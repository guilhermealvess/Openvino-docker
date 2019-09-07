## Criando a imagem

```
docker build . -t openvino
```

## Instanciando o container

```
docker run -it openvino

# MODO Movidius™ Neural Compute Stick
docker run -it --privileged=true openvino --network=host
```

## Definindo variáveis de ambiente

```
~/# sh env_config_variables.sh
/opt/intel/openvino

~/# source ~/.bashrc
~/# sh /opt/intel/openvino/install_dependencies/install_NCS_udev_rules.sh
```

## Executando o exemplo

```
~/# python3 vino_python.py

```
