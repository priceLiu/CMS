//联动事件(二级)
function getSubcate(select, id, field) {

    if (typeof id == "undefined") {
        id = 1;
    }
    if (typeof field == "undefined") {
        field = "KeyWord";
    }
    var id2 = eval(id + 1);
    var parentId = select.options[select.selectedIndex].value;
    var name = select.options[select.selectedIndex].text;
    var field2Name = select.id.replace('Field' + id + 'DropDownList', 'Field' + id2 + 'DropDownList');
    if (parentId) {
        if (id == 1) {
            DoubleCascadeField2(select.id, parentId, field2Name, 'Name', field, 'ParentID', 'Category' + select.getAttribute("filter"), '请选择', 'db', '', '', '', function () {
                subcateChange(field2Name, id2);
            });
        } else {
            ThreeCascadeField3(select.id, parentId, field2Name, 'Name', field, 'ParentID', 'ParentID', 'Category' + select.getAttribute("filter"), '请选择', 'db', '', '', '', function () {
                subcateChange(field2Name, id2);
            });
        }
    }
}

//二级改变方法
function subcateChange(selectId, id) {
    if (typeof id == "undefined") {
        id = 2;
    }
    var keyword = "";
    var select = document.getElementById(selectId);
    var field2HiddenName = select.id.replace('Field' + id + 'DropDownList', 'Field' + id + 'Hidden');
    if (select.selectedIndex > -1) {
        keyword = select.options[select.selectedIndex].value;
    }
    $("#" + field2HiddenName).val(keyword);
}

// 联动控件加载二级菜单    v1.0  2011-1-12   moye
// 参数说明：
//      value   :   查询的值
//      myId    :   联动select的id
//      field2TextMapping   :   绑定select的text值
//      field2ValueMapping  :   绑定select的value值
//      field1ValueMapping  :   查询的字段名
//      table               :   表名
//      emptyText           :   为空显示值
//      type                :   xml/db
//      path                :   路径
//      nodesName           :   节点名
//      attributesName      :   属性名
//      callback            :   回调方法
function DoubleCascadeField2(select1Id, value, myId, field2TextMapping, field2ValueMapping, field1ValueMapping, table,
                                                                emptyText, type, path, nodesName, attributesName, callback) {

    var field2 = document.getElementById(myId);
    $.ajax({
        type: 'POST',
        url: '/ModelUI/Controls/page/QueryAjax.aspx',
        data: 'name=DoubleCascade.ascx&field1Value=' + escape(value) + "&field2TextMapping=" + escape(field2TextMapping) + "&field2ValueMapping=" + escape(field2ValueMapping) + "&field1ValueMapping=" + escape(field1ValueMapping) + "&table=" + escape(table) + "&type=" + escape(type) + "&path=" + escape(path) + "&nodesName=" + escape(nodesName) + "&attributesName=" + escape(attributesName),
        cache: false,
        complete: function (msg, textStatus) {

            var all = msg.responseText.split(",");
            field2.options.length = 0;
            if (emptyText != "") {
                field2.options.add(new Option('请选择', ''));
            }

            for (i = 0; i < all.length; i++) {
                if (all[i].length > 1) {
                    field2.options.add(new Option(all[i].split("&")[0], all[i].split("&")[1]));
                }
            }
            if (typeof callback != 'undefined' && callback instanceof Function) {
                callback();
            }

        }
    });
}


// 联动控件加载三级菜单    v1.0  2012.3.9   -mxy
// 参数说明：
//      field1Id:           :   第一个select的ID
//      field2Value         :   查询的值(第二个select的值)
//      field3Id            :   联动select的id(第三个select)
//      field3TextMapping   :   联动select的text值(第三个select)
//      field3ValueMapping  :   联动select的value值(第三个select)
//      field2ValueMapping  :   绑定select的value值
//      field1ValueMapping  :   查询的字段名
//      table               :   表名
//      emptyText           :   为空显示值
//      type                :   xml/db
//      path                :   路径
//      nodesName           :   节点名
//      attributesName      :   属性名
//      callback            :   回调方法
//联动控件加载三级菜单
function ThreeCascadeField3(field1Id, field2Value, field3Id, field3TextMapping, field3ValueMapping, field2ValueMapping, field1ValueMapping, table, emptyText, type, path, nodesName, attributesName) {
    var field3 = document.getElementById(field3Id);
    var field1Value = $("#" + field1Id + "").val();
    $.ajax({
        type: 'POST',
        url: '/ModelUI/Controls/page/QueryAjax.aspx',
        data: 'name=ThreeCascade.ascx&field1Value=' + escape(field1Value) + '&field2Value=' + escape(field2Value) + "&field3TextMapping=" + escape(field3TextMapping) + "&field3ValueMapping=" + escape(field3ValueMapping) + "&field2ValueMapping=" + escape(field2ValueMapping) + "&field1ValueMapping=" + field1ValueMapping + "&table=" + escape(table) + "&type=" + escape(type) + "&path=" + escape(path) + "&nodesName=" + escape(nodesName) + "&attributesName=" + escape(attributesName),
        cache: false,
        complete: function (msg, textStatus) {
            var all = msg.responseText.split(",");
            field3.options.length = 0;
            if (emptyText != "") {
                field3.options.add(new Option('请选择', ''));
            }
            for (i = 0; i < all.length; i++) {
                if (all[i].length > 1) {
                    field3.options.add(new Option(all[i].split("&")[0], all[i].split("&")[1]));
                }
            }
        }
    });
}