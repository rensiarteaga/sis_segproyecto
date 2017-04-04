<?php
/**
 * @package pXP
 * @file DefProyectoActividad.php
 * @author  (admin)
 * @date 10-11-2016 06:41:48
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.DefProyectoActividad = Ext.extend(Phx.gridInterfaz, {

        constructor: function (config) {
            this.maestro = config.maestro;
            //llama al constructor de la clase padre
            Phx.vista.DefProyectoActividad.superclass.constructor.call(this, config);
            this.init();
            //this.load({params: {start: 0, limit: this.tam_pag}})
        },
        loadValoresIniciales: function () {
            Phx.vista.DefProyectoActividad.superclass.loadValoresIniciales.call(this);
            this.Cmp.id_def_proyecto.setValue(this.maestro.id_def_proyecto);
        },

        onReloadPage: function (m) {
            this.maestro = m;
            this.store.baseParams = {
                id_def_proyecto: this.maestro.id_def_proyecto,
                id_proyecto: this.maestro.id_proyecto
            };
            this.load({params: {start: 0, limit: 50}})
        },
        Atributos: [
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
                config: {
                    name: 'id_actividad',
                    fieldLabel: 'Actividad', //nombre de la cabecera de la tabla
                    allowBlank: true,
                    emptyText: 'Elija una opción...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_segproyecto/control/Actividad/listarActividad',
                        id: 'id_actividad',
                        root: 'datos',
                        sortInfo: {
                            field: 'actividad',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_actividad', 'actividad'],
                        remoteSort: true,
                        baseParams: {par_filtro: 'actividad'}
                    }),
                    valueField: 'id_actividad',
                    displayField: 'actividad', //lo que se mostrar en el combo box
                    gdisplayField: 'actividad',
                    hiddenName: 'id_actividad',
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
                    renderer: function (value, p, record) {
                        //calculando el tamaño del nivel del arbol
                        //var tamanio = record.data['ancestors'].replace(/[^>]/g, "").length + 1;
                        var flechas = '';

                        for (i = 0; i < record.data['nivel']; i++) {
                            flechas += '<i class="fa fa-long-arrow-right"></i>  ';
                        }
                        if (record.data['nivel'] == 1) {

                            return String.format('<h4>{0}</h4>', record.data['actividad']);
                        } else {
                            return String.format(flechas + '{0}', record.data['actividad']);
                        }
                    }
                },
                type: 'ComboBox',
                id_grupo: 0,
                filters: {pfiltro: 'actividad', type: 'string'},
                grid: true,
                form: true
            },
            {
                config: {
                    name: 'descripcion',
                    fieldLabel: 'Descripción',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 250
                },
                type: 'TextArea',
                filters: {pfiltro: 'deprac.descripcion', type: 'string'},
                id_grupo: 1,
                grid: true,
                egrid: true,
                form: true
            },


            {
                config: {
                    name: 'min_fecha_orden',
                    fieldLabel: 'Fecha orden min.',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 250,
                    renderer: function (value, p, record) {
                        return value ? value : ''
                    }
                },
                type: 'TextArea',
                filters: {pfiltro: 'vpp.min_fecha_orden', type: 'string'},
                id_grupo: 1,
                grid: true,
                form: true
            },
            {
                config: {
                    name: 'max_fecha_entrega',
                    fieldLabel: 'Fecha entrega max.',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 250,
                    renderer: function (value, p, record) {
                        return value ? value : ''
                    }
                },
                type: 'TextArea',
                filters: {pfiltro: 'vpp.max_fecha_entrega', type: 'string'},
                id_grupo: 1,
                grid: true,
                form: true
            },
            {
                config: {
                    name: 'plazo',
                    fieldLabel: 'Plazo',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 250,
                    renderer: function (value, p, record) {
                        return value ? value + ' dias' : ''
                    }
                },
                type: 'Field',
                filters: {pfiltro: 'vpp.plazo', type: 'numeric'},
                id_grupo: 1,
                grid: true,
                form: true
            },

            {
                config: {
                    name: 'monto_suma',
                    fieldLabel: 'Monto total.',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 250,
                    renderer: function (value, p, record) {
                        return value ? value : ''
                    }
                },
                type: 'TextArea',
                filters: {pfiltro: 'vpp.monto_suma', type: 'numeric'},
                id_grupo: 1,
                grid: true,
                form: true
            }
        ],
        tam_pag: 50,
        title: 'DefinicionProyectoActividad',
        ActSave: '../../sis_segproyecto/control/DefProyectoActividad/insertarDefProyectoActividad',
        ActDel: '../../sis_segproyecto/control/DefProyectoActividad/eliminarDefProyectoActividad',
        ActList: '../../sis_segproyecto/control/DefProyectoActividad/listarDefProyectoActividad',
        id_store: 'id_def_proyecto_actividad',
        fields: [
            {name: 'id_def_proyecto_actividad', type: 'numeric'},
            {name: 'id_def_proyecto', type: 'numeric'},
            {name: 'id_actividad', type: 'numeric'},
            {name: 'descripcion', type: 'string'},
            {name: 'ancestors', type: 'string'},
            {name: 'nivel', type: 'numeric'},
            'actividad',
            'min_fecha_orden',
            'max_fecha_entrega',
            'plazo',
            'monto_suma',
            'tipo_actividad',

        ],
        sortInfo: {
            field: 'id_def_proyecto_actividad',
            direction: 'ASC'
        },
        bdel: true,
        bsave: true,
        bedit: false,
        bexcel: false,
        onButtonNew: function () {
            //abrir formulario de solicitud
            var me = this;
            me.objSolForm = Phx.CP.loadWindows('../../../sis_segproyecto/vista/actividad/BuscarActividad.php',
                'Formulario de asignacion de actividades',
                {
                    modal: true,
                    width: '90%',
                    height: '90%'
                }, {
                    data: {objPadre: me}
                },
                this.idContenedor,
                'BuscarActividad',
                {
                    config: [{
                        event: 'selectactividades',
                        delegate: this.onSaveForm,

                    }],

                    scope: this
                });


        },

        onSaveForm: function (interface, valores, id_def_proyecto) {
            var me = this;
            //alert(valores)
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                url: '../../sis_segproyecto/control/DefProyectoActividad/insertarDefinicionProyectosActividades',
                params: {id_actividades: valores, id_def_proyecto: id_def_proyecto},

                success: me.successSaveArb,
                //argument: me.argumentSave,

                failure: me.conexionFailure,
                timeout: me.timeout,
                scope: me
            });

            interface.panel.close();


        },

        successSaveArb: function (resp) {

            Phx.CP.loadingHide();
            this.reload();

        },
        south: {
            url: '../../../sis_segproyecto/vista/def_proyecto_actividad_pedido/DefProyectoActividadPedido.php',
            title: 'definicion proyecto actividad pedido',

            height: 200,
            cls: 'DefProyectoActividadPedido',
            collapsed: true
        }
        ,


    })
</script>
		
		