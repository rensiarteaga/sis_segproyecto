<?php
/**
 * @package pXP
 * @file gen-Actividad.php
 * @author  (admin)
 * @date 31-01-2017 21:38:35
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Actividad = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.Actividad.superclass.constructor.call(this, config);
                this.init();
            },
        Atributos: [
            {
                //configuracion del componente
                config: {
                    labelSeparator: '',
                    inputType: 'hidden',
                    name: 'id_actividad'
                },
                type: 'Field',
                form: true
            },
            {
                //configuracion del componente
                config: {
                    labelSeparator: '',
                    inputType: 'hidden',
                    name: 'id_actividad_padre'
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
                    maxLength: 150
                },
                type: 'TextField',
                filters: {pfiltro: 'acti.actividad', type: 'string'},
                id_grupo: 1,
                grid: true,
                form: true
            },
            {
                config: {
                    name: 'id_tipo',
                    fieldLabel: 'Tipo actividad',
                    allowBlank: false,
                    emptyText: 'Elija un tipo...',
                    store: new Ext.data.JsonStore({
                        url: '../../sis_segproyecto/control/Actividad/listarTipos',
                        id: 'id_tipo',
                        root: 'datos',
                        sortInfo: {
                            field: 'tipo',
                            direction: 'ASC'
                        },
                        totalProperty: 'total',
                        fields: ['id_tipo', 'tipo'], //campos de combo box
                        remoteSort: true,
                        baseParams: {par_filtro: 'tipo'} //para busquedas en el combo
                    }),
                    valueField: 'id_tipo',
                    displayField: 'tipo',
                    gdisplayField: 'tipo',//vista en la grilla
                    hiddenName: 'id_tipo',
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
                        return String.format('{0} ', record.data['tipo']);
                    }
                },
                type: 'ComboBox',
                id_grupo: 0,
                filters: {pfiltro: 'tipo', type: 'string'},
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
                filters: {pfiltro: 'acti.estado_reg', type: 'string'},
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
                filters: {pfiltro: 'acti.fecha_reg', type: 'date'},
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
                filters: {pfiltro: 'acti.usuario_ai', type: 'string'},
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
                filters: {pfiltro: 'acti.id_usuario_ai', type: 'numeric'},
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
                filters: {pfiltro: 'acti.fecha_mod', type: 'date'},
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
            title: 'Actividad',
            ActSave: '../../sis_segproyecto/control/Actividad/insertarActividad',
            ActDel: '../../sis_segproyecto/control/Actividad/eliminarActividad',
            ActList: '../../sis_segproyecto/control/Actividad/listarActividad',
            id_store: 'id_actividad',
            fields: [
                {name: 'id_actividad', type: 'numeric'},
                {name: 'id_actividad_padre', type: 'numeric'},
                {name: 'actividad', type: 'string'},
                {name: 'tipo_actividad', type: 'string'},
                {name: 'id_tipo', type: 'numeric'},
                {name: 'tipo', type: 'string'},
                {name: 'estado_reg', type: 'string'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'},
            ],
            sortInfo: {
                field: 'id_actividad',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true
        }
    )
</script>