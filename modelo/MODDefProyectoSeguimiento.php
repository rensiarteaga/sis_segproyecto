<?php
/**
*@package pXP
*@file gen-MODDefProyectoSeguimiento.php
*@author  (admin)
*@date 24-02-2017 04:16:20
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDefProyectoSeguimiento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDefProyectoSeguimiento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_sel';
		$this->transaccion='SP_SEPR_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_def_proyecto_seguimiento','int4');
		$this->captura('id_def_proyecto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('porcentaje','numeric');
		$this->captura('fecha','date');
		$this->captura('descripcion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDefProyectoSeguimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_ime';
		$this->transaccion='SP_SEPR_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porcentaje','porcentaje','numeric');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDefProyectoSeguimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_ime';
		$this->transaccion='SP_SEPR_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento','id_def_proyecto_seguimiento','int4');
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porcentaje','porcentaje','numeric');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDefProyectoSeguimiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_ime';
		$this->transaccion='SP_SEPR_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento','id_def_proyecto_seguimiento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
    function insertarFormDefProyectoSeguimiento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='sp.ft_def_proyecto_seguimiento_ime';
        $this->transaccion='SP_FSEPR_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        $this->setParametro('id_def_proyecto_seguimiento','id_def_proyecto_seguimiento','int4');
        $this->setParametro('id_def_proyecto','id_def_proyecto','int4');
        $this->setParametro('fecha','fecha','date');
        $this->setParametro('descripcion','descripcion','varchar');
        $this->setParametro('porcentaje','porcentaje','numeric');
        $this->setParametro('id_actividad_padre','id_actividad_padre','int4');
        $this->setParametro('tipo_form','tipo_form','varchar');

        $this->setParametro('json_new_records','json_new_records','json_text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>