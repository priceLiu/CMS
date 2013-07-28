<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Queryselector.ascx.cs" Inherits="We7.Model.UI.Controls.system.QuerySelector" %>

<style>
    #<%=ClientID%>-fieldsinfo ul {
    background: white;
    border: 1px solid #CCC;
    border-image: initial;
   /* position: absolute;*/
    width: 170px;
    padding: 0px;
    margin: 0px;
    list-style-type:none;
}
#<%=ClientID%>-fieldsinfo ul li {
    list-style-type:none;
}
#<%=ClientID%>-fieldsinfo a {
    display: block;
    height: 30px;
    margin: 0 0 7px 0;
    background-repeat: no-repeat;
    background-position: 97% center;
    font-size: 18px;
    color: white;
    padding: 5px 0 0 20px;
    text-decoration: none;
    background-color: #535353;
    width: 150px;
    text-overflow: ellipsis;
    overflow:hidden; 
    white-space:nowrap;
    cursor: pointer;
}
#<%=ClientID%>-fieldsinfo a:hover {
    background-color: #8EBD40;
    color: white;
}
</style>
<div id="<%=ClientID +"-selector-container"%>">
    <input type="hidden" id="<%=ClientID +"-objselectors"%>" name="<%=ClientID +"-objselectors"%>"/>
</div>


