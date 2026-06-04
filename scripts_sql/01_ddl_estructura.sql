--Novena entidad: Employees
CREATE TABLE employees(
    id_emp SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(10) NOT NULL UNIQUE,


    --llaves foráneas
    id_suc INT NOT NULL REFERENCES sucursal(id_suc),
    id_cargo INT NOT NULL REFERENCES cargo(id_cargo)
);

--Décima entidad: Cabecera_venta
CREATE TABLE cabecera_venta(
    id_venta SERIAL PRIMARY KEY,
    fecha DATE,
    total INT NOT NULL,


    --llaves foráneas
    id_cli INT NOT NULL REFERENCES cliente(id_cli),
    id_emp INT NOT NULL REFERENCES employees(id_emp),
    id_suc INT NOT NULL REFERENCES sucursal(id_suc)
);

--Undécima entidad: Detalle_venta
CREATE TABLE detalle_venta(
    id_detalle SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario INT NOT NULL,

    --llaves foráneas
    id_smart INT NOT NULL REFERENCES smartphone(id_smart),
    id_venta INT NOT NULL REFERENCES cabecera_venta(id_venta)
);

--Duodécima entidad: Metodo_pago
CREATE TABLE metodo_pago(
    id_mpago SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);
