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
        urlEstore: '../../sis_segproyecto/control/DefProyectoActividad/listarProyectoSeguimientoActividad',

        tam_pag: 10,
        //layoutType: 'wizard',
        layout: 'fit',
        autoScroll: false,
        breset: false,
        labelSubmit: '<i class="fa fa-check"></i> Guardar seguimiento',
        constructor: function (config) {
            if (config.data.tipo_form == 'edit') {
                this.urlEstore = '../../sis_segproyecto/control/DefProyectoActividad/listarProyectoSeguimientoActividadEditar';
            }
            this.buildComponentesDetalle();
            this.buildDetailGrid();
            this.buildGrupos();


            Phx.vista.FormProyectoSeguimiento.superclass.constructor.call(this, config);
            this.init();
            if (this.data.tipo_form == 'new') {
                this.mestore.baseParams = {id_def_proyecto: config.data.objPadre.id_def_proyecto};
                console.log('imprimiendo el mestore->',this.mestore.baseParams);
            } else {

                this.mestore.baseParams = {
                    id_def_proyecto: config.data.objPadre.id_def_proyecto,
                    id_def_proyecto_seguimiento: this.data.datos_originales.data.id_def_proyecto_seguimiento
                };
            }
            this.mestore.load();
            console.log('que tipo de datos es ', this.data.tipo_form);

            if (this.data.tipo_form == 'new') {
                this.onNew();
            }
            else {
                this.onEdit();
            }
            this.loadValoresIniciales();

        },

        ActSave: '../../sis_segproyecto/control/DefProyectoSeguimiento/insertarFormDefProyectoSeguimiento',


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
                    name: 'tipo_form'
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
                    fieldLabel: 'Descripción',
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
            console.log('datos de prueba yac', record)
            //los padres no puden colocar valores en la evaluacion
            //record.data.nivel == 1 --> padre
            if (record.data.nivel == 1) {
                return false;
            }
            else {
                return true;
            }

        },
        buildDetailGrid: function () {

            //cantidad,detalle,peso,total
            var Items = Ext.data.Record.create([{
                name: 'actividad',
                type: 'string'
            }, {
                name: 'porcentaje',
                type: 'numeric'
            },{
                name: 'ponderado',
                type: 'numeric'
            }
            ]);

            console.log('url del store', this.urlEstore)
            this.mestore = new Ext.data.JsonStore({

                url: this.urlEstore,
                id: 'id_def_proyecto_actividad',
                root: 'datos',
                totalProperty: 'total',
                fields: ['id_def_proyecto_actividad', 'id_def_proyecto_seguimiento_actividad', 'actividad', 'porcentaje', 'nivel','interno'],
                remoteSort: true,
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
                            var flechas = '';
                            for (i = 0; i < record.data['nivel']; i++) {
                                flechas += '<i class="fa fa-long-arrow-right"></i>  ';
                            }
                            return String.format(flechas + ' {0}', record.data['actividad']);
                        },

                    },{
                        header: 'Interno',
                        dataIndex: 'interno',
                        align: 'center',
                        width: 200,
                        //egrid: true,
                        renderer: function (value, p, record) {
                            return value ? String.format('{0}', record.data['interno']) : ' ';
                        }
                    },
                    {
                        header: 'Avance',
                        dataIndex: 'porcentaje',
                        align: 'center',
                        width: 200,
                        //egrid: true,
                        renderer: function (value, p, record) {
                            return value ? String.format('{0}', record.data['porcentaje']) : ' ';
                        },
                        editor: this.detCmp.porcentaje
                    }

                ]
            });
        },
        buildComponentesDetalle: function () {
            this.detCmp = {

                /*'porcentaje': new Ext.form.NumberField({
                 name: 'porcentaje',
                 msgTarget: 'title',
                 currencyChar: ' ',
                 fieldLabel: 'Porcentaje',
                 minValue: 0.0001,
                 maxValue: 100,
                 allowBlank: false,
                 allowDecimals: true,
                 allowNegative: false,
                 decimalPrecision: 2

                 })*/
                'porcentaje': new Ext.form.ComboBox({
                    allowBlank: false,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender: true,
                    mode: 'local',
                    store: new Ext.data.ArrayStore({
                        id: 0,
                        fields: [
                            'porcentaje'
                        ],
                        data: [[0], [0.25], [0.5], [0.75], [1]]
                    }),
                    valueField: 'porcentaje',
                    displayField: 'porcentaje'

                })
            }
        },
        onEdit: function () {

            this.accionFormulario = 'EDIT';
            this.loadForm(this.data.datos_originales)
        },
        onNew: function () {
            this.accionFormulario = 'NEW';
        },
        onSubmit: function (o) {
            //  validar formularios
            var arra = [], i, me = this;

       /*     for (i = me.megrid.store.getCount()-1; i >= 0; i--) {
                record = me.megrid.store.getAt(i);
                console.log('impriimedo los Valores records '+i,record)
                arra.push(record.data);
            }*/
            for (i = 0; i < me.megrid.store.getCount(); i++) {
                record = me.megrid.store.getAt(i);
                console.log('impriimedo los Valores records',record)
                arra.push(record.data);
            }
            console.log('arreglo de los datos quse cargaran',arra)

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
                alert('no tiene ningun concepto')
            }
        },

        successSave: function (resp) {

            Phx.CP.loadingHide();
            var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            this.fireEvent('successsaveformulario', this, objRes);

        },
        loadValoresIniciales: function () {
            Phx.vista.FormProyectoSeguimiento.superclass.loadValoresIniciales.call(this);
            this.Cmp.id_def_proyecto.setValue(this.data.objPadre.id_def_proyecto);
            this.Cmp.tipo_form.setValue(this.data.tipo_form);

        },

    })
</script>