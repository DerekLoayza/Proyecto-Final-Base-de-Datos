from flask import Flask, Response, jsonify
from flask_cors import CORS
import psycopg2
app = Flask(__name__)
CORS(app)
# Datos
#Para descargar Python en la pc usamos //python -m pip install flask psycopg2-binary
mi_conexion = {
    "dbname": "tungtech",
    "user": "postgres",
    "password": "tungtungtech",
    "host": "localhost"
}

# 1 endpoint CRUD 
@app.route('/api/registrar_venta', methods=['POST'])
def registrar_venta():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    try: 
        # cursor.execute("BEGIN;")
        # Es mejor no utilizar BEGIN, como en sql utilizamos las funciones de psycopg2
        # factura
        cursor.execute("INSERT INTO cabecera_venta (fecha, total, id_cli, id_emp, id_suc) VALUES ('2026-06-11', 3500, 1, 1, 1) RETURNING id_venta;")
        fila = cursor.fetchone()
        if fila is None:
            raise Exception("No se pudo obtener id_venta")
        id_venta = fila[0]
        # id_venta = cursor.fetchone()[0] no utilizamos porque:
        # El insert no retorna nada
        # o falla el returning y fetchone() devuelve None
        # detalle
        cursor.execute(f"INSERT INTO detalle_venta (cantidad, precio_unitario, id_smart, id_venta) VALUES (1, 3500, 1, {id_venta});")
        # stock
        cursor.execute("UPDATE smartphone SET stock = stock - 1 WHERE id_smart = 1;")
        # cursor.execute("COMMIT;")
        conexion.commit()
        # No COMMIT como sql, sino commit por psycopg2 
        return jsonify({"mensaje": "Todo salio bien, se actualizaron las 3 tablas."})
    except Exception as e:
        # cursor.execute("ROLLBACK;")
        conexion.rollback()
        # No ROLLBACK como sql, sino commit por psycopg2 
        return jsonify({"error": str(e)})
    finally:
        cursor.close()
        conexion.close()

# 2 endpoint reporte, Get ayuda a abrirlo en la web
@app.route('/api/exportar_reporte', methods=['GET'])
def exportar_reporte():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    consulta = """
        SELECT m.nombre, s.modelo, s.especificaciones, SUM(d.cantidad), SUM(d.cantidad * d.precio_unitario)
        FROM marca m
        JOIN smartphone s ON m.id_marca = s.id_marca
        JOIN detalle_venta d ON s.id_smart = d.id_smart
        GROUP BY m.nombre, s.modelo, s.especificaciones
        HAVING SUM(d.cantidad * d.precio_unitario) > 1000;
    """
    cursor.execute(consulta)
    filas = cursor.fetchall()
    conexion.close()
    # imprimimos el texto
    texto_csv = "Marca,Modelo,Especificaciones,Total_Equipos_Vendidos,Ingresos_Totales\n"
    for fila in filas:
        texto_csv += f"{fila[0]},{fila[1]},{fila[2]},{fila[3]},{fila[4]}\n"
    # descarga
        return Response(
        texto_csv,
        mimetype="text/csv",
        headers={"Content-disposition": "attachment; filename=reporte_basico.csv"}
    )
# 3 endpoint smartphones disponibles
@app.route('/api/smartphones', methods=['GET'])
def get_smartphones():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    try:
        cursor.execute("""
            SELECT 
                s.id_smart,
                m.nombre AS marca,
                s.modelo,
                c.nombre AS categoria,
                s.precio,
                s.stock
            FROM smartphone s
            JOIN marca m
                ON s.id_marca = m.id_marca
            JOIN categoria c
                ON s.id_cat = c.id_cat
        """)
        filas = cursor.fetchall()
        resultado = []
        for f in filas:
            resultado.append({
                "id": f[0],
                "marca": f[1],
                "modelo": f[2],
                "categoria": f[3],
                "precio": f[4],
                "stock": f[5]
            })
        return jsonify(resultado)
    finally:
        cursor.close()
        conexion.close()
# 4 endpoint clientes
@app.route('/api/clientes', methods=['GET'])
def get_clientes():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    try:
        cursor.execute("""
            SELECT id_cli, nombre, apellido, telefono
            FROM cliente;
        """)
        filas = cursor.fetchall()
        return jsonify([
            {
                "id": f[0],
                "nombre": f[1],
                "apellido": f[2],
                "telefono": f[3]
            }
            for f in filas
        ])
    finally:
        cursor.close()
        conexion.close()
# 5 endpoint empleados
@app.route('/api/empleados', methods=['GET'])
def get_empleados():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    try:
        cursor.execute("""
            SELECT 
                e.id_emp,
                e.nombre,
                e.apellido,
                c.nombre AS cargo,
                s.nombre AS sucursal
            FROM empleado e
            JOIN cargo c ON e.id_cargo = c.id_cargo
            JOIN sucursal s ON e.id_suc = s.id_suc;
        """)
        filas = cursor.fetchall()
        return jsonify([
            {
                "id": f[0],
                "nombre": f[1],
                "apellido": f[2],
                "cargo": f[3],
                "sucursal": f[4]
            }
            for f in filas
        ])
    finally:
        cursor.close()
        conexion.close()
# 6 endpoint sucursales
@app.route('/api/sucursales', methods=['GET'])
def get_sucursales():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    try:
        cursor.execute("""
            SELECT id_suc, nombre, direccion
            FROM sucursal;
        """)
        filas = cursor.fetchall()
        return jsonify([
            {
                "id": f[0],
                "nombre": f[1],
                "direccion": f[2]
            }
            for f in filas
        ])
    finally:
        cursor.close()
        conexion.close()
# 7 endpoint stocks
@app.route('/api/stock', methods=['GET'])
def get_stock():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    try:
        cursor.execute("""
            SELECT id_smart, stock
            FROM smartphone;
        """)
        return jsonify([
            {"id": f[0], "stock": f[1]}
            for f in cursor.fetchall()
        ])
    finally:
        cursor.close()
        conexion.close()

#Link para descargar reporte 
#http://127.0.0.1:5000/api/exportar_reporte

if __name__ == '__main__':
    app.run(port=5000)
