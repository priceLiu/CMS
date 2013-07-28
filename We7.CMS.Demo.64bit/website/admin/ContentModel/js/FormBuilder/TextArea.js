/// <reference path="../jquery-1.4.1-vsdoc.js" />

; (function() {

    We7.Controls.TextArea = We7.extend(We7.Controls.Field, {

        setOptions: function(options) {
            We7.Controls.TextArea.superclass.setOptions.call(this, options);
            this.options.Height = options.Height;
            this.options.Width = options.Width;
            this.options.Rows = options.Rows;

        },

        //render input dom node

        renderComponent: function() {

            //the wrap element div
            this.warpEl = $.create('div', { className: 'we7-textarea-wrap' });

            //attributes of the input field
            var attributes = {};

            if (this.options.Rows) { attributes.rows = this.options.Rows; }
            if (this.options.Name) { attributes.name = this.options.Name; }

            //create the input element

            this.el = $.TEXTAREA(attributes);

            $(this.el).css("height", this.options.Height);
            $(this.el).css("width", this.options.Width);
            //append it to the warp

                  //可任意定制textBox属性 
            var expand = this.options.Expand;
            var appendHtml;
            if (expand && (We7.isArray(expand) || We7.isObject(expand))) {
                $.each(expand, function (i) {

                    switch (expand[i].type) {

                        case "fn": $(el).bind(expand[i].key, function () {
                            var fn = expand[i].val;
                            if (typeof (fn) === "string") {
                                new Function(fn).apply(this);
                            }
                            else
                            { fn.apply(this); }
                        });
                            break;
                         //GTODO：需要重新搞一下
                        case "append":
                            appendHtml=expand[i].val;
                            break;
                        case "attr": 
                            $(el).attr(expand[i].key, expand[i].val);
                            break;
                    }

                });
            }

            $(this.warpEl).append(this.el);

            $(this.fieldContainer).append(this.warpEl);

        },
        initEvents: function() {

//            $(this.el).change(this.options.change);
//            $(this.el).blur(this.options.blur);
//            $(this.el).keyup(this.options.keyup);
//            $(this.el).keydown(this.options.keydown);
//            $(this.el).keypress(this.options.keypress);
        //GTODO:this.options.这种获取事件的方法目前已经不太靠谱，绑定事件大部分是使用的AddEvent 不存在属性里
        We7.isFunction(this.options.click) && $(this.el).bind("click", this.options.click);
        We7.isFunction(this.options.change) && $(this.el).bind("change", this.options.change);
        We7.isFunction(this.options.blur) && $(this.el).bind("blur", this.options.blur);
        We7.isFunction(this.options.keyup) && $(this.el).bind("keyup", this.options.keyup);
        We7.isFunction(this.options.keydown) && $(this.el).bind("keydown", this.options.keydown);
        We7.isFunction(this.options.keypress) && $(this.el).bind("keypress", this.options.keypress);

        },
        getValue: function() {

            return $(this.el).val();
        },
        getEl: function() {
            return this.el;
        },
        setValue: function(value) {
        $(this.el).val(value);
        }
    });

    // Register this class as "TextBox" type
//    We7.Control.registerType("TextArea", We7.Controls.TextArea, []);
    We7.Control.registerType("TextArea", We7.Controls.TextArea, [{ Type: "Number", Label: "绑定验证", Name: "Params.validator", Value: '',Expand: [{ type: "attr", key: "disabled", val: true }, { type: "append", key: "", val: " <a href='javascript:void(0)'  title=\"点此选择\" onclick=\"openValidateManager()\"  >点此选择</a>"}]}]);
})();
