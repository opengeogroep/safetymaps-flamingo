/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


Ext.define("viewer.components.safetymapsWindow", {
    window: null,
    constructor: function (config) {
        this.initConfig(config);
        this.loadWindow(this.config.id);
    },
    loadWindow: function (id) {
        this.window = Ext.create('Ext.window.Window', {
            title: id,
            height: 600,
            width: 600,
            autoScroll: true,
            constrain: true,
            xtype: 'panel',
            closeAction: "hide",
            items: [{
                    id: "panel",
                    width: "100%",
                    flex: 1,
                    autoScroll: true,
                    border: false,
                    html: "<div id='" + "html" + "' style='width:100%;height:100%;'></div>"
                }, {
                    itemId: "footerId",
                    width: "100%",
                    height: 50,
                    autoScroll: true,
                    border: false,
                    hidden: true,
                    bodyStyle: "background-color: #F5F5F5; padding: 10px;",
                    html: "footer"
                }],
            listeners: {
                hide: function () {
                    console.log("do nothing");
                }
            }
        });
    }

});