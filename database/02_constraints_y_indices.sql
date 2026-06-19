--Llaves foráneas
-- Foráneas de empleado
ALTER TABLE empleado ADD CONSTRAINT fk_emp_sucursal FOREIGN KEY (id_suc) REFERENCES sucursal(id_suc);
ALTER TABLE empleado ADD CONSTRAINT fk_emp_cargo FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo);
-- Foráneas de smartphone 
ALTER TABLE smartphone ADD CONSTRAINT fk_smart_marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca);
ALTER TABLE smartphone ADD CONSTRAINT fk_smart_cat FOREIGN KEY (id_cat) REFERENCES categoria(id_cat);
-- Foráneas de cabecera_venta 
ALTER TABLE cabecera_venta ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cli) REFERENCES cliente(id_cli);
ALTER TABLE cabecera_venta ADD CONSTRAINT fk_venta_empleado FOREIGN KEY (id_emp) REFERENCES empleado(id_emp);
ALTER TABLE cabecera_venta ADD CONSTRAINT fk_venta_sucursal FOREIGN KEY (id_suc) REFERENCES sucursal(id_suc);
-- Foráneas de detalle_venta
ALTER TABLE detalle_venta ADD CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta) REFERENCES cabecera_venta(id_venta) ON DELETE CASCADE;
ALTER TABLE detalle_venta ADD CONSTRAINT fk_detalle_smart FOREIGN KEY (id_smart) REFERENCES smartphone(id_smart);
-- Foráneas de pago_venta
ALTER TABLE pago_venta ADD CONSTRAINT fk_pago_venta_venta FOREIGN KEY (id_venta) REFERENCES cabecera_venta(id_venta) ON DELETE CASCADE;
ALTER TABLE pago_venta ADD CONSTRAINT fk_pago_venta_mpago FOREIGN KEY (id_mpago) REFERENCES metodo_pago(id_mpago);
--Foráneas de garantía
ALTER TABLE garantia ADD CONSTRAINT fk_garantía_detalle FOREIGN KEY (id_detalle) REFERENCES detalle_venta(id_detalle) ON DELETE CASCADE;
--Foráneas de cabecera_compra
ALTER TABLE cabecera_compra ADD CONSTRAINT fk_cabecera_compra_prov FOREIGN KEY (id_prov) REFERENCES proveedor(id_prov);
ALTER TABLE cabecera_compra ADD CONSTRAINT fk_cabecera_compra_suc FOREIGN KEY (id_suc) REFERENCES sucursal(id_suc);
--Foráneas de detalle_compra
ALTER TABLE detalle_compra ADD CONSTRAINT fk_detalle_compra_compra FOREIGN KEY (id_compra) REFERENCES cabecera_compra(id_compra) ON DELETE CASCADE;
ALTER TABLE detalle_compra ADD CONSTRAINT fk_detalle_compra_smart FOREIGN KEY (id_smart) REFERENCES smartphone(id_smart);