<?php
/**
*@package pXP
*@file gen-MODDefProyectoSeguimientoActividad.php
*@author  (admin)
*@date 24-02-2017 05:02:05
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDefProyectoSeguimientoActividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDefProyectoSeguimientoActividad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_actividad_sel';
		$this->transaccion='SP_PRSEAC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_def_proyecto_seguimiento_actividad','int4');
		$this->captura('id_def_proyecto_seguimiento','int4');
		$this->captura('id_def_proyecto_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('porcentaje_avance','numeric');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
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
			
	function insertarDefProyectoSeguimientoActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_actividad_ime';
		$this->transaccion='SP_PRSEAC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento','id_def_proyecto_seguimiento','int4');
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porcentaje_avance','porcentaje_avance','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDefProyectoSeguimientoActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_actividad_ime';
		$this->transaccion='SP_PRSEAC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento_actividad','id_def_proyecto_seguimiento_actividad','int4');
		$this->setParametro('id_def_proyecto_seguimiento','id_def_proyecto_seguimiento','int4');
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('porcentaje_avance','porcentaje_avance','numeric');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDefProyectoSeguimientoActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_seguimiento_actividad_ime';
		$this->transaccion='SP_PRSEAC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_seguimiento_actividad','id_def_proyecto_seguimiento_actividad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>