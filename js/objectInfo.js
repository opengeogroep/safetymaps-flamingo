/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var safetymaps = safetymaps || {};
safetymaps.safetymapsCreator = safetymaps.safetymapsCreator || {};

safetymaps.safetymapsCreator.renderGeneral = function (object, window) {
    var fields = ["l", "html"];
    var columns = [
        {text: '', dataIndex: 'l'},
        {text: '', dataIndex: 'html'}
    ];
    var conf = {tabName: "General",
        fields: fields,
        columns: columns
    };
    var rows = safetymaps.creator.renderGeneral(object);
    var values = [];
    $.each(rows, function (i, row) {
        console.log(row);
        if (row.t || row.html) {
            row.html = row.html ? row.html : Mustache.escape(row.t);
            values.push(row);
        }
    });
    window.createGrid(conf, values, {});

};

safetymaps.safetymapsCreator.renderExtra = function (object, window) {
    var fields = ["name", "property", "extra"];

    var columns = [
        {text: '', dataIndex: 'name'},
        {text: '', dataIndex: 'property'},
        {text: '', dataIndex: 'extra'}
    ];
    var conf = {tabName: "extra",
        fields: fields,
        columns: columns
    };

    var values = [
        {name: "formele naam", property: "object.formele_naam", extra: "hallo"},
    ];
    window.createGrid(conf, values, {});
};

safetymaps.safetymapsCreator.renderNew = function (object, window) {
    var me = this;
    var fields = ["name", "property", "optie", "locatie"];

    var columns = [
        {text: 'naam', dataIndex: 'name'},
        {text: 'prop', dataIndex: 'property'},
        {text: 'opti', dataIndex: 'optie'},
        {text: 'loc', dataIndex: 'locatie'}

    ];
    var conf = {tabName: "new",
        fields: fields,
        columns: columns
    };

    var values = [
        {name: "formele naam", property: "object.formele_naam", optie: "hallo", locatie: "Utrecht"},
        {name: "formele naam", property: "object.formele_naam", optie: "hallo1", locatie: "Arnhem"},
        {name: "formele naam", property: "object.formele_naam", optie: "hallo2", locatie: "Rottrerdam"},
    ];
    window.createGrid(conf, values, {});

};