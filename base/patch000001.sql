

/***********************************I-SCP-YAC-SEP-0-13/02/2017****************************************/

--------------- SQL ---------------

CREATE TABLE sp.tactividad (
  id_actividad SERIAL NOT NULL,
  actividad VARCHAR(150),
  id_actividad_padre INTEGER,
  PRIMARY KEY(id_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);



/***********************************F-SCP-YAC-SEP-0-13/02/2017****************************************/



/***********************************I-SCP-YAC-SP-0-01/03/2017****************************************/

--------------- SQL ---------------

CREATE TABLE sp.tdef_proyecto (
  id_def_proyecto SERIAL NOT NULL,
  id_proyecto INTEGER,
  fecha_inicio_teorico DATE,
  fecha_fin_teorico DATE,
  descripcion TEXT,
  PRIMARY KEY(id_def_proyecto)
) INHERITS (pxp.tbase)

WITH (oids = false);


--------------- SQL ---------------

CREATE TABLE sp.tdef_proyecto_actividad (
  id_def_proyecto_actividad SERIAL NOT NULL,
  id_def_proyecto INTEGER,
  id_actividad INTEGER,
  descripcion VARCHAR(250);
  PRIMARY KEY(id_def_proyecto_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-YAC-SP-0-01/03/2017****************************************/


