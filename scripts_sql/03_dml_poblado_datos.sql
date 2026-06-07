-- Inserts básicos de prueba 
INSERT INTO SMARTPHONE (id_smart, modelo, precio, stock, especificaciones, id_marca, id_cat) 
VALUES (1, 'Galaxy S24', 3500.00, 20, '256GB, 8GB RAM', 1, 1);

INSERT INTO EMPLEADO (id_emp, nombre, apellido, dni, id_suc, id_cargo) 
VALUES (1, 'Juan', 'Perez', '12345678', 1, 1);

-- Datos de prueba para simular una venta y probar el reporte
INSERT INTO CABECERA_VENTA (id_venta, fecha, total, id_cli, id_emp, id_suc)
VALUES (1, '2026-06-07 10:00:00', 3500.00, 1, 1, 1);

INSERT INTO DETALLE_VENTA (id_detalle, id_venta, id_smart, cantidad, precio_unitario)
VALUES (1, 1, 1, 1, 3500.00);

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

-- poblando tabla smartphone
INSERT INTO smartphone(modelo, precio, stock, especificaciones, id_marca, id_cat)
VALUES
    ('Galaxy S24 Ultra', 1399.99, 15, '12GB RAM, 512GB, Snapdragon 8 Gen 3', 1, 1),
    ('iPhone 15 Pro', 1499.99, 10, '8GB RAM, 512GB, A17 Pro', 2, 1),
    ('Redmi Note 13 Pro', 449.99, 30, '8GB RAM, 256GB, Snapdragon 7s Gen 2', 3, 2),
    ('Moto G84', 329.99, 25, '12GB RAM, 256GB, Snapdragon 695', 4, 2),
    ('Huawei Nova 12', 599.99, 20, '8GB RAM, 256GB, Kirin', 5, 5);

-- POblando tabla sucursal
INSERT INTO sucursal (nombre, direccion, telefono)
VALUES
    ('Sucursal Centro', 'Av. Principal 123', '987654321'),
    ('Sucursal Norte', 'Calle Los Pinos 456', '987654322'),
    ('Sucursal Sur', 'Av. Las Flores 789', '987654323'),
    ('Sucursal Este', 'Jr. Los Olivos 321', '987654324'),
    ('Sucursal Oeste', 'Av. Independencia 654', '987654325');

-- Poblando tabla pago_venta
INSERT INTO pago_venta (monto, id_venta, id_mpago)
VALUES 
    (250.50, 101, 101), 
    (440.00, 102, 102), 
    (1002.50, 103, 103), 
    (500.00, 104, 104), 
    (180.50, 105, 102); 

-- Poblando tabla garantia
INSERT INTO garantia (fecha_inicio, fecha_fin, condiciones, id_detalle)
VALUES 
    ('2024-01-10', '2025-01-10', 'Cubre defectos de fabrica del equipo.', 101),
    ('2024-02-15', '2024-08-15', 'Garantia de 6 meses. No cubre pantallas rotas.', 102),
    ('2024-03-20', '2025-03-20', 'Garantia extendida (incluye mantenimiento preventivo)', 103),
    ('2024-04-05', '2025-04-05', 'Cubre fallos de batería y hardware.', 104),
    ('2024-05-12', '2024-11-12', 'Solo reparación técnica autorizada, no reemplazo.', 105);

-- Poblando tabla cabecera_compra
INSERT INTO cabecera_compra (fecha, total, id_prov, id_suc)
VALUES 
    ('2023-10-01', 5000.00, 101, 101),
    ('2023-10-15', 7500.50, 102, 102),
    ('2023-11-05', 3200.00, 103, 103),
    ('2023-11-20', 10500.00, 104, 104),
    ('2023-12-10', 4800.00, 105, 105);

-- Poblando tabla detalle_compra
INSERT INTO detalle_compra (cantidad, precio_unitario, id_compra, id_smart)
VALUES 
    (25, 200.00, 101, 101), 
    (50, 150.01, 102, 102), 
    (32, 100.00, 103, 103), 
    (30, 350.00, 104, 104), 
    (40, 120.00, 105, 105);
