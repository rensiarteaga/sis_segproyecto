<?php
/**
 * @package pXP
 * @file gen-DefProyecto.php
 * @author  (admin)
 * @date 08-02-2017 19:56:10
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.DefProyecto = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.DefProyecto.superclass.constructor.call(this, config);
                this.init();
                this.load({params: {start: 0, limit: this.tam_pag}})
            },
            Atributos: [
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
                        name: 'id_proyecto',
                        fieldLabel: 'Proyecto',
                        allowBlank: false,
                        emptyText: 'Elija una opción...',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_segproyecto/control/DefProyecto/listarProyectos',
                            id: 'id_',
                            root: 'datos',
                            sortInfo: {
                                field: 'nombre',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_proyecto', 'nombre', 'codproyecto'], //campos de combo box
                            remoteSort: true,
                            baseParams: {par_filtro: 'nombre#codproyecto'} //para busquedas en el combo
                        }),
                        tpl: '<tpl for="."><div class="x-combo-list-item" ><div class="awesomecombo-item {checked}">{codproyecto}</div><p style="padding-left: 20px;">{nombre}</p> </div></tpl>',
                        valueField: 'id_proyecto',
                        displayField: 'nombre',
                        gdisplayField: 'desc_proyecto',//vista en la grilla
                        hiddenName: 'id_proyecto',
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
                            return String.format('( {0} ) {1}', record.data['codproyecto'], record.data['desc_proyecto']);
                        }
                    },
                    type: 'ComboBox',
                    id_grupo: 0,
                    filters: {pfiltro: 'nombre', type: 'string'},
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'descripcion',
                        fieldLabel: 'Descripción',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 200
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'defproy.descripcion', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'fecha_inicio_teorico',
                        fieldLabel: 'Fecha inicio teorico',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'defproy.fecha_inicio_teorico', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'fecha_fin_teorico',
                        fieldLabel: 'Fecha fin teórico',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'defproy.fecha_fin_teorico', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'estado_reg',
                        fieldLabel: 'Estado Registro',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'defproy.estado_reg', type: 'string'},
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
                    filters: {pfiltro: 'defproy.id_usuario_ai', type: 'numeric'},
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
                    filters: {pfiltro: 'defproy.usuario_ai', type: 'string'},
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
                    filters: {pfiltro: 'defproy.fecha_reg', type: 'date'},
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
                    filters: {pfiltro: 'defproy.fecha_mod', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                }
            ],

            tam_pag: 50,
            title: 'definición proyecto',
            ActSave: '../../sis_segproyecto/control/DefProyecto/insertarDefProyecto',
            ActDel: '../../sis_segproyecto/control/DefProyecto/eliminarDefProyecto',
            ActList: '../../sis_segproyecto/control/DefProyecto/listarDefProyecto',
            id_store: 'id_def_proyecto',
            fields: [
                {name: 'id_def_proyecto', type: 'numeric'},
                {name: 'fecha_inicio_teorico', type: 'date', dateFormat: 'Y-m-d'},
                {name: 'descripcion', type: 'string'},
                {name: 'fecha_fin_teorico', type: 'date', dateFormat: 'Y-m-d'},
                {name: 'estado_reg', type: 'string'},
                {name: 'id_proyecto', type: 'numeric'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},
                'desc_proyecto',
                'codproyecto',

            ],
            sortInfo: {
                field: 'id_def_proyecto',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true,
            bexcel: false
                /*
                 ,

                 south: {
                 url: '../../../sis_segproyecto/vista/def_proyecto_seguimiento/DefProyectoSeguimiento.php',
                 title: 'Seguimiento de proyectos',
                 width: '10%',
                 height: '50%',
                 cls: 'DefProyectoSeguimiento',
                 collapsed: true
                 }
                 ,
                 east: {
                 url: '../../../sis_segproyecto/vista/def_proyecto_actividad/DefProyectoActividad.php',
                 title: 'Asignacion actividades',
                 width: '50%',
                 cls: 'DefProyectoActividad',
                 collapsed: true
                 }
                 */
        }
    )
</script>
		
		