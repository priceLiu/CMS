<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExModelListForObsolete.aspx.cs" MasterPageFile="~/Admin/theme/classic/content.Master"
    Inherits="We7.CMS.Web.Admin.Addins.ExModelList" %>

<%@ Register Src="~/ModelUI/Panel/system/ExListPanel.ascx" TagName="ExListPanel" TagPrefix="uc1" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">

    <script type="text/javascript" src="/Admin/Ajax/My97DatePicker/WdatePicker.js"></script>

    <link rel="stylesheet" type="text/css" href="<%=AppPath %>/theme/Style/article.css" media="screen" />
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
        <uc1:ExListPanel ID="ucList" runat="server" />
    </div>
</asp:Content>
