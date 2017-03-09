<?php
/**
 * @package pXP
 * @file    FormSolicitud.php
 * @author  Rensi Arteaga Copari
 * @date    30-01-2014
 * @description permites subir archivos a la tabla de documento_sol
 */
header("content-type: text/javascript; charset=UTF-8");
?>

<script>
    Phx.vista.FormProyectoSeguimiento = Ext.extend(Phx.frmInterfaz, {
        ActSave: '../../sis_segproyecto/control/DefProyectoSeguimiento/insertarFormDefProyectoSeguimiento',
        tam_pag: 10,
        //layoutType: 'wizard',
        layout: 'fit',
        autoScroll: false,
        breset: false,
        labelSubmit: '<i class="fa fa-check"></i> Guardar seguimiento',
        constructor: function (config) {
            this.buildComponentesDetalle();
            this.buildDetailGrid();
            this.buildGrupos();

            Phx.vista.FormProyectoSeguimiento.superclass.constructor.call(this, config);
            this.init();
            this.mestore.baseParams = {id_def_proyecto: config.data.objPadre.id_def_proyecto};
            this.mestore.load();
            this.loadValoresIniciales();
            console.log('que tipo de datos es ',config.data.tipo_form);
        },

        Atributos: [
            {
                //configuracion del componente
                config: {
                    labelSeparator: '',
                    inputType: 'hidden',
                    name: 'id_def_proyecto_seguimiento'
                },
                type: 'Field',
                id_grupo: 0,
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
                id_grupo: 0,
                form: true
            },

            {
                config: {
                    name: 'fecha',
                    fieldLabel: 'Fecha seguimiento',
                    allowBlank: true,
                    width: 100,
                    format: 'd/m/Y'
                },
                type: 'DateField',

                id_grupo: 0,

                form: true
            },
            {
                config: {
                    name: 'descripcion',
                    fieldLabel: 'DescripciÓn',
                    allowBlank: true,
                    width: 300,

                    maxLength: 255
                },
                type: 'TextArea',

                id_grupo: 1,

                form: true
            }

        ],

        buildGrupos: function () {
            this.Grupos = [{
                layout: 'border',
                border: false,
                frame: true,
                items: [
                    {
                        xtype: 'fieldset',
                        border: false,
                        split: true,
                        layout: 'column',
                        region: 'north',
                        autoScroll: true,
                        autoHeight: true,
                        collapseFirst: false,
                        collapsible: true,
                        width: 300,
                        //autoHeight: true,
                        padding: '0 0 0 10',
                        items: [
                            {
                                bodyStyle: 'padding-right:5px;',

                                autoHeight: true,
                                border: false,
                                items: [
                                    {
                                        xtype: 'fieldset',
                                        frame: true,
                                        border: false,
                                        layout: 'form',
                                        title: '',
                                        width: 300,

                                        //margins: '0 0 0 5',
                                        padding: '0 0 0 10',
                                        bodyStyle: 'padding-left:5px;',
                                        id_grupo: 0,
                                        items: [],
                                    }]
                            },
                            {
                                bodyStyle: 'padding-right:5px;',

                                border: false,
                                autoHeight: true,
                                items: [{
                                    xtype: 'fieldset',
                                    frame: true,
                                    layout: 'form',
                                    title: ' ',
                                    width: 300,
                                    border: false,
                                    //margins: '0 0 0 5',
                                    padding: '0 0 0 10',
                                    bodyStyle: 'padding-left:5px;',
                                    id_grupo: 1,
                                    items: [],
                                }]
                            }
                        ]
                    },
                    this.megrid
                ]
            }];
        },
        onInitAdd: function (r, i) {

            var arra = [], i, me = this;
            record = me.megrid.store.getAt(i);
            console.log('datos antes del edit', record, record.data.tipo_actividad)
            if (record.data.tipo_actividad == 'padre') {
                return false;
            }
            else {
                return true;
            }

        },

        buildDetailGrid: function () {

            //cantidad,detalle,peso,totalo
            var Items = Ext.data.Record.create([{
                name: 'actividad',
                type: 'string'
            }, {
                name: 'porcentaje',
                type: 'numeric'

            }
            ]);

            this.mestore = new Ext.data.JsonStore({
                url: '../../sis_segproyecto/control/DefProyectoActividad/listarProyectoSeguimientoActividad',
                id: 'id_def_proyecto_actividad',
                root: 'datos',
                totalProperty: 'total',
                fields: ['id_def_proyecto_actividad', 'actividad', 'porcentaje', 'tipo_actividad'
                ], remoteSort: true,
                baseParams: {dir: 'ASC', sort: 'id_def_proyecto_actividad', limit: '50', start: '0'}
            });

            this.editorDetail = new Ext.ux.grid.RowEditor({
                saveText: 'Aceptar',
                name: 'btn_editor'

            });
            //console.log("Estoy en el store",this.mestore);
            this.summary = new Ext.ux.grid.GridSummary();
            // al iniciar la edicion
            this.editorDetail.on('beforeedit', this.onInitAdd, this);

            //al cancelar la edicion
            //this.editorDetail.on('canceledit', this.onCancelAdd , this);

            //al cancelar la edicion
            //this.editorDetail.on('validateedit', this.onUpdateRegister, this);

           // this.editorDetail.on('afteredit', this.onAfterEdit, this);


            this.megrid = new Ext.grid.GridPanel({
                layout: 'fit',
                store: this.mestore,
                region: 'center',
                split: true,
                border: false,
                plain: true,
                //autoHeight: true,
                plugins: [this.editorDetail, this.summary],
                stripeRows: true,


                columns: [
                    new Ext.grid.RowNumberer(),
                    {
                        header: 'Actividad',
                        dataIndex: 'actividad',
                        width: 200,
                        sortable: false,
                        renderer: function (value, p, record) {
                            if (record.data.tipo_actividad == 'padre') {
                                return String.format('<i class="fa fa-asterisk"></i> {0}', record.data['actividad']);
                            } else {
                                return String.format('{0}', record.data['actividad']);

                            }
                        },

                    },
                    {
                        header: 'Porcentaje',
                        dataIndex: 'porcentaje',
                        align: 'center',
                        width: 200,
                        //egrid: true,
                        renderer: function (value, p, record) {
                            return value ? String.format('{0} %', record.data['porcentaje']) : '';
                        },
                        editor: this.detCmp.porcentaje
                    }
                ]
            });
            // console.log("pruebas", this.megrid);
        },
        buildComponentesDetalle: function () {
            this.detCmp = {

                'porcentaje': new Ext.form.NumberField({
                    name: 'porcentaje',
                    msgTarget: 'title',
                    currencyChar: ' ',
                    fieldLabel: 'Prec. Unit.',
                    minValue: 0.0001,
                    maxValue: 100,
                    allowBlank: false,
                    allowDecimals: true,
                    allowNegative: false,
                    decimalPrecision: 2

                })

            }


        },
        onSubmit: function (o) {
            //  validar formularios
            var arra = [], i, me = this;
            for (i = 0; i < me.megrid.store.getCount(); i++) {
                record = me.megrid.store.getAt(i);
                if (record.data.tipo_actividad == 'hijo') {
                    arra.push(record.data);
                }

            }


            me.argumentExtraSubmit = {
                'json_new_records': JSON.stringify(arra, function replacer(key, value) {
                    /*if (typeof value === 'string') {
                     return String(value).replace(/&/g, "%26")
                     }*/
                    return value;
                })
            };

            if (i > 0 && !this.editorDetail.isVisible()) {
                Phx.vista.FormProyectoSeguimiento.superclass.onSubmit.call(this, o, undefined, true);
            }
            else {
                alert('no tiene ningun concepto  para comprar')
            }
        },

        successSave: function (resp) {

            Phx.CP.loadingHide();
            var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            this.fireEvent('successsave', this, objRes);

        },

        loadValoresIniciales: function () {
            Phx.vista.FormProyectoSeguimiento.superclass.loadValoresIniciales.call(this);
            this.Cmp.id_def_proyecto.setValue(this.data.objPadre.id_def_proyecto);
        },


    })
</script>