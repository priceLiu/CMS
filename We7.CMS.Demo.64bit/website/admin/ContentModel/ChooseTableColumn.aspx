<%@ Page Language="C#" MasterPageFile="~/Admin/theme/classic/content.Master" AutoEventWireup="true"
    CodeBehind="ChooseTableColumn.aspx.cs" Inherits="We7.CMS.Web.Admin.ContentModel.ChooseTableColumn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <style>
        .tab
        {
            padding: 0 0 5px 10px;
            clear: both;
        }
        .col
        {
            display: none;
        }
        .col li
        {
            width: 160px;
            float: left;
        }
        .rTop
        {
            height: 20px;
            width: auto;
            text-align: left;
            font-size: small;
            line-height: 25px;
            position: fixed;
            right: 10px;
            bottom: 10px;
            border-bottom-color: #333;
            border-right-color: #333;
            margin: 5px;
        }
        .opl
        {
            padding: 2px 0 2px 0;
        }
        
        .searchword
        {
            background-color: yellow;
        }
    </style>
    <script type="text/we7template" id="tmpl">
    <?for (var i=0,len=this.length;i<len;i++){var item=this[i]; ?>
    <div  class="tab">
		<h3><a href="javascript:void(0)" onclick="FadeIn(this)"><?=item.Table?>&nbsp;&nbsp;&nbsp;<?=(item.Desc==""?"无":item.Desc) ?></a> </h3><ul class="col"><?=ColumnRender(item.Table,item.Columns)?></ul><br/>
        <div ></div>
        </div>
	<?}?>
    </script>
    <script type="text/javascript">
    
        var resultCount = 0;
        var timeout;

        $(document).ready(function () {
            $("#searchBar").live("keyup", function () {
                var keyCode=window.event.keyCode;
                if( keyCode==8 ||keyCode==13 ||keyCode==32 || (keyCode>=65 && keyCode<=90 ))
                {
                    timeout && clearTimeout(timeout);
                    timeout = setTimeout(serach, 1000);
                 }
            });
        });
        function StartRender() {
            var json=<%=result.ToString()%>;
            json = json.sort(function (left, right) {
                return left.Table > right.Table ? 1 : (left.Table < right.Table ? -1 : 0);
            });
            we7("#mainContent").render(json, $("#tmpl"), -1);
        }
        function ColumnRender(tab, obj) {
            var temp = [];
            if (obj) {
                $.each(obj, function (i) {
                    temp.push(we7.formatStr('<li><input type="checkbox" value={"tab":"{1}","key":"{0}","val":"{2}"} onclick="Choose(this)" /> {0}</li>', obj[i], tab, "ID"));
                });
            }

            return temp.join("");
        }
        function Choose(obj) {
            obj = $(obj);
            var json = eval('(' + obj.val() + ')');
            var result = '表:<b>{0}</b>,字段：<b>{1}</b> <input type="button" value="确定" onclick=window.parent.SelectTabInfo({3})>';
            if (!obj.attr("checked")) {
                json.tab = "";
                json.key = "";
                json.val = "";
            }
            result = we7.formatStr(result, json.tab.length > 0 ? json.tab : "无", json.key.length > 0 ? json.key : "无", json.val, JSON.stringify(json));
            $("#ui-result").html(result);

        }
        function FadeIn(obj) {
            var c = $(obj).parent().parent().find(".col");
            if (c.css("display") != "none")
                c.fadeOut("slow");
            else
                c.fadeIn("slow");
        }
        function highlightWord(node, word) {

            var temp=[];
            if (node.hasChildNodes) {
                var index;
                for (index = 0; index < node.childNodes.length; index++) {
                    highlightWord(node.childNodes[index], word);
                }
            }
            if (node.nodeType == 3) { // text node
                temp.NodeVal = node.nodeValue.toLowerCase();
                temp.WordVal = word.toLowerCase();
                if (temp.NodeVal.indexOf(temp.WordVal) != -1) {
                    temp.pn = node.parentNode;
                    if (temp.pn.className != "searchword" && temp.pn.nodeName.toLowerCase() == "a") {
                        temp.nv = node.nodeValue;
                        temp.ni = temp.NodeVal.indexOf(temp.WordVal);
                        temp.before = document.createTextNode(temp.nv.substr(0, temp.ni));
                        temp.docWordVal = temp.nv.substr(temp.ni, word.length);
                        temp.after = document.createTextNode(temp.nv.substr(temp.ni + word.length));
                        temp.hiwordtext = document.createTextNode(temp.docWordVal);
                        temp.hiword = document.createElement("span");
                        temp.hiword.className = "searchword";
                        temp.hiword.appendChild(temp.hiwordtext);
                        temp.pn.insertBefore(temp.before, node);
                        temp.pn.insertBefore(temp.hiword, node);
                        temp.pn.insertBefore(temp.after, node);
                        temp.pn.removeChild(node);
                        resultCount++;
                    }
                }
            }
        }
        function InitBeforeHighlight() {
            $(".searchword").each(function () {
                var parentNoe = $(this).parent();
                var t = $(this).parent().text();
                $(this).remove();
                parentNoe.text(t);
                resultCount = 0;
            });
        }
        function serach() {
            InitBeforeHighlight();
            if ($("#searchBar").val().trim() != "") {
                highlightWord($("#mainContent")[0], $("#searchBar").val());
            }
            if( resultCount > 0)
            {
                $("html,body").animate({ scrollTop: $(".searchword:first").offset().top }, "slow");
            }
            $(".serach-result").html(resultCount);
        }

    </script>
    <div class="rTop" id="rTop">
        <div class=" ui-state-default ui-corner-all fm-button-icon-left ui-search">
            <span class="ui-icon ui-icon-search"></span>
            <input type="text" id="searchBar" />
            共<span class="serach-result">0</span>个 <span id="ui-result"></span>
        </div>
    </div>
    <div id="mainContent">
    </div>
    <script type="text/javascript" src="/scripts/we7/we7.loader.js">
    </script>
    <script type="text/javascript" src="/scripts/we7/we7.render.js"> 
    </script>
    <script type="text/javascript">
        StartRender(); </script>
</asp:Content>
