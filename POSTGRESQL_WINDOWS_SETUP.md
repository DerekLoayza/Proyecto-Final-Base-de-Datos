# 1er Paso: Instalación de PostgreSQL
1. Descargar PostgreSQL desde la página oficial:
   https://www.postgresql.org/download/windows/
2. Ejecutar el instalador.
3. Durante la instalación:
   - Seleccionar:
     - PostgreSQL Server
     - pgAdmin 4
     - Command Line Tools
   - Elegir una contraseña para el usuario `postgres`.
   - Mantener el puerto por defecto (`5432`).
4. Finalizar la instalación.
# 2do Paso: Validación del servidor PostgreSQL
Verificar que el servicio esté en ejecución.
## Opción A: Desde Servicios de Windows
1. Presionar `Win + R`.
2. Escribir:
   ```
   services.msc
   ```
3. Buscar el servicio:
   ```
   postgresql-x64-XX
   ```
   (XX corresponde a la versión instalada).
4. Verificar que el estado sea **Running**.
## Opción B: Desde CMD
```cmd
sc query postgresql-x64-XX
```
# 3er Paso: Conexión a PostgreSQL
Abrir **SQL Shell (psql)**.
Ingresar los siguientes datos (presionar Enter para aceptar los valores por defecto cuando corresponda):
```
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password:
```
Si la conexión fue exitosa aparecerá:
```sql
postgres=#
```
# Errores que pueden ocurrir
## Contraseña incorrecta del usuario postgres
Ingresar a PostgreSQL y ejecutar:
```sql
ALTER USER postgres WITH PASSWORD 'tungtungtech';
```
## Autenticación mal configurada
Editar el archivo:
```
C:\Program Files\PostgreSQL\XX\data\pg_hba.conf
```
Cambiar:
```
local   all   postgres                  md5
host    all   all   127.0.0.1/32        md5
host    all   all   ::1/128             md5
```
Por:
```
local   all   postgres                  scram-sha-256
host    all   all   127.0.0.1/32        scram-sha-256
host    all   all   ::1/128             scram-sha-256
```
Guardar los cambios.
Reiniciar el servicio desde **Servicios de Windows** o ejecutar:
```cmd
net stop postgresql-x64-XX
net start postgresql-x64-XX
```
# 4to Paso: Dentro de PostgreSQL
Crear la base de datos:
```sql
CREATE DATABASE tungtech;
```
Salir de PostgreSQL:
```sql
\q
```
# 5to Paso: Importar los archivos SQL
Abrir CMD o PowerShell dentro de la carpeta del proyecto y ejecutar:
```cmd
psql -U postgres -d tungtech -f database\01_ddl_estructura.sql
```
```cmd
psql -U postgres -d tungtech -f database\02_constraints_y_indices.sql
```
```cmd
psql -U postgres -d tungtech -f database\03_dml_poblado_datos.sql
```
```cmd
psql -U postgres -d tungtech -f database\04_reportes_y_analisis.sql
```
# Errores que pueden ocurrir
## Sobreescritura de la base de datos
### A. Eliminar la base de datos y crearla nuevamente
Ingresar a PostgreSQL y ejecutar:
```sql
DROP DATABASE tungtech;
CREATE DATABASE tungtech;
```
Luego repetir el proceso de importación.
### B. Limpiar la base de datos sin eliminarla
Conectarse a la base de datos `tungtech` y ejecutar:
```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```
Luego volver a ejecutar los archivos SQL.
# Nota
Si el comando `psql` no es reconocido, utilizar la ruta completa del ejecutable:
```cmd
"C:\Program Files\PostgreSQL\XX\bin\psql.exe"
```
O agregar la carpeta:
```
C:\Program Files\PostgreSQL\XX\bin
```
a la variable de entorno **PATH** de Windows.
