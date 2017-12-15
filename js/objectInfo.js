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
        if (row.t || row.html) {
            row.html = row.html ? row.html : Mustache.escape(row.t);
            values.push(row);
        }
    });
    window.createGrid(conf, values, {});

};

safetymaps.safetymapsCreator.renderDetails = function (object, window) {
    var tabs = safetymaps.creator.renderDetails(object);
    var values = [];
    for (var i = 0; i < tabs.length; i++) {
        var fields = [];
        var columns = [];
        var tab = tabs[i];
        $.each(tab.rows, function (i, row) {
            if (i === 0) {
                for (var key in row) {
                    fields.push(key);
                    columns.push({text: row[key], dataIndex: key});
                }
            } else if (row.t || row.html) {
                row.html = row.html ? row.html : Mustache.escape(row.t);
                values.push(row);
            }
        });

        var conf = {tabName: tab.name,
            fields: fields,
            columns: columns
        };

        //var values = [
        //{name: "formele naam", property: "object.formele_naam", extra: "hallo"},
        //];
        window.createGrid(conf, values, {});
    }
};

safetymaps.safetymapsCreator.renderContacts = function (object, window) {
    var rows = safetymaps.creator.renderContacts(object);
    var fields = [];
    var columns = [];
    var values= [];
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (i === 0) {
            for (var key in row) {
                fields.push(key);
                columns.push({text: row[key], dataIndex: key});
            }
        }else {
            var obj ={};
            console.log(row);
            for(var key in row){
                obj[key] = row[key];
            }
            console.log(obj);
            values.push(obj);
        }
    }
    var conf = {tabName: "creator.contacts",
        fields: fields,
        columns: columns
    };
    window.createGrid(conf, values, {});

};