<?php

/**
 * @package pXP
 * @file MODDefProyectoActividad.php
 * @author  (admin)
 * @date 10-11-2016 06:41:48
 * @description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */
class MODDefProyectoActividad extends MODbase
{

    function __construct(CTParametro $pParam)
    {
        parent::__construct($pParam);
    }

    function listarDefProyectoActividad()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_sel';
        $this->transaccion = 'SP_DEPRAC_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion
        $this->setCount(false);


        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');

        //Definicion de la lista del resultado del query
        $this->captura('id_def_proyecto_actividad', 'int4');
        $this->captura('id_def_proyecto', 'int4');
        $this->captura('id_actividad', 'int4');
        $this->captura('descripcion', 'varchar');
        $this->captura('actividad', 'varchar');
        $this->captura('min_fecha_orden', 'date');
        $this->captura('max_fecha_entrega', 'date');
        $this->captura('plazo', 'int4');
        $this->captura('monto_suma', 'numeric');
        $this->captura('tipo_actividad', 'int4');
        $this->captura('ancestors', 'varchar');
        $this->captura('nivel', 'int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function insertarDefProyectoActividad()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_ime';
        $this->transaccion = 'SP_DEPRAC_INS';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');
        $this->setParametro('id_actividad', 'id_actividad', 'int4');
        $this->setParametro('estado_reg', 'estado_reg', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function modificarDefProyectoActividad()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_ime';
        $this->transaccion = 'SP_DEPRAC_MOD';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_def_proyecto_actividad', 'id_def_proyecto_actividad', 'int4');
        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');
        $this->setParametro('id_actividad', 'id_actividad', 'int4');
        $this->setParametro('estado_reg', 'estado_reg', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function eliminarDefProyectoActividad()
    {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_ime';
        $this->transaccion = 'SP_DEPRAC_ELI';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_def_proyecto_actividad', 'id_def_proyecto_actividad', 'int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function insertarDefinicionProyectosActividades()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_ime';
        $this->transaccion = 'SP_DEPRACS_INS';
        $this->tipo_procedimiento = 'IME';


        //Define los parametros para la funcion
        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');
        $this->setParametro('id_actividades', 'id_actividades', 'varchar');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function listarProyectoSeguimientoActividad()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_sel';
        $this->setCount(false);
        $this->transaccion = 'SP_PROSEG_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion

        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');
        //Definicion de la lista del resultado del query
        $this->captura('id_def_proyecto_actividad', 'int4');
        $this->captura('id_def_proyecto', 'int4');
        $this->captura('id_actividad', 'int4');
        $this->captura('actividad', 'varchar');
        $this->captura('porcentaje', 'numeric');
        $this->captura('id_def_proyecto_seguimiento_actividad', 'int4');
        $this->captura('nivel', 'int4');
        $this->captura('interno', 'numeric');
        $this->captura('tipo', 'int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function listarProyectoSeguimientoActividadEditar()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_sel';
        $this->setCount(false);
        $this->transaccion = 'SP_PROSEGE_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion
        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');

        //Definicion de la lista del resultado del query

        $this->captura('id_def_proyecto_actividad', 'int4');
        $this->captura('id_def_proyecto', 'int4');
        $this->captura('id_actividad', 'int4');
        $this->captura('actividad', 'varchar');
        $this->captura('porcentaje', 'numeric');
        $this->captura('id_def_proyecto_seguimiento_actividad', 'int4');
        $this->captura('nivel', 'int4');
        $this->captura('interno', 'numeric');
        $this->captura('tipo', 'int4');


        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function listarProyectoSeguimientoActividadTotal()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_sel';
        $this->setCount(false);
        $this->transaccion = 'SP_PROSEGAT_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion

        //envia parametros a la transaccion
        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');
        //Definicion de la lista del resultado del query
        $this->captura('v_id_def_proyecto_actividad', 'int4');
        // $this->captura('id_def_proyecto', 'int4');
        $this->captura('v_id_actividad', 'int4');
        $this->captura('v_actividad', 'varchar');
        $this->captura('estado', 'varchar');
        $this->captura('id_tipo', 'int4');
        $this->captura('tipo', 'varchar');
        $this->captura('id_proy_seguimiento_actividad_estado', 'int4');
        $this->captura('id_def_proyecto_seguimiento_total', 'int4');
        $this->captura('v_nivel', 'int4');
        $this->captura('id_estado_seguimiento', 'int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    function listarProyectoSeguimientoActividadTotalEditar()
    {
        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento = 'sp.ft_def_proyecto_actividad_sel';
        $this->setCount(false);
        $this->transaccion = 'SP_PROSEGAT_EDIT_SEL';
        $this->tipo_procedimiento = 'SEL';//tipo de transaccion

        //envia parametros a la transaccion
        $this->setParametro('id_def_proyecto', 'id_def_proyecto', 'int4');
        $this->setParametro('id_def_proyecto_seguimiento_total', 'id_def_proyecto_seguimiento_total', 'int4');


        //Definicion de la lista del resultado del query
        $this->captura('v_id_def_proyecto_actividad', 'int4');
        // $this->captura('id_def_proyecto', 'int4');
        $this->captura('v_id_actividad', 'int4');
        $this->captura('v_actividad', 'varchar');
        $this->captura('estado', 'varchar');
        $this->captura('id_tipo', 'int4');
        $this->captura('tipo', 'varchar');
        $this->captura('id_proy_seguimiento_actividad_estado', 'int4');
        $this->captura('id_def_proyecto_seguimiento_total', 'int4');
        $this->captura('v_nivel', 'int4');
        $this->captura('id_estado_seguimiento', 'int4');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
}

?>