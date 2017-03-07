<?php
/**
*@package pXP
*@file gen-MODDefProyectoActividadPedido.php
*@author  (admin)
*@date 12-11-2016 12:56:05
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDefProyectoActividadPedido extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDefProyectoActividadPedido(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_def_proyecto_actividad_pedido_sel';
		$this->transaccion='SP_DEPRACPE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//Definicion de la lista del resultado del query
		$this->captura('id_def_proyecto_actividad_pedido','int4');
		$this->captura('id_def_proyecto_actividad','int4');
		$this->captura('id_pedido','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('pedido','varchar');
		$this->captura('nrosap','varchar');
		$this->captura('fechaordenproceder','varchar');
		$this->captura('fecha_entrega_contrato_prev','varchar');
		$this->captura('monto','double precision');
		$this->captura('monedamonto','int4');
		$this->captura('plazo','int4');
		$this->captura('monto_total','double precision');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDefProyectoActividadPedido(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_actividad_pedido_ime';
		$this->transaccion='SP_DEPRACPE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('id_pedido','id_pedido','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDefProyectoActividadPedido(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_actividad_pedido_ime';
		$this->transaccion='SP_DEPRACPE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_actividad_pedido','id_def_proyecto_actividad_pedido','int4');
		$this->setParametro('id_def_proyecto_actividad','id_def_proyecto_actividad','int4');
		$this->setParametro('id_pedido','id_pedido','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDefProyectoActividadPedido(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sp.ft_def_proyecto_actividad_pedido_ime';
		$this->transaccion='SP_DEPRACPE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_def_proyecto_actividad_pedido','id_def_proyecto_actividad_pedido','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	function listarPedidos(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sp.ft_pedido_sel';
		$this->transaccion='SP_PED_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
			
		//Definicion de la lista del resultado del query
		$this->captura('id_pedido','int4');
		$this->captura('nrosap','varchar');
		$this->captura('pedido','varchar');
		$this->captura('nrocontrato','varchar');
		$this->captura('fechaautorizacionpedido','varchar');
		$this->captura('fechaordenproceder','varchar');
		$this->captura('plazo_entrega_contrato','int4');
		$this->captura('plazo_entrega_contrato_unidad','varchar');
		$this->captura('fecha_entrega_contrato_prev','varchar');
		$this->captura('monto','double precision');
		$this->captura('monedamonto','int4');
		$this->captura('fecha_adenda','varchar');
		$this->captura('plazo_entrega_adenda','int4');
		$this->captura('plazo_entrega_unidad_adenda','varchar');
		$this->captura('monto_adenda','double precision');
		$this->captura('descripcion_adenda','varchar');
		$this->captura('contrato_adenda','varchar');
		$this->captura('plazo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>