/********************************************I-DAT-RAC-SEP-0-15/01/2013********************************************/

/* Data for the 'segu.tsubsistema' table  (Records 1 - 1) */

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES 
  (E'SP', E'Seguimiento de Proyectos', E'2017-02-13', E'SP', E'activo', E'segproyecto', NULL);
  
  ----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');

  
  
/********************************************F-DAT-RAC-SEP-0-15/01/2013********************************************/


/********************************************I-DAT-YAC-SP-0-20/02/2017********************************************/

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
----------------------------------
--COPY LINES TO dependencies.sql FILE  
---------------------------------

select pxp.f_insert_testructura_gui ('SP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ACTI', 'SP');

/********************************************F-DAT-YAC-SP-0-20/02/2017********************************************/

/********************************************I-DAT-YAC-SP-0-03/03/2017********************************************/

select pxp.f_insert_tgui ('SEGUIMIENTO DE PROYECTOS', '', 'SP', 'si', 1, '', 1, '', '', 'SP');
select pxp.f_insert_tgui ('Actividades', 'actividades', 'ACTI', 'si', 1, 'sis_segproyecto/vista/actividad/ActividadPadre.php', 2, '', 'ActividadPadre', 'SP');
select pxp.f_insert_tgui ('Proyecto actividad', 'Proyectos Actividades', 'PRAC', 'si', 1, 'sis_segproyecto/vista/def_proyecto/DefProyecto.php', 2, '', 'DefProyecto', 'SP');

/********************************************F-DAT-YAC-SP-0-03/03/2017********************************************/

/********************************************I-DAT-YAC-SP-0-17/03/2017********************************************/

CREATE OR REPLACE FUNCTION sp.ft_registro_actividad(actividad_padre VARCHAR, actividades_hijos VARCHAR [])
  RETURNS BOOL AS
$$ DECLARE
  hijo           VARCHAR;
  v_id_actividad INTEGER;
  valor BOOL := FALSE ;
BEGIN

  INSERT INTO sp.tactividad (fecha_reg, actividad, id_actividad_padre)
  VALUES (now()  , actividad_padre, NULL)
  RETURNING id_actividad INTO v_id_actividad;
  FOREACH hijo IN ARRAY (actividades_hijos) LOOP
    INSERT INTO sp.tactividad (fecha_reg, actividad, id_actividad_padre)
    VALUES (now() ,hijo, v_id_actividad);
    valor := true;
  END LOOP;
  return valor;
END; $$ LANGUAGE plpgsql;



-------realizando el registro de las actividades

SELECT sp.ft_registro_actividad('Ingeniería del proyecto'::VARCHAR,ARRAY['Norma 30','Compra de terreno','Planos aprobados para invitación']);
SELECT sp.ft_registro_actividad('Suministros subestaciones'::VARCHAR,ARRAY['Porticos','Estructuras soporte','Interruptores','Seccionadores','PT''s CT''s','Pararrayos','Transformador de potencia','Tableros control y protecciones','Telecomunicaciones','Cables de Control y potencia','Otros varios (menores a 50.000 Bs.)']);
SELECT sp.ft_registro_actividad('Conformación plataforma'::VARCHAR,ARRAY['Instalación faenas','Relevamiento topografico','Limpieza y retiro de capa vegetal (orgánico)','Excavación no clasificada.','Rellenos Compactados','Cerco perimetral de malla olímpica con postes de hormigón de 3.50 metros','Construcción sitemas de drenajes']);
SELECT sp.ft_registro_actividad('Construcción Sala de Control'::VARCHAR,ARRAY['Instalación faenas','Replanteo y excavaciones','Fundaciones, columnas y vigas','Construcción de Muros','Construcción Techo ','Zanjas sala de control','Conformación del piso de la sala','Instalación carpinteria en sala','Instalaciones sanitarias y electricas','Pintura y acabados sala de control']);
SELECT sp.ft_registro_actividad('Obras Civiles de Patio'::VARCHAR,ARRAY['Instalación faenas','Replanteo y excavaciones','fundaciones pórtico y equipos','Fundación transformador','Malla de tierra','Zanjas de patio','Fundaciones tableros intermediarios','Fundaciones postes iluminación eterna','Cerco o muro perimetral','Drenajes internos','Cordones de protección','Tendido de grava']);
SELECT sp.ft_registro_actividad('Montaje electromecanico S/E'::VARCHAR,ARRAY['Instalación faenas','Montaje porticos y soportes equipos','Sistema de barras en alta tension','Sistema de barras rigidas','Montaje interruptores','Montaje seccionadores','Montaje PT''s y CT''s','Montaje otros equipos','Montaje del Transformador','Instalación iluminación de patio','Conexionado cables C&P','Comissioning C&P','Estudios Norma Operativa 8, 11 y 17','Pruebas a equipos de patio y C&P','Puesta en servicio']);
SELECT sp.ft_registro_actividad('Cierre de proyecto'::VARCHAR,ARRAY['Informe puesta en sevicio','Cierre Contable del proyecto']);

/********************************************F-DAT-YAC-SP-0-17/03/2017********************************************/
/********************************************I-DAT-YAC-SP-0-20/03/2017********************************************/
create or REPLACE FUNCTION sp.ft_cantidad_cadena_caracter(cadena VARCHAR,caracter VARCHAR) RETURNS INTEGER AS
$$
DECLARE
  resultado INTEGER;
BEGIN

  resultado := LENGTH(cadena) - LENGTH(REPLACE(cadena, caracter, ''));

  RETURN resultado;
END;
$$
LANGUAGE 'plpgsql';
/********************************************F-DAT-YAC-SP-0-20/03/2017********************************************/
