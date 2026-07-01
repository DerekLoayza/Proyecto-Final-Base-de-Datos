
-- =========================================================
-- 🔥 CREATE: VENTA COMPLETA
-- =========================================================
BEGIN;

INSERT INTO cabecera_venta (fecha, total, id_cli, id_emp, id_suc)
VALUES (CURRENT_DATE, 0, 1, 1, 1);

INSERT INTO detalle_venta (cantidad, precio_unitario, id_smart, id_venta)
VALUES (
    2,
    (SELECT precio FROM smartphone WHERE id_smart = 1),
    1,
    (SELECT MAX(id_venta) FROM cabecera_venta)
);

UPDATE smartphone
SET stock = stock - 2
WHERE id_smart = 1;

UPDATE cabecera_venta
SET total = (
    SELECT SUM(cantidad * precio_unitario)
    FROM detalle_venta
    WHERE id_venta = (SELECT MAX(id_venta) FROM cabecera_venta)
)
WHERE id_venta = (SELECT MAX(id_venta) FROM cabecera_venta);

COMMIT;


-- =========================================================
-- 🔥 READ: CONSULTAS (SELECTS)
-- =========================================================

-- Ver smartphones disponibles
SELECT * FROM smartphone;

-- Ver clientes
SELECT * FROM cliente;

-- Ver empleados con sucursal
SELECT e.id_emp, e.nombre, e.apellido, s.nombre AS sucursal
FROM empleado e
JOIN sucursal s ON e.id_suc = s.id_suc;

-- Ver ventas completas
SELECT * FROM cabecera_venta;


-- =========================================================
-- 🔥 UPDATE: ACTUALIZAR VENTA (ejemplo stock + precio)
-- =========================================================

-- cambiar stock de un celular
UPDATE smartphone
SET stock = stock + 5
WHERE id_smart = 1;

-- actualizar precio de un celular
UPDATE smartphone
SET precio = 999.99
WHERE id_smart = 1;

-- actualizar total de una venta
UPDATE cabecera_venta
SET total = 5000
WHERE id_venta = 1;


-- =========================================================
-- 🔥 DELETE: ELIMINAR VENTA COMPLETA
-- =========================================================

BEGIN;

-- devolver stock antes de borrar
UPDATE smartphone s
SET stock = s.stock + dv.cantidad
FROM detalle_venta dv
WHERE dv.id_smart = s.id_smart
  AND dv.id_venta = 1;

-- borrar dependencias primero
DELETE FROM pago_venta
WHERE id_venta = 1;

DELETE FROM detalle_venta
WHERE id_venta = 1;

DELETE FROM cabecera_venta
WHERE id_venta = 1;

COMMIT;


-- =========================================================
-- 🔥 DELETE: ELIMINAR COMPRA COMPLETA
-- =========================================================

BEGIN;

-- revertir stock
UPDATE smartphone s
SET stock = s.stock - dc.cantidad
FROM detalle_compra dc
WHERE dc.id_smart = s.id_smart
  AND dc.id_compra = 1;

DELETE FROM detalle_compra
WHERE id_compra = 1;

DELETE FROM cabecera_compra
WHERE id_compra = 1;

COMMIT;
