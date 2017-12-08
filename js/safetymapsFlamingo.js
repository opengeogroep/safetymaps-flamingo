/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


Ext.define ("viewer.components.safetymapsFlamingo",{
    extend: "viewer.components.Component",
    config: {},
    viewerController: null,
    map: null,
    imagePath:"",
    
    constructor: function(conf){
       var me = this;
       
       viewer.components.safetymapsFlamingo.superclass.constructor.call(this, conf);

       this.initConfig(conf);
       
       me.initApplication(conf);
    },
    
    initApplication: function(conf){
        var me = this;
        me.viewerController = me.config.viewerController;
        me.map = me.viewerController.mapComponent.getMap();
        
        safetymaps.creator.api.basePath = conf.dataPath+"/"; // path to safetymaps-server
        if (actionBeans && actionBeans["componentresource"]){
            me.imagePath=actionBeans["componentresource"];
            me.imagePath=Ext.String.urlAppend(me.imagePath,"className="+Ext.getClass(me).getName());
            me.imagePath=Ext.String.urlAppend(me.imagePath,"resource=");
        } else {
            me.imagePath = "";
        };
        me.imagePath += "/module/assets/";
        safetymaps.creator.api.imagePath = me.imagePath;
        safetymaps.safetymapsCreator.constructor(me);
    }
});