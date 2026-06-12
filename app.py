from flask import Flask, Response, jsonify
import psycopg2

app = Flask(__name__)

# Tu configuración directa
mi_conexion = {
    "dbname": "tungtech",
    "user": "postgres",
    "password": "tungtungtech",
    "host": "localhost"
}

# 1. Endpoint del CRUD (Se hace con POST porque inserta datos)
@app.route('/api/registrar_venta', methods=['POST'])
def registrar_venta():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    
    try:
        cursor.execute("BEGIN;")
        
        # Inserta factura
        cursor.execute("INSERT INTO cabecera_venta (fecha, total, id_cli, id_emp, id_suc) VALUES ('2026-06-11', 3500, 1, 1, 1) RETURNING id_venta;")
        id_venta = cursor.fetchone()[0]
        
        # Inserta detalle
        cursor.execute(f"INSERT INTO detalle_venta (cantidad, precio_unitario, id_smart, id_venta) VALUES (1, 3500, 1, {id_venta});")
        
        # Actualiza stock
        cursor.execute("UPDATE smartphone SET stock = stock - 1 WHERE id_smart = 1;")
        
        cursor.execute("COMMIT;")
        return jsonify({"mensaje": "Todo salio bien, se actualizaron las 3 tablas."})
        
    except Exception as e:
        cursor.execute("ROLLBACK;")
        return jsonify({"error": str(e)})
    finally:
        cursor.close()
        conexion.close()

# 2. Endpoint del Reporte (Se hace con GET para poder abrirlo en el navegador)
@app.route('/api/exportar_reporte', methods=['GET'])
def exportar_reporte():
    conexion = psycopg2.connect(**mi_conexion)
    cursor = conexion.cursor()
    
    consulta = """
        SELECT m.nombre, SUM(d.cantidad), SUM(d.cantidad * d.precio_unitario)
        FROM marca m
        JOIN smartphone s ON m.id_marca = s.id_marca
        JOIN detalle_venta d ON s.id_smart = d.id_smart
        GROUP BY m.nombre
        HAVING SUM(d.cantidad * d.precio_unitario) > 1000;
    """
    cursor.execute(consulta)
    filas = cursor.fetchall()
    conexion.close()
    
    # Armamos el texto del CSV a mano (estilo principiante)
    texto_csv = "Marca,Total_Equipos_Vendidos,Ingresos_Totales\n"
    for fila in filas:
        texto_csv += f"{fila[0]},{fila[1]},{fila[2]}\n"
    
    # Le decimos a Flask que devuelva esto como un archivo descargable
    return Response(
        texto_csv,
        mimetype="text/csv",
        headers={"Content-disposition": "attachment; filename=reporte_basico.csv"}
    )

if __name__ == '__main__':
    app.run(port=5000)