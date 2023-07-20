# Ejecutar el script ```repositories_init.sh```

Este script descarga los repositorios de las apps del sistema.

Va a crear la carpeta ```/app``` y dentro ```/admin_app``` y ```/erp_api```.

# Construir las imagenes de los contenedores.

```docker-compose build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) ```

# Instalar el node_modules usando el node de los contenedores:

```docker-compose run --rm erp_api npm install```

```docker-compose run --rm admin_app npm install```

# Despues de instalar las librerias, levantar el proyecto con:

```docker-compose up```