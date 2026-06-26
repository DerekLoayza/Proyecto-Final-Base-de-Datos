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
-- Stock disponible
SELECT
    id_smart,
    modelo,
    precio,
    stock
FROM smartphone
WHERE stock > 0
ORDER BY modelo;
-- Clientes
SELECT
    id_cli,
    nombre,
    apellido,
    dni
FROM cliente
ORDER BY apellido, nombre;
-- Empleados
SELECT
    e.id_emp,
    e.nombre,
    e.apellido,
    c.nombre AS cargo,
    s.nombre AS sucursal
FROM empleado e
JOIN cargo c
    ON e.id_cargo = c.id_cargo
JOIN sucursal s
    ON e.id_suc = s.id_suc
ORDER BY e.apellido;
-- Sucursales
SELECT
    id_suc,
    nombre
FROM sucursal
ORDER BY nombre;
-- Métodos de pago
SELECT
    id_mpago,
    descripcion
FROM metodo_pago
ORDER BY descripcion;
-- Información del smartphone
SELECT
    modelo,
    precio,
    stock
FROM smartphone
WHERE id_smart = %s;
-- Existencia de un cliente
SELECT
    id_cli,
    nombre,
    apellido
FROM cliente
WHERE dni = %s;
-- Detalle de una venta
SELECT
    dv.id_detalle,
    s.modelo,
    dv.cantidad,
    dv.precio_unitario,
    dv.cantidad * dv.precio_unitario AS subtotal
FROM detalle_venta dv
JOIN smartphone s
    ON dv.id_smart = s.id_smart
WHERE dv.id_venta = %s;
-- Historial de ventas
SELECT
    cv.id_venta,
    cv.fecha,
    cli.nombre || ' ' || cli.apellido AS cliente,
    emp.nombre || ' ' || emp.apellido AS empleado,
    suc.nombre AS sucursal,
    cv.total
FROM cabecera_venta cv
JOIN cliente cli
    ON cv.id_cli = cli.id_cli
JOIN empleado emp
    ON cv.id_emp = emp.id_emp
JOIN sucursal suc
    ON cv.id_suc = suc.id_suc
ORDER BY cv.fecha DESC;