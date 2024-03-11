
CREATE TABLE CLIENTE (
    id_cliente SERIAL PRIMARY KEY,
    tipo_identificacion VARCHAR(10) NOT NULL CHECK (tipo_identificacion IN ('DNI', 'NIT', 'PASAPORTE', 'CC')),
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PRODUCTO (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    precio_proveedor NUMERIC(10,2) NOT NULL,
    precio_venta NUMERIC(10,2) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    cantidad INT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    fecha_pedido DATE,
    id_cliente INT,
    tipo_registro VARCHAR(15) NOT NULL CHECK (tipo_registro IN ('MANUAL', 'SEMIAUTOMATICO')),
    nombre VARCHAR(50),
    estado_pedido VARCHAR(50),
	destino VARCHAR(50),
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE Factura (
    id_factura SERIAL PRIMARY KEY,
    id_pedido INT,
    fecha_Factura DATE,
    total_Factura NUMERIC(10, 2), 
    tipo_radicado VARCHAR(20) NOT NULL CHECK (tipo_radicado IN ('EMAIL', 'SERVICIO DE TRANSPORTE')),
    factura_radicada VARCHAR(255), 
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_factura_pedido FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

CREATE TABLE Guia_transporte (
    id_guia_transporte SERIAL PRIMARY KEY,
    id_cliente INT,
    fecha_guia_transporte DATE,
    destino VARCHAR(50),
    foto_prueba VARCHAR(255), 
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_guia_transporte_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE Documento_entrega (
    id_documento_entrega SERIAL PRIMARY KEY,
    id_pedido INT,
    id_factura INT,
    id_guia_transporte INT,
    fecha_despacho DATE,
    fecha_entrega DATE,
    estado_entrega VARCHAR(255),
    observacion VARCHAR(255),
    foto_prueba VARCHAR(255),
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_documento_entrega_guia_transporte FOREIGN KEY (id_guia_transporte) REFERENCES Guia_transporte(id_guia_transporte),
    CONSTRAINT fk_documento_entrega_pedido FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    CONSTRAINT fk_documento_entrega_factura FOREIGN KEY (id_factura) REFERENCES Factura(id_factura)
);

CREATE TABLE linea_pedido (
    id_linea_pedido SERIAL PRIMARY KEY,
    id_documento_entrega INT,
    id_pedido INT,
    fecha_despacho DATE,
    fecha_entrega DATE,
    estado_linea_pedido VARCHAR(255),
    observacion VARCHAR(255),
    tipo_producto VARCHAR(3) NOT NULL CHECK (tipo_producto IN ('MTO', 'MTS')),
    id_producto INT,
    cantidad_producto INT,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_linea_pedido_producto FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    CONSTRAINT fk_linea_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    CONSTRAINT fk_linea_pedido_documento_entrega FOREIGN KEY (id_documento_entrega) REFERENCES Documento_entrega(id_documento_entrega)
);

insert into CLIENTE values (1, 'DNI', 'CORONA', '3917 Pawling Way', '971-716-7567', 'corona@google.cn');
insert into CLIENTE values (2, 'CC', 'COLPENSIONES', '5 Briar Crest Lane', '369-513-4514', 'colpensiones@geocities.com');
insert into CLIENTE values (3, 'NIT', 'BANCO BOGOTA', '706 Dawn Plaza', '414-104-8692', 'bancobogota@dagondesign.com');
insert into CLIENTE values (4, 'NIT', 'BANCO OCCIDENTE', '34373 Amoth Point', '974-737-8689', 'bancooccidente@mit.edu');
insert into CLIENTE values (5, 'PASAPORTE', 'SURA', '527 Lotheville Junction', '665-114-3891', 'sura@t.co');



insert into PRODUCTO (id_producto, nombre, descripcion, precio_proveedor, precio_venta, fecha_vencimiento, cantidad) values (1, 'Producto A', 'Re-contextualized secondary leverage', 5558141.75, 7321825.6, '12/7/2029', 6000);
insert into PRODUCTO (id_producto, nombre, descripcion, precio_proveedor, precio_venta, fecha_vencimiento, cantidad) values (2, 'Producto B', 'Realigned empowering firmware', 3686542.92, 5863068.39, '9/10/2032', 1200);
insert into PRODUCTO (id_producto, nombre, descripcion, precio_proveedor, precio_venta, fecha_vencimiento, cantidad) values (3, 'Producto C', 'Progressive actuating standardization', 5513526.14, 292586.91, '7/5/2032', 1800);
insert into PRODUCTO (id_producto, nombre, descripcion, precio_proveedor, precio_venta, fecha_vencimiento, cantidad) values (4, 'Producto D', 'Open-architected analyzing budgetary management', 6822153.71, 7320607.99, '2/4/2050', 2500);



insert into PEDIDO (id_pedido, fecha_pedido, id_cliente, tipo_registro, nombre, estado_pedido, destino) values (1, '2024-02-11', 1, 'SEMIAUTOMATICO', 'Pedido 1', 'Completed','Destino A');
insert into PEDIDO (id_pedido, fecha_pedido, id_cliente, tipo_registro, nombre, estado_pedido, destino) values (2, '2024-02-11', 1, 'SEMIAUTOMATICO', 'Pedido 2', 'Cancelled', 'Destino A');
insert into PEDIDO (id_pedido, fecha_pedido, id_cliente, tipo_registro, nombre, estado_pedido, destino) values (3, '2024-02-11', 2, 'SEMIAUTOMATICO', 'Pedido 3', 'In Progress', 'Destino B');
insert into PEDIDO (id_pedido, fecha_pedido, id_cliente, tipo_registro, nombre, estado_pedido, destino) values (4, '2024-02-11', 3, 'SEMIAUTOMATICO', 'Pedido 4', 'In Progress','Destino C');


INSERT INTO Guia_transporte (id_cliente, fecha_guia_transporte, destino, foto_prueba) 
VALUES (1,  '2024-03-09', 'Destino A', '');
INSERT INTO Guia_transporte (id_cliente, fecha_guia_transporte, destino, foto_prueba) 
VALUES (2, '2024-03-10', 'Destino B', '');

INSERT INTO Documento_entrega (id_pedido, id_factura, id_guia_transporte, fecha_despacho, fecha_entrega, estado_entrega, observacion, foto_prueba) 
VALUES (1, null , 1, '2024-03-10', null, 'En camino', 'Sin observaciones', '');
INSERT INTO Documento_entrega (id_pedido, id_factura, id_guia_transporte, fecha_despacho, fecha_entrega, estado_entrega, observacion, foto_prueba) 
VALUES (1, null , 1, '2024-03-10', null, 'En camino', 'Necesita reprogramación', '');
INSERT INTO Documento_entrega (id_pedido, id_factura, id_guia_transporte, fecha_despacho, fecha_entrega, estado_entrega, observacion, foto_prueba) 
VALUES (1, null , 2, '2024-03-11', null, 'Entregado', 'Firmado por el destinatario', '');
INSERT INTO Documento_entrega (id_pedido, id_factura, id_guia_transporte, fecha_despacho, fecha_entrega, estado_entrega, observacion, foto_prueba) 
VALUES (2, null, 1, '2024-03-10', null, 'En camino', 'Retraso debido al clima', '');


INSERT INTO linea_pedido (id_documento_entrega, id_pedido, fecha_despacho, fecha_entrega, estado_linea_pedido, observacion, destino, tipo_producto, id_producto, cantidad_producto)
VALUES (1, 1, '2024-03-10', '2024-03-11', 'Completo', 'Sin observaciones', 'Destino A', 'MTO', 1, 10);
INSERT INTO linea_pedido (id_documento_entrega, id_pedido, fecha_despacho, fecha_entrega, estado_linea_pedido, observacion, destino, tipo_producto, id_producto, cantidad_producto)
VALUES (2, 1, '2024-03-10', '2024-03-12', 'Completo', 'Piezas en color blanco', 'Destino B', 'MTS', 2, 15);
INSERT INTO linea_pedido (id_documento_entrega, id_pedido, fecha_despacho, fecha_entrega, estado_linea_pedido, observacion, destino, tipo_producto, id_producto, cantidad_producto)
 VALUES (3, 2, '2024-03-11', '2024-03-13', 'Fabricando', 'Retraso en fabrica', 'Destino C', 'MTO', 3, 20);
INSERT INTO linea_pedido (id_documento_entrega, id_pedido, fecha_despacho, fecha_entrega, estado_linea_pedido, observacion, destino, tipo_producto, id_producto, cantidad_producto)
VALUES (4, 2, '2024-03-10', '2024-03-14', 'Completo', 'Piezas en color dorado', 'Destino D', 'MTS', 4, 25);

