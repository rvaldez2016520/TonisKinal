/*
	Programador
		Rui Luis Valdez Arevalo
        2016520
	Fecha de creación
		24/03/2020
	Modificaciones
		30/03/2020 Se crearon los procedimientos almacenados
*/

drop database if exists DBTonysKinal2016520;

create database DBTonysKinal2016520;
use DBTonysKinal2016520;

create table Productos(
	codigoProducto int auto_increment not null,
    nombreProducto varchar(150) not null,
    cantidad int not null,
    primary key PK_codigoProducto(codigoProducto)	
);

create table TipoEmpleado(
	codigoTipoEmpleado int auto_increment not null,
    descripcion varchar(100),
    primary key PK_codigoTipoEmpleado(codigoTipoEmpleado)
);

create table Empleados(
	codigoEmpleado int auto_increment not null,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(10) not null,
    gradoCocinero varchar(50) not null,
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado(codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key (codigoTipoEmpleado) 
    references tipoEmpleado(codigoTipoEmpleado)
);

create table TipoPlato(
	codigoTipoPlato int auto_increment not null,
    descripcionTipo varchar(100) not null,
    primary key PK_codigoTipoPlato(codigoTipoPlato)
);

create table Platos(
	codigoPlato int auto_increment not null,
    cantidad int not null,
    nombrePlato varchar(50),
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2),
    codigoTipoPlato int not null,
    primary key PK_codigoPlato(codigoPlato),
    constraint FK_Platos_TipoPlato foreign key (codigoTipoPlato)
    references TipoPlato(codigoTipoPlato)
);

create table Empresas(
	codigoEmpresa int auto_increment not null,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(10) not null,
    primary key PK_codigoEmpresa(codigoEmpresa)
);

create table Presupuesto(
	codigoPresupuesto int auto_increment not null,
    fechaSolicitud date,
    cantidadPresupuesto decimal(10,2),
    codigoEmpresa int not null,
    primary key PK_codigoPresupuesto(codigoPresupuesto),
    constraint FK_Presupuesto_Empresas foreign key (codigoEmpresa)
    references Empresas(codigoEmpresa)
);

create table Servicios(
	codigoServicio int auto_increment not null,
    fechaServicio date,
    tipoServicio varchar(100),
    horaServicio time,
    lugarServicio varchar(100),
    telefonoContacto varchar(10),
    codigoEmpresa int not null,
    primary key PK_codigoServicio(codigoServicio),
    constraint FK_Servicios_Empresas foreign key (codigoEmpresa)
    references Empresas(codigoEmpresa)
);

CREATE TABLE Servicios_has_Empleados(
	codigoServicioEmpleado INT auto_increment NOT NULL,
	codigoServicio INT NOT NULL,
    codigoEmpleado INT NOT NULL,
	CONSTRAINT FK_Servicios_Servicios_has_Empleados
		FOREIGN KEY (codigoServicio) REFERENCES Servicios(codigoServicio),
	CONSTRAINT FK_Empleados_Servicios_has_Empleados
		FOREIGN KEY (codigoEmpleado) REFERENCES Empleados(codigoEmpleado),
	fechaEvento DATE NOT NULL,
    horaEvento TIME NOT NULL,
    lugarEvento VARCHAR(150) NOT NULL,
    PRIMARY KEY PK_codigoServicioEmpleado(codigoServicioEmpleado)
);

CREATE TABLE Servicios_has_Platos(
	codigoServicio INT NOT NULL,
    codigoPlato INT NOT NULL,
	CONSTRAINT FK_Servicios_Servicios_has_Platos
		FOREIGN KEY (codigoServicio) REFERENCES Servicios(codigoServicio),
	CONSTRAINT FK_Platos_Servicios_has_Platos
		FOREIGN KEY (codigoPlato) REFERENCES Platos(codigoPlato)
);

