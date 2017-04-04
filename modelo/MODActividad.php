<?php
/**
*@package pXP
*@file gen-MODActividad.php
*@author  (admin)
*@date 31-01-2017 21:38:35
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODActividad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarActividad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_actividad_sel';
		$this->transaccion='SP_ACTI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('id_actividad_padre','int4');
		$this->captura('actividad','varchar');
		$this->captura('tipo_actividad','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_tipo','int4');
		$this->captura('tipo','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_actividad_ime';
		$this->transaccion='SP_ACTI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad_padre','id_actividad_padre','int4');
		$this->setParametro('actividad','actividad','varchar');
		//$this->setParametro('tipo_actividad','tipo_actividad','varchar');
		$this->setParametro('id_tipo','id_tipo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_actividad_ime';
		$this->transaccion='SP_ACTI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad','id_actividad','int4');
		$this->setParametro('id_actividad_padre','id_actividad_padre','int4');
		$this->setParametro('actividad','actividad','varchar');
		$this->setParametro('tipo_actividad','tipo_actividad','varchar');
		$this->setParametro('id_tipo','id_tipo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarActividad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_actividad_ime';
		$this->transaccion='SP_ACTI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_actividad','id_actividad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarActividadArb() {
        $this->procedimiento = 'sp.ft_actividad_sel';
        $this->setCount(false);
        $this->transaccion = 'SP_ACT_ARB_SEL';
        $this->tipo_procedimiento = 'SEL';

        $id_padre = $this->objParam->getParametro('id_padre');
        $this->setParametro('id_padre', 'id_padre', 'varchar');

       //Definicion de la lista del resultado del query
		$this->captura('id_actividad','int4');
		$this->captura('id_actividad_padre','int4');
		$this->captura('actividad','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('tipo_nodo','varchar');
		$this->captura('checked','varchar');
		

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    public function listarTipos()
    {
        $this->procedimiento='sp.ft_actividad_sel';
        $this->transaccion='SP_ACT_TIP_SEL';
        $this->setCount(false);
        $this->tipo_procedimiento='SEL';//tipo de transaccion

        //Definicion de la lista del resultado del query
        $this->captura('id_tipo','int4');
        $this->captura('tipo','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>