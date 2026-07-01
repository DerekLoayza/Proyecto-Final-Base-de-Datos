# LINUX
## 1er Paso: Crear el entorno virtual
```bash
python3 -m venv venv
```
## 2do Paso: Activar el entorno virtual
```bash
source venv/bin/activate
```
## 3er Paso: Actualizar pip
```bash
pip install --upgrade pip
```
## 4to Paso: Instalar las dependencias
```bash
pip install flask psycopg2-binary
pip install flask-cors
```
---

# WINDOWS

## 1er Paso: Crear el entorno virtual
```cmd
python -m venv venv
```
## 2do Paso: Activar el entorno virtual
### CMD
```cmd
venv\Scripts\activate
```
### PowerShell
```powershell
venv\Scripts\Activate.ps1
```
## 3er Paso: Actualizar pip
```cmd
python -m pip install --upgrade pip
```
## 4to Paso: Instalar las dependencias
```cmd
pip install flask psycopg2-binary
pip install flask-cors
```
# Errores que pueden ocurrir
## PowerShell no permite ejecutar scripts
Si aparece un error relacionado con la política de ejecución (`ExecutionPolicy`), ejecutar PowerShell como administrador y ejecutar:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Luego volver a activar el entorno:
```powershell
venv\Scripts\Activate.ps1
```
## El comando `python` no es reconocido
Verificar que Python esté instalado y agregado a la variable de entorno **PATH**.
También se puede comprobar la instalación con:
```cmd
python --version
```
o
```cmd
py --version
```
