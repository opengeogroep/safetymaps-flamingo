/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


Ext.define("viewer.components.safetymapsWindow", {
    window: null,
    constructor: function (config) {

        this.initConfig(config);
        this.config = config;
        this.loadWindow(this.config.id);
    },
    loadWindow: function (id) {
        var me = this;
        this.window = Ext.create('Ext.window.Window', {
            title: id,
            height: 600,
            width: 600,
            layout: 'fit',
            resizable: true,
            closeAction: "hide",
            constrain: true,
            items: [
                me.createTabs()],
            listeners: {
                hide: function () {
                    me.tab.removeAll();
                }
            }
        });
    },

    createGrid: function (config, items, callback) {
        var me = this;
        var store = Ext.create('Ext.data.Store', {
            storeId: config.name + "Store",
            fields: ['name'],
            data: items
        });

        var grid = Ext.create('Ext.grid.Panel', {
            forceFit: true,
            title: config.name,
            store: store,
            flex: 1,
            columns: [
                {text: 'Name', dataIndex: 'name'

                }
            ],
            listeners: {
                itemclick: callback
            }
        });
        this.tab.add(grid);
    },

    createTabs: function () {
        this.tab = Ext.create('Ext.TabPanel', {
            layout: 'fit',
            autoScroll: true,
        });
        return this.tab;
    },

    destroyGrid: function (id) {

    }

});