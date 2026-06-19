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
        cursor.execute("BEGIN;")
        # factura
        cursor.execute("INSERT INTO cabecera_venta (fecha, total, id_cli, id_emp, id_suc) VALUES ('2026-06-11', 3500, 1, 1, 1) RETURNING id_venta;")
        id_venta = cursor.fetchone()[0]
        # detalle
        cursor.execute(f"INSERT INTO detalle_venta (cantidad, precio_unitario, id_smart, id_venta) VALUES (1, 3500, 1, {id_venta});")
        # stock
        cursor.execute("UPDATE smartphone SET stock = stock - 1 WHERE id_smart = 1;")
        cursor.execute("COMMIT;")
        return jsonify({"mensaje": "Todo salio bien, se actualizaron las 3 tablas."})
    except Exception as e:
        cursor.execute("ROLLBACK;")
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

#endpoint para el EXPLAIN
@app.route('/api/explicar_rendimiento', methods=['GET'])
def explicar_rendimiento():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    consulta = """
        EXPLAIN ANALYZE
        SELECT m.nombre, s.modelo, s.especificaciones, SUM(d.cantidad), SUM(d.cantidad * d.precio_unitario)
        FROM marca m
        JOIN smartphone s ON m.id_marca = s.id_marca
        JOIN detalle_venta d ON s.id_smart = d.id_smart
        GROUP BY m.nombre, s.modelo, s.especificaciones
        HAVING SUM(d.cantidad * d.precio_unitario) > 1000;
    """
    cursor.execute(consulta)
    plan_ejecucion = cursor.fetchall()
    conexion.close()
    resultado_texto = "Plan de Ejecucion con Detalles:\n\n"
    for fila in plan_ejecucion:
        resultado_texto += fila[0] + "\n"
    return Response(resultado_texto, mimetype="text/plain")
    #Link para descargar reporte 
    #http://127.0.0.1:5000/api/exportar_reporte

if __name__ == '__main__':
    app.run(port=5000)