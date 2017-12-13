/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


Ext.define("viewer.components.safetymapsWindow", {
    window: null,
    options: {
        height:600,
        width:600
    },
    constructor: function (config) {

        this.initConfig(config);
        this.config = config;
        this.loadWindow(this.config.id);
    },
    loadWindow: function (id) {
        var me = this;
        this.window = Ext.create('Ext.window.Window', {
            title: id,
            height: me.options.height,
            width: me.options.width,
            layout: 'fit',
            resizable: true,
            closeAction: "hide",
            constrain: true,
            items: [
                me.createTabs()],
            listeners: {
                hide: function () {
                    me.tab.removeAll();
                },
                show: function () {
                    this.setX(window.innerWidth-me.options.width-25);
                    this.setY(window.innerHeight-me.options.height-25);
                }
            }
        });
    },

    createGrid: function (config, items, callback) {
        var store = Ext.create('Ext.data.Store', {
            storeId: config.tabName + "Store",
            fields: config.fields,
            data: items
        });

        var grid = Ext.create('Ext.grid.Panel', {
            forceFit: true,
            title: config.tabName,
            store: store,
            columns: config.columns,
            listeners: {
                itemclick: callback
            }
        });
        this.tab.add(grid);
    },

    createTabs: function () {
        this.tab = Ext.create('Ext.TabPanel', {
            layout: 'fit',
            autoScroll: true
        });
        return this.tab;
    },

    destroyGrid: function (id) {

    }

});