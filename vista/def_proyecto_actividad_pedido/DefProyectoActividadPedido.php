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
                this.iniciarEventos();
                //this.load({params:{start:0, limit:this.tam_pag}})
            },
            iniciarEventos: function () {

                this.Cmp.id_pedido.on('select', function (Combo, dato) {

                    this.cargarAcumulados(Combo, dato);
                }, this);

                this.Cmp.porcentaje_asignado.on('change', function (CmpPorcentaje) {
                    this.cargarPorcentajeMonto(CmpPorcentaje);
                }, this);
                this.Cmp.monto_asignado.on('change', function (CmpMonto) {
                    this.cargarMontoPorcentaje(CmpMonto);
                }, this);

            },
            cargarAcumulados: function (Combo, dato) {
                //alert('entre')
                console.log('valor del combo', Combo, dato.json)
                this.Cmp.monto_acumulado.setValue(dato.json.suma_monto_acu);
                this.Cmp.porcentaje_acumulado.setValue(dato.json.suma_porcentaje_acu);
                this.Cmp.monto_total.setValue(dato.json.monto);
                this.Cmp.porcentaje_asignado.setValue(100 - parseFloat(dato.json.suma_porcentaje_acu));
                this.Cmp.monto_asignado.setValue(parseFloat(dato.json.monto) - parseFloat(dato.json.suma_monto_acu));
            },

            cargarPorcentajeMonto: function (CmpPorcentaje) {
                var porcentaje_calculado = parseFloat(CmpPorcentaje.getValue()) * parseFloat(this.Cmp.monto_total.getValue()) / 100;
                console.log('valor del porcentaje', porcentaje_calculado)
                this.Cmp.monto_asignado.setValue(porcentaje_calculado);
            },

            cargarMontoPorcentaje: function (CmpMonto) {
                var monto_calculado = parseFloat(CmpMonto.getValue()) / parseFloat(this.Cmp.monto_total.getValue()) * 100;
                console.log('valor del monto', monto_calculado)
                this.Cmp.porcentaje_asignado.setValue(monto_calculado);
            },

            successSave: function (resp) {
                Phx.vista.DefProyectoActividadPedido.superclass.successSave.call(this, resp);
                Phx.CP.getPagina(this.idContenedorPadre).reload();
            },

            onButtonEdit: function () {
                var record = this.sm.getSelected();
                console.log('entre del record suma_porcentaje_acu', record.data);

                Phx.vista.DefProyectoActividadPedido.superclass.onButtonEdit.call(this);

                this.Cmp.porcentaje_acumulado.setValue(parseFloat(record.data.suma_porcentaje_acu)-parseFloat(this.Cmp.porcentaje_asignado.getValue()));
                this.Cmp.monto_acumulado.setValue(parseFloat(record.data.suma_monto_acu)-parseFloat(this.Cmp.monto_asignado.getValue()));
            },
            onButtonNew: function () {
                //se agrega esta opcion para verificar si es una actividad validad para que pueda agregar uno nuevo
                var record_maestro = this.maestro;
                if(record_maestro.nivel == 2 && record_maestro.tipo_actividad != 4){
                    Phx.vista.DefProyectoActividadPedido.superclass.onButtonNew.call(this);
                }else{
                    alert('No puedes agregar un pedido nuevo a la actividad seleccionada')
                }


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

                {
                    config: {
                        name: 'id_pedido',//se agrega una s para guardar en formato de arreglo[] el name
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
                            fields: ['id_pedido', 'pedido', 'nrosap', 'nrocontrato', 'codinvitacion', 'suministro', 'falta_valor', 'suma_porcentaje_acu', 'suma_monto_acu'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'codinvitacion#pedido#nrosap'}
                        }),
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p style="color: green"><b >{codinvitacion} </b> - {suministro}</p><p>{falta_valor} <b>{nrosap} </b> - {pedido}</p><p><b>Porcentaje acumulado:</b>{suma_porcentaje_acu}% <b>Monto acumulado:</b>{suma_monto_acu}</p> </div></tpl>',
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
                        renderer: function (value, p, record) {
                            return String.format('<p style="color: green">( {0} ) {1}</p><p> ( {2} ) {3}</p>', record.data['codinvitacion'], record.data['suministro'], record.data['nrosap'], record.data['pedido']);
                        }
                    },
                    type: 'ComboBox',
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
                        disabled: true,
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
                    form: true
                },

                {
                    config: {
                        name: 'porcentaje_acumulado',
                        fieldLabel: 'Porcentaje acumulado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: '',
                        disabled: true,
                        renderer: function (value, p, record) {
                            //observando que valor tiene el record
                            //console.log(record)
                            return value + ' %'
                        }
                    },
                    type: 'Field',
                    filters: {pfiltro: 'vped.monto_total', type: 'numeric'},
                    id_grupo: 1,
                    grid: false,
                    form: true
                },
                {
                    config: {
                        name: 'monto_acumulado',
                        fieldLabel: 'Monto acumulado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: '',
                        disabled: true,
                        renderer: function (value, p, record) {
                            //observando que valor tiene el record
                            //console.log(record)
                            return value
                        }
                    },
                    type: 'Field',
                    filters: {pfiltro: 'monto', type: 'numeric'},
                    id_grupo: 1,
                    grid: false,
                    form: true
                },
                {
                    config: {
                        name: 'porcentaje_asignado',
                        fieldLabel: 'Porcentaje asignado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: '',
                        renderer: function (value, p, record) {
                            //observando que valor tiene el record
                            //console.log(record)
                            return String.format('{0}%', record.data['porcentaje_asignado']);
                        }
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'depracpe.porcentaje', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'monto_asignado',
                        fieldLabel: 'Monto asignado',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: '',
                        renderer: function (value, p, record) {
                            //observando que valor tiene el record
                            //console.log(record)
                            return String.format('{0}', record.data['monto_asignado']);

                        }
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'depracpe.monto', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
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
                'monto_asignado',
                'porcentaje_asignado',
                'suma_porcentaje_acu',
                'suma_monto_acu',

            ],
            sortInfo: {
                field: 'id_def_proyecto_actividad_pedido',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true,
            bedit: true,
            bsave: false,
            bexcel: false,
            loadValoresIniciales: function () {
                Phx.vista.DefProyectoActividadPedido.superclass.loadValoresIniciales.call(this);
                this.Cmp.id_def_proyecto_actividad.setValue(this.maestro.id_def_proyecto_actividad);
                this.id_def_proyecto = this.maestro.id_def_proyecto;

                //carga un valor en los parametros del combobox
                this.Cmp.id_pedido.store.baseParams.id_def_proyecto = this.maestro.id_def_proyecto;
                // funcion para recargar el combobox
                this.Cmp.id_pedido.modificado = true;

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
		
		