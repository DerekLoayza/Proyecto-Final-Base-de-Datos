# 1er Paso: Instalación de PostgreSQL
sudo dnf install postgresql postgresql-server postgresql-contrib
# 2do Paso: Inicialización de la base de datos
sudo postgresql-setup --initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql
## Extra (validación del servidor PostgreSQL)
sudo systemctl status postgresql
# Errores que pueden ocurrir
## Autenticación mal configurada (Ident authentication failed / Peer authentication failed)
### 1. Ingresar como el usuario postgres
```bash
sudo -u postgres psql
```
### 2. Asignar una contraseña al usuario postgres
```sql
ALTER USER postgres WITH PASSWORD 'tungtungtech';
```
### 3. Configurar la autenticación
Editar el archivo:
```bash
/var/lib/pgsql/data/pg_hba.conf
```
Cambiar:
```conf
local   all   postgres                         ident
host    all   all   127.0.0.1/32               ident
host    all   all   ::1/128                    ident
```
Por:
```conf
local   all   postgres                         scram-sha-256
host    all   all   127.0.0.1/32               scram-sha-256
host    all   all   ::1/128                    scram-sha-256
```
Reiniciar PostgreSQL:
```bash
sudo systemctl restart postgresql
```
### 4. Probar la conexión
```bash
psql -U postgres -h localhost -W
```
# 3er Paso: Dentro de PostgreSQL
Crear la base de datos:

```sql
CREATE DATABASE tungtech;
```
Salir de PostgreSQL:
```sql
\q
```
# 4to Paso: Importar los archivos SQL
```bash
psql -U postgres -d tungtech -f database/01_ddl_estructura.sql
```
```bash
psql -U postgres -d tungtech -f database/02_constraints_y_indices.sql
```
```bash
psql -U postgres -d tungtech -f database/03_dml_poblado_datos.sql
```
```bash
psql -U postgres -d tungtech -f database/04_reportes_y_analisis.sql
```
# Errores que pueden ocurrir
## Sobreescritura de la base de datos
### A. Eliminar la base de datos y crearla nuevamente
```sql
DROP DATABASE tungtech;
```
Luego repetir desde el **3er Paso**.
### B. Limpiar la base de datos sin eliminarla
```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```
Luego volver a importar los archivos SQL.
