<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Article_option.ascx.cs"
    Inherits="We7.CMS.Web.Admin.controls.Article_option" %>
<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<%@ Register Assembly="FCKeditor.net" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<link rel="stylesheet" type="text/css" media="screen" href="/admin/theme/Style/jquery.easywidgets.css" />
<link rel="stylesheet" type="text/css" media="screen" href="/admin/theme/Style/mywidgets.css" />

<script src="/admin/Ajax/jquery/jquery-ui.min.js" type="text/javascript"></script>

<script src="/admin/cgi-bin/Menu/jquery.easywidgets.js" type="text/javascript"></script>

<script src="/admin/cgi-bin/Menu/mywidgets.js" type="text/javascript"></script>

<script src="/Admin/Ajax/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script src="/Admin/cgi-bin/Article.js" type="text/javascript"></script>

<WEC:MessagePanel ID="Messages" runat="server"></WEC:MessagePanel>
<div id="conbox">
    <dl>
        <dt>»文章/稿件的基本信息<br>
            <input class="Btn" id="SaveButton" runat="server" visible="false" type="submit" value="保存文章信息"
                onserverclick="SaveButton_ServerClick">
            <dd>
                <div id="channelList" runat="server" class="channelList">
                    <img src="/admin/images/bulb.gif" align="absmiddle" />
                    <asp:DropDownList ID="ChannelDropDownList" runat="server" onchange="contentEdited(true);">
                    </asp:DropDownList>
                    <label class="block_info">
                        &larr; 要发布到哪个栏目？</label>
                </div>
                <div id="ParentArticleDiv" runat="server" class="channelList" visible="false">
                    <p>
                        父级文章：<asp:Label ID="ParentArticleTitle" runat="server"></asp:Label>
                        <input type="hidden" id="ParentArticleID" runat="server" />
                    </p>
                </div>
                <div id="titlediv">
                    <input type="hidden" id="titleTextBoxId" value="<%=TitleTextBox.ClientID %>" />
                    <input class="TitleText" id="TitleTextBox" runat="server" size="30" title="文章的主标题，请仔细填写，不可以为空。"
                           onchange="contentEdited(true);"/>
                </div>  
                <div runat="server" id="BodyDiv">
                    <input type="hidden" id="editorid" name="editorid" value="<%=ContentTextBox.ClientID %>" />
                    <FCKeditorV2:FCKeditor ID="ContentTextBox" EnableSourceXHTML="true" EnableXHTML="true"
                     FontSizes="smaller;larger;xx-small;x-small;small;medium;large;x-large;xx-large"    HtmlEncodeOutput="false" runat="server" Height="300px" Width="545px" BasePath="/admin/fckeditor/">
                    </FCKeditorV2:FCKeditor>
                    <div class="editorFooter inputWidth">
                    </div>
                </div>
                <%
                    if (System.IO.File.Exists(Server.MapPath("/Plugins/ErrorCorrection/Plugin.xml")))
                    {
                     %>
                   <input id="btnErrorCorrection" class="Btn" runat="server" type="submit" value="纠错" onserverclick="btnErrorCorrection_ServerClick" />                    
                    <% }
                     %>                
                <br />
                <br />
                <div class="widget collapsable  inputWidth" id="widget-myprocess" style="margin-left: 0px">
                    <div class="widget-header">
                        <strong>高级选项</strong>
                    </div>
                    <div class="widget-content" >
                        <div class="inside">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr id="linkSpan" style="display: none" runat="server">
                                    <td class="formTitle">
                                        源文件URL地址
                                    </td>
                                    <td class="formValue">
                                        <input class="txt" id="ContentUrlTextBox" runat="server" style="width: 450px" onchange="contentEdited(true);" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        标题样式
                                    </td>
                                    <td class="formValue" style="vertical-align:bottom;">
                                        <asp:CheckBox ID="chkBold" runat="server" Text="加粗" />&nbsp;&nbsp;<asp:CheckBox ID="chkItalic"
                                            runat="server" Text="斜体" />
                                        &nbsp;
                                        <asp:DropDownList ID="ddlColor" runat="server" Style="height:20px;font-size:12px;padding:0px; margin:0px; text-align: center;vertical-align:middle;color:#666">
                                            <asp:ListItem Text="默认" Value=""></asp:ListItem>
                                            <asp:ListItem Text="红色" Value="#FF0000"></asp:ListItem>
                                            <asp:ListItem Text="橙色" Value="#FF2400"></asp:ListItem>
                                            <asp:ListItem Text="黄色" Value="#FFFF00"></asp:ListItem>
                                            <asp:ListItem Text="绿色" Value="#00FF00"></asp:ListItem>
                                            <asp:ListItem Text="蓝色" Value="#0000FF"></asp:ListItem>
                                            <asp:ListItem Text="靛色" Value="#8A2BE2"></asp:ListItem>
                                            <asp:ListItem Text="紫色" Value="#9932CD"></asp:ListItem>
                                            <asp:ListItem Text="黑色" Value="#000000"></asp:ListItem>
                                            <asp:ListItem Text="白色" Value="#FFFFFF"></asp:ListItem>
                                            <asp:ListItem Text="灰色" Value="#C0C0C0"></asp:ListItem>
                                        </asp:DropDownList>
                                        色
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        文章类型
                                    </td>
                                    <td class="formValue">
                                        <%--<asp:DropDownList ID="ActicleTypeDropDownList" runat="server" onchange="contentEdited(true);">--%>

                                        <script>
                                            var linkSpanID=document.getElementById('<%=this.ClientID %>_linkSpan');
                                        </script>

                                        <asp:DropDownList ID="ActicleTypeDropDownList" runat="server" onchange="ActicleTypeDropDownList_onchange(linkSpanID,this);">
                                            <asp:ListItem Value="">请选择文章类型</asp:ListItem>
                                            <asp:ListItem Value="0" Selected="True">原创文章</asp:ListItem>
                                            <asp:ListItem Value="8">引用文章</asp:ListItem>
                                            <asp:ListItem Value="10">共享文章</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        副标题
                                    </td>
                                    <td class="formValue">
                                        <input class="txt" id="SubTitleTextBox" runat="server" style="width: 450px" onchange="contentEdited(true);" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        页面标题
                                    </td>
                                    <td class="formValue">
                                        <input class="txt" id="PageTitleTextBox" runat="server"  onfocus="this.value='';this.style='width: 450px;';" style="color:#BBB;width: 450px"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        摘要
                                        <br />
                                        <br />
                                    </td>
                                    <td class="formValue">
                                        <textarea id="DescriptionTextBox" runat="server" rows="6" cols="50" style="width: 450px"
                                            onchange="contentEdited(true);"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        文章关键字
                                    </td>
                                    <td>
                                        <input type="hidden" id="keywordinputid" value="<%=KeywordTextBox.ClientID %>" name="keywordinputid" />
                                        <textarea id="KeywordTextBox" runat="server" style="width: 450px; height: 42px;"
                                            name="S1"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        文章描述
                                    </td>
                                    <td>
                                        <textarea id="DescriptionKeyTextBox" runat="server" cols="50" style="width: 450px;
                                            height: 43px;" name="S2"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        作者
                                    </td>
                                    <td class="formValue">
                                        <input runat="server" id="AuthorTextBox" class="txt" style="width: 250px" onchange="contentEdited(true);" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        来源
                                    </td>
                                    <td class="formValue">
                                        <input id="SourceTextBox" runat="server" class="txt" style="width: 250px" onchange="contentEdited(true);" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        排序
                                    </td>
                                    <td class="formValue">
                                        <input id="IndexTextBox" runat="server" class="txt" style="width: 250px" onchange="contentEdited(true);"
                                            value="999" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        修改时间
                                    </td>
                                    <td class="formValue">
                                        <input id="UpdatedTextBox" runat="server" class="txt" style="width: 250px" onchange="contentEdited(true);" onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td class="formTitle">
                                        <asp:Label ID="CreatorLabel" runat="server" Text=""></asp:Label>
                                        创建于
                                        <asp:Label ID="CreatedLabel" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        过期时间：
                                    </td>
                                    <td class="formValue">
                                        <input id="txtInvalidDate" name="" class="txt" onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                            style="width: 250px" runat="server" />&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        选项
                                    </td>
                                    <td class="formValue">
                                        <label for="sex_female">
                                            <span style="display: <%=ButtonVisble%>">
                                                <asp:CheckBox ID="IsShowCheckBox" runat="server" />在首页显示</span>
                                            <asp:CheckBox ID="AllowCommentsCheckBox" runat="server" Checked="True" />允许评论</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle">
                                        状态
                                    </td>
                                    <td class="formValue">
                                        <asp:DropDownList ID="StateDropDownList" runat="Server" onchange="contentEdited(true);">
                                            <asp:ListItem Text="启用" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="禁用" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="审核中" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="过期" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="已删除" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>生成语言</td>
                                    <td>
                                        <asp:CheckBox ID="TTS" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td style="padding-top: 15px; padding-left: 0px">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <input id="SaveButton2" class="Btn" runat="server" type="submit" value="保存文章信息" onserverclick="SaveButton_ServerClick" />
                <br />
    </dl>
    <div style="display: none">
        <input type="button" id="saveAricleButton" onclick="window.saveArticle();" />
    </div>
