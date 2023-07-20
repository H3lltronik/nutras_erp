# ERP Nutribites

## Terminologia:

PRODUCTO DE CATALOGO (PT): La entidad que representa el producto que maneja la empresa. Viene acompañada de un documento de especificacion tecnica (PDF) y RECETA (PDF) y una serie de pasos para la creacion de dicho producto.

PRODUCTO PARCIAL: La entidad que representa un producto en un estado parcial, es decir, a la mitad de un proceso de RECETA.
Estos tambien cuentan con ficha tecnica y RECETA.

MATERIA PRIMA: La entidad que representa los ingredientes necesarios para generar un PRODUCTO PARCIAL o PRODUCTO CATALOGO.
especificacion tecnica (PDF)

SOFT-DELETE: (No podran ser borrados realmente de la DB)

## Descripcion

- Procedimiento para alta de PRODUCTO DE CATALOGO
  - Reconocimiento de pasos de PRODUCTO PARCIAL antes de ser considerado PRODUCTO TERMINADO
- Procedimiento para alta de SUBPRODUCTO (REV)
- Perfiles y permisos basados en roles para el acceso a distintas vistas o procedimientos
  - Perfil Super Administrador
  - Perfil Direccion
  - Perfil Calidad
  - Perfil Produccion
  - Perfil Almacen
- Entidad almacen para relacionar existencia de PRODUCTO TERMINADO en un area
  - Almacen de produccion
  - Almacen general

## Entidades

### PRODUCTO DE CATALOGO

---

## Requerimientos funcionales

### Modulo de permisos

- Un usuario no podra ingresar a ciertas secciones del sistema si sus roles no se lo permiten.
  - Los roles deben ser declarados en el codigo para que al crear un perfil, tenga los roles indicados.
  - Comprobar acceso restringido basado en roles de cadenas de texto
  - Los roles se daran de alta via codigo conforme nuevas secciones se añadan
- Haber un usuario por default (ENV VARS) llamado Super Usuario para asegurar el acceso al panel (opcional)
- Los registros de usuarios tendran SOFT-DELETE (No podran ser borrados realmente de la DB)
- Perfiles:
  - Administrador / Soporte
  - Direccion
  - Produccion
  - Calidad
  - Compras
  - Auxiliar de direccion
  - Comodin
  - Almacen

### Modulo de usuarios

- Modulo para el alta de credenciales de un usuario y un perfil.

### Modulo de Catalogos de Productos

- Un usuario con perfil DIRECCION, y PRODUCCION pueden dar de alta, todos los demas podra entrar a esta seccion solo consulta.
- Seccion para dar de alta PRODUCTO CATALOGO
  - Obligatoriamente se tendra que subir tambien un archivo de especificacion de producto (PDF) [Opcional para Direccion] PRODUCCION, CALIDAD
  - Obligatoriamente se tendra que subir tambien un archivo de RECETA (PDF) [Opcional para Direccion] PRODUCCION, CALIDAD
  - Llenar el formulario para la generacion de la RECETA y sus correspondientes PASOS DE RECETA
- Seccion para dar de alta PRODUCTO PARCIAL
  - Obligatoriamente se tendra que subir tambien un archivo de especificacion de producto (PDF) [Opcional para Direccion] PRODUCCION, CALIDAD
  - Obligatoriamente se tendra que subir tambien un archivo de RECETA (PDF) [Opcional para Direccion] PRODUCCION, CALIDAD
  - Llenar el formulario para la generacion de la RECETA y sus correspondientes PASOS DE RECETA
- Seccion para dar de alta MATERIA PRIMA
  - Obligatoriamente se tendra que subir tambien un archivo de especificacion de producto (PDF) [Opcional para Direccion] PRODUCCION, CALIDAD

### Ejemplo

Producto: Dontas
Debe tener: Receta y ficha tecnica, nombre de producto, codigo de producto y sus codigos de lotes.

### Generacion de lotes (Alta de productos)

Este escrito busca describir la funcionalidad de los lotes, no se trata de un modulo independiente.
La generacion de lotes estara dentro de la creacion de PRODUCTO PARCIAL / CATALOGO.

- Alta de lotes
  - Solo un usuario con perfil ALMACEN, PRODUCCION podra acceder a esta seccion. Habra un formulario a llenar para dar de alta los lotes.
    - Seleccion de PRODUCTO que contiene (PRODUCTO PARCIAL, PRODUCTO CATALOGO, MATERIA PRIMA)
    - Campo para codigo (001-ABC)
    - Estatus del producto (CONFORME, NO CONFORME, RECUPERADO CONFORME, RECUPERADO NO CONFORME) *REV

Si se selecciona como estatus del producto RECUPERADO CONFORME: * REV

### Modulo de Etiquetas

