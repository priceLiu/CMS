/* File Created: 十月 19, 2012 */
/*1、添加Jquery引用
  2、创建一个 "<div id='order-container'></div>" 的容器
*/
(function ($) {
    //排序信息
    var tagSinPut;

    var tagSinPutClassName = ".tagsinput"; //实例化排序信息的样式选择器

    //样式
    var tagSinPutStyle = "<style>div.tagsinput { border:1px solid #CCC; background: #FFF; padding:5px; width:100%; height:100%; overflow-y: auto;}div.tagsinput span.tag { border: 1px solid #a5d24a; -moz-border-radius:2px; -webkit-border-radius:2px; display: block; float: left; padding: 5px; text-decoration:none; background: #cde69c; color: #638421; margin-right: 5px; margin-bottom:5px;font-family: helvetica;  font-size:13px;}div.tagsinput span.tag a { font-weight: bold; color: #82ad2b; text-decoration:none; font-size: 11px; cursor: pointer; } div.tagsinput input { width:80px; margin:0px; font-family: helvetica; font-size: 13px; border:1px solid transparent; padding:5px; background: transparent; color: #000; outline:0px;  margin-right:5px; margin-bottom:5px; }div.tagsinput div { display:block; float: left; } .tags_clear { clear: both; width: 100%; height: 0px; }.not_valid {background: #FBD8DB !important; color: #90111A !important;}</style>";
    var orderSelector = "#tagsinputjsonvalue"; //排序对象json ID选择器
    var ajaxUrl = "/Admin/DataControlUI/FieldControl/Order/OrdersSelection.ashx"; //可选的字段信息请求url(return json)

    function thinkmentOrder(obj) {
        this.Mode = 1; //排序方式 0正序，1倒序
        this.AliasName = ""; //别名
        this.Name = ""; //字段名
        //一下三列暂不支持
        this.Adorn = 0;
        this.Start = 0;
        this.Length = 0;
        $.extend(this, obj);
        return this;
    }

    window.orderSelector = function (options) {
        options = {
            TableName: options.TableName,     //表名
            TableDesc: options.TableDesc,     //表描述  
            Orders: options.Orders,
            maxSize: options.maxSize || 100,  //可用排序的列最大长度
            removed: options.removed,         //移除某项排序条件 (callback(当前被移除的排序条件))
            inserted: options.inserted,       //插入某项排序条件 (callback(当前最新的排序条件集合))
            preinit: options.initing,         //开始加载         
            inited: options.inited,           //加载完成
            container: options.container,     //容器选择器
            ajaxfields: options.ajaxfields || ajaxUrl,
            selector: options.selector || orderSelector ////排序对象json ID选择器
        };
        options.preinit && options.preinit();

        orderSelector = options.selector;
        ajaxUrl = options.ajaxfields;

        //初始化排序信息
        if ($(options.container).find(tagSinPutClassName)) {
            $(options.container).append('<div class="tagsinput"></div>');
        }

        //添加样式
        tagSinPut = $(options.container).find(tagSinPutClassName).append(tagSinPutStyle);

        if (options && tagSinPut) {
            //$.each(options.ObjDescription, function (i) {
            var desc = options.TableDesc || options.TableName;
            $(tagSinPut).prepend("<span class='tag' style='background-color: yellow; '><span rel='" + encodeURIComponent(JSON.stringify({ TableName: options.TableName, TableDesc: options.TableDesc })) + "'>排序对象：" + desc + "&nbsp;&nbsp;</span></span>");
            //});
            $.each(options.Orders, function () {
                window.orderSelector.insertOrder({
                    mode: this.Mode,
                    field: this.Name,
                    desc: this.AliasName,
                    json: this
                }, options.inserted);
            });
        }

        //添加样式
        tagSinPut = $(tagSinPutClassName).append(tagSinPutStyle);

        //添加存储排序对象的json隐藏域
        $(options.selector) && tagSinPut.append("<input type='hidden' id='" + options.selector.replace("#", '') + "'/>");

        //给新添的"移除"监听上事件
        $(tagSinPut).find('a').live('click', function () {
            $(this).parent().fadeOut('fast', function () {
                $(this).remove();
                window.orderSelector.flushOrders();
                if (options.removed) {
                    options.removed(JSON.parse(decodeURIComponent($(this).find('span:first').attr('rel')))); //回调当前被移除的对象
                }
            });
        });

        window.orderSelector.flushOrders(); //刷新排序对象

        if ($.mcDropdown) { //jquery插件,用于生成下拉列表
            $.ajax({
                type: "get",
                url: ajaxUrl,
                data: "act=orderInfo&size=" + options.maxSize + "&orders=" + encodeURIComponent(JSON.stringify({ TableName: options.TableName, TableDesc: options.TableDesc, Orders: options.Orders })),
                dataType: "json",
                success: function (data) {
                    data = {
                        code: data.code,         //操作代码 200成功,301未登录,500失败
                        message: data.massage,
                        result: data.result
                    };

                    if (data && data.code === 200) {
                        //初始化字段选择器
                        if ($(options.container).find("#fields-selector")) {
                            $(options.container).append('<div id="fields-selector"></div>');
                        }

                        $(options.container).find("#fields-selector").append('<input type="text" name="orderinfo" id="orderinfo" placeholder="选择或搜索字段" style="width: 300px; " value=""/><ul id="fieldsinfo" class="mcdropdown_menu">');
                        $.each(data.result, function () {
                            var ordersAsc = new thinkmentOrder({
                                Mode: 0,
                                Name: this.Field,
                                AliasName: this.Description
                            });
                            var ordersDesc = new thinkmentOrder({
                                Mode: 1,
                                Name: this.Field,
                                AliasName: this.Description
                            });

                            var html = '<li rel="' + this.Field + '">' + this.Field + '<b>' + this.Description + '</b><ul><li rel="' + encodeURIComponent(JSON.stringify(ordersAsc)) + '">正序</li><li rel="' + encodeURIComponent(JSON.stringify(ordersDesc)) + '">倒序</li></ul></li>';
                            $(options.container).find("#fieldsinfo").append(html);
                        });

                        //
                        $("#orderinfo").mcDropdown($(options.container).find("#fieldsinfo")/*#fieldsinfo*/, {
                            targetColumnSize: 1,
                            maxRows: 100,
                            select: function (v) {
                                var order = JSON.parse(decodeURIComponent(v));
                                window.orderSelector.insertOrder({
                                    field: order.Name,
                                    desc: order.AliasName,
                                    mode: order.Mode,
                                    json: order
                                }, options.inserted);
                            }
                        });
                    } else {
                        alert(data.massage);
                    }
                }
            });
        }

        options.inited && options.inited(); //加载完成
    };

    window.orderSelector.flushOrders = function (callback) { //刷新排序对象
        var orderObject = {
            //排序对象
            TableName: "",
            TableDesc: "",
            Orders: []
        };
        $(tagSinPut).find(".tag>span").each(function (i) {
            var objJson = JSON.parse(decodeURIComponent($(this).attr('rel')));
            if (i === 0) { //表描述信息
                orderObject.TableName = objJson.TableName;
                orderObject.TableDesc = objJson.TableDesc;
            } else {
                orderObject.Orders = orderObject.Orders.concat(objJson);
            }
        });
        $(orderSelector).val(encodeURIComponent(JSON.stringify(orderObject)));

        callback && callback(orderObject); //排序对象
    };

    window.orderSelector.insertOrder = function (order, callback) {
        order = {
            mode: order.mode,   //排序 0 : 正序 else 倒序
            field: order.field, //字段名
            desc: order.desc,   //描述
            json: order.json    //排序json
        };

        if (order) {
            var mode = "倒序";
            var orderjson = encodeURIComponent(JSON.stringify(order.json));
            if (order.mode === 0) {
                mode = "正序";
            }
            $(tagSinPut).append("<span class='tag'><span rel='" + orderjson + "'>" + order.desc + "：" + mode + "&nbsp;&nbsp;</span><a title='删除 排序条件'>x</a></span>");
        }
        window.orderSelector.flushOrders(function (v) {
            callback && callback(v);
        });
    };

})(jQuery);