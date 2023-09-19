/* Tabla que contiene la integracion de las 4 tablas csv */
CREATE TABLE IntegracionViaje (
	curp CHAR(18),
	idViaje INT,
	nombre VARCHAR(50),
	aPaterno VARCHAR(50),
	aMaterno VARCHAR(50),
	fechaNacimiento DATE,
	lugar VARCHAR(50),
	fecha DATE
);


/* Visualizacion de la tabla */
SELECT * FROM IntegracionViaje;


