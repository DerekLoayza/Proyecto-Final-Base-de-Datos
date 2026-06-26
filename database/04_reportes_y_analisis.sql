-- -------
-- Índices
-- -------
CREATE INDEX idx_smartphone_id_marca
ON smartphone(id_marca);
CREATE INDEX idx_detalleventa_id_smart
ON detalle_venta(id_smart);
CREATE INDEX idx_cabeceraventa_id_cli
ON cabecera_venta(id_cli);
CREATE INDEX idx_cabeceracompra_id_prov
ON cabecera_compra(id_prov);
CREATE INDEX idx_empleado_id_suc
ON empleado(id_suc);
-- ---------------
-- Explain Analize
-- ---------------
EXPLAIN ANALYZE
SELECT *
FROM smartphone
WHERE id_marca = 1;
EXPLAIN ANALYZE
SELECT *
FROM cabecera_venta
WHERE id_cli = 1;
EXPLAIN ANALYZE
SELECT *
FROM cabecera_compra
WHERE id_prov = 3;
EXPLAIN ANALYZE
SELECT modelo, precio
FROM smartphone
WHERE id_cat = 2;
EXPLAIN ANALYZE
-- --------
-- Reportes
-- --------
SELECT
    m.nombre AS marca,
    SUM(d.cantidad) AS total_equipos_vendidos,
    SUM(d.cantidad * d.precio_unitario) AS ingresos_totales
FROM MARCA m
JOIN SMARTPHONE s ON m.id_marca = s.id_marca
JOIN DETALLE_VENTA d ON s.id_smart = d.id_smart
GROUP BY m.nombre
HAVING SUM(d.cantidad * d.precio_unitario) > 1000;
-- Smartphone disponibles
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
ORDER BY m.nombre, s.modelo;
