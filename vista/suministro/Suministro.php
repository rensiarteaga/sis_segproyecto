<?php
/**
 * @package pXP
 * @file gen-Suministro.php
 * @author  (admin)
 * @date 12-11-2016 14:03:32
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Suministro = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.Suministro.superclass.constructor.call(this, config);
                this.init();
                this.grid.addListener('cellclick', this.oncellclick, this);
                console.log('datos', config.data.datos_originales.data.id_def_proyecto_seguimiento);
                this.load({
                    params: {
                        start: 0,
                        limit: this.tam_pag,
                        id_def_proyecto_seguimiento: config.data.datos_originales.data.id_def_proyecto_seguimiento
                    }
                })
            },

            oncellclick: function (grid, rowIndex, columnIndex, e) {
                var record = this.store.getAt(rowIndex),
                    fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name


                // sw= record.data['tipo_guardar']=false;
                // record.set('tipo_guardar', sw);

                if (fieldName == 'documento_emarque') {
                    var sw1 = record.data['documento_emarque'];
                    sw1 = record.data['documento_emarque'] == 0 ? 1 : 0;
                    record.set('documento_emarque', sw1);
                }

                if (fieldName == 'invitacion') {
                    var sw2 = record.data['invitacion'];
                    sw2 = record.data['invitacion'] == 0 ? 1 : 0;
                    record.set('invitacion', sw2);
                    // record.commit();
                }

                if (fieldName == 'adjudicacion') {
                    var sw3 = record.data['adjudicacion'];
                    sw3 = record.data['adjudicacion'] == 0 ? 1 : 0;
                    record.set('adjudicacion', sw3);
                    // record.commit();
                }

                if (fieldName == 'llegada_sitio') {
                    var sw4 = record.data['llegada_sitio'];
                    sw4 = record.data['llegada_sitio'] == 0 ? 1 : 0;
                    record.set('llegada_sitio', sw4);
                    // record.commit();
                }
            },
            cambiarRevision: function (record) {
                Phx.CP.loadingShow();
                var d = record.data
            },
            onButtonSave: function () {
                if (this.data.datos_originales.data.editado == 't') {
                    Phx.vista.Suministro.superclass.onButtonSave.call(this);

                } else {

                    alert('Usted NO puede editar los datos!!!')
                }
            },

            Atributos: [


                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'tipo_guardar'
                    },
                    type: 'Field',
                    form: true
                }, {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_seguimiento_suministro'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_def_proyecto'
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
                        name: 'actividad',
                        fieldLabel: 'actividad',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 1,
                        renderer: function (value, p, record, rowIndex, colIndex) {
                            if (record.data.padre != 'f') {
                                // return  String.format(record.data.actividad);
                            }
                            else {
                                return String.format(record.data.actividad);
                            }
                        }
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'a.actividad', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    //egrid:true,
                    form: true
                },
                {
                    config: {
                        name: 'invitacion',
                        fieldLabel: 'invitacion',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 1,
                        renderer: function (value, p, record, rowIndex, colIndex) {

                            //check or un check row
                            var checked = '',
                                state = '',
                                momento = '0';
                            if (value == '1') {
                                checked = 'checked';
                            }
                            /*if(record.data.id_int_comprobante){
                             state = 'disabled';
                             }*/
                            if (record.data.padre == 'f') {


                                return String.format('<div style="vertical-align:middle;text-align:center;"><input style="height:37px;width:37px;" type="checkbox"  {0} {1}></div>', checked, state);
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sum.invitacion', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    //egrid:true,
                    form: true
                },


                {
                    config: {
                        name: 'adjudicacion',
                        fieldLabel: 'adjudicacion',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 1,
                        renderer: function (value, p, record, rowIndex, colIndex) {

                            //check or un check row
                            var checked = '',
                                state = '',
                                momento = '0';
                            if (value == '1') {
                                checked = 'checked';
                            }
                            /*if(record.data.id_int_comprobante){
                             state = 'disabled';
                             }*/
                            if (record.data.padre == 'f') {
                                return String.format('<div style="vertical-align:middle;text-align:center;"><input style="height:37px;width:37px;" type="checkbox"  {0} {1}></div>', checked, state);
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sum.adjudicacion', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    //egrid:true,
                    form: true
                },
                {
                    config: {
                        name: 'documento_emarque',
                        fieldLabel: 'documento_emarque',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 130,
                        maxLength: 1,
                        renderer: function (value, p, record, rowIndex, colIndex) {

                            //check or un check row
                            var checked = '',
                                state = '',
                                momento = '0';
                            if (value == '1') {
                                checked = 'checked';
                            }
                            /*if(record.data.id_int_comprobante){
                             state = 'disabled';
                             }*/
                            if (record.data.padre == 'f') {
                                return String.format('<div style="vertical-align:middle;text-align:center;"><input style="height:37px;width:37px;" type="checkbox"  {0} {1}></div>', checked, state);
                            }
                            else {
                                //record.data.invitacion=1;
                                return String.format('');
                            }
                        }
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sum.documento_emarque', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    //egrid:true,
                    form: true
                },
                {
                    config: {
                        name: 'llegada_sitio',
                        fieldLabel: 'llegada_sitio',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 1,
                        renderer: function (value, p, record, rowIndex, colIndex) {

                            //check or un check row
                            var checked = '',
                                state = '',
                                momento = '0';
                            if (value == '1') {
                                checked = 'checked';
                            }
                            /*if(record.data.id_int_comprobante){
                             state = 'disabled';
                             }*/
                            if (record.data.padre == 'f') {
                                return String.format('<div style="vertical-align:middle;text-align:center;"><input style="height:37px;width:37px;" type="checkbox"  {0} {1}></div>', checked, state);
                            }
                            else {
                                //return  String.format('<b><font size=2 >{0}</font><b>', Ext.util.Format.number(value,'0,000.00'));
                                //return '';

                                return String.format('');
                            }
                        }
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'sum.llegada_sitio', type: 'numeric'},
                    id_grupo: 5,
                    grid: true,
                    //egrid:true,
                    form: true

                    //type:'TextField',
                    //filters:{pfiltro:'sum.llegada_sitio',type:'string'},
                    //id_grupo:1,
                    //grid:true,
                    //egrid:true,
                    //form:true
                }
            ],
            //IMPRIMIR EN GRID
            //id_def_proyecto_actividad
            tam_pag: 50,
            title: 'Seguimiento al suministro',
            ActSave: '../../sis_segproyecto/control/Suministro/insertarSuministro',
            ActDel: '../../sis_segproyecto/control/Suministro/eliminarSuministro',
            ActList: '../../sis_segproyecto/control/Suministro/listarSuministro',
            id_store: 'id_def_proyecto_actividad',
            fields: [
                {name: 'id_seguimiento_suministro', type: 'numeric'},
                {name: 'tipo_guardar', type: 'string'},
                {name: 'id_def_proyecto', type: 'numeric'},
                {name: 'id_def_proyecto_actividad', type: 'numeric'},
                {name: 'documento_emarque', type: 'string'},
                //{name:'estado_reg', type: 'string'},
                {name: 'invitacion', type: 'string'},
                {name: 'adjudicacion', type: 'string'},
                {name: 'llegada_sitio', type: 'string'},
                {name: 'actividad', type: 'string'},
                {name: 'padre', type: 'string'},

                //{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                //{name:'usuario_ai', type: 'string'},
                //{name:'id_usuario_reg', type: 'numeric'},
                //{name:'id_usuario_ai', type: 'numeric'},
                //{name:'id_usuario_mod', type: 'numeric'},
                //{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
                //{name:'usr_reg', type: 'string'},
                //{name:'usr_mod', type: 'string'},

            ],
            sortInfo: {
                //field: 'id_seguimiento_suministro',
                field: 'actividad',
                direction: 'ASC'
            },

            bdel: false,
            bsave: true,
            bedit: false,
            bnew: false,
            bexcel: false,
//    bact: false

        }
    )
</script>
		
		