</div>
<script type="text/javascript">
    window.saveBtnId = '<%=SaveButton2.ClientID %>';
    window.updateArticle = function (article) {
        var fckeditor;
        if (article && article.content) {
            fckeditor = FCKeditorAPI.GetInstance('<%=ContentTextBox.ClientID %>');
            fckeditor.SetData(article.content);
        }
    };
    window.saveArticle = function() {
        var button = document.getElementById(saveBtnId);
        if (button) {
            button.click();
        }
    };
    
    function OnSaveArticle() {
        if (articleOptionCheck('<%=ClientID %>') == false) {
            return false;
        }
        var button = document.getElementById(window.saveBtnId);
        if (button.getAttribute("skipCheck")) {
            // 如果标记了跳过检查，则跳过
            button.removeAttribute("skipCheck");
            return true;
        }
        var fckeditor = FCKeditorAPI.GetInstance('<%=ContentTextBox.ClientID %>');
        var content = fckeditor.GetHTML();
        var event = jQuery.Event("ArticleEditSave");
        $(document).trigger(event, {
            article: { content: content },
            editor: fckeditor
        });
        return !event.isDefaultPrevented();
    }
    
    function CreateTTS(articleID, articleContent) {
        $.ajax({
            async: false,
            type: 'POST',
            dataType: "json",
            url: "/Plugins/TTSPlugin/UI/Handler.ashx",
            data: {
                "Action": "PlayToFile",
                "FilePath": "/_Data/TTS",
                "FileID": articleID,
                "FileContent": articleContent
            }
        });
    }

    window.onload = function() {
        if (QueryString("TTS") == "true") {
            var content = FCKeditorAPI.GetInstance('<%=ContentTextBox.ClientID %>').LinkedField.defaultValue;
            var id = QueryString("id");
            CreateTTS(id.replace("{", "").replace("}", "").replace( /-/gi , "_"), content.replace( /&\w+;/gi , ""));
        }
    };
</script>
