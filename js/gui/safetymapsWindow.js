/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


Ext.define("viewer.components.safetymapsWindow", {
    window: null,
    options: {
        height: 600,
        width: 600
    },
    constructor: function (config) {

        this.initConfig(config);
        //this.options.merge(config);
        this.options = $.extend({
            height: 600,
            width: 600
        }, config);
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
                me.createTabs()
            ],
            listeners: {
                hide: function () {
                    if(me.id === "infopanel"){
                        me.tab.removeAll();
                    }
                },
                show: function () {
                    if (me.id === "infopanel") {
                        this.setX(window.innerWidth - me.window.width - 25);
                        this.setY(window.innerHeight - me.window.height - 25);
                    } else {
                        this.setX(150);
                        this.setY(window.innerHeight - me.window.height);
                    }

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
        if (config.feature) {
            this.tab.hide();
            this.window.add(grid);
        } else {
            this.tab.add(grid);
        }
    },

    createTabs: function () {
        this.tab = Ext.create('Ext.TabPanel', {
            layout: 'fit',
            autoScroll: true
        });
        return this.tab;
    },

    destroyGrid: function (id) {

    },

    createCarousel: function (data) {
        var carousel = Ext.create('Ext.panel.Panel', {
            title: i18n.t("creator.media"),
            styleHtmlContent: true,
            width: 200,
            html: data[0].outerHTML

        });
        this.tab.add(carousel);
    }
});