CREATE TABLE Productos_has_Platos(
	codigoProducto INT NOT NULL,
    codigoPlato INT NOT NULL,
	CONSTRAINT FK_Productos_Productos_has_Platos
		FOREIGN KEY (codigoProducto) REFERENCES Productos(codigoProducto),
	CONSTRAINT FK_Platos_Productos_has_Platos
		FOREIGN KEY (codigoPlato) REFERENCES Platos(codigoPlato)
);

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------PROCEDIMIENTOS ALMACENADOS----------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/********************************************************************************Productos*****************************************************************************/
/* Listar*/
DELIMITER $$
	create procedure sp_ListarProductos()
    begin
		select codigoProducto,nombreProducto,cantidad from Productos;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarProducto(in _nombreProducto varchar(150),in _cantidad int)
    begin
		insert into Productos(nombreProducto,cantidad) 
        values(_nombreProducto,_cantidad);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarProducto(in _codigoProducto int,in _nombreProducto varchar(150),in _cantidad int)
    begin
		update Productos set 
        nombreProducto = _nombreProducto,
        cantidad= _cantidad
        where codigoProducto = _codigoProducto;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarProducto(in _codigoProducto int)
    begin
		delete from Productos where codigoProducto = _codigoProducto;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarProducto(in _codigoProducto int)
    begin
		select * from Productos where codigoProducto = _codigoProducto;
    end $$
DELIMITER ;

/**********************************************************************Tipo de Empleado********************************************************************************/

/*Listar*/
DELIMITER $$
	create procedure sp_ListarTipoEmpleado()
    begin
		select codigoTipoEmpleado,descripcion from TipoEmpleado;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarTipoEmpleado(in _descripcion varchar(100))
    begin
		insert into TipoEmpleado(descripcion) 
        values(_descripcion);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarTipoEmpleado(in _codigoTipoEmpleado int,in _descripcion varchar(100))
    begin
		update TipoEmpleado set 
        descripcion = _descripcion 
        where codigoTipoEmpleado = _codigoTipoEmpleado;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarTipoEmpleado(in _codigoTipoEmpleado int)
    begin
		delete from TipoEmpleado where codigoTipoEmpleado = _codigoTipoEmpleado;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarTipoEmpleado(in _codigoTipoEmpleado int)
    begin
		select * from TipoEmpleado where codigoTipoEmpleado = _codigoTipoEmpleado;
    end $$
DELIMITER ;

/****************************************************************************Empleados********************************************************************************/

/*Listar*/
DELIMITER $$
	create procedure sp_ListarEmpleados()
    begin
		select codigoEmpleado,numeroEmpleado,apellidosEmpleado,nombresEmpleado,direccionEmpleado,telefonoContacto,gradoCocinero,codigoTipoEmpleado
        from Empleados;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarEmpleado(in _numeroEmpleado int,in _apellidosEmpleado varchar(150),in _nombresEmpleado varchar(150),in _direccionEmpleado varchar(150),
    in _telefonoContacto varchar(10),in _gradoCocinero varchar(50),in _codigoTipoEmpleado int)
    begin
		insert into Empleados(numeroEmpleado,apellidosEmpleado,nombresEmpleado,direccionEmpleado,telefonoContacto,gradoCocinero,codigoTipoEmpleado)
        values(_numeroEmpleado,_apellidosEmpleado,_nombresEmpleado,_direccionEmpleado,_telefonoContacto,_gradoCocinero,_codigoTipoEmpleado);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarEmpleado(in _codigoEmpleado int,in _numeroEmpleado int,in _apellidosEmpleado varchar(150),in _nombresEmpleado varchar(150),in _direccionEmpleado varchar(150),
    in _telefonoContacto varchar(10),in _gradoCocinero varchar(50),in _codigoTipoEmpleado int)
    begin
		update Empleados set 
        numeroEmpleado = _numeroEmpleado,
        apellidosEmpleado = _apellidosEmpleado,
        nombresEmpleado = _nombresEmpleado,
        direccionEmpleado = _direccionEmpleado,
        telefonoContacto = _telefonoContacto,
        gradoCocinero = _gradoCocinero,
        codigoTipoEmpleado = _codigoTipoEmpleado
        where codigoEmpleado = _codigoEmpleado;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarEmpleado(in _codigoEmpleado int)
    begin
		delete from Empleados where codigoEmpleado = _codigoEmpleado;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarEmpleado(in _codigoEmpleado int)
    begin
		select * from Empleados where codigoEmpleado = _codigoEmpleado;
    end $$
DELIMITER ;

/***********************************************************************Tipo de Plato*********************************************************************************/

