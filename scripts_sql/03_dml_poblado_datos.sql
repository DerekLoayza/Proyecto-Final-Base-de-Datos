-- Inserts básicos de prueba 
INSERT INTO SMARTPHONE (id_smart, modelo, precio, stock, especificaciones, id_marca, id_cat) 
VALUES (1, 'Galaxy S24', 3500.00, 20, '256GB, 8GB RAM', 1, 1);





















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
