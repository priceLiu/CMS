<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArticlesEdit.aspx.cs" MasterPageFile="~/User/DefaultMaster/content.Master"
    Inherits="We7.CMS.Web.User.Articles.ArticlesEdit" %>

<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<%@ Register Assembly="FCKeditor.net" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyHeadPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" href="/ModelUI/skin/default.css" media="screen" />
    <script src="/Admin/Ajax/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/Admin/Ajax/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="/Admin/cgi-bin/Article.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <form id="mainForm" runat="server">
    <div class="realRight ml10">
        <div class="mybox">
            <h2 class="mytit">
                文章编辑
            </h2>
            <div id="mycontent">
                <WEC:MessagePanel ID="Messages" runat="server">
                </WEC:MessagePanel>
                <dl>
                    <input class="Btn" id="SaveButton" runat="server" visible="false" type="submit" value="保存文章信息"
                        onserverclick="SaveButton_ServerClick">
                    <dd>
                        <div id="channelList" runat="server" class="channelList">
                            <img src="/admin/images/bulb.gif" align="absmiddle" alt="请选择一个栏目进行发布文章！" title="请选择一个栏目进行发布文章！" />
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
                            <br/>
                            <input type="hidden" id="titleTextBoxId" value="<%=TitleTextBox.ClientID %>" />
                            <label>
                                文章标题
                            </label>
                            <input class="TitleText" id="TitleTextBox" runat="server" size="30" title="文章的主标题，请仔细填写，不可以为空。"
                                onchange="contentEdited(true);" />
                            <br/> <br/>
                        </div>
                        <div runat="server" id="BodyDiv">
                            <input type="hidden" id="editorid" name="editorid" value="<%=ContentTextBox.ClientID %>" />
                            <FCKeditorV2:FCKeditor ToolbarSet="Basic" ID="ContentTextBox" EnableSourceXHTML="true"
                                EnableXHTML="true" FontSizes="smaller;larger;xx-small;x-small;small;medium;large;x-large;xx-large"
                                HtmlEncodeOutput="false" runat="server" Height="300px" Width="545px" BasePath="/admin/fckeditor/">
                            </FCKeditorV2:FCKeditor>
                            <div class="editorFooter inputWidth">
                            </div>
                        </div>
                        <br />
                        <div class="widget collapsable  inputWidth" id="widget-myprocess" style="margin-left: 0px">
                            <div class="widget-header">
                                <strong>高级选项</strong>
                            </div>
                            <div class="widget-content">
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
                                                文章类型
                                            </td>
                                            <td class="formValue">
                                                <script type="text/javascript">
                                                    var pageClientID = '<%=linkSpan.ClientID.Replace("_linkSpan","") %>';
                                                </script>
                                                <asp:DropDownList ID="ActicleTypeDropDownList" runat="server" onchange="ActicleTypeDropDownList_onchange(this,pageClientID);">
                                                    <asp:ListItem Value="">请选择文章类型</asp:ListItem>
                                                    <asp:ListItem Value="0" Selected="True">原创文章</asp:ListItem>
                                                    <asp:ListItem Value="8">引用文章</asp:ListItem>
                                                    <asp:ListItem Value="10">共享文章</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="formTitle">
                                                摘要
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
                                                <input id="UpdatedTextBox" runat="server" class="txt" style="width: 250px" onchange="contentEdited(true);"
                                                    onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
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
                                            <td>
                                            </td>
                                            <td style="padding-top: 15px; padding-left: 0px">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <input id="SaveButton2" class="Btn" runat="server" type="submit" value="保存文章信息" onclick="return OnSaveArticle()"
                            onserverclick="SaveButton_ServerClick" />
                        <br />
                    </dd>
                </dl>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var nEditor = new ubbEditor('<%=ContentTextBox.ClientID %>');
        nEditor.tLang = 'zh-cn';
        nEditor.tInit('nEditor', '/Scripts/ubbeditor/');
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
    </script>
    </form>
</asp:Content>
