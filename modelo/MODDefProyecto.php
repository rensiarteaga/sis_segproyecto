<?php
/**
*@package pXP
*@file gen-MODDefProyecto.php
*@author  (admin)
*@date 08-02-2017 19:56:10
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDefProyecto extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDefProyecto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_sel';
		$this->transaccion='SP_DEFPROY_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_def_proyecto','int4');
		$this->captura('fecha_inicio_teorico','date');
		$this->captura('descripcion','text');
		$this->captura('fecha_fin_teorico','date');
		$this->captura('estado_reg','varchar');
		$this->captura('id_proyecto','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_proyecto','varchar');
		$this->captura('codproyecto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDefProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_ime';
		$this->transaccion='SP_DEFPROY_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('fecha_inicio_teorico','fecha_inicio_teorico','date');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('fecha_fin_teorico','fecha_fin_teorico','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_proyecto','id_proyecto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDefProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_ime';
		$this->transaccion='SP_DEFPROY_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');
		$this->setParametro('fecha_inicio_teorico','fecha_inicio_teorico','date');
		$this->setParametro('descripcion','descripcion','text');
		$this->setParametro('fecha_fin_teorico','fecha_fin_teorico','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_proyecto','id_proyecto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDefProyecto(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_ime';
		$this->transaccion='SP_DEFPROY_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto','id_def_proyecto','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	//csa_proyecto_proyecto listado
	function listarProyecto(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_proyecto_sel';
		$this->transaccion='SP_PROY_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_proyecto','int4');
		$this->captura('codproyecto','varchar');
		$this->captura('nombre','varchar');
		/*$this->captura('idpedido','int4');
		$this->captura('nrosap','varchar');
		$this->captura('pedido','varchar');
		$this->captura('nrocontrato','varchar');
		$this->captura('fechaautorizacionpedido','varchar');
		$this->captura('fechaordenproceder','varchar');
		$this->captura('plazo_entrega_contrato','int4');
		$this->captura('plazo_entrega_contrato_unidad','varchar');
		$this->captura('fecha_entrega_contrato_prev','varchar');
		$this->captura('monto','DOUBLE PRECISION');
		$this->captura('monedamonto','int4');
	*/
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
    function listarReporteResumen(){

        //Definicion de variables para ejecucion del procedimientp
        $this->procedimiento='sp.ft_def_proyecto_rep';
        $this->transaccion='SP_DEFPROREP_SEL';
        $this->tipo_procedimiento='SEL';//tipo de transaccion
        $this->setCount(false);
        $this->setTipoRetorno('record');

        //captura parametros adicionales para el count

        $this->setParametro('id_def_proyecto','id_def_proyecto','int4');


        //Definicion de la lista del resultado del query
        $this->captura('id_def_proyecto_actividad','int4');
        $this->captura('id_def_proyecto','int4');
        $this->captura('id_actividad','int4');
        $this->captura('descripcion','varchar');
        $this->captura('actividad','varchar');
        $this->captura('plazo','int4');
        $this->captura('monto_suma','double precision');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
			
}
?>