<script type="text/javascript">
    (function ($) {
        //排序信息
        var tagSinPut;

        var tagSinPutClassName = ".tagsinput"; //实例化排序信息的样式选择器

        //样式
        var tagSinPutStyle = "<style>div.tagsinput { bselector:1px solid #CCC; background: #FFF; padding:5px; width:100%; height:100%; overflow-y: auto;}div.tagsinput span.tag { bselector: 1px solid #a5d24a; -moz-bselector-radius:2px; -webkit-bselector-radius:2px; display: block; float: left; padding: 5px; text-decoration:none; background: #cde69c; color: #638421; margin-right: 5px; margin-bottom:5px;font-family: helvetica;  font-size:13px;}div.tagsinput span.tag a { font-weight: bold; color: #82ad2b; text-decoration:none; font-size: 11px; cursor: pointer; } div.tagsinput input { width:80px; margin:0px; font-family: helvetica; font-size: 13px; bselector:1px solid transparent; padding:5px; background: transparent; color: #000; outline:0px;  margin-right:5px; margin-bottom:5px; }div.tagsinput div { display:block; float: left; } .tags_clear { clear: both; width: 100%; height: 0px; }.not_valid {background: #FBD8DB !important; color: #90111A !important;}</style>";
        var queryselector = "#<%=ClientID%>-tagsinputjsonvalue"; //排序对象json ID选择器
        var ajaxUrl = "/admin/ContentModel/ajax/QuerySelectHandler.ashx"; //可选的字段信息请求url(return json)
        window.<%=ClientID%> = function (options) {
            options = {
                tablename: options.tablename,     //表名 
                keyidentify: options.keyidentify, //标识符
                valueidentify: options.valueidentify, //标识符
                querycount: options.querycount || 10, //查询数量
                querylicense: options.querylicense || "%", //查询凭据
                isinitshow: options.isinitshow || false,   //是否显示初始化信息
                removed: options.removed,         //移除某项查询结果 (callback(当前被移除的排序条件))
                inserted: options.inserted,       //插入某项查询结果 (callback(当前最新的排序条件集合))
                preinit: options.initing,         //开始加载         
                inited: options.inited,           //加载完成
                container: options.container,     //容器选择器
                ajaxfields: options.ajaxfields || ajaxUrl,
                selectors : options.selectors ,
                selector: options.selector || queryselector ////排序对象json ID选择器
            };
            options.preinit && options.preinit();

            queryselector = options.selector;
            ajaxUrl = options.ajaxfields;

            //初始化查询信息
            if ($(options.container).find(tagSinPutClassName)) {
                $(options.container).append('<div class="tagsinput"></div>');
            }

            //添加样式
            tagSinPut = $(options.container).find(tagSinPutClassName).append(tagSinPutStyle);

            if (options && tagSinPut) {
                $.each(options.selectors, function () {
                    window.<%=ClientID%>.insertselector({
                        keyidentify: this[options.keyidentify],
                        valueidentify: this[options.valueidentify]
                    }, options.inserted);
                });
            }

            //添加存储排序对象的json隐藏域
            $(options.selector) && tagSinPut.append("<input type='hidden' id='" + options.selector.replace("#", '') + "'/>");

            //给新添的"移除"监听上事件
            $(tagSinPut).find('a').live('click', function () {
                $(this).parent().fadeOut('fast', function () {
                    $(this).remove();
                    window.<%=ClientID%>.flushselectors();
                    if (options.removed) {
                        options.removed(JSON.parse(decodeURIComponent($(this).find('span:first').attr('rel')))); //回调当前被移除的对象
                    }
                });
            });

            window.<%=ClientID%>.flushselectors(); //刷新排序对象

            var queryentity = {
                "tablename": options.tablename,
                "querycount": options.querycount,
                "keyidentify": options.keyidentify,
                "valueidentify": options.valueidentify,
                "querylicense": options.querylicense
            };

            function iniresultlist(query, call) {
                $.ajax({
                    type: "get",
                    url: ajaxUrl,
                    data: "query=" + encodeURIComponent(JSON.stringify(query)),
                    dataType: "json",
                    success: call
                });
            }

            iniresultlist(queryentity, function (result) {
                result = {
                    code: result.code,  //操作代码 200成功,301未登录,500失败
                    message: result.massage,
                    result: result.result
                };
                if (result && result.code === 200) {
                    var fieldsselector = "<%=ClientID%>-fields-selector";
                    var queryidselector = "<%=ClientID%>-query-select";
                    var fieldsinfoselector = "<%=ClientID%>-fieldsinfo";
                    //初始化字段选择器
                    var fields = $("#"+fieldsselector);
                    if (!fields.length) {
                        fields = $('<div id='+fieldsselector+'></div>').appendTo($(options.container));
                    }

                    fields.append('<input type="text" id="'+queryidselector+'" placeholder="选择或搜索字段" style="width: 300px; " value=""/><ul id="'+fieldsinfoselector+'" />');

                    //字段信息
                    var fieldsinfo = $(options.container).find("#"+fieldsinfoselector);

                    //实例化结果至页面
                    function initresult(kv) {
                        $(fieldsinfo).empty();
                        $.each(kv, function () {
                           var html = '<li rel="' + encodeURIComponent(JSON.stringify(this)) + '"><a>' + this[options.valueidentify] + '</a></li>';
                           $(fieldsinfo).append(html);
                        });
                    }

                    if (options.isinitshow) {
                        initresult(result.result);
                    }

                    $(fieldsinfo).find("li").live("click", function() {
                        var order = JSON.parse(decodeURIComponent($(this).attr("rel")));
                        window.<%=ClientID%>.insertselector({
                                keyidentify: order[options.keyidentify],
                                valueidentify: order[options.valueidentify]
                            }, options.inserted);
                        $(fieldsinfo).empty();
                    });

                    $("#"+queryidselector).focus().keyup(function () {
                        var text = $(this).val();
                        console.log(text);

                        if ($.trim(text) === '') {
                            queryentity.querylicense = "%";
                            iniresultlist(queryentity, function (r) {
                                initresult(r.result);
                            });
                        } else {
                            queryentity.querylicense = text;
                            iniresultlist(queryentity, function (r) {
                                initresult(r.result);
                            });
                        }
                    });
                } else {
                    alert(data.massage);
                }
            });

            options.inited && options.inited(); //加载完成
        };

        window.<%=ClientID%>.flushselectors = function (callback) { //刷新排序对象
            var keyidentify = [];
            $(tagSinPut).find(".tag>span").each(function () {
                var objJson = decodeURIComponent($(this).attr('rel'));
                keyidentify = keyidentify.concat(objJson);
            });
            $(queryselector).val(encodeURIComponent(keyidentify.join(",")));
            console.log($(queryselector).val());
            callback && callback(keyidentify); //排序对象
        };

        window.<%=ClientID%>.insertselector = function (selector, callback) {
            selector = {
                keyidentify: selector.keyidentify,   //显示字段
                valueidentify: selector.valueidentify //值字段s
            };

            if (selector) {
                $(tagSinPut).append("<span class='tag'><span rel='" + selector.keyidentify + "'>" + selector.valueidentify + "&nbsp;&nbsp;</span><a title='删除'>x</a></span>");
            }
            window.<%=ClientID%>.flushselectors(function (v) {
                callback && callback(v);
            });
        };

    })(jQuery);

    if (window.<%=ClientID%>) {
        <%=ClientID%>({
            selector: "#<%=ClientID +"-objselectors"%>",
            container: "#<%=ClientID +"-selector-container"%>",
            tablename: "<%= Queryentity.tablename %>",
            keyidentify: "<%= Queryentity.keyidentify %>",
            valueidentify: "<%= Queryentity.valueidentify %>",
            querylicense: "<%= Queryentity.querylicense %>",
            querycount: "<%= Queryentity.querycount %>",
            selectors: <%=string.IsNullOrEmpty(QuerySelectors) ? "\"\"" : QuerySelectors  %>
        });
    }
</script>