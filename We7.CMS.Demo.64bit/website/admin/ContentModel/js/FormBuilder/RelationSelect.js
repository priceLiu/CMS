/// <reference path="../jquery-1.4.1-vsdoc.js" />
; (function () {

    We7.Controls.RelationSelect = We7.extend(We7.Controls.Field, {

        setOptions: function (options) {
            We7.Controls.RelationSelect.superclass.setOptions.call(this, options);
            this.options.Url = options.Url;
            this.options.TextField = options.TextField;
            this.options.ValueField = options.ValueField;
            this.options.ParamData = options.ParamData;

        },

        renderComponent: function () {
            //the wrap element div
            this.warpEl = $.create('div', { className: 'we7-RelationSelect-wrap' });

            //attributes of the input field
            var attributes = {};

            attributes.ID = this.options.ID || this.options.Name;
            if (this.options.Name) { attributes.Name = this.options.Name; }

            //create the input element

            this.el = $.SELECT(attributes);
            var elm = this.el;
            if (this.options.Width) { $(this.el).css("width", this.options.Width); };
            if (this.options.height) { $(this.el).css("height", this.options.height); };
            //ajax Items
            if (this.options.Url) {
                $.getJSON(this.options.Url, this.options.ParamData, function (data) {
                    $.each(data, function (i) {
                        var attr = {};
                        attr.Value = data[i].Value;
                        var op = $.create("option", attr, data[i].text);
                        $(elm).append(op);
                    });
                });
            }
            var Params = this.options.Params;
            if (!this.options.Url && Params) {

                $.each(Params, function (i) {
                    if (Params[i].Name == "data") {
                        var string = Params[i].Value;
                        var items = string.split(",");

                        for (var p in items) {
                            var item = items[p].split("|");

                            if (item.length == 2) {
                                var attr = {};
                                attr.value = item[0];
                                var op = $.create("option", attr, item[1]);
                                $(elm).append(op);
                            }
                            else {
                                var attr = {};
                                attr.value = item[0];
                                var op = $.create("option", attr, item[0]);
                                $(elm).append(op);
                            }
                        }
                    }
                });

            }
            //append it to the warp

            $(this.warpEl).append(this.el);
            if (this.options.Type == "RelationSelectEx")
                $(this.warpEl).append("<a href='javascript:void(0);'>新增</a>");

            $(this.el).attr("value", this.options.Value);

            $(this.fieldContainer).append(this.warpEl);
        },
        initEvents: function () {
            $(this.el).change(this.options.change);
        },
        setValue: function (Value) {

            $(this.el).attr("value", Value);
        },
        getEl: function () {
            return this.el;
        },
        getValue: function () {
            return $(this.el).val();
        },
        getText: function () {
            return $(this.el).find("option:selected").text();

        }
    });
    We7.Control.registerType("RelationSelect", We7.Controls.RelationSelect,
 [
 { Type: "TextBox", Label: "关联表", Name: "Params.model", Expand: [{ type: "attr", key: "readonly", val: true }, { type: "attr", key: "value", val: "点击此处选择" }, { type: "fn", key: "click", val: " newForm(\"ChooseTableColumn.aspx\", \"选择表结构\", \"80%\", \"80%\",true);"}, { type: "apply", key: "", val: "<span rel=\"xml-hint\" title=\"点此选择\" ></span>"}] },
  { Type: "TextBox", Label: "文本字段", Name: "Params.textfield", Expand: [{ type: "attr", key: "disabled", val: true}] },
  { Type: "TextBox", Label: "", Name: "Params.valuefield", Style: "display:none;" }
  ]);

    We7.Controls.RelationSelectEx =We7.extend( We7.Controls.RelationSelect,{});
    We7.Control.registerType("RelationSelectEx", We7.Controls.RelationSelectEx,
 [ ]);
})();