<?php
/**
*@package pXP
*@file gen-MODDefProyectoSeguimientoTotal.php
*@author  (admin)
*@date 13-11-2016 20:28:07
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDefProyectoSeguimientoTotal extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDefProyectoSeguimientoTotal(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_total_sel';
		$this->transaccion='SP_PRSETO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_def_proyecto_seguimiento_total','int4');
		$this->captura('id_def_proyecto','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('fecha','date');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDefProyectoSeguimientoTotal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_total_ime';
		$this->transaccion='SP_PRSETO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha','fecha','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDefProyectoSeguimientoTotal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_total_ime';
		$this->transaccion='SP_PRSETO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento_total','id_def_proyecto_seguimiento_total','int4');
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha','fecha','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDefProyectoSeguimientoTotal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_total_ime';
		$this->transaccion='SP_PRSETO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento_total','id_def_proyecto_seguimiento_total','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarEstadosSeguimiento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_total_sel';
		$this->transaccion='SP_ESTADO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
	    $this->setParametro('id_tipo','id_tipo','int4');
		
		//Definicion de la lista del resultado del query
		$this->captura('id_estado_seguimiento','int4');
		$this->captura('estado','varchar');
		$this->captura('id_tipo','int4');

	  
				
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
	function insertarFormEstado(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='sp.ft_def_proyecto_seguimiento_total_ime';
        $this->transaccion='SP_PRSETO_INS';
        $this->tipo_procedimiento='IME';

        //Define los parametros para la funcion
        //$this->setParametro('id_def_proyecto_seguimiento_total','id_def_proyecto_seguimiento_total','int4');
		
        $this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('id_def_proyecto_seguimiento_total', 'id_def_proyecto_seguimiento_total', 'int4');	
			
        $this->setParametro('fecha','fecha','date');
        $this->setParametro('descripcion','descripcion','varchar');
		
        //$this->setParametro('porcentaje','porcentaje','numeric');
		
        $this->setParametro('id_estado_seguimiento','id_estado_seguimiento','int4');
		$this->setParametro('v_id_def_proyecto_actividad','v_id_def_proyecto_actividad','int4');
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