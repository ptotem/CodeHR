function myFormatter(cellvalue, options, rowObject) {
    if (Array.isArray(rowObject)) {
        return 'Total is: ' + rowObject[4];
    } else {
        return 'Total is: ' + rowObject.total;
    }
}

function final_rating(cellvalue, options, rowObject) {
    if (gon.avpnabove) {
        return rowObject[1]
    }
    else{
        return "NA"
    }
}

$(function(){

    $(".chzn-select").chosen();
    $(".chzn-select-deselect").chosen({allow_single_deselect:true});

var emp_id = "532c03a55c7461821100002a";
var weightage_option = "";
for (var i = 10; i <= 100; i = i + 5) {
    weightage_option = weightage_option + i.toString() + ":" + i.toString() + ";";
}
weightage_option = weightage_option.substring(0, weightage_option.length - 1);
var rating_option = "";
for (var i = 1; i <= 6; i++) {
    rating_option = rating_option + i.toString() + ":" + i.toString() + ";";
}
rating_option = rating_option.substring(0, rating_option.length - 1);

var lastsel;
var lastsel1;
var lastsel2;
var lastsel3;
var lastsel4;
var lastsel5;
//    Grid for Goals and subgoals
//    ==============================================================================================================
jQuery("#goals_list").jqGrid({
    url: '/goal_index/' + emp_id,
    datatype: "json",
    colNames: ['id', 'Goal'],
    colModel: [
        {name: 'id', index: 'id', width: 50, hidden: true, editable: false,key :true},
        {name: 'Name', index: 'name', width: 980, editable: false}
    ],
    footerrow: true,
    userDataOnFooter: true,
    pager: '#goals_pager',
    sortname: 'id',
    viewrecords: true,
    sortorder: "desc",
    multiselect: false,
    subGrid: true,
    height: '100%',
    subGridRowExpanded: function (subgrid_id, row_id) {
        console.log(subgrid_id)
        var subgrid_table_id, pager_id;
        subgrid_table_id = subgrid_id + "_t";
        pager_id = "p_" + subgrid_table_id;
        $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
        jQuery("#" + subgrid_table_id).jqGrid({
            url: "/subgoal_index/" + row_id + "/" + emp_id,
            datatype: "json",
            colNames: ['ID', 'KRA', 'Expected','Achieved', '%', 'FEEDBACK', 'Calculated','Self', 'Manager', 'Final'],
            colModel: [
                {name: 'ID', index: 'id', width: 50, key: true, hidden: true},
                {name: 'KRA', index: 'KRA', width: 270, key: true, editable: false,"edittype":"textarea","wrap":"on"},
                {name: "Expected", index: "Expected", width: 70, align: "left", editable: false,"edittype":"textarea","wrap":"on"},
                {name: 'Achieved', index: 'Achieved', width: 70, align: "center", editable: true},//, edittype: "select", editoptions: {value: weightage_option}},
                {name: 'Weightage', index: 'Weightage', width: 40, align: "center", editable: false},//, edittype: "select", editoptions: {value: weightage_option}},
                {name: 'FEEDBACK', index: 'FEEDBACK', width: 270, align: "left", editable: true,"edittype":"textarea","wrap":"on"},
                {name: "Calculated", index: "Calculated", width: 40, align: "center", sortable: false, editable: false},//, edittype: "select", editoptions: {value: rating_option}},
                {name: "Self", index: "Self", width: 40, align: "center", sortable: false, editable: true},//, edittype: "select", editoptions: {value: rating_option}},
                {name: "Manager", index: "Manager", width: 75, align: "center", sortable: false, editable: false},//, edittype: "select", editoptions: {value: rating_option}},
                {name: "Final", index: "Final", width: 50, align: "center", sortable: false, editable: false}
            ],
            rowNum: 20,
            editurl: "/subgoals/" + emp_id + "/" + row_id,
            pager: pager_id,
            sortname: 'id',
            width: '100%',
            sortorder: "asc",
            height: '100%',
            pginput: false,
            pgbuttons: false,
            ondblClickRow: function(id)
            {
                if (id && id !== lastsel) {
                    jQuery("#" + subgrid_table_id).jqGrid('restoreRow', lastsel);
                    jQuery("#" + subgrid_table_id).jqGrid('editRow', id, true, false, false, false, false,
                        function (xhr, res) {
                            jQuery("#goals_list").jqGrid('setGridParam', {url: '/goal_index/' + emp_id, page: 1});
                            jQuery("#goals_list").jqGrid('setCaption', "Job Profile").trigger('reloadGrid');
                        });
                    lastsel = id;
                }
            }
        });
        jQuery("#" + subgrid_table_id).jqGrid('setGroupHeaders', {
            useColSpanStyle: true,
            groupHeaders: [
                {startColumnName: 'Calculated', numberOfColumns: 4, titleText: 'Rating'},
                {startColumnName: 'Expected', numberOfColumns: 2, titleText: 'Measure Of Achievement'}
            ]
        });
        jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id, {edit: false, add: false, del: true})
        jQuery("#" + subgrid_table_id).jqGrid('inlineNav', "#" + pager_id, {
            addParams: {
                addRowParams: {
                    aftersavefunc: function (rowid, response, options) {
                        jQuery("#goals_list").jqGrid('setGridParam', {url: '/goals/' + emp_id, page: 1});
                        jQuery("#goals_list").jqGrid('setCaption', "Job Profile").trigger('reloadGrid');
                    }
                }
            },
            editParams: {
                aftersavefunc: function (rowid, response, options) {
                    jQuery("#goals_list").jqGrid('setGridParam', {url: '/goals/' + emp_id, page: 1});
                    jQuery("#goals_list").jqGrid('setCaption', "Job Profile").trigger('reloadGrid');
                }
            }
        });
    },
    subGridRowColapsed: function (subgrid_id, row_id) {
    },
    subGridOptions: {
        expandOnLoad: true
    },
//        editurl: '/goalsheet_containers/update',
    pginput: false,
    pgbuttons: false,
    caption: "Goals"
});
});