<?php
/**
*@package pXP
*@file gen-MODSuministro.php
*@author  (admin)
*@date 12-11-2016 14:03:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODSuministro extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarSuministro(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_suministro_sel';
		$this->transaccion='SP_SUM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_seguimiento_suministro','int4');
        $this->captura('tipo_guardar','bool');
		$this->captura('id_def_proyecto','int4');
		$this->captura('id_def_proyecto_actividad','int4');
		$this->captura('actividad','varchar');

        //$this->captura('estado_reg','varchar');
        $this->captura('documento_emarque','bit');
        $this->captura('invitacion','bit');
		$this->captura('adjudicacion','bit');
		$this->captura('llegada_sitio','bit');
		$this->captura('padre','bool');

		//$this->captura('fecha_reg','timestamp');
		//$this->captura('usuario_ai','varchar');
		//$this->captura('id_usuario_reg','int4');
		//$this->captura('id_usuario_ai','int4');
		//$this->captura('id_usuario_mod','int4');
		/*$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');*/
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarSuministro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_suministro_ime';
		$this->transaccion='SP_SUM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('documento_emarque','documento_emarque','bit');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('invitacion','invitacion','bit');
		$this->setParametro('adjudicacion','adjudicacion','bit');
		$this->setParametro('llegada_sitio','llegada_sitio','bit');
        $this->setParametro('tipo_guardar','tipo_guardar','bool');
        $this->setParametro('id_seguimiento_suministro','id_seguimiento_suministro','int4');

		 $this->setParametro('padre','padre','bool');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarSuministro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_suministro_ime';
		$this->transaccion='SP_SUM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_seguimiento_suministro','id_seguimiento_suministro','int4');
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('documento_emarque','documento_emarque','bit');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('invitacion','invitacion','bit');
		$this->setParametro('adjudicacion','adjudicacion','bit');
		$this->setParametro('llegada_sitio','llegada_sitio','bit');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarSuministro(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_suministro_ime';
		$this->transaccion='SP_SUM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_seguimiento_suministro','id_seguimiento_suministro','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>