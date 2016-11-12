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
            this.load({params: {start: 0, limit: this.tam_pag}})
        },
        loadValoresIniciales: function () {
            Phx.vista.DefProyectoActividad.superclass.loadValoresIniciales.call(this);
            this.Cmp.id_def_proyecto.setValue(this.maestro.id_def_proyecto);
        },

        onReloadPage: function (m) {
            this.maestro = m;
            this.store.baseParams = {id_def_proyecto: this.maestro.id_def_proyecto};
            console.log((this.maestro))
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
                    fieldLabel: 'actividad', //nombre de la cabecera de la tabla
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
                        return String.format('{0}', record.data['actividad']);
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
                    name: 'estado_reg',
                    fieldLabel: 'Estado Reg.',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 10
                },
                type: 'TextField',
                filters: {pfiltro: 'deprac.estado_reg', type: 'string'},
                id_grupo: 1,
                grid: true,
                form: false
            },
            {
                config: {
                    name: 'descripcion',
                    fieldLabel: 'descripcion',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 250
                },
                type: 'TextField',
                filters: {pfiltro: 'deprac.descripcion', type: 'string'},
                id_grupo: 1,
                grid: true,
                form: true
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
                filters: {pfiltro: 'deprac.usuario_ai', type: 'string'},
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
                filters: {pfiltro: 'deprac.fecha_reg', type: 'date'},
                id_grupo: 1,
                grid: true,
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
                    name: 'id_usuario_ai',
                    fieldLabel: 'Creado por',
                    allowBlank: true,
                    anchor: '80%',
                    gwidth: 100,
                    maxLength: 4
                },
                type: 'Field',
                filters: {pfiltro: 'deprac.id_usuario_ai', type: 'numeric'},
                id_grupo: 1,
                grid: false,
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
                filters: {pfiltro: 'deprac.fecha_mod', type: 'date'},
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
            {name: 'estado_reg', type: 'string'},
            {name: 'descripcion', type: 'string'},
            {name: 'usuario_ai', type: 'string'},
            {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
            {name: 'id_usuario_reg', type: 'numeric'},
            {name: 'id_usuario_ai', type: 'numeric'},
            {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
            {name: 'id_usuario_mod', type: 'numeric'},
            {name: 'usr_reg', type: 'string'},
            {name: 'usr_mod', type: 'string'}, 'actividad',

        ],
        sortInfo: {
            field: 'id_def_proyecto_actividad',
            direction: 'ASC'
        },
        bdel: true,
        bsave: true,
        onButtonNew: function () {
            //abrir formulario de solicitud
            var me = this;
            me.objSolForm = Phx.CP.loadWindows('../../../sis_segproyecto/vista/actividad/BuscarActividad.php',
                'Formulario de Solicitud de Compra',
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
             var  me = this;
            alert(valores)
              Phx.CP.loadingShow();
             Ext.Ajax.request({
                    url: '../../../sis_segproyecto/control/DefProyectoActividad/insertarDefinicionProyectosActividades',
                    params: {id_actividades : valores, id_def_proyecto: id_def_proyecto},
                    
                    success: this.successSave,
                    //argument: me.argumentSave,

                    failure: me.conexionFailure,
                    timeout: me.timeout,
                    scope: me
                });

            interface.panel.close();


        },
        
        successSave: function(resp) {
        console.log('sobre cargar successSave')
        },
    })
</script>
		
		