<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelList.aspx.cs" MasterPageFile="~/Admin/theme/classic/content.Master"
    Inherits="We7.CMS.Web.Admin.Addins.ModelListing" %>
<%@ Register Src="~/ModelUI/Panel/system/ListUIPanel.ascx" TagName="ListUIPanel" TagPrefix="uc2" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <script type="text/C#">
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Response.Redirect(Request.RawUrl.ToLower().Replace("modellist.aspx", "modellistforobsolete.aspx"));
        }
    </script>
    <script type="text/javascript" src="/Admin/Ajax/My97DatePicker/WdatePicker.js"></script>

    <link rel="stylesheet" type="text/css" href="/admin/theme/Style/article.css" media="screen" />
    <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="../Images/icons_article.gif" />
        <asp:Label ID="NameLabel" runat="server">
        </asp:Label>
        <span class="summary"><span id="navChannelSpan"></span>
            <asp:Label ID="SummaryLabel" runat="server" Text=" ">
            </asp:Label>
        </span>
    </h2>
    <div id="position">
        <asp:Literal ID="PagePathLiteral" runat="server"></asp:Literal>
    </div>
    <div id="mycontent">
        <uc2:ListUIPanel ID="ucList" runat="server" />
		<asp:HiddenField ID="UseObsoleteList" Value="true"
			runat="server" /><%--将此值改为true则会调用旧有列表模式--%>
    </div>
</asp:Content>
