## Criando a imagem

```
docker build . -t openvino
```

## Instanciando o container

```
docker run -it openvino
docker run -it --privileged=true openvino
```

## Definindo variáveis de ambiente

```
~/# sh env_config_variables.sh
/opt/intel/openvino

~/# source $OPEN_VINO_PATH/bin/setupvars.sh
~/# source ~/.bashrc
```

## Executando o exemplo

```
~/# python3 vino_python.py

```
