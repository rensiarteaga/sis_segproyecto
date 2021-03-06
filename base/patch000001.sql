

/***********************************I-SCP-YAC-SP-0-13/02/2017****************************************/

CREATE TABLE sp.tactividad (
  id_actividad SERIAL NOT NULL,
  actividad VARCHAR(150),
  id_actividad_padre INTEGER,
  PRIMARY KEY(id_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SP-0-13/02/2017****************************************/
/***********************************I-SCP-YAC-SP-0-14/02/2017****************************************/

-- confgiuracion para el acceso a base de datos sql server 172.18.79.22
CREATE EXTENSION IF NOT EXISTS tds_fdw;

CREATE SERVER mssql_csa_prod
FOREIGN DATA WRAPPER tds_fdw
OPTIONS (servername '172.18.79.22', port '1433');


CREATE USER MAPPING FOR postgres
SERVER mssql_csa_prod
OPTIONS (username 'usrPXP', password 'usrPXP2kk7prod');


CREATE USER MAPPING FOR dbkerp_admin
SERVER mssql_csa_prod
OPTIONS (username 'usrPXP', password 'usrPXP2kk7prod');

CREATE USER MAPPING FOR dbetr_capacitacion_admin
SERVER mssql_csa_prod
OPTIONS (username 'usrPXP', password 'usrPXP2kk7prod');


CREATE USER MAPPING FOR "dbetr_capacitacion_jorge.heredia"
SERVER mssql_csa_prod
OPTIONS (username 'usrPXP', password 'usrPXP2kk7prod');

/***********************************F-SCP-YAC-SP-0-14/02/2017****************************************/
/***********************************I-SCP-YAC-SP-1-14/02/2017****************************************/

-- diseñado la tabla foranea del csa proyecto pedido invitacion
-- usamos el bytea para poder recibir los nvchar de sql server
-- En la consulta de sql server es necesario poner un alias(as)cuando se recupera de una nvchar
DROP VIEW IF EXISTS sp.vcsa_proyecto_pedido;
DROP FOREIGN TABLE IF EXISTS sp.csa_proyecto_pedido;
CREATE FOREIGN TABLE sp.csa_proyecto_pedido (
  idproyecto                    INTEGER NULL,
  codproyecto                   BYTEA NULL,
  nombre                        BYTEA NULL,
  idpedido                      INTEGER NULL,
  nrosap                        BYTEA NULL,
  pedido                        BYTEA NULL,
  nrocontrato                   BYTEA NULL,
  fechaautorizacionpedido       BYTEA NULL,
  fechaordenproceder            BYTEA NULL,
  plazo_entrega_contrato        INTEGER NULL,
  plazo_entrega_contrato_unidad BYTEA NULL,
  fecha_entrega_contrato_prev   BYTEA NULL,
  monto                         FLOAT NULL,
  monedamonto                   INTEGER NULL,
  plazo                         INTEGER NULL,
  monto_total                   FLOAT NULL,
  idinvitacion                  INTEGER NULL,
  codinvitacion                 BYTEA NULL,
  suministro                    BYTEA NULL
)
SERVER mssql_csa_prod
OPTIONS (QUERY 'SELECT
  idproyecto,
  cast(codproyecto AS NVARCHAR(20))                     AS codproyecto,
  cast(nombre AS NVARCHAR(255))                         AS nombre,
  idpedido,
  cast(nrosap AS NVARCHAR(15))                          AS nrosap,
  cast(pedido AS NVARCHAR(255))                         AS pedido,
  cast(nrocontrato AS NVARCHAR(20))                     AS nrocontrato,
  cast(fechaautorizacionpedido AS NVARCHAR(10))         AS fechaautorizacionpedido,
  cast(fechaordenproceder AS NVARCHAR(30))              AS fechaordenproceder,
  plazo_entrega_contrato,
  cast(plazo_entrega_contrato_unidad AS NVARCHAR(2))    AS plazo_entrega_contrato_unidad,
  cast(fecha_entrega_contrato_previsto AS NVARCHAR(20)) AS fecha_entrega_contrato_prev,
  monto,
  monedamonto,
  plazo,
  monto_total,
  idinvitacion,
  cast(CodInvitacion as NVARCHAR(20)) as codinvitacion,
  cast(Suministro as NVARCHAR(255)) as suministro
FROM csa_prod.dbo.proyecto_pedido'
);

-- creando la vista del proyecto
-- para crear la vista debemos de poner el as por que si no el convert_form da errores
CREATE OR REPLACE VIEW sp.vcsa_proyecto_pedido AS
  SELECT
    DISTINCT
    idproyecto                                                       AS id_proyecto,
    convert_from(codproyecto, 'LATIN1') :: VARCHAR                   AS codproyecto,
    convert_from(nombre, 'LATIN1') :: VARCHAR                        AS nombre,
    idpedido                                                         AS id_pedido,
    convert_from(nrosap, 'LATIN1') :: VARCHAR                        AS nrosap,
    convert_from(pedido, 'LATIN1') :: VARCHAR                        AS pedido,
    convert_from(nrocontrato, 'LATIN1') :: VARCHAR                   AS nrocontrato,
    convert_from(fechaautorizacionpedido, 'LATIN1') :: VARCHAR       AS fechaautorizacionpedido,
    convert_from(fechaordenproceder, 'LATIN1') :: VARCHAR            AS fechaordenproceder,
    plazo_entrega_contrato,
    convert_from(plazo_entrega_contrato_unidad, 'LATIN1') :: VARCHAR AS plazo_entrega_contrato_unidad,
    convert_from(fecha_entrega_contrato_prev, 'LATIN1') :: VARCHAR   AS fecha_entrega_contrato_prev,
    monto,
    monedamonto,
    plazo,
    monto_total,
    idinvitacion,
    convert_from(codinvitacion, 'LATIN1'):: VARCHAR as codinvitacion,
    convert_from(suministro, 'LATIN1')::VARCHAR as suministro
  FROM sp.csa_proyecto_pedido;

/***********************************F-SCP-YAC-SP-1-14/02/2017****************************************/

/***********************************I-SCP-YAC-SP-0-01/03/2017****************************************/

CREATE TABLE sp.tdef_proyecto (
  id_def_proyecto SERIAL NOT NULL,
  id_proyecto INTEGER,
  fecha_inicio_teorico DATE,
  fecha_fin_teorico DATE,
  descripcion TEXT,
  PRIMARY KEY(id_def_proyecto)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sp.tdef_proyecto_actividad (
  id_def_proyecto_actividad SERIAL NOT NULL,
  id_def_proyecto INTEGER,
  id_actividad INTEGER,
  descripcion VARCHAR(250),
  PRIMARY KEY(id_def_proyecto_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-YAC-SP-0-01/03/2017****************************************/

/***********************************I-SCP-JUAN-SP-0-03/03/2017****************************************/


CREATE TABLE sp.tdef_proyecto_actividad_pedido (
  id_def_proyecto_actividad_pedido SERIAL NOT NULL,
  id_def_proyecto_actividad INTEGER,
  id_pedido INTEGER,
  PRIMARY KEY(id_def_proyecto_actividad_pedido)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-SP-0-03/03/2017****************************************/


/***********************************I-SCP-JUAN-SP-0-08/03/2017****************************************/


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



CREATE TABLE sp.tdef_proyecto_seguimiento_actividad (
  id_def_proyecto_seguimiento_actividad SERIAL NOT NULL,
  id_def_proyecto_seguimiento INTEGER,
  id_def_proyecto_actividad INTEGER,
  porcentaje_avance NUMERIC(6,3),
  PRIMARY KEY(id_def_proyecto_seguimiento_actividad)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-SP-0-08/03/2017****************************************/
/***********************************I-SCP-YAC-SP-0-20/03/2017****************************************/

ALTER TABLE sp.tactividad
  ADD COLUMN tipo_actividad VARCHAR(100);

/***********************************F-SCP-YAC-SP-0-20/03/2017****************************************/
/***********************************I-SCP-YAC-SP-0-27/03/2017****************************************/

ALTER TABLE sp.tactividad
  ADD COLUMN id_tipo INTEGER;



ALTER TABLE sp.tactividad
  ADD CONSTRAINT tactividad_fk FOREIGN KEY (id_tipo)
REFERENCES sp.ttipo(id_tipo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/***********************************F-SCP-YAC-SP-0-27/03/2017****************************************/
/***********************************I-SCP-YAC-SP-0-30/03/2017****************************************/

CREATE TABLE sp.tsuministro (
  id_seguimiento_suministro SERIAL NOT NULL,
  id_def_proyecto INTEGER,
  id_def_proyecto_actividad INTEGER,
  invitacion BIT(1),
  adjudicacion BIT(1),
  documento_emarque BIT(1),
  llegada_sitio BIT(1),
  PRIMARY KEY(id_seguimiento_suministro)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-YAC-SP-0-30/03/2017****************************************/


/***********************************I-SCP-JUAN-SP-0-31/03/2017****************************************/


CREATE TABLE sp.ttipo (
  id_tipo SERIAL NOT NULL,
  tipo VARCHAR(100),
  PRIMARY KEY(id_tipo)
) INHERITS (pxp.tbase)

WITH (oids = false);



CREATE TABLE sp.testado_seguimiento (
  id_estado_seguimiento SERIAL NOT NULL,
  estado VARCHAR(100),
  id_tipo INTEGER,
  PRIMARY KEY(id_estado_seguimiento)
) INHERITS (pxp.tbase)

WITH (oids = false);



CREATE TABLE sp.tdef_proyecto_seguimiento_total (
  id_def_proyecto_seguimiento_total SERIAL NOT NULL,
  id_def_proyecto INTEGER,
  fecha DATE,
  descripcion VARCHAR(500),
  PRIMARY KEY(id_def_proyecto_seguimiento_total)
) INHERITS (pxp.tbase)

WITH (oids = false);



CREATE TABLE sp.tproy_seguimiento_actividad_estado (
  id_proy_seguimiento_actividad_estado SERIAL,
  id_estado_seguimiento INTEGER,
  id_def_proyecto_seguimiento_total INTEGER,
  id_proyecto_actividad INTEGER,
  PRIMARY KEY(id_proy_seguimiento_actividad_estado)
) INHERITS (pxp.tbase)
WITH (oids = false);
/***********************************F-SCP-JUAN-SP-0-31/03/2017****************************************/
/***********************************I-SCP-YAC-SP-0-18/05/2017****************************************/
ALTER TABLE sp.tdef_proyecto_actividad_pedido
  ADD COLUMN monto NUMERIC;

ALTER TABLE sp.tdef_proyecto_actividad_pedido
  ADD COLUMN porcentaje NUMERIC;
/***********************************F-SCP-YAC-SP-0-18/05/2017****************************************/
