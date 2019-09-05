## Criando a imagem

```
docker build . -t openvino
```

## Instanciando o container

```
docker run -it openvino
docker run --privileged –v /dev:/dev <image_name>
```

## Definindo variáveis de ambiente

```
~/# sh env_config_variables.sh
```

## Executando o exemplo

```
~/# python3 vino_python.py

```