- Seccion en el administrador con acceso solo a usuarios con perfil CALIDAD y ALMACEN
- Llenar un formulario para generar la etiqueta imprimible.
  1. Se seleccionara un PRODUCTO de una lista desplegable. (Primero se selecciona este, despues muestra sus lotes)
     - Boton + para crear un producto nuevo (Si el producto no esta en la lista)
  2. Se seleccionara un lote de una lista desplegable.
     - Boton + para crear un lote nuevo (Si el lote no esta en la lista) (Inferir producto al mandarlo a crear lote)
  - Al llenar el formulario y enviarlo, se generara un codigo QR / Codigo de barras que se ingresara en un PDF mas la informacion de lote / producto

Existen dos tipos de etiqueta, la descrita anteriormente es una etiqueta "General" y de "OTs".
Las de "OTs" son etiquetas que solo un usuario con perfil PRODUCCION puede generar.
La etiqueta debe decir: "OT: numero_de_OT"

El formulario para este tipo de etiqueta sera:

- Selector de OTs
  - Solo poder seleccionar OTs activas

- Escribir codigo para templates para estos PDFs

### Modulo Direccion

Solo pueden ingresar usuarios con el perfil DIRECCION

#### Submodulo solicitud de direccion

Una solicitud de direccion es un conjunto de OTs.

Se pueden dar de alta multiples OTs por solicitud.

El formulario de la solicitud tendra los siguientes campos:

- Lista dinamica de OTs (generacion de multiples OTs y asignacion con la solicitud)
- Fecha estimada de finalizacion de la solicitud.

#### Submodulo OT

- Una OT por PRODUCTO CATALOGO
- Se llenara un formulario para generar el registro OT. El formulario contendra:
  - Fecha estimada de finalizacion de la OT.
  - Opcion para subida de archivos (FILE MANAGER)
    - Solo el perfil DIRECCION puede hacer subida y consulta de esos archivos
  - Diagrama de gantt * REV
  - Boton para cancelar la OT con confirmacion * REV
  - Selector de PRODUCTO CATALOGO (UNO SOLO)
  - Cantidad de prod (en cantidad de materia)
  - Notas

### Modulo inventario

Se trata casi de una entidad, ya que la misma funcionalidad descrita aplica para el inventario de produccion como el general.

### Registro de eventos

- Hacer registro en alguna tabla o conjunto de tablas los distintos movimientos que ocurren en la plataforma. El objetivo de el almacenamiento de estos eventos en general es para el requerimiento de TRAZABILIDAD y REPORTES ya que facilitara la obtencion de datos para reportes al tratarse de una tabla de historicos. Por eso mismo, esta tabla o conjunto de tablas tendra que tener indices bien establecidos para asegurar la velocidad de queries. Algunos de los eventos son:
  - Subida de archivos a OT
  - Avance de OT
  - Creacion / Edicion de OT
  - Generacion de codigo QR / Barras
  - Alta de PRODUCTO CATALOGO / PARCIAL
  - Etiquetado
  - Generacion de PDF (ORDENES DE COMPRA, REQUISICION DE MATERIALES, etc)
  - Registro de login

## NOTAS

- los subproductos serán dados de alta en algún panel del administrador y buscarían representar todos los productos parciales que tengan en su catálogo industrial.
- El lote es un codigo, este codigo puede ser el mismo para dos lotes y estos dos lotes podrian tener PRODUCTO distinto, como DONAS y CEREAL
- Validaciones robustas en formularios

### Subsistema de recetas / procedimientos / pasos de productos

Los PRODUCTOS CATALOGO y PRODUCTOS PARCIALES no son mas que el resultado de un conjunto de procedimientos previos. Por ejemplo, podriamos tener dado de alta un PRODUCTO PARCIAL llamado _masa_ el cual es el resultado de haber combinado las MATERIAS PRIMAS _agua_ y _harina_.

En la especificacion del producto _masa_ se definen con exactitud la cantidad de materia para producir una determinada cantidad de _masa_.

Ejemplo:

```markdown
# Masa

paso 1:
- 10 ml de agua
- 100 g de harina

Mezclarlas
```

Estos "Pasos" deberan ser mapeados por alguien a traves de una interfaz ya que es importante identificar el inter de cada paso dentro de la elaboracion de cualquier producto, debido a que en dicho inter ocurre algo llamado ETIQUETACION en donde se le asigna un codigo de barras nuevo al PRODUCTO PARCIAL / CATALOGO que se haya producido.

- Debera haber un procedimiento abstracto para la identificacion de pasos necesarios para la elaboracion de un PRODUCTO CATALOGO Y PRODUCTO PARCIAL.
  
## PENDIENTE

- Definir el procedimiento de rollback para el inventario, lotes, etc cuando una OT es cancelada.
  

  1:57

- Obtencion de materias primas
- Combinar materias primas haciendo PP
- Embasado (Ahora si PT)


Step 1, avance relativo a la cantidad de OCs
Step 2, es un total o no, no hay receta.
Step 3, es un total o no



SI PIDEN UN PRODUCTO CON UNA FORMA DISTINTA O COLOR, TIENEN QUE DAR DE ALTA EN EL CATALOGO?