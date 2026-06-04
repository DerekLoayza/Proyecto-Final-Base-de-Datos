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

-- Tercera entidad: Categoría
CREATE TABLE categoria{
    id_cat INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
};

-- Cuarta entidad: Marca
CREATE TABLE marca{
    id_marca INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
};

-- Quinta entidad: Smartphone
CREATE TABLE smartphone{
    id_smart SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT,
    especificaciones TEXT,
    -- Utilización de claves foráneas
    -- Claves de la tabla marca y categoria
    -- Formas corta
    -- id_marca INT REFERENCES marca(id_marca),
    -- id_cat INT REFERENCES categoria(id_cat)
    -- Forma correcta
    id_marca INT,
    id_cat INT,
    CONSTRAINT fk_smartphone_marca 
        FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
    CONSTRAINT fk_smartphone_categoria 
        FOREIGN KEY (id_cat) REFERENCES categoria(id_cat)
};

-- Sexta entidad: Sucursal
CREATE TABLE Sucursal{
    id_suc SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE
};

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
-- CREATE TABLE metodo_pago(
    id_mpago SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);
