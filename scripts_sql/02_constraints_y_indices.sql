--Llaves foráneas
-- Foráneas de EMPLEADO 
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_emp_sucursal FOREIGN KEY (id_suc) REFERENCES SUCURSAL(id_suc);
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_emp_cargo FOREIGN KEY (id_cargo) REFERENCES CARGO(id_cargo);

-- Foráneas de SMARTPHONE 
ALTER TABLE SMARTPHONE ADD CONSTRAINT fk_smart_marca FOREIGN KEY (id_marca) REFERENCES MARCA(id_marca);
ALTER TABLE SMARTPHONE ADD CONSTRAINT fk_smart_cat FOREIGN KEY (id_cat) REFERENCES CATEGORIA(id_cat);

-- Foráneas de CABECERA_VENTA 
ALTER TABLE CABECERA_VENTA ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cli) REFERENCES CLIENTE(id_cli);
ALTER TABLE CABECERA_VENTA ADD CONSTRAINT fk_venta_empleado FOREIGN KEY (id_emp) REFERENCES EMPLEADO(id_emp);
ALTER TABLE CABECERA_VENTA ADD CONSTRAINT fk_venta_sucursal FOREIGN KEY (id_suc) REFERENCES SUCURSAL(id_suc);

-- Foráneas de DETALLE_VENTA
ALTER TABLE DETALLE_VENTA ADD CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta) REFERENCES CABECERA_VENTA(id_venta) ON DELETE CASCADE;
ALTER TABLE DETALLE_VENTA ADD CONSTRAINT fk_detalle_smart FOREIGN KEY (id_smart) REFERENCES SMARTPHONE(id_smart);




-- Foraneas de pago_venta
ALTER TABLE pago_venta ADD CONSTRAINT fk_pago_venta_venta FOREIGN KEY (id_venta) REFERENCES cabecera_venta(id_venta);
ALTER TABLE pago_venta ADD CONSTRAINT fk_pago_venta_mpago FOREIGN KEY (id_mpago) REFERENCES metodo_pago(id_mpago);

--Foraneas de garantía
ALTER TABLE garantía ADD CONSTRAINT fk_garantía_detalle FOREIGN KEY (id_detalle) REFERENCES detalle_venta(id_detalle);

--Foraneas de cabecera_compra
ALTER TABLE cabecera_compra ADD CONSTRAINT fk_cabecera_compra_prov FOREIGN KEY (id_prov) REFERENCES proveedor(id_prov);
ALTER TABLE cabecera_compra ADD CONSTRAINT fk_cabecera_compra_suc FOREIGN KEY (id_suc) REFERENCES sucursal(id_suc);

--Foraneas de detalle_compra
ALTER TABLE detalle_compra ADD CONSTRAINT fk_detalle_compra_compra FOREIGN KEY (id_compra) REFERENCES cabecera_compra(id_compra);
ALTER TABLE detalle_compra ADD CONSTRAINT fk_detalle_compra_smart FOREIGN KEY (id_smart) REFERENCES smartphone(id_smart);



