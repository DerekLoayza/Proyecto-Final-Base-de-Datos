-- 1ra entidad: Cargo DL
CREATE TABLE cargo (
    id_cargo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);
-- 2da entidad: Cliente DL
CREATE TABLE cliente (
    id_cli SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(200)
);
-- 3era entidad: Proveedor DL
CREATE TABLE proveedor (
    id_prov SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ruc VARCHAR(11) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(200)
);
-- 4ta entidad: Categoría
CREATE TABLE categoria(
    id_cat INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);
-- 5ta entidad: Marca
CREATE TABLE marca(
    id_marca INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);
-- 6ta entidad: Smartphone
CREATE TABLE smartphone(
    id_smart SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0 NOT NULL,
    especificaciones TEXT,
    -- llaves foráneas
    id_marca INT,
    id_cat INT
);
-- 7ma entidad: Sucursal
CREATE TABLE sucursal(
    id_suc SERIAL PRIMARY KEY,  
    nombre VARCHAR(50) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE
);
-- 8va entidad: Empleado
CREATE TABLE empleado(
    id_emp SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(10) NOT NULL UNIQUE,
    -- llaves foráneas
    id_suc INT NOT NULL,
    id_cargo INT NOT NULL
);
-- 9na entidad: Cabecera_venta
CREATE TABLE cabecera_venta(
    id_venta SERIAL PRIMARY KEY,
    fecha DATE,
    total INT NOT NULL,
    -- llaves foráneas
    id_cli INT NOT NULL,
    id_emp INT NOT NULL,
    id_suc INT NOT NULL
);
-- 10ma entidad: Detalle_venta
CREATE TABLE detalle_venta(
    id_detalle SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario INT NOT NULL,
    -- llaves foráneas
    id_smart INT NOT NULL,
    id_venta INT NOT NULL
);
-- 11ava entidad: Metodo_pago
CREATE TABLE metodo_pago(
    id_mpago SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);
-- 12ava entidad: pago_venta
CREATE TABLE pago_venta (
    id_pago SERIAL PRIMARY KEY,
    monto DECIMAL(12,2) NOT NULL,
    -- llaves foráneas (hereda de la factura de venta y del metodo de pago)
    id_venta INT NOT NULL,
    id_mpago INT NOT NULL
);
-- 13ava entidad: garantía
CREATE TABLE garantia (
    id_gar SERIAL PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    condiciones TEXT,
    -- llave foránea (hereda del detalle de venta)
    id_detalle INT NOT NULL
);
-- 14ava entidad: cabecera_compra
CREATE TABLE cabecera_compra (
    id_compra SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    total DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    -- llaves foráneas (hereda de proveedor y sucursal)
    id_prov INT NOT NULL,
    id_suc INT NOT NULL
);
-- 15ava entidad: detalle_compra
CREATE TABLE detalle_compra (
    id_detalle_c SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    -- llaves foráneas (hereda de la compra y del celular)
    id_compra INT NOT NULL,
    id_smart INT NOT NULL
);


