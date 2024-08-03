create database DBEmpleado

use DBEmpleado

create table Departamento(
idDepartamento int primary key identity(1,1),
nombre nvarchar(50)
)

create table Empleado(
idEmpledo int primary key identity(1,1),
nombreCompleto varchar(50),
idDepartamento int references Departamento(idDepartamento),
sueldo int,
fechaContrato date
)

insert into Departamento(nombre) values
('Administrador'),
('Marketing'),
('Ventas'),
('Comercio')

insert into Empleado(nombreCompleto, idDepartamento, sueldo, fechaContrato) values
('Leo steven', 1 , 1500, getdate())

select * from Departamento

select * from Empleado

--Store procedure

create procedure sp_ListaDepartamentos
as
begin
	select idDepartamento, nombre from Departamento
end

create procedure sp_ListadoEmpleados
as
begin
	set dateformat dmy
	select e.idEmpledo,
	e.nombreCompleto,
	d.idDepartamento,
	d.nombre,
	e.sueldo,
	convert(char(10), e.fechaContrato,103) as 'fechaContrato'
	from Empleado as e
	inner join Departamento as d
	on e.idDepartamento = d.idDepartamento
end

create procedure sp_GuardarEmpleado(
@nombreCompleto varchar(50),
@idDepartamento int,
@sueldo int,
@fechaContrato varchar(10)
)
as
begin
	set dateformat dmy
	insert into Empleado(nombreCompleto, idDepartamento,sueldo, fechaContrato)
	values
	(@nombreCompleto, @idDepartamento, @sueldo, convert(date,@fechaContrato))
end

create procedure sp_EditarEmpleado(
@idEmpledo int,
@nombreCompleto varchar(50),
@idDepartamento int,
@sueldo int,
@fechaContrato varchar(10)
)
as
begin
	set dateformat dmy

	update Empleado set
	nombreCompleto = @nombreCompleto,
	idDepartamento = @idDepartamento,
	sueldo = @sueldo,
	fechaContrato = convert(date,@fechaContrato)
	where idEmpledo = @idEmpledo
end


create procedure sp_EliminarEmpleado(
@idEmpledo int)
as
begin
	delete from Empleado where idEmpledo  = @idEmpledo
end
