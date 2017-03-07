<?php
/**
*@package pXP
*@file MODDefProyectoActividad.php
*@author  (admin)
*@date 10-11-2016 06:41:48
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDefProyectoActividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDefProyectoActividad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_actividad_sel';
		$this->transaccion='SP_DEPRAC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_def_proyecto_actividad','int4');
		$this->captura('id_def_proyecto','int4');
		$this->captura('id_actividad','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('actividad','varchar');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('max_fecha_orden','varchar');
		$this->captura('min_fecha_orden','varchar');
		$this->captura('max_fecha_entrega','varchar');
		$this->captura('min_fecha_entrega','varchar');
		$this->captura('monto_suma','double precision');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDefProyectoActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_actividad_ime';
		$this->transaccion='SP_DEPRAC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDefProyectoActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_actividad_ime';
		$this->transaccion='SP_DEPRAC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDefProyectoActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_actividad_ime';
		$this->transaccion='SP_DEPRAC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function insertarDefinicionProyectosActividades(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_actividad_ime';
		$this->transaccion='SP_DEPRACS_INS';
		$this->tipo_procedimiento='IME';
				
			
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('id_actividades','id_actividades','varchar');
		
	

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>