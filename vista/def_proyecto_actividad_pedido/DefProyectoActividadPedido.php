<?php
/**
 * @package pXP
 * @file gen-DefProyectoActividadPedido.php
 * @author  (admin)
 * @date 12-11-2016 12:56:05
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.DefProyectoActividadPedido = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;

                //llama al constructor de la clase padre
                Phx.vista.DefProyectoActividadPedido.superclass.constructor.call(this, config);
                this.init();

                //this.load({params:{start:0, limit:this.tam_pag}})
            },

            Atributos: [
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_def_proyecto_actividad_pedido'
                    },
                    type: 'Field',
                    form: true
                },

                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_def_proyecto_actividad'
                    },
                    type: 'Field',
                    form: true
                },

                //nuevo componente
                /*{
                 config:{
                 name:'id_roles',
                 fieldLabel:'Roles',
                 allowBlank:true,
                 emptyText:'Roles...',
                 store: new Ext.data.JsonStore({
                 url: '../../sis_seguridad/control/Rol/listarRol',
                 id: 'id_rol',
                 root: 'datos',
                 sortInfo:{
                 field: 'rol',
                 direction: 'ASC'
                 },
                 totalProperty: 'total',
                 fields: ['id_rol','rol','descripcion'],
                 // turn on remote sorting
                 remoteSort: true,
                 baseParams:{par_filtro:'rol'}

                 }),
                 valueField: 'id_rol',
                 displayField: 'rol',
                 forceSelection:true,
                 typeAhead: true,
                 triggerAction: 'all',
                 lazyRender:true,
                 mode:'remote',
                 pageSize:10,
                 queryDelay:1000,
                 width:250,
                 minChars:2,
                 enableMultiSelect:true

                 //renderer:function(value, p, record){return String.format('{0}', record.data['descripcion']);}

                 },
                 type:'AwesomeCombo',
                 id_grupo:0,
                 grid:false,
                 form:true
                 },*/
                {
                    config: {
                        name: 'id_pedidos',//se agrega una s para guardar en formato de arreglo[] el name
                        fieldLabel: 'Proceso y Orden',
                        allowBlank: false,
                        emptyText: 'Elija una opción...',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_segproyecto/control/DefProyectoActividadPedido/listarPedidos',
                            id: 'id_pedido',
                            root: 'datos',
                            sortInfo: {
                                field: 'pedido',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_pedido', 'pedido', 'nrosap', 'nrocontrato', 'codinvitacion', 'suministro','falta_valor'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'codinvitacion#pedido#nrosap'}
                        }),
                        tpl:'<tpl for="."><div class="x-combo-list-item"><div class="awesomecombo-item {checked}"><p style="color: green"><b >{codinvitacion} </b> - {suministro}</p></div><p>{falta_valor} <b>{nrosap} </b> - {pedido}</p> </div></tpl>',
                        //tpl: '<tpl for="."><div class="x-combo-list-item" ><div class="awesomecombo-item {checked}"><b>nrosap: </b>{nrosap}<p style="padding-left: 20px;">{pedido}</p></div></tpl>',
                        valueField: 'id_pedido',
                        displayField: 'pedido',
                        gdisplayField: 'pedido',
                        hiddenName: 'id_pedido',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '100%',
                        gwidth: 350,
                        minChars: 2,
                        enableMultiSelect: true,
                        renderer: function (value, p, record) {
                            return String.format('<p style="color: green">( {0} ) {1}</p><p> ( {2} ) {3}</p>', record.data['codinvitacion'], record.data['suministro'], record.data['nrosap'], record.data['pedido']);
                        }
                    },
                    type: 'AwesomeCombo',
                    id_grupo: 0,
                    filters: {pfiltro: 'nrosap', type: 'string'},
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'fechaordenproceder',
                        fieldLabel: 'Fecha orden proceder',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,

                        renderer: function (value, p, record) {
                            //return value?new Date(value).dateFormat('d/m/Y') :''
                            return value ? value : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'vped.fechaordenproceder', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'nrocontrato',
                        fieldLabel: 'Nro. de contrato',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,

                        renderer: function (value, p, record) {
                            //return value?new Date(value).dateFormat('d/m/Y') :''
                            return value ? value : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'nrocontrato', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },

                {
                    config: {
                        name: 'plazo',
                        fieldLabel: 'Plazo',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        renderer: function (value, p, record) {
                            return value ? value + ' dias' : ''
                        }
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'vped.plazo', type: 'int'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_entrega_contrato_prev',
                        fieldLabel: 'Fecha entrega contrato',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: '',
                        renderer: function (value, p, record) {

                            return value
                        }
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'vped.fecha_entrega_contrato_prev', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'monto_total',
                        fieldLabel: 'Monto total',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: '',
                        renderer: function (value, p, record) {
                            //observando que valor tiene el record
                            //console.log(record)
                            return value
                        }
                    },
                    type: 'Field',
                    filters: {pfiltro: 'vped.monto_total', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'estado_reg',
                        fieldLabel: 'Estado Reg.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'depracpe.estado_reg', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_usuario_ai',
                        fieldLabel: '',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'depracpe.id_usuario_ai', type: 'numeric'},
                    id_grupo: 1,
                    grid: false,
                    form: false
                },
                {
                    config: {
                        name: 'usr_reg',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu1.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'usuario_ai',
                        fieldLabel: 'Funcionaro AI',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 300
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'depracpe.usuario_ai', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_reg',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'depracpe.fecha_reg', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'usr_mod',
                        fieldLabel: 'Modificado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu2.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_mod',
                        fieldLabel: 'Fecha Modif.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'depracpe.fecha_mod', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                }
            ],
            tam_pag: 50,
            title: 'Definición proyecto actividad pedido',
            ActSave: '../../sis_segproyecto/control/DefProyectoActividadPedido/insertarDefProyectoActividadPedido',
            ActDel: '../../sis_segproyecto/control/DefProyectoActividadPedido/eliminarDefProyectoActividadPedido',
            ActList: '../../sis_segproyecto/control/DefProyectoActividadPedido/listarDefProyectoActividadPedido',
            id_store: 'id_def_proyecto_actividad_pedido',
            fields: [
                {name: 'id_def_proyecto_actividad_pedido', type: 'numeric'},
                {name: 'id_def_proyecto_actividad', type: 'numeric'},
                {name: 'id_pedido', type: 'numeric'},
                {name: 'estado_reg', type: 'string'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},
                'pedido',
                'nrosap',
                'fechaordenproceder',
                'fecha_entrega_contrato_prev',
                'monto',
                'plazo',
                'monto_total',
                'nrocontrato',
                'codinvitacion',
                'suministro',
            ],
            sortInfo: {
                field: 'id_def_proyecto_actividad_pedido',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true,
            bedit: false,
            bsave: false,
            bexcel: false,
            loadValoresIniciales: function () {
                Phx.vista.DefProyectoActividadPedido.superclass.loadValoresIniciales.call(this);
                this.Cmp.id_def_proyecto_actividad.setValue(this.maestro.id_def_proyecto_actividad);
                this.id_def_proyecto = this.maestro.id_def_proyecto;

                //carga un valor en los parametros del combobox
                this.Cmp.id_pedidos.store.baseParams.id_def_proyecto = this.maestro.id_def_proyecto;
                // funcion para recargar el combobox
                this.Cmp.id_pedidos.modificado = true;

            },

            onReloadPage: function (m) {
                this.maestro = m;
                this.store.baseParams = {id_def_proyecto_actividad: this.maestro.id_def_proyecto_actividad};
                this.load({params: {start: 0, limit: 50}})

            },

                /*
                 //trabajando para la deehabilitacion de las opciones de los botones del tab
                 preparaMenu: function (n) {
                 var tb = Phx.vista.DefProyecto.superclass.preparaMenu.call(this);
                 var rec = this.sm.getSelected();
                 console.log('desde prepara menu', this.maestro)

                 return tb;
                 },

                 liberaMenu: function () {

                 console.log('imprimiendo el this',this)
                 var tb = Phx.vista.DefProyecto.superclass.liberaMenu.call(this);
                 if(this.maestro.nivel == 3){
                 this.bnew = false;
                 //this.getBoton('bnew').disabled();
                 //this.getBoton('bedit').disabled();

                 console.log('entre, soy un nieto')
                 }else{
                 //this.getBoton('bnew').enable();
                 //this.getBoton('bedit').enable();
                 console.log('soy un padre o hijo')
                 }
                 console.log('desde liberar menu', this.maestro)

                 },*/
        }
    )
</script>
		
		