/* 
 * Copyright (C) 2015 ARIS B.V.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
 * Dbk Toggle Button component
 * Shows or hides the DBK's in the map.
 * @author <a href="mailto:eddy.scheper@aris.nl">Eddy Scheper</a>
 */


Ext.define("viewer.components.safetymapsToggle", {
    extend: "viewer.components.Component",
    button: null,
    layersVisible: true,
    iconOnUrl: "",
    iconOffUrl: "",
    toolTipOn: "Verberg DBK's",
    toolTipOff: "Toon DBK's",
    config: {
        // Flag (value 'visible') to show the DBK features/objects after startup.
        startupState: "visible"
    },
    constructor: function (conf) {
        var me = this;
        var basePath;

        viewer.components.safetymapsFlamingo.superclass.constructor.call(this, conf);

        this.initConfig(conf);

        // Get base path.
        if (actionBeans && actionBeans["componentresource"]) {
            basePath = actionBeans["componentresource"];
            basePath = Ext.String.urlAppend(basePath, "className=" + Ext.getClass(me).getName());
            basePath = Ext.String.urlAppend(basePath, "resource=");
        } else {
            basePath = "";
        }
        ;

        // Define icons (on = visible).
        this.iconOnUrl = basePath + "images/dbk_toggle_on.png";
        this.iconOffUrl = basePath + "images/dbk_toggle_off.png";

        // Check startup state.
        if (this.config.startupState === "visible") {
            this.layersVisible = true;
        } else {
            this.layersVisible = false;
        }
        ;

        this.forceState = true;

        // Create button.
        this.renderButton({
            handler: function () {
                me.onClick();
            },
            icon: this.iconOnUrl,
            tooltip: this.toolTipOn
        });

        // Update button state.
        this.updateButtonState(this.layersVisible);



        this.config.viewerController.addListener(viewer.viewercontroller.controller.Event.ON_COMPONENTS_FINISHED_LOADING, function () {
            // Get DBK component.

            var dbkComps = this.viewerController.getComponentsByClassName("viewer.components.safetymapsFlamingo");

            // DBK component found?
            if (dbkComps && dbkComps.length > 0) {
                $(safetymaps.safetymapsCreator).on("safetymapsInit", function (event, features) {
                    me.onDbkInitialized();
                });
            } else {
                //console.log("No 'viewer.components.Dbk' found.");
                this.button.setDisabled(true);
            }
            ;

        }, this);

        return this;
    },
    //---------------------------------------------------------------------------
    onDbkInitialized: function () {
        console.log("jaja");
        if (!this.layersVisible) {
            // Show/hide layers.
            this.updateMap(false);
            // Hide dialogs.
            //this.updateDialogs(false);
        }
        ;
    },
    //---------------------------------------------------------------------------
    onClick: function () {
        // Show/hide layers.
        this.updateMap(!this.layersVisible);
        // Hide dialogs.
        //this.updateDialogs(!this.layersVisible);
        // Toggle flag.
        this.layersVisible = !this.layersVisible;
        // Update button.
        this.updateButtonState(this.layersVisible);
    },
    //---------------------------------------------------------------------------
    updateButtonState: function (visible) {
        if (visible) {
            this.button.setIcon(this.iconOnUrl);
            this.button.setTooltip(this.toolTipOn);
        } else {
            this.button.setIcon(this.iconOffUrl);
            this.button.setTooltip(this.toolTipOff);
        }
    },
    //---------------------------------------------------------------------------
    updateMap: function (visible) {

        // Show/hide Feature layer.
        if (safetymaps.safetymapsCreator && safetymaps.safetymapsCreator.clusteringLayer.layer) {
            safetymaps.safetymapsCreator.clusteringLayer.layer.setVisibility(visible);
        }

        if (safetymaps.safetymapsCreator.objectLayers.layers && safetymaps.safetymapsCreator.objectLayers.layers.length > 0) {
            $.each(safetymaps.safetymapsCreator.objectLayers.layers, function (i, l) {
                l.setVisibility(visible);
            });
        }
        if (safetymaps.safetymapsCreator.conf.clusterWindow.window && safetymaps.safetymapsCreator.conf.featureInfoWindow.window) {
            safetymaps.safetymapsCreator.conf.clusterWindow.window.hide();
            safetymaps.safetymapsCreator.conf.featureInfoWindow.window.hide();
        }


    }
});
        