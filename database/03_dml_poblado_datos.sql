-- ---------------------------
-- Poblado de Datos en general
-- ---------------------------
INSERT INTO cargo (nombre)
VALUES ('Vendedor'), ('Administrador');
INSERT INTO cliente (nombre, apellido, dni)
VALUES
    ('Juan', 'Perez', '12345678'),
    ('Aldo', 'Paredes', '78162131'),
    ('Jose', 'Velarde', '48912372'),
    ('Julian', 'Quispe', '08781335'),
    ('Mario', 'Zavala', '18794613');
INSERT INTO proveedor (nombre, ruc)
VALUES ('Dist A', '10000000001'), ('Dist B', '10000000002'), ('Dist C', '10000000003'), ('Dist D', '10000000004'), ('Dist E', '10000000005');
INSERT INTO metodo_pago (descripcion)
VALUES ('Efectivo'), ('Tarjeta'), ('Yape');
-- Poblando tabla categoria
INSERT INTO categoria (id_cat, nombre)
VALUES
    (1, 'Gama Alta'),
    (2, 'Gama Media'),
    (3, 'Gama Baja'),
    (4, 'Gaming'),
    (5, 'Empresarial');
-- Poblando tabla marca
INSERT INTO marca (id_marca, nombre)
VALUES
    (1, 'Samsung'),
    (2, 'Apple'),
    (3, 'Xiaomi'),
    (4, 'Motorola'),
    (5, 'Huawei');
-- Poblando tabla smartphone
INSERT INTO smartphone(modelo, precio, stock, especificaciones, id_marca, id_cat)
VALUES
    ('Galaxy S24 Ultra', 1399.99, 15, '12GB RAM, 512GB, Snapdragon 8 Gen 3', 1, 1),
    ('iPhone 15 Pro', 1499.99, 10, '8GB RAM, 512GB, A17 Pro', 2, 1),
    ('Redmi Note 13 Pro', 449.99, 30, '8GB RAM, 256GB, Snapdragon 7s Gen 2', 3, 2),
    ('Moto G84', 329.99, 25, '12GB RAM, 256GB, Snapdragon 695', 4, 2),
    ('Huawei Nova 12', 599.99, 20, '8GB RAM, 256GB, Kirin', 5, 5);
-- Poblando tabla sucursal
INSERT INTO sucursal (nombre, direccion, telefono)
VALUES
    ('Sucursal Centro', 'Av. Principal 123', '987654321'),
    ('Sucursal Norte', 'Calle Los Pinos 456', '987654322'),
    ('Sucursal Sur', 'Av. Las Flores 789', '987654323'),
    ('Sucursal Este', 'Jr. Los Olivos 321', '987654324'),
    ('Sucursal Oeste', 'Av. Independencia 654', '987654325');
-- Inserts básicos de prueba 
INSERT INTO empleado (nombre, apellido, dni, id_suc, id_cargo)
VALUES
    ('Margarita', 'Perez', '79454612', 1, 1),
    ('Maria', 'Gomez', '23456789', 2, 2),
    ('Carlos', 'Ramirez', '34567890', 3, 1),
    ('Ana', 'Torres', '45678901', 4, 2),
    ('Juan', 'Paredes', '12345678', 5, 1);
-- Datos de prueba para simular una venta y probar el reporte
INSERT INTO cabecera_venta (fecha, total, id_cli, id_emp, id_suc)
VALUES ('2026-06-07 10:00:00', 3500.00, 1, 1, 1);
INSERT INTO detalle_venta (id_venta, id_smart, cantidad, precio_unitario)
VALUES (1, 1, 10, 3500.00);
-- Poblando tabla pago_venta
INSERT INTO pago_venta (monto, id_venta, id_mpago)
VALUES (3500.00, 1, 1);
-- Poblando tabla garantia
INSERT INTO garantia (fecha_inicio, fecha_fin, condiciones, id_detalle)
VALUES ('2026-06-07', '2027-06-07', 'Cubre defectos de fabrica', 1);
-- Poblando tabla cabecera_compra
INSERT INTO cabecera_compra (fecha, total, id_prov, id_suc)
VALUES
    ('2023-10-01', 5000.00, 1, 1),
    ('2023-10-15', 7500.50, 2, 2),
    ('2023-11-05', 3200.00, 3, 3),
    ('2023-11-20', 10500.00, 4, 4),
    ('2023-12-10', 4800.00, 5, 5);
-- Poblando tabla detalle_compra
INSERT INTO detalle_compra (cantidad, precio_unitario, id_compra, id_smart)
VALUES
    (25, 200.00, 1, 1),
    (50, 150.01, 2, 2),
    (32, 100.00, 3, 3),
    (30, 350.00, 4, 4),
    (40, 120.00, 5, 5);
-- -------------
-- Transacciones
-- -------------
BEGIN;
UPDATE smartphone
SET stock = stock - 1
WHERE id_smart = 1;
UPDATE cabecera_venta
SET total = 3499.99
WHERE id_venta = 1;
COMMIT;
-- --------
-- Rollback
-- --------
BEGIN;
UPDATE smartphone
SET stock = 999
WHERE id_smart = 1;
ROLLBACK;
-- -------------------------
-- NoSQL, tipo de dato JSONB
-- -------------------------
-- Creamos tabla "DETALLES" de tipo jsonb 
ALTER TABLE smartphone ADD COLUMN detalles JSONB;
-- LLenamos datos para 3 celulares distintos
UPDATE smartphone 
SET detalles = '{"ram": "12GB", "stylus": true, "procesador": "Snapdragon"}' 
WHERE id_smart = 1;
UPDATE smartphone 
SET detalles = '{"ram": "8GB", "ecosistema": "iOS", "material": "Titanio"}' 
WHERE id_smart = 2;
UPDATE smartphone 
SET detalles = '{"ram": "8GB", "carga_rapida": "67W", "infrarrojo": true}' 
WHERE id_smart = 3;
-- Consulta, ignora todo lo demás excepto ram 
SELECT modelo, detalles->>'ram' AS memoria_ram 
FROM smartphone 
WHERE detalles IS NOT NULL;