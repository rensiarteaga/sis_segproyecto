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
    Phx.vista.FormProyectoSeguimientoTotal = Ext.extend(Phx.frmInterfaz, {
        urlEstore: '../../sis_segproyecto/control/DefProyectoActividad/listarProyectoSeguimientoActividadTotal',

        tam_pag: 10,

        layout: 'fit',
        autoScroll: false,
        breset: false,
        labelSubmit: '<i class="fa fa-check"></i> Guardar',
        constructor: function (config) {
            if (config.data.tipo_form == 'edit') {
                this.urlEstore = '../../sis_segproyecto/control/DefProyectoActividad/listarProyectoSeguimientoActividadTotalEditar';
            }
            this.buildComponentesDetalle();
            this.buildDetailGrid();
            this.buildGrupos();


            Phx.vista.FormProyectoSeguimientoTotal.superclass.constructor.call(this, config);
            this.init();

          //  this.grid.addListener('cellclick', this.oncellclick,this);
            
            if (this.data.tipo_form == 'new') {

               this.mestore.baseParams = {id_def_proyecto: config.data.objPadre.id_def_proyecto};
              // console.log(config.data);
            } else {

                this.mestore.baseParams = {
                    id_def_proyecto: config.data.objPadre.id_def_proyecto,
                    id_def_proyecto_seguimiento_total: this.data.datos_originales.data.id_def_proyecto_seguimiento_total
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
        


        ActSave: '../../sis_segproyecto/control/DefProyectoSeguimientoTotal/insertarFormEstado',

        onSaveForm: function (interface, valores, id_def_proyecto) {
                alert('Datos guardados');
                interface.panel.close();
        },
            
        Atributos: [
            {
                //configuracion del componente
                config: {
                    labelSeparator: '',
                    inputType: 'hidden',
                    name: 'id_def_proyecto_seguimiento_total'
                },
                type: 'Field',
           //     id_grupo: 0,
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
           //     id_grupo: 0,
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
           //     id_grupo: 0,
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
            //    id_grupo: 0,
                form: true
            },

            {
                config: {
                    name: 'fecha',
                    fieldLabel: 'Fecha',
                    allowBlank: true,
                    width: 100,
                    format: 'd/m/Y'
                },
                type: 'DateField',

             //   id_grupo: 0,

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

               // id_grupo: 1,

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
            console.log('datos antes del edit', r,record, record.data.tipo_actividad)
            console.log("record.data.id_tipo",record.data.id_tipo);
            
            //me.detCmp.estado.modificado=true;
            me.detCmp.estado.modificado=true;
            
            me.detCmp.estado.store.baseParams.id_tipo=record.data.id_tipo;
            
          /*  if (record.data.tipo_actividad == 'padre') {
                return false;
            }
            else {
                return true;
            }
           */            
           
            if (record.data.v_nivel == 1) {
                return false;
            }
            else {
                return true;
            }
            

        },
        
        onUpdateRegister :function (preuba, p,i,rowIndex){
        	
        	//var record = this.store.getAt(rowIndex),
            //fieldName = grid.getColumnModel().getDataIndex(columnIndex); 
            var me = this;
            var record = me.megrid.store.getAt(rowIndex); 
          
          
           //var sw1 =record.data['documento_emarque'];
           // sw1= record.data['documento_emarque']==0?1:0;
           // record.set('documento_emarque', sw1);
           
          
            me.detCmp.estado.modificado=true;
            me.detCmp.estado.store.baseParams.id_estado_seguimiento=record.data.id_estado_seguimiento;
            record.data.id_estado_seguimiento= me.detCmp.estado.store.baseParams.estado;
           
           
      //      console.log("comobo ",me.detCmp.estado.store.getAt(rowIndex)); 
           
            
         //   var sw1 =me.detCmp.estado.store.baseParams.estado;
         //   sw1= record.data['id_estado_seguimiento'];
         //   record.set('estado', 'juan');
            
           // record.set('estado', sw1);
         //   alert(sw1);
            
            //alert();
            
            
        //    var me = this;
            
       // 	console.log(me.megrid.store.getAt(rowIndex));
       // 	record.data['documento_emarque']
       // 	console.log("variable i ",i);
       // 	console.log("variable prueba ",preuba);
       // 	console.log("variable j ",rowIndex);
       
       
       //   alert(p.id_estado_seguimiento);
          
          
       },
        
        
        buildDetailGrid: function () {

            //cantidad,detalle,peso,total
            var Items = Ext.data.Record.create([{
                name: 'v_actividad',
                type: 'string'
            }, {
                name: 'estado',
                type: 'string'

            }
            ]);

          //  console.log('url del store', this.urlEstore)
            this.mestore = new Ext.data.JsonStore({

                url: this.urlEstore,
                id: 'v_id_def_proyecto_actividad',
                root: 'datos',
                totalProperty: 'total',
                fields: ['v_id_def_proyecto_actividad', 'v_id_actividad', 'v_actividad', 'estado', 'id_tipo', 'tipo', 'id_proy_seguimiento_actividad_estado', 'id_def_proyecto_seguimiento_total', 'v_nivel', 'id_estado_seguimiento'],
                remoteSort: true,
                baseParams: {dir: 'ASC', sort: 'v_id_def_proyecto_actividad', limit: '50', start: '0'}
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
            this.editorDetail.on('validateedit', this.onUpdateRegister, this);

            // this.editorDetail.on('afteredit', this.onAfterEdit, this);



            this.megrid = new Ext.grid.GridPanel({
                layout: 'fit',
                store: this.mestore,
                region: 'center',
                split: true,
                border: false,
                plain: true,

                plugins: [this.editorDetail, this.summary],
                stripeRows: true,
  //CAMPOS PARA MOSTRAR          
                columns: [
                    new Ext.grid.RowNumberer(),
                    {
                        header: 'Actividad',
                        dataIndex: 'v_actividad',
                        width: 200,
                        sortable: false,
                        renderer: function (value, p, record) {
                            var asteriscos = '';
                            for (i = 0; i < record.data['v_nivel']; i++) {
                                asteriscos += '<i class="fa fa-asterisk"></i>  ';
                            }
                            return String.format(asteriscos + ' {0}', record.data['v_actividad']);
                        },

                    },
                    {
                        header: 'Estado',
                        dataIndex: 'id_estado_seguimiento',
                        align: 'center',
                        width: 200,
                        //egrid: true,
                               forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '100%',
                        gwidth: 150,
                        minChars: 2,
                        
                       renderer:function (value, p, record) {                                     
                           //  return value ? String.format('{0}', record.data['estado']) : ' ';
                           if(record.data.Estado != 'summary'){  
                           	                	
                                     return value ? String.format('{0}', record.data['estado']) : ' ';
                           }
                        },
                        
                     editor: this.detCmp.estado
                    }     
                    ,{
                        header: 'estados',
                        dataIndex: 'estado',
                        align: 'center',
                        width: 200,
                        //egrid: true,
                               forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '100%',
                        gwidth: 150,
                        minChars: 2,
                        //egrid: true,
                       renderer:function (value, p, record) {                                     
                           //  return value ? String.format('{0}', record.data['estado']) : ' ';
                           if(record.data.Estado != 'summary'){  
                           	                	
                                     return value ? String.format('{0}', record.data['id_estado_seguimiento']) : ' ';
                           }
                        },
                        
                    }
                                        
                ]
            });
        },
        
        buildComponentesDetalle: function () {
        	
            this.detCmp = {
        		 	
                'estado': new Ext.form.ComboBox({
                	
                	
                    allowBlank: false,
                    typeAhead: true,
                    triggerAction: 'all',
                    lazyRender: true,
                    mode: 'remote',
                     emptyText: 'Elija una opción...',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_segproyecto/control/DefProyectoSeguimientoTotal/listarEstadosSeguimiento',
                            
                           
                            id: 'id_',
                            root: 'datos',
                            sortInfo: {
                                field: 'estado',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_estado_seguimiento', 'estado', 'id_tipo'], //campos de combo box
                            remoteSort: true,
                            baseParams: {par_filtro: 'estado#id_tipo'} //para busquedas en el combo
                        }),
                    pageSize: 15,
                    //valueField: 'id_estado_seguimiento',
                     valueField: 'id_estado_seguimiento',
                    displayField: 'estado'
                    

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
            
            console.log("imprimir megrid yac" ,me.megrid.store);
            
            for (i = 0; i < me.megrid.store.getCount(); i++) {
                record = me.megrid.store.getAt(i);

                arra.push(record.data);
            }


            me.argumentExtraSubmit = {
                'json_new_records': JSON.stringify(arra, function replacer(key, value) {
                    /*if (typeof value === 'string') {
                     return String(value).replace(/&/g, "%26")
                     }*/
                    return value;
                })  
            };
            
            if (i > 0 && !this.editorDetail.isVisible() ) {
                Phx.vista.FormProyectoSeguimientoTotal.superclass.onSubmit.call(this, o, undefined, true);
            }
            else {
                alert('no tiene ningun concepto  para comprar')
            } 
            
        },

        successSave: function (resp) {

            Phx.CP.loadingHide();
            var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            console.log('estoy guardando', this, objRes);
            this.fireEvent('successsaveformulario', this, objRes);

        },
        loadValoresIniciales: function () {
            Phx.vista.FormProyectoSeguimientoTotal.superclass.loadValoresIniciales.call(this);
            this.Cmp.id_def_proyecto.setValue(this.data.objPadre.id_def_proyecto);
            
            
            this.Cmp.tipo_form.setValue(this.data.tipo_form);
        },

    })
</script>