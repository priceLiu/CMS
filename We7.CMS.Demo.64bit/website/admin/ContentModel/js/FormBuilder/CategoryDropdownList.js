/// <reference path="../jquery-1.4.1-vsdoc.js" />
;
(function($) {
    We7.Controls.CategoryDropdownList = We7.extend(We7.Controls.Field, {
        setOptions: function(options) {
            We7.Controls.SelectInput.superclass.setOptions.call(this, options);
            this.options.SelectData = this.getParam("selectdata");
            this.options.SelectData = this.options.SelectData || "";

        },
        renderComponent: function() {
            //the wrap element div
            this.warpEl = $.create('div', { className: 'we7-selectinput-wrap' });

            //attributes of the input field
            var attributes = { };

            // attributes.ID = this.options.ID || this.options.Name;
            if (this.options.Name) {
                attributes.Name = this.options.Name;
            }

            //create the input element

            this.el = $.TEXT(attributes);
            this.select = $.SELECT(attributes);

            if (this.options.Width) {
                $(this.el).css("width", this.options.Width);
            }
            ;
            if (this.options.height) {
                $(this.el).css("height", this.options.height);
            }
            ;

            //append it to the warp

            $(this.warpEl).append(this.el);

            $(this.warpEl).append(this.select);
            if (this.options.SelectData) {
                this.setValue(this.options.SelectData);
            }
            $(this.fieldContainer).append(this.warpEl);
        },
        initEvents: function() {
            $(this.el).change(this.options.change);
        },
        setValue: function(Value) {
            $(this.el).val(Value);
        },
        getEl: function() {
            return this.el;
        },
        getValue: function() {
            return $(this.el).val();
        }
    });

    //获取所有站点列表
    (function initSites() {

        var url = "/Admin/ContentModel/ajax/ContentModel.asmx/GetAllGroupSite";
        $.ajax({
            url: url,
            type: "POST",
            async: false,
            cache: false,
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function(json) {
                json = JSON.parse(json);
                var result = [];
                if (json) {
                    $.each(json, function() {
                        result = result.concat(this.Name + "|" + this.Label);
                    });
                }
                We7.Control.registerType("CategoryThreeCascade",
                    We7.Controls.CategoryDropdownList,
                    [
                        { "Name": "Params.keyword", Type: "TextBox", "Label": "分类关键字" },
                        { Type: "Select", Label: "部门过滤", Name: "Params.filter", Params: [{ Name: "data", Value: "false|否,true|是" }] },
                        { Type: "Select", Label: "来源", Name: "Params.fromSite", Params: [{ Name: "data", Value:result.join(",") }] }
                    ]);
                    We7.Control.registerType("CategoryDoubleCascade",
                        We7.Controls.CategoryDropdownList,
                    [{ "Name": "Params.keyword", Type: "TextBox", "Label": "分类关键字" },
                        { Type: "Select", Label: "部门过滤", Name: "Params.filter", Params: [{ Name: "data", Value: "false|否,true|是" }] }, 
                        { Type: "Select", Label: "来源", Name: "Params.fromSite", Params: [{ Name: "data", Value: result.join(",")}] }
                    ]);
                    We7.Controls.CategoryDoubleCascade = 
                        We7.extend(We7.Controls.CategoryDropdownList, { });
                    We7.Control.registerType("CategoryDropdownList",
                        We7.Controls.CategoryDoubleCascade,
                        [
                            { Type: "Select", Label: "格式化", Name: "Params.format", Params: [{ Name: "data", Value: "false|否,true|是" }] }
                        ]);
            }
        });
    })();

})(jQuery);
