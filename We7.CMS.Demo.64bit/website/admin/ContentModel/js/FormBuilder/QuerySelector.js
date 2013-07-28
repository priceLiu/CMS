/* File Created: 十一月 16, 2012 */
;
(function ($) {

    We7.Controls.QuerySelector = We7.extend(We7.Controls.Field, {

        setOptions: function (options) {
            We7.Controls.SelectInput.superclass.setOptions.call(this, options);
            this.options.SelectData = this.getParam("selectdata");
            this.options.SelectData = this.options.SelectData || "";

        },
        renderComponent: function () {

            //the wrap element div
            this.warpEl = $.create('div', { className: 'we7-selectinput-wrap' });

            //attributes of the input field
            var attributes = {};

            // attributes.ID = this.options.ID || this.options.Name;
            if (this.options.Name) { attributes.Name = this.options.Name; }

            //create the input element

            this.el = $.TEXT(attributes);
            this.select = $.SELECT(attributes);

            if (this.options.Width) { $(this.el).css("width", this.options.Width); };
            if (this.options.height) { $(this.el).css("height", this.options.height); };

            //append it to the warp

            $(this.warpEl).append(this.el);

            $(this.warpEl).append(this.select);
            if (this.options.SelectData) {
                this.setValue(this.options.SelectData);
            }
            $(this.fieldContainer).append(this.warpEl);
        },
        initEvents: function () {
            $(this.el).change(this.options.change);
        },
        setValue: function (Value) {
            $(this.el).val(Value);
        },
        getEl: function () {
            return this.el;
        },
        getValue: function () {
            return $(this.el).val();
        }

    });
    
     //获取所有模型信息
    (function initModels() {
        var url = "/Admin/ContentModel/ajax/ContentModel.asmx/GetAllModelInfo";
        $.ajax({
            url: url,
            type: "POST",
            async: false,
            cache: false,
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(json) {
                json = JSON.parse(json);
                var result = [];
                if (json) {
                    $.each(json, function() {
                        result = result.concat(this.Name + "|" + this.Label);
                    });
                }
                 //todo:丁乐，需要做成联动选字段。当前只能选模型

                We7.Control.registerType("QuerySelector",
                    We7.Controls.QuerySelector,
                    [
                        {
                            Type: "Select",
                            Label: "选择模型名",
                            Name: "Params.modelname",
                            Params: [{
                                Name: "data",
                                Value: result.join(",")
                            }]
                        },
                        { "Name": "Params.keyidentify", Type: "TextBox", "Label": "选择标识字段" },
                        { "Name": "Params.valueidentify", Type: "TextBox", "Label": "选择显示字段" },
                        
                    ]);
            }
        });
    })();

    
    
//    //获取所有字段信息
//    function getFieldsInfo(name,call) {
//        var url = "/Admin/ContentModel/ajax/ContentModel.asmx/GetFieldsInfo";
//        $.ajax({
//            url: url,
//            data: JSON.stringify({modelName : name}),
//            async:false,
//            type: "POST",
//            cache:false,
//            contentType: 'application/json; charset=utf-8',
//            dataType: 'json',
//            success: function (json) {
//                json = JSON.parse(json);
//                var result= [];
//                if (json) {
//                    $.each(json, function() {
//                        result = result.concat (this.Field + "|" + this.Description);
//                    });
//                }
//                fields = result.join(",");
//                call && call(json);
//            }
//        });
//    }


//    function initFields(json) {
//        var keyIdentify = $("select[name=Selecotor.KeyIdentify]");
//        var valueIdentify = $("select[name=Selecotor.ValueIdentify]");
//        $(keyIdentify).empty();
//        $(valueIdentify).empty();
//        $.each(json, function() {
//            $(keyIdentify).append("<option value='"+this.Field+"'>"+this.Description+"</option>");
//            $(valueIdentify).append("<option value='"+this.Field+"'>"+this.Description+"</option>");
//        });
//    }

//    function initEvet() {
//        var modelName = $("select[name=Selecotor.ModelName]");
//        var keyIdentify = $("select[name=Selecotor.KeyIdentify]");
//        var valueIdentify = $("select[name=Selecotor.ValueIdentify]");
//        if (!modelName.length || !keyIdentify.length || !valueIdentify.length) {
//            setTimeout(function() {
//                initEvet();
//            }, 200);
//        }else {
//            //完成加载
//            if ($(modelName).val()) {
//                getFieldsInfo($(modelName).val(), initFields);//赋初始值
//            }
//            $(modelName).bind("change", function() {
//                console.log("执行到了change事件");
//                getFieldsInfo($(modelName).val(), initFields);
//            });
//            
//        }
//    }
    
})(jQuery)