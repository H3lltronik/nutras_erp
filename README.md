Ejecutar el script ```repositories_init.sh```

Para instalar el vendor usando el node de los contenedores:

```cd apps/erp_api```
```docker-compose run --rm erp_api npm install```

```cd apps/admin_app```
```docker-compose run --rm admin_app npm install```

Construir las imagenes de los contenedores

```docker-compose build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) ```

Despues de instalar las librerias, levantar el proyecto con:

```docker-compose up```