

/***********************************I-SCP-YAC-SP-0-13/02/2017****************************************/

--------------- SQL ---------------

CREATE TABLE sp.tactividad (
  id_actividad SERIAL NOT NULL,
  actividad VARCHAR(150),
  id_actividad_padre INTEGER,
  PRIMARY KEY(id_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);



/***********************************F-SCP-YAC-SP-0-13/02/2017****************************************/



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
  descripcion VARCHAR(250),
  PRIMARY KEY(id_def_proyecto_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-YAC-SP-0-01/03/2017****************************************/

/***********************************I-SCP-JUAN-SP-0-03/03/2017****************************************/ --------------- SQL ---------------

CREATE TABLE sp.tdef_proyecto_actividad_pedido (
  id_def_proyecto_actividad_pedido SERIAL NOT NULL,
  id_def_proyecto_actividad INTEGER,
  id_pedido INTEGER,
  PRIMARY KEY(id_def_proyecto_actividad_pedido)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-SP-0-03/03/2017****************************************/


/***********************************I-SCP-JUAN-SP-0-08/03/2017****************************************/
--------------- SQL ---------------

CREATE TABLE sp.tdef_proyecto_seguimiento (
  id_def_proyecto_seguimiento SERIAL,
  id_def_proyecto INTEGER,
  fecha DATE,
  descripcion VARCHAR(255),
  porcentaje NUMERIC(6,3),
  CONSTRAINT tdef_proyecto_seguimiento_pkey PRIMARY KEY(id_def_proyecto_seguimiento),
  CONSTRAINT tdef_proyecto_seguimiento_fk FOREIGN KEY (id_def_proyecto)
    REFERENCES sp.tdef_proyecto(id_def_proyecto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)

WITH (oids = false);

--------------- SQL ---------------

CREATE TABLE sp.tdef_proyecto_seguimiento_actividad (
  id_def_proyecto_seguimiento_actividad SERIAL NOT NULL,
  id_def_proyecto_seguimiento INTEGER,
  id_def_proyecto_actividad INTEGER,
  porcentaje_avance NUMERIC(6,3),
  PRIMARY KEY(id_def_proyecto_seguimiento_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-SP-0-08/03/2017****************************************/


