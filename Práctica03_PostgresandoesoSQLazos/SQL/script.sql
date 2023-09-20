/* Tabla que contiene la integracion de las 4 tablas csv */
CREATE TABLE IntegracionViaje (
	curp CHAR(50),
	nombre VARCHAR(50),
	apellidoPaterno VARCHAR(50),
	apellidoMaterno VARCHAR(50),
	fechaNacimiento VARCHAR(50),
	idViaje INT,
	fecha VARCHAR(50),
	lugar VARCHAR(50)
);


/* Visualizacion de la tabla */
SELECT TOP (100) [curp]
	,[nombre]
	,[apellidoPaterno]
	,[apellidoMaterno]
	,[fechaNacimiento]
	,[idViaje]
	,[fecha]
	,[lugar]
FROM [BDPractica3].[dbo].[IntegracionViaje];


