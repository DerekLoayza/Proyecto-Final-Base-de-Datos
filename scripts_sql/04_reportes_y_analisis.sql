--Reporte
SELECT 
    m.nombre AS marca, 
    SUM(d.cantidad) AS total_equipos_vendidos, 
    SUM(d.cantidad * d.precio_unitario) AS ingresos_totales
FROM MARCA m
JOIN SMARTPHONE s ON m.id_marca = s.id_marca
JOIN DETALLE_VENTA d ON s.id_smart = d.id_smart
GROUP BY m.nombre
HAVING SUM(d.cantidad * d.precio_unitario) > 1000;