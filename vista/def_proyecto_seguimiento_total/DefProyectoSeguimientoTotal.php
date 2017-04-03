<?php
/**
*@package pXP
*@file gen-DefProyectoSeguimientoTotal.php
*@author  (admin)
*@date 13-11-2016 20:28:07
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DefProyectoSeguimientoTotal=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DefProyectoSeguimientoTotal.superclass.constructor.call(this,config);
		this.init();
		//this.load({params:{start:0, limit:this.tam_pag}})
		 this.iniciarEventos();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_def_proyecto_seguimiento_total'
			},
			type:'Field',
			form:true 
		},
			{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_def_proyecto'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'prseto.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
				type:'TextField',
				filters:{pfiltro:'prseto.descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'fecha',
				fieldLabel: 'fecha',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'prseto.fecha',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'prseto.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'prseto.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'prseto.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'prseto.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Proyecto seguimineto total ',
	ActSave:'../../sis_segproyecto/control/DefProyectoSeguimientoTotal/insertarDefProyectoSeguimientoTotal',
	ActDel:'../../sis_segproyecto/control/DefProyectoSeguimientoTotal/eliminarDefProyectoSeguimientoTotal',
	ActList:'../../sis_segproyecto/control/DefProyectoSeguimientoTotal/listarDefProyectoSeguimientoTotal',
	id_store:'id_def_proyecto_seguimiento_total',
	fields: [
		{name:'id_def_proyecto_seguimiento_total', type: 'numeric'},
		{name:'id_def_proyecto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'fecha', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_def_proyecto_seguimiento_total',
		direction: 'ASC'
	},
	 loadValoresIniciales: function () {
                Phx.vista.DefProyectoSeguimientoTotal.superclass.loadValoresIniciales.call(this);
                this.Cmp.id_def_proyecto.setValue(this.maestro.id_def_proyecto);
            },
            //relacion de padre hijo en vistas
            onReloadPage: function (m) {
                this.maestro = m;
                this.store.baseParams = {id_def_proyecto: this.maestro.id_def_proyecto};
                this.load({params: {start: 0, limit: 50}})
            },
            onButtonNew: function () {
                //abrir formulario de solicitud
                this.openForm('new');
            },
            onButtonEdit: function () {
                //abrir formulario de solicitud
                  
                this.openForm('edit',this.sm.getSelected());
            },
            openForm: function (tipo, record) {
                var me = this;
                me.objSolForm = Phx.CP.loadWindows('../../../sis_segproyecto/vista/def_proyecto_seguimiento_total/FormProyectoSeguimientoTotal.php',
                    'Formulario de seguimiento de proyecto totales',
                    {
                        modal: true,
                        width: '50%',
                        height: '60%'
                    }, {
                        data: {
                            objPadre: me.maestro,
                            tipo_form: tipo,
                            datos_originales: record
                        }
                    },
                    this.idContenedor,
                    'FormProyectoSeguimientoTotal',
                    {
                        config: [{
                            event: 'successsaveformulario',
                            delegate: this.onSaveForm,
                        }],
                        scope: me
                    });
            }, 
            onSaveForm: function (interface, valores, id_def_proyecto) {
                alert('Datos guardados');
                interface.panel.close();
           }, 
            
	bdel:true,
	bsave:true
	}
)
</script>
		
		