/*Listar*/
DELIMITER $$
	create procedure sp_ListarTipoPlatos()
    begin
		select codigoTipoPlato,descripcionTipo from TipoPlato;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarTipoPlato(in _descripcionTipo varchar(100))
    begin
		insert into TipoPlato(descripcionTipo) values(_descripcionTipo);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarTipoPlato(in _codigoTipoPlato int,in _descripcionTipo varchar(100))
    begin
		update TipoPlato set 
        descripcionTipo = _descripcionTipo 
        where codigoTipoPlato = _codigoTipoPlato;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarTipoPlato(in _codigoTipoPlato int)
    begin
		delete from TipoPlato where codigoTipoPlato = _codigoTipoPlato;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarTipoPlato(in _codigoTipoPlato int)
    begin
		select * from TipoPlato where codigoTipoPlato = _codigoTipoPlato;
    end $$
DELIMITER ;

/********************************************************************Platos********************************************************************************************/

/*Listar*/
DELIMITER $$
	create procedure sp_ListarPlatos()
    begin
		select codigoPlato,cantidad,nombrePlato,descripcionPlato,precioPlato,codigoTipoPlato from Platos;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarPlato(in _cantidad int,in _nombrePlato varchar(50),in _descripcionPlato varchar(150),in _precioPlato decimal(10,2), in _codigoTipoPlato int)
    begin
		insert into Platos(cantidad,nombrePlato,descripcionPlato,precioPlato,codigoTipoPlato)
        values(_cantidad,_nombrePlato,_descripcionPlato,_precioPlato,_codigoTipoPlato);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarPlato(in _codigoPlato int,in _cantidad int,in _nombrePlato varchar(50),in _descripcionPlato varchar(150),
    in _precioPlato decimal(10,2), in _codigoTipoPlato int)
    begin
		update Platos set 
        cantidad = _cantidad,
        nombrePlato = _nombrePlato,
        descripcionPlato = _descripcionPlato,
        precioPlato = _precioPlato,
        codigoTipoPlato = _codigoTipoPlato
        where codigoPlato = _codigoPlato;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarPlato(in _codigoPlato int)
    begin
		delete from Platos where codigoPlato = _codigoPlato;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarPlato(in _codigoPlato int)
    begin
		select * from Platos where codigoPlato = _codigoPlato;
    end $$
DELIMITER ;

/*************************************************************Empresas*************************************************************************************************/


DELIMITER $$
	create procedure sp_ListarEmpresa()
    begin
		select codigoEmpresa,nombreEmpresa,direccion,telefono from Empresas;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarEmpresa(in _nombreEmpresa varchar(150),in _direccion varchar(150),in _telefono varchar(10))
    begin
		insert into Empresas(nombreEmpresa,direccion,telefono) 
        values(_nombreEmpresa,_direccion,_telefono);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarEmpresa(in _codigoEmpresa int,in _nombreEmpresa varchar(150),in _direccion varchar(150),in _telefono varchar(10))
    begin
		update Empresas set 
        nombreEmpresa = _nombreEmpresa,
        direccion = _direccion,
        telefono = _telefono
        where codigoEmpresa = _codigoEmpresa;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarEmpresa(in _codigoEmpresa int)
    begin
		delete from Empresas where codigoEmpresa = _codigoEmpresa;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarEmpresa(in _codigoEmpresa int)
    begin
		select * from Empresas where codigoEmpresa = _codigoEmpresa;
    end $$
DELIMITER ;

/****************************************************************Presupuesto*******************************************************************************************/

/*Listar*/
DELIMITER $$
	create procedure sp_ListarPresupuesto()
    begin
		select codigoPresupuesto,fechaSolicitud,cantidadPresupuesto,codigoEmpresa from Presupuesto;
    end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarPresupuesto(in _fechaSolicitud date,in _cantidadPresupuesto decimal(10,2),in _codigoEmpresa int)
    begin
		insert into Presupuesto(fechaSolicitud,cantidadPresupuesto,codigoEmpresa) 
        values(_fechaSolicitud,_cantidadPresupuesto,_codigoEmpresa);
    end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarPresupuesto(in _codigoPresupuesto int,in _fechaSolicitud date,in _cantidadPresupuesto decimal(10,2),in _codigoEmpresa int)
    begin
		update Presupuesto set 
        fechaSolicitud = _fechaSolicitud,
        cantidadPresupuesto = _cantidadPresupuesto,
        codigoEmpresa = _codigoEmpresa
        where codigoPresupuesto = _codigoPresupuesto;
    end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarPresupuesto(in _codigoPresupuesto int)
    begin
		delete from Presupuesto where codigoPresupuesto = _codigoPresupuesto;
    end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarPresupuesto(in _codigoPresupuesto int)
    begin
		select * from Presupuesto where codigoPresupuesto = _codigoPresupuesto;
    end $$
DELIMITER ;

/********************************************************************Servicios*****************************************************************************************/

/*Listar*/
DELIMITER $$
	create procedure sp_ListarServicios()
    begin
		select codigoServicio,fechaServicio,tipoServicio,horaServicio,lugarServicio,telefonoContacto,codigoEmpresa from Servicios;
	end $$
DELIMITER ;
/*Agregar*/
DELIMITER $$
	create procedure sp_AgregarServicio(in _fechaServicio date, in _tipoServicio varchar(100), in _horaServicio time, 
    in _lugarServicio varchar(100), in _telefonoContacto varchar(10), in _codigoEmpresa int)
    begin
		insert into Servicios(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa)
        values (_fechaServicio, _tipoServicio, _horaServicio, _lugarServicio, _telefonoContacto, _codigoEmpresa);
	end $$
DELIMITER ;
/*Actualizar*/
DELIMITER $$
	create procedure sp_ActualizarServicio(in _codigoServicio int, in _fechaServicio date, in _tipoServicio varchar(100), in _horaServicio time, in _lugarServicio varchar(100), 
    in _telefonoContacto varchar(10), in _codigoEmpresa int)
    begin
		update Servicios set
        fechaServicio = _fechaServicio,
        tipoServicio = _tipoServicio,
        horaServicio = _horaServicio,
        lugarServicio = _lugarServicio,
        telefonoContacto =_telefonoContacto
        where codigoServicio = _codigoServicio;
	end $$
DELIMITER ;
/*Eliminar*/
DELIMITER $$
	create procedure sp_EliminarServicio(in _codigoServicio int)
		begin 
        delete from Servicios where codigoServicio = _codigoServicio;
        end $$
DELIMITER ;
/*Buscar*/
DELIMITER $$
	create procedure sp_BuscarServicio(in _codigoServicio int)
    begin
    select * from Servicios where codigoServicio = _codigoServicio;
    end $$
DELIMITER ;
 
 /**********************************************************Servicios_has_Empleado************************************************************************************/
 
 /*Agregar*/
DROP PROCEDURE IF EXISTS sp_agregarServicio_has_Empleado;
DELIMITER $$
CREATE PROCEDURE sp_agregarServicio_has_Empleado(
	IN codigoServicio INT,
    IN codigoEmpleado INT,
    IN fechaEvento DATE,
    IN horaEvento TIME,
    IN lugarEvento VARCHAR(100)
)
BEGIN
	INSERT INTO Servicios_has_Empleados(codigoServicio,codigoEmpleado,fechaEvento,horaEvento,lugarEvento) VALUES (codigoServicio,codigoEmpleado,fechaEvento,horaEvento,lugarEvento);
END $$
DELIMITER ;

/*Listar*/
DROP PROCEDURE IF EXISTS sp_listarServicios_has_Empleados;
DELIMITER $$
CREATE PROCEDURE sp_listarServicios_has_Empleados()
BEGIN
	select Servicios_has_Empleados.codigoServicioEmpleado,Servicios_has_Empleados.codigoServicio,Servicios_has_Empleados.codigoEmpleado,Servicios_has_Empleados.fechaEvento,Servicios_has_Empleados.horaEvento,
		Servicios_has_Empleados.lugarEvento FROM Servicios_has_Empleados;
END $$
DELIMITER ;



/*Buscar*/
DROP PROCEDURE IF EXISTS sp_buscarServicio_has_Empleado;
DELIMITER $$
CREATE PROCEDURE sp_buscarServicio_has_Empleado(
	IN codServEmpleado INT
)
BEGIN
	SELECT Servicio_has_Empleado.codigoServicio,Servicios_has_Empleados.codigoEmpleado,Servicios_has_Empleados.fechaEvento,Servicios_has_Empleados.horaEvento,
		Servicios_has_Empleados.lugarEvento FROM Servicios_has_Empleados WHERE codigoServicioEmpleado = codServEmpleado;
END $$
DELIMITER ;


/*Actualizar*/
DROP PROCEDURE IF EXISTS sp_actualizarServicios_has_Empleados;
DELIMITER $$
CREATE PROCEDURE sp_actualizarServicios_has_Empleados(
	IN codServEmpleado INT,
	IN codServicio INT,
    IN codEmpleado INT,
    IN feEvento DATE,
    IN hrEvento TIME,
    IN lugEvento VARCHAR(100)
)
BEGIN
	UPDATE Servicios_has_Empleados SET
		codigoServicio = codServicio,
		codigoEmpleado = codEmpleado,
        fechaEvento = feEvento,
        horaEvento = hrEvento,
        lugarEvento = lugEvento
    WHERE codigoServicioEmpleado = codServEmpleado; 
END $$
DELIMITER ;

/*Elimnar*/
DROP PROCEDURE IF EXISTS sp_eliminarServicio_has_Empleado;
DELIMITER $$
CREATE PROCEDURE sp_eliminarServicio_has_Empleado(
	IN codServEmpleado INT
)
BEGIN
	DELETE FROM Servicios_has_Empleados  WHERE codigoServicioEmpleado = codServEmpleado;
END $$
DELIMITER ;

/*****************************************************************Servicios_has_Platos*********************************************************************************/

/*Listar*/
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_listarServicios_has_Platos;
DELIMITER $$
	CREATE PROCEDURE sp_listarServicios_has_Platos()
		BEGIN
			select codigoServicio,codigoPlato FROM Servicios INNER JOIN Platos ON codigoServicio = CodigoPlato;
		END $$
        
DELIMITER ;

/*Agregar*/
DELIMITER $$
	CREATE PROCEDURE sp_agregarServicios_has_Plato(
		IN codigoServicio INT,
		IN codigoPlato INT
	)
	BEGIN
		INSERT INTO Servicios_has_Platos(codigoServicio,codigoPlato)
			VALUES (codigoServicio,codigoPlato);
	END $$
DELIMITER ;

/*******************************************************************Productos_has_Platos*******************************************************************************/

/*Listar*/
DELIMITER $$
CREATE PROCEDURE sp_listarProductos_has_Platos()
BEGIN
	SELECT codigoProducto,codigoPlato FROM Productos INNER JOIN Platos ON codigoProducto = codigoPlato;
END $$
DELIMITER ;
call sp_listarProductos_has_Platos();

/*Agregar*/
DELIMITER $$
CREATE PROCEDURE sp_agregarProductos_has_Platos(
	in codigoPlato INT,
	in codigoProducto INT
)
BEGIN
	INSERT INTO Productos_has_Platos (codigoPlato,codigoProducto) VALUES (codigoPlato,codigoProducto);
END $$
DELIMITER ;

/*--------------------------------------------------*/

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin';

/*REGISTROS*/
call sp_AgregarEmpresa("TonysKinal","Zona 2, Ciudad de Guatemala ","1234-5678");
call sp_AgregarEmpresa("PolloCampero","Zona 5, Ciudad de Guatemala ","1234-5696");
call sp_AgregarEmpresa("PolloGranjero","Zona 7, Ciudad de Guatemala","8523-6974");
call sp_AgregarEmpresa("PolloRey","Zona 1, Ciudad de Guatemala","1265-7841");
call sp_AgregarEmpresa("Telepizza","Zona 2, Ciudad de Guatemala","1599-6153");
call sp_AgregarEmpresa("PizzaHut","Zona 3, Ciudad de Guatemala","4985-6384");
call sp_AgregarEmpresa("McDonalds","Zona 4, Ciudad de Guatemala","1010-2036");
call sp_AgregarEmpresa("BurguerKing","Zona 7, Ciudad de Guatemala","1259-9689");
call sp_AgregarEmpresa("Charly's","Zona 5, Ciudad de Guatemala","1599-6325");
call sp_AgregarEmpresa("Tuani's","Zona 8, Ciudad de Guatemala ","2589-6459");
/*--------------------------------------------------*/
call sp_AgregarTipoEmpleado("Gerente");
call sp_AgregarTipoEmpleado("Mantenimiento");
call sp_AgregarTipoEmpleado("Empleado");
call sp_AgregarTipoEmpleado("JefeDeAreaVentas");
call sp_AgregarTipoEmpleado("Proveedor");
call sp_AgregarTipoEmpleado("Tendero");
call sp_AgregarTipoEmpleado("Chef");
call sp_AgregarTipoEmpleado("Socio");
call sp_AgregarTipoEmpleado("JefeAreaComputacion");
call sp_AgregarTipoEmpleado("JefeAreaLimpieza");
/*--------------------------------------------------*/
call sp_AgregarEmpleado("2016520","Valladares Salguero","Carlos Manuel","12 calle 11 avenida zona 6","15979632","1","6");
call sp_AgregarEmpleado("2016277","Tumax Reyes","Kevin Andre","14 calle 12 avenida zona 7","45962020","1","6");
call sp_AgregarEmpleado("2019320","Rios Cifuentes","Angel Gabriel","10 calle 14 avenida zona 10","12459638","0","5");
call sp_AgregarEmpleado("2020123","Hernandez Escobar","Josue Mariano","09 calle 16 avenida zona 18","45285656","10","7");
call sp_AgregarEmpleado("2020003","Escobar Arevalo","Jose Luis","20 calle 15 avenida zona 6","12782013","10","7");
call sp_AgregarEmpleado("2020010","Hernandez Paz","Luis Antonio","18 calle 16 avenida zona 8","75691235","10","7");
call sp_AgregarEmpleado("2020200","Valdez Arevalo","Gerson Antonio","16 calle 20 avenida zona 3","75387520","10","7");
call sp_AgregarEmpleado("2021010","Armas Reyes","Claudia Lorena","02 calle 06 avenida zona 5","85294273","0","1");
call sp_AgregarEmpleado("2021203","Reyes Rodriguez","Jazmin","01 calle 02 avenida zona 2","76892075","1","3");
call sp_AgregarEmpleado("2021456","Arevalo Palma","Dylan Manuel","20 calle 11 avenida zona 3","78962020","0","10");
call sp_AgregarEmpleado("2022010","Palma Rios","Polina","24 calle 10 avenida zona 4","53892574","0","10");
/*--------------------------------------------------*/

call sp_AgregarPresupuesto("2011-06-14","2077000.00","1");
call sp_AgregarPresupuesto("2011-10-14","2400456.00","2");
call sp_AgregarPresupuesto("2012-09-14","265369.00","3");
call sp_AgregarPresupuesto("2013-01-14","26265489.00","4");
call sp_AgregarPresupuesto("2014-07-14","625481.00","5");
call sp_AgregarPresupuesto("2016-06-14","6548761.00","6");
call sp_AgregarPresupuesto("2016-01-14","2413948.00","7");
call sp_AgregarPresupuesto("2017-03-14","3268647.00","8");
call sp_AgregarPresupuesto("2020-12-14","44748210.00","9");
call sp_AgregarPresupuesto("2020-12-20","107510.00","10");

/*--------------------------------------------------*/

call sp_AgregarServicio("2011-12-11","Adomicilio","12:30:00","Zona 8, Ciudad De Guatemala","12859632","1");
call sp_AgregarServicio("2012-10-23","Express","20:15:00","Zona 21, Ciudad De Guatemala","24898541","3");
call sp_AgregarServicio("2013-04-15","Local","13:25:00","Zona 8, Ciudad De Guatemala","78963512","5");
call sp_AgregarServicio("2014-06-12","Local","15:40:00","Zona 10, Ciudad De Guatemala","12527896","4");
call sp_AgregarServicio("2015-10-16","Adomicilio","17:50:00","Zona 2, Ciudad De Guatemala","20365478","6");
call sp_AgregarServicio("2016-12-11","Adomicilio","20:40:00","Zona 4, Ciudad De Guatemala","85256545","7");
call sp_AgregarServicio("2017-01-16","Adomicilio","22:45:00","Zona 8, Ciudad De Guatemala","32128595","10");
call sp_AgregarServicio("2020-05-19","Express","16:50:00","Zona 9, Ciudad De Guatemala","78963215","10");
call sp_AgregarServicio("2020-07-20","Express","06:20:00","Zona 3, Ciudad De Guatemala","12953645","5");
call sp_AgregarServicio("2020-06-29","Local","10:20:00","Zona 18, Ciudad De Guatemala","12859635","4");

/*--------------------------------------------------*/

