
--Primera entidad: Cargo DL
CREATE TABLE cargo (
    id_cargo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
); 

--Segunda entidad: Cliente DL
CREATE TABLE cliente (
    id_cli SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(200)
);

--Tercera entidad: Proveedor DL
CREATE TABLE proveedor (
    id_prov SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ruc VARCHAR(11) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(200)
);