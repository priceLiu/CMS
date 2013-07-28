<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Article_keyword.ascx.cs"
    Inherits="We7.CMS.Web.Admin.controls.Article_keyword" %>
    <%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<div id="keywords" class="TagsList">
    <div id="conbox">
        <dl>
            <dt>»关键字<br />
                <img src="/admin/images/bulb.gif" align="absmiddle" />
                <label class="block_info">
                    关键字用于筛选文章到页面不同位置，及用来建立文章关联。下面的系统关键字与常用关键字点击即可加入为本篇文章的关键字。</label>
                <dd>
                    <ul id="keywordList" >
                        <asp:Literal ID="KeyWordListLitiral" runat="server"></asp:Literal>
                    </ul>
                </dd>
                <dd style="clear: both">
                    <input id="keyWordNameInput" name="keyWordNameInput" maxlength="20">
                    <br />
                    <input class="Btn" id="keyWordAddSubmit" type="button" value="添加" onclick="addWord(keyWordNameInput.value)"
                        hidefocus>
                    <p class="Hint">
                        关键字必须是标准的中文或英文单词，且文字与字母间不允许有其他字符或空格。</p>
                </dd>
                <dd>
                    <h1>
                        本站常用关键字 <span rel="xml-hint" title="常用关键字：取出本站使用频率最高的关键字"></span>
                    </h1>
                    <div class="usefulkeyWords">
                        <input type="hidden" id="pi" value="2" />
                        <asp:Literal ID="CommonKeyWordsLiteral" runat="server"></asp:Literal>
                        <img src="/admin/images/icon_down.gif" onclick="GetKeyWords()" class="tipit" title="点击获取更多关键字"
                            style="cursor: pointer; padding-left: 10px;" />
                    </div>
                </dd>
            </dt>
        </dl>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(".Del").each(function (i) {
            $(this).bind("click", function (event) {
                removeKeyWord($(this).attr("title"), event);
            });
        });
    });
    function addWord(word) {
//        if (!/^[A-z\u4e00-\u9fa5]+$/gi.test(word)) {
//            $("#keyWordNameInput").select();
//            we7.info("请输入中文或英文!");
//            return;
//        }
        word = $.trim(word);
        if (word.length > 0) {
            we7.loading("操作中..");
            $.ajax({
                type: "get",
                url: "/admin/ajax/KeyWordAjax.aspx?op=add&id=" + $("#IDHidden").val()  + "&name=" + encodeURIComponent(word),
                datatype: "json ",
                success: function (json) {
                    json = eval('(' + json + ')');
                    if (json.success) {
                        if (word.length > 10)
                            word = word.substring(0, 10) + "..";
                        $('#keywordList').append(FormatKeyWord(word));
                        $("#keyWordNameInput").val('');
                        $("#keyWordNameInput").focus();
                        we7.info("操作成功!");
                    }
                    else {
                        we7.info("添加失败 " + word + ",错误消息：" + json.msg, { autoHide: true, hideTimeout: 6000 });
                    }
                },
                failure: function (msg, resp, status) {
                    alert(msg);
                    alert(resp);
                    alert(status);
                }
            });
        } else {
            $("#keyWordNameInput").focus();
        } 
    }
    function removeKeyWord(word, event) {
        word = $.trim(word);
        if (word.length > 0) {
            we7.loading("操作中..");
            $.ajax({
                type: "get",
                url: "/admin/ajax/KeyWordAjax.aspx",
                data: "op=del&id=" + $("#IDHidden").val()  + "&name=" + encodeURIComponent(word),
                datatype: "json ",
                success: function (json) {
                    json = eval('(' + json + ')');
                    if (json.success) {
                        $(event.target).parent().remove();
                        we7.status("操作成功!");
                    }
                    else
                        we7.status("删除失败 " + word + ",错误消息：" + json.msg, { autoHide: true, hideTimeout: 6000 });
                }
            });
        } 
    }
    function GetKeyWords() {
        var loading = $("<br/> <img src='/admin/images/blue-loading.gif' />");
        $(".usefulkeyWords").append(loading);
        $.ajax({
            type: "get",
            url: "/admin/ajax/KeyWordAjax.aspx",
            data: "op=list&pi=" + $("#pi").val(),
            datatype: "json ",
            success: function (json) {
                loading.remove();
                if (we7.isStr(json) && json) {
                    json = eval('(' + json + ')');
                    if (json.success) {
                        if (we7.isObj(json.Data) && json.Data) {
                            $(".usefulkeyWords").append("<br/><br/>");
                            $.each(json.Data, function (i) {
                                $(".usefulkeyWords").append(we7.formatStr("<a href=\"javascript:addWord('{0}')\" title=\"为文章添加关键字 {0}？\" >{0}</a> ", json.Data[i].Identifier));
                            });
                            $("#pi").val((parseInt($("#pi").val()) + 1));
                        }
                    }
                    else {
                        we7.status("加载失败,错误消息：" + json.msg, { autoHide: true, hideTimeout: 6000 });
                    }
                }
                else
                    we7.status("请求无响应，或者异常，请查看错误日志");
            }
        }); 
    }
    function FormatKeyWord(word) {
        var a = $("<A class=a_del title=\"" + word + "\" href=\"javascript:void(0);\" >[x]</A>");
        a.bind("click", function (event) {
            removeKeyWord(word, event);
        });
        return $("<LI><IMG class=Icon height=16 src=\"/admin/images/icon_globe.gif\" width=16>" + word + " </LI>").append(a);
    } 
</script>
<asp:Literal ID="ArticleIDHidden" runat="server"></asp:Literal>