call sp_AgregarProducto("Salchica, salsa, mayonesa","10");
call sp_AgregarProducto("Libra de Azúcar","10");
call sp_AgregarProducto("Latas de conserva","100");
call sp_AgregarProducto("Condimento","500");
call sp_AgregarProducto("Libra de sal","100");
call sp_AgregarProducto("Masa","50");
call sp_AgregarProducto("Bolsa de hielo","50");
call sp_AgregarProducto("Gaseosa","100");
call sp_AgregarProducto("Crema","20");
call sp_AgregarProducto("Queso","20");

/*--------------------------------------------------*/

call sp_AgregarTipoPlato("Platos llanos");
call sp_AgregarTipoPlato("Platos para cremas");
call sp_AgregarTipoPlato("Platos para sopas");
call sp_AgregarTipoPlato("Platos para postres");
call sp_AgregarTipoPlato("Platos hondos");
call sp_AgregarTipoPlato("Platos normales pequeños");
call sp_AgregarTipoPlato("Platos normales medianos");
call sp_AgregarTipoPlato("Platos normales grandes");
call sp_AgregarTipoPlato("Platos de cafe");
call sp_AgregarTipoPlato("Platos de cuchara");

/*--------------------------------------------------*/

call sp_AgregarPlato("20","Shucos","Incluye bebida","7.00","6");
call sp_AgregarPlato("20","Enchilada","Incluye bebida","10.00","6");
call sp_AgregarPlato("20","Fiambre","Incluye bebida","20.00","7");
call sp_AgregarPlato("20","Paches","Incluye bebida","8.00","6");
call sp_AgregarPlato("20","Tamal","Incluye bebida","9.00","6");
call sp_AgregarPlato("20","Chuchitos","Incluye bebida","5.00","1");
call sp_AgregarPlato("20","Tostadas","Incluye bebida","6.00","1");
call sp_AgregarPlato("20","Pastass","Incluye bebida","15.00","3");
call sp_AgregarPlato("20","Tostadas","Incluye bebida","6.00","6");
call sp_AgregarPlato("20","Papas","Incluye bebida","5.00","6");

/*--------------------------------------------------*/

call sp_agregarServicio_has_Empleado("1","1","2011-06-11","09:00:00","Zona 12");
call sp_agregarServicio_has_Empleado("3","2","2012-01-11","06:00:00","Zona 11");
call sp_agregarServicio_has_Empleado("4","3","2013-04-11","08:00:00","Zona 10");
call sp_agregarServicio_has_Empleado("6","4","2014-03-11","13:00:00","Zona 9");
call sp_agregarServicio_has_Empleado("1","5","2015-02-11","18:00:00","Zona 8");
call sp_agregarServicio_has_Empleado("9","6","2018-11-11","12:00:00","Zona 6");
call sp_agregarServicio_has_Empleado("1","7","2018-12-11","12:00:00","Zona 1");
call sp_agregarServicio_has_Empleado("7","8","2020-07-11","16:00:00","Zona 5");
call sp_agregarServicio_has_Empleado("5","9","2020-09-11","15:00:00","Zona 3");
call sp_agregarServicio_has_Empleado("2","10","2020-08-11","13:00:00","Zona 4");

/*--------------------------------------------------*/



/*--------------------------------------------------*/



/*--------------------------------------------------*/
Delimiter $$

create procedure sp_ListarReporte(in codEmpresa int)
Begin
	select * from Empresas E inner join Presupuesto P on
		E.codigoEmpresa = P.codigoEmpresa
        inner join Servicios S on
			E.codigoEmpresa = S.codigoEmpresa
            where E.codigoEmpresa = codEmpresa order by P.cantidadPresupuesto;
End$$

Delimiter ;

/*--------------------------------------------------*/

DELIMITER $$
	CREATE PROCEDURE sp_listarReporteServicio(IN codServ INT)
		BEGIN
			SELECT * FROM Servicios S INNER JOIN Platos P ON S.codigoServicio = P.codigoPlato
				INNER JOIN TipoPlato T ON S.codigoServicio = T.codigoTipoPlato
					INNER JOIN Productos R ON S.codigoServicio = R.codigoProducto
						INNER JOIN Empresas E ON S.codigoServicio = E.codigoEmpresa
							WHERE S.codigoServicio = codServ ORDER BY S.tipoServicio;
		END$$
DELIMITER ;
