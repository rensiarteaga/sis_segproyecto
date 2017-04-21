/***********************************I-DEP-RAC-SP-0-01/02/2017*****************************************/

select pxp.f_insert_testructura_gui ('SEP', 'SISTEMA');


ALTER TABLE sp.tactividad
  ADD CONSTRAINT tactividad__id_actividad_fk FOREIGN KEY (id_actividad_padre)
    REFERENCES sp.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/***********************************F-DEP-RAC-SP-0-01/02/2017*****************************************/

/***********************************I-DEP-RAC-SP-0-01/03/2017*****************************************/

ALTER TABLE sp.tdef_proyecto_actividad
  ADD CONSTRAINT tdef_proyecto_actividad_fk FOREIGN KEY (id_def_proyecto)
    REFERENCES sp.tdef_proyecto(id_def_proyecto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE sp.tdef_proyecto_actividad
  ADD CONSTRAINT tdef_proyecto_actividad_fk1 FOREIGN KEY (id_actividad)
    REFERENCES sp.tactividad(id_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


/***********************************I-DEP-YAC-SP-0-01/03/2017*****************************************/

select pxp.f_insert_testructura_gui ('SP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ACTI', 'SP');
select pxp.f_insert_testructura_gui ('PRAC', 'SP');

ALTER TABLE sp.tdef_proyecto_actividad_pedido
  ADD CONSTRAINT tdef_proyecto_actividad_pedido_fk FOREIGN KEY (id_def_proyecto_actividad)
    REFERENCES sp.tdef_proyecto_actividad(id_def_proyecto_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-YAC-SP-0-03/03/2017*****************************************/

/***********************************I-DEP-JUAN-SP-0-08/03/2017*****************************************/
ALTER TABLE sp.tdef_proyecto_seguimiento
  ADD CONSTRAINT tdef_proyecto_seguimiento_fk FOREIGN KEY (id_def_proyecto)
    REFERENCES sp.tdef_proyecto(id_def_proyecto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE sp.tdef_proyecto_seguimiento_actividad
  ADD CONSTRAINT tdef_proyecto_seguimiento_actividad_fk FOREIGN KEY (id_def_proyecto_seguimiento)
    REFERENCES sp.tdef_proyecto_seguimiento(id_def_proyecto_seguimiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE sp.tdef_proyecto_seguimiento_actividad
  ADD CONSTRAINT tdef_proyecto_seguimiento_actividad_fk1 FOREIGN KEY (id_def_proyecto_actividad)
    REFERENCES sp.tdef_proyecto_actividad(id_def_proyecto_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-JUAN-SP-0-08/03/2017*****************************************/
/***********************************I-DEP-YAC-SP-0-30/03/2017*****************************************/
ALTER TABLE sp.tsuministro
  ADD CONSTRAINT tsuministro_fk FOREIGN KEY (id_def_proyecto)
    REFERENCES sp.tdef_proyecto(id_def_proyecto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE sp.tsuministro
  ADD CONSTRAINT tsuministro_fk1 FOREIGN KEY (id_def_proyecto_actividad)
    REFERENCES sp.tdef_proyecto_actividad(id_def_proyecto_actividad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-YAC-SP-0-30/03/2017*****************************************/
/***********************************I-DEP-JUAN-SP-0-31/03/2017*****************************************/

ALTER TABLE sp.testado_seguimiento
  ADD CONSTRAINT testado_seguimiento_fk FOREIGN KEY (id_tipo)
    REFERENCES sp.ttipo(id_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE sp.tdef_proyecto_seguimiento_total
  ADD CONSTRAINT tdef_proyecto_seguimiento_total_fk FOREIGN KEY (id_def_proyecto)
    REFERENCES sp.tdef_proyecto(id_def_proyecto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE sp.tproy_seguimiento_actividad_estado
  ADD CONSTRAINT tproy_seguimiento_actividad_estado_fk FOREIGN KEY (id_estado_seguimiento)
    REFERENCES sp.testado_seguimiento(id_estado_seguimiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-JUAN-SP-0-31/03/2017*****************************************/
/***********************************I-DEP-YAC-SP-0-02/04/2017*****************************************/

select pxp.f_delete_testructura_gui ('SEP', 'SISTEMA');
select pxp.f_delete_testructura_gui ('ACTI', 'SP');
select pxp.f_insert_testructura_gui ('SP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('PRAC', 'SP');
select pxp.f_delete_testructura_gui ('PRSECO', 'SP');
select pxp.f_delete_testructura_gui ('PRSECO', 'SP');
select pxp.f_delete_testructura_gui ('PRSETO', 'PRSECO');
select pxp.f_delete_testructura_gui ('PRSETO', 'SP');
select pxp.f_delete_testructura_gui ('ACTI', 'SP');
select pxp.f_insert_testructura_gui ('ACTI', 'SP');
select pxp.f_insert_testructura_gui ('SEPROPONd', 'SP');
select pxp.f_insert_testructura_gui ('PRSECO', 'SEPROPONd');
select pxp.f_insert_testructura_gui ('PRSETO', 'SEPROPONd');


select pxp.f_insert_testructura_gui ('SP', 'SISTEMA');
select pxp.f_delete_testructura_gui ('ACTI', 'SP');
select pxp.f_insert_testructura_gui ('PRAC', 'SP');
select pxp.f_delete_testructura_gui ('ACTI', 'SP');
select pxp.f_insert_testructura_gui ('SEPROPONd', 'SP');
select pxp.f_delete_testructura_gui ('PRSECO', 'SEPROPONd');
select pxp.f_delete_testructura_gui ('PRSETO', 'SEPROPONd');
select pxp.f_delete_testructura_gui ('PRSETO', 'SP');
select pxp.f_insert_testructura_gui ('PRSETO', 'SP');
select pxp.f_insert_testructura_gui ('PRSECO', 'SP');
select pxp.f_insert_testructura_gui ('ACTI', 'SEPROPONd');

/***********************************F-DEP-YAC-SP-0-02/04/2017*****************************************/
/***********************************I-DEP-YAC-SP-0-05/04/2017*****************************************/
select pxp.f_delete_testructura_gui ('ACTI', 'SP');
select pxp.f_delete_testructura_gui ('PRSECO', 'SEPROPONd');
select pxp.f_delete_testructura_gui ('PRSETO', 'SEPROPONd');
select pxp.f_delete_testructura_gui ('PRSETO', 'SP');
select pxp.f_insert_testructura_gui ('PRSETO', 'SP');
select pxp.f_insert_testructura_gui ('PRSECO', 'SP');
select pxp.f_insert_testructura_gui ('ACTI', 'SEPROPONd');
/***********************************F-DEP-YAC-SP-0-05/04/2017*****************************************/
/***********************************I-DEP-YAC-SP-0-12/04/2017*****************************************/
-- agregando la propiedad de eliminacion en cascada.

ALTER TABLE sp.tactividad DROP CONSTRAINT tactividad__id_actividad_fk;
ALTER TABLE sp.tactividad
ADD CONSTRAINT tactividad__id_actividad_fk
FOREIGN KEY (id_actividad_padre) REFERENCES tactividad (id_actividad) ON DELETE CASCADE;

ALTER TABLE sp.tsuministro DROP CONSTRAINT tsuministro_fk;
ALTER TABLE sp.tsuministro
ADD CONSTRAINT tsuministro_fk
FOREIGN KEY (id_def_proyecto) REFERENCES tdef_proyecto (id_def_proyecto) ON DELETE CASCADE;

ALTER TABLE sp.tdef_proyecto_seguimiento_total DROP CONSTRAINT tdef_proyecto_seguimiento_total_fk;
ALTER TABLE sp.tdef_proyecto_seguimiento_total
ADD CONSTRAINT tdef_proyecto_seguimiento_total_fk
FOREIGN KEY (id_def_proyecto) REFERENCES tdef_proyecto (id_def_proyecto) ON DELETE CASCADE;

ALTER TABLE sp.tdef_proyecto_actividad DROP CONSTRAINT tdef_proyecto_actividad_fk;
ALTER TABLE sp.tdef_proyecto_actividad
ADD CONSTRAINT tdef_proyecto_actividad_fk
FOREIGN KEY (id_def_proyecto) REFERENCES tdef_proyecto (id_def_proyecto) ON DELETE CASCADE;

ALTER TABLE sp.tdef_proyecto_seguimiento DROP CONSTRAINT tdef_proyecto_seguimiento_fk;
ALTER TABLE sp.tdef_proyecto_seguimiento
ADD CONSTRAINT tdef_proyecto_seguimiento_fk
FOREIGN KEY (id_def_proyecto) REFERENCES tdef_proyecto (id_def_proyecto) ON DELETE CASCADE;

ALTER TABLE sp.tdef_proyecto_seguimiento_actividad DROP CONSTRAINT tdef_proyecto_seguimiento_actividad_fk1;
ALTER TABLE sp.tdef_proyecto_seguimiento_actividad
ADD CONSTRAINT tdef_proyecto_seguimiento_actividad_fk1
FOREIGN KEY (id_def_proyecto_actividad) REFERENCES tdef_proyecto_actividad (id_def_proyecto_actividad) ON DELETE CASCADE;

ALTER TABLE sp.tdef_proyecto_actividad_pedido DROP CONSTRAINT tdef_proyecto_actividad_pedido_fk;
ALTER TABLE sp.tdef_proyecto_actividad_pedido
ADD CONSTRAINT tdef_proyecto_actividad_pedido_fk
FOREIGN KEY (id_def_proyecto_actividad) REFERENCES tdef_proyecto_actividad (id_def_proyecto_actividad) ON DELETE CASCADE;

/***********************************F-DEP-YAC-SP-0-12/04/2017*****************************************/

/***********************************I-DEP-YAC-SP-0-17/04/2017*****************************************/
ALTER TABLE sp.tsuministro
  DROP CONSTRAINT tsuministro_fk RESTRICT;

  ALTER TABLE sp.tsuministro
  ADD COLUMN id_def_proyecto_seguimiento INTEGER;

  ALTER TABLE sp.tsuministro
  ADD CONSTRAINT tsuministro_fk FOREIGN KEY (id_def_proyecto_seguimiento)
    REFERENCES sp.tdef_proyecto_seguimiento(id_def_proyecto_seguimiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-YAC-SP-0-17/04/2017*****************************************/

