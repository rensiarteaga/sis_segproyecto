

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


