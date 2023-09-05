/* Vista para la tabla empleado con el CURP y nombre completo */
CREATE VIEW vista_empleados
as select curp, nombre, paterno, materno 
from Empleado
WHERE nombre LIKE 'A%';

/* Consultando vista_empleados */
SELECT * FROM vista_empleados;


/* Vista con toda la informacion de los empleados y departamentos */
CREATE VIEW vista_empleados_departamentos
as select e.curp, e.nombre, e.paterno, e.materno, e.salario,
e.genero, e.nacimiento, e.ciudad, e.calle, e.cp, d.numDepto,
d.nombreDepto, d.fecha
from Empleado e 
join Departamento d
on e.numDepto=d.numDepto;

/* Consultando vista_empleados_departamentos */
SELECT * FROM vista_empleados_departamentos;


/* Vista que muestra numProyecto, nombreProyecto, el numero de empleados y el
numero de horas colaboradas de cada proyecto */
CREATE VIEW vista_proyecto_empleados
as select p.numProy, p.nombreProy, 
count(c.curp) as empleadosEnProyecto,
sum(c.numHoras) as horasColaboradas
from Colaborar c
join Proyecto p
on c.numProy=p.numProy
group by p.numProy, p.nombreProy;

/* Consultando vista_proyecto_empleados */
SELECT * FROM vista_proyecto_empleados;




/* Vista Materializada para la tabla empleado con el CURP y nombre completo */
CREATE VIEW vm_empleados WITH SCHEMABINDING
AS select curp, nombre, paterno, materno 
from dbo.Empleado
WHERE nombre LIKE 'A%';	

/* Consultando vm_empleados */
SELECT * FROM vm_empleados;


/* Vista Materializada con toda la informacion de los empleados y departamentos */
CREATE VIEW vm_empleados_departamentos WITH SCHEMABINDING
as select e.curp, e.nombre, e.paterno, e.materno, e.salario,
e.genero, e.nacimiento, e.ciudad, e.calle, e.cp, d.numDepto,
d.nombreDepto, d.fecha
from dbo.Empleado e 
join dbo.Departamento d
on e.numDepto=d.numDepto;

/* Consultando vm_empleados_departamentos */
SELECT * FROM vm_empleados_departamentos;