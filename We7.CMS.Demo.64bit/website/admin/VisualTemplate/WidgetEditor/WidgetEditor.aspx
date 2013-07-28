﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WidgetEditor.aspx.cs"
 Inherits="We7.CMS.Web.Admin.VisualTemplate.WidgetEditor" ValidateRequest="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>部件编辑</title>
    <base target="_self" />
    <style type="text/css">
        input, selectd
        {
            margin: 0;
        }
        td
        {
            font-size: 14px;
        }        
        body{
            margin:0px auto;  
        }    
        .CodeMirror-wrapping{
            border:1px solid #aaa;
        }   
               
#fullbg{
background-color: Gray;
display:none;
z-index:3;
position:absolute;
left:0px;
top:0px;
filter:Alpha(Opacity=30);
/* IE */
-moz-opacity:0.4;
/* Moz + FF */
opacity: 0.4;
}

#dialog {
position:absolute;
width:200px;
height:200px;
display: none;
z-index: 5;
}

.orderfields {
    float: left;
    width: 170px;
}
.orderfields ul {
    background: white;
    border: 1px solid #CCC;
    border-image: initial;
   /* position: absolute;*/
    width: 170px;
    padding: 0px;
    margin: 0px;
    list-style-type:none;
}
.orderfields ul li {
    list-style-type:none;
}
.orderfields a {
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
.orderfields a:hover {
    background-color: #8EBD40;
    color: white;
}

.fields-title {
    
}

.table-desc { }

.search-span {
    
}
.search-span input
{
   
    border: 1px solid #999;
    -moz-border-radius: 2px;
    border-radius: 2px;
    -moz-box-shadow: inset 1px 1px 2px rgba(0,0,0,.2);
    -webkit-box-shadow: inset 1px 1px 2px rgba(0, 0, 0, .2);
    box-shadow: inset 1px 1px 2px rgba(0, 0, 0, .2);
    background-color: white;
    color: #666;
    outline: none;
    padding: 10px;
}
.search-span input:hover {
     -moz-box-shadow: inset 1px 1px 4px rgba(0,0,0,.4);
    -webkit-box-shadow: inset 1px 1px 4px rgba(0, 0, 0, .4);
    box-shadow: inset 1px 1px 4px rgba(0, 0, 0, .4);
}
#orderpager{ margin-top: 10px;}
.pager-item{display:block;float:left;}
.pager-spinner-prev,.pager-spinner-next {
    cursor:pointer;width: 21px;height:21px;
    background-image: url(../../images/arrow.png);
    background-repeat: no-repeat;
    margin-left: 15px;
}
.pager-spinner-prev 
{
    background-position: 0 -21px;
}
.pager-spinner-prev:hover {
    background-position: 0 1px;
}
.pager-spinner-next 
{
    background-position: -44px -21px;
}
.pager-spinner-next:hover {
    background-position: -44px 0;
}
.pager-spinner-prev,.pager-spinner-next{}
.pager-bar{ display: none;}
.page-number{ float: right;margin-right: 10px;}
    </style>
    <link rel="stylesheet" type="text/css" href="/admin/ajax/CodeMirror/css/docs.css"/>
    <script src="/admin/ajax/CodeMirror/js/codemirror.js" type="text/javascript"></script>
     <script type="text/javascript" src="<%=AppPath%>/ajax/jquery/jquery.latest.min.js"></script>
    <script src="pager.js" type="text/javascript"></script>

    <script type="text/javascript">
        function store() {
            document.getElementById("hdFileName").value = "";
             var r = window.showModalDialog('WidgetSaveAs.htm?20110418011', '<%=Request["ctr"] %>', 'scrollbars=no;resizable=no;help=no;status=no;center=1; dialogHeight=160px;dialogwidth=430px;');
             debug;
			 if (r) {
                 showBg('dialog', 'dialog_content');
                document.getElementById("hdFileName").value = r.name;
                return true;
            }
            return false;
        }

        //显示灰色JS遮罩层
        function showBg(ct, content) {
            var bH = $("body").height();
            var bW = $("body").width() + 16;
            var objWH = getObjWh(ct);
            $("#fullbg").css({ width: bW, height: bH, display: "block" });
            var tbT = objWH.split("|")[0] + "px";
            var tbL = objWH.split("|")[1] + "px";
            $("#" + ct).css({ top: tbT, left: tbL, display: "block" });
            // $("#" + content).html("<div style='text-align:center'>正在加载，请稍后...</div>");
            $(window).scroll(function () { resetBg() });
            $(window).resize(function () { resetBg() });
        }
        function getObjWh(obj) {
            var st = document.documentElement.scrollTop; //滚动条距顶部的距离
            var sl = document.documentElement.scrollLeft; //滚动条距左边的距离
            var ch = document.documentElement.clientHeight; //屏幕的高度
            var cw = document.documentElement.clientWidth; //屏幕的宽度
            var objH = $("#" + obj).height(); //浮动对象的高度
            var objW = $("#" + obj).width(); //浮动对象的宽度
            var objT = Number(st) + (Number(ch) - Number(objH)) / 2;
            var objL = Number(sl) + (Number(cw) - Number(objW)) / 2;
            return objT + "|" + objL;
        }
        function resetBg() {
            var fullbg = $("#fullbg").css("display");
            if (fullbg == "block") {
                var bH2 = $("body").height();
                var bW2 = $("body").width() + 16;
                $("#fullbg").css({ width: bW2, height: bH2 });
                var objV = getObjWh("dialog");
                var tbT = objV.split("|")[0] + "px";
                var tbL = objV.split("|")[1] + "px";
                $("#dialog").css({ top: tbT, left: tbL });
            }
        }

        //关闭灰色JS遮罩层和操作窗口
        function closeBg() {
            $("#fullbg").css("display", "none");
            $("#dialog").css("display", "none");
        }
        function Close(value) {
            console.log(value);
            value = value.replace(/\~/g, '/');
            window.returnValue = value;

            //兼容Chrome
            window.opener.ReturnValue = value;

            window.close();
        }

        <%if (!string.IsNullOrEmpty(OrderObj.TableName)) {%>
        $(document).ready(function () {
            $.ajax({
                type: "get",
                url: "../../DataControlUI/FieldControl/Order/OrdersSelection.ashx",
                data: "orders=<%=Orders%>&act=orderInfo",
                dataType: "json",
                success: function (data) {
                    if (data && data.code === 200) {
                        $.each(data.result, function () {
                            var fieldLi = document.createElement("li");
                            var fieldA = document.createElement("a");
                            fieldA.title =  this.Field + "：" + this.Description;
                            
                            var fieldSpan = document.createElement("span");
                            fieldSpan.className = 'fields-title';
                            $(fieldSpan).text(this.Description);
                            $(fieldSpan).attr('ref', this.Field);
                            $(fieldA).attr('ref',this.Field);
                            $(fieldA).append(fieldSpan);
                            $(fieldLi).append(fieldA);
                            
                            //绑定点击事件
                            $(fieldA).bind('click', function () {
                                var itemText = $(window.onCursorActivityText).text();
                                $(window.onCursorActivityText).text(itemText + $(this).attr("ref"));
                            }); 
                            
                            $(".orderfields>ul:first").append(fieldLi);
                            
                        });
                        
                        $('.orderfields>ul:first>li:gt(9)').hide();		
		                
                        function pageCount(s){
                            if ((s % 10) != 0 && s < 10) {
                                return 1;
                            }else if((s % 10) ==0 ) {
                                return s / 10;
                            }else {
                                return Math.ceil(s / 10);
                            }
                        }

                        function formatPageNumber(pager) {
                            return pager.currentPage() + "/" + pager.totalPages();
                        }
                        
                        var count = parseInt(pageCount($('.orderfields>ul:first>li').length));
                        var defaultPager = new Pager("#orderpager",count ,1);
                        $('<span class="page-number" />').html(formatPageNumber(defaultPager)).appendTo("#orderpager");

		                defaultPager.onpaged(function(page, lastPage){
		                    if(page == lastPage) {
		                        return;
		                    }
			                $('.orderfields>ul:first>li').each(function(i){
				                if(page * 10 -1 >= i && i <= (page * 10) +10 && i >= (page * 10) -10 ){
					                $(this).show();
				                }else{
					                $(this).hide();
				                }
			                });
		                    this.holder.children("span.page-number").html(formatPageNumber(this));
		                });
                    } else {
                        alert(data.message);
                    }
                }
            });
            //搜索过滤
            $(function () {
                $("#search-widgets").focus().keyup(function () {
                    var text = $(this).val();
                    if ($.trim(text) === '') {
                        $(".orderfields>ul>li:lt(10)").show();
                        $(".orderfields>ul>li:gt(9)").hide();
                        return;
                    }
                    //遍历关键字
                    $(".orderfields>ul>li").each(function () {
                        var elt = $(this);
                        var value = elt.text();
                        //命中关键字则显示
                        if (value.toLowerCase().indexOf($.trim(text).toLowerCase()) >= 0) {
                            elt.show();
                        } //隐藏
                        else {
                            elt.hide();
                        }
                    });
                    $(".orderfields>ul>li:visible:gt(9)").hide();
                });
            });
        });
        <%} %>
    </script>

</head>
<body style="Margin:0 auto;Padding:0;">
    <form id="form1" runat="server">
    <div style="float: left">
        <table width="80%">
            <tr>
                <td>
                    <asp:TextBox ID="CtrCodeTextBox" runat="server" TextMode="MultiLine" Width="620px"
                        style="border: 2px solid #aaa;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="SaveButton" runat="server" Text="　　保存　　" OnClick="SaveButton_Click" />
                            </td>
                            <td>
                                <asp:Button ID="PreviewButton" runat="server" Text="　　预览　　" OnClick="PreviewButton_Click" />
                            </td>
                            <td>
                                <asp:Button ID="StoreButton" OnClientClick="return store();" runat="server" Text="　　另存为　　" OnClick="StoreButton_Click" />
                                <asp:HiddenField ID="hdFileName" runat="server" />
                            </td>
                            <td>
                                <asp:Label ID="msgLabel" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div class="orderfields">
        <span class="search-span">
            <input id="search-widgets" type="text" placeholder='<%=string.IsNullOrEmpty(OrderObj.TableName) ? "暂未配置表" : "搜索" + OrderObj.TableDesc +"的字段"%>'  x-webkit-speech=""/></span>
        <ul style="min-height: 420px"></ul>
        <div id="orderpager"></div>
    </div>
    </form>
      <script type="text/javascript">
          var editor = CodeMirror.fromTextArea('<%=CtrCodeTextBox.ClientID %>', {
              parserfile: ["parsexml.js?" + new Date().getTime(), "parsecss.js?" + new Date().getTime(), "tokenizejavascript.js?" + new Date().getTime(), "parsejavascript.js?" + new Date().getTime(), "parsehtmlmixed.js?" + new Date().getTime()],
              //              stylesheet: "/admin/Ajax/CodeMirror/contrib/csharp/css/csharpcolors.css",
              stylesheet: ["/admin/Ajax/CodeMirror/css/xmlcolors.css"
                    , "/admin/Ajax/CodeMirror/css/jscolors.css", "/admin/Ajax/CodeMirror/css/csscolors.css"],
              path: "/admin/Ajax/CodeMirror/js/",
              height: "500px",
              width: "620px",
              indentUnit: 4,
              lineNumbers: "true",
              onCursorActivity: function (x) {
                  window.onCursorActivityText = x;
              }
          });
         
    </script>
    <div id="main">
<div id="dialog_content">
</div>
</div>
<!-- JS遮罩层 -->
<div id="fullbg"></div>
<!-- end JS遮罩层 -->
<!-- 对话框 -->
<div id="dialog">
<div style="text-align: center;"><img src='../../Images/SaveLoding.gif' /><br /><b>正在保存中，请稍后...</b></div>
</div>
<!-- JS遮罩层上方的对话框 -->
</body>

</html>