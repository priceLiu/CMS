<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="We7.CMS.Web.Admin.main" %>

<%@ Register Src="../tools/widget/SiteProfile.ascx" TagName="SiteProfile" TagPrefix="uc1" %>
<%@ Register Src="../tools/widget/wid_myprocess.ascx" TagName="wid_myprocess" TagPrefix="uc2" %>
<%@ Register Src="../tools/widget/wid_Shop.ascx" TagName="wid_Shop" TagPrefix="uc5" %>
<%@ Register Src="../tools/widget/wid_Product.ascx" TagName="wid_Product" TagPrefix="uc6" %>
<%@ Register Src="../tools/widget/wid_guide.ascx" TagName="wid_guide" TagPrefix="uc4" %>
<%@ Register Src="../tools/widget/wid_article.ascx" TagName="wid_article" TagPrefix="uc7" %>
<asp:content id="Content1" contentplaceholderid="MyContentPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" media="screen" href="Style/jquery.easywidgets.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="Style/mywidgets.css" />
    <script src="../Ajax/jquery/jquery-ui.min.js" type="text/javascript"></script>
    <script src="../cgi-bin/Menu/jquery.easywidgets.js" type="text/javascript"></script>
    <script src="../cgi-bin/Menu/mywidgets.js" type="text/javascript"></script>
    <h2 class="title">
        <img id="RoleImage" src="../Images/icons_home.gif" alt="我的工作台" />
        <asp:Label ID="RoleLabel" runat="server" Text="我的工作台">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="">
            </asp:Label>
        </span>
        <div id="buttonShow">
            <a onclick="$.fn.ShowEasyWidgets(); return false" href="#" title="显示所有挂件，包括以前关掉的">显示所有挂件</a>
        </div>
    </h2>
    <div class="widget-place" id="widget-place-1">        
        <uc2:wid_myprocess ID="wid_myprocess1" runat="server" />       
        <uc1:SiteProfile ID="wid_siteprofile1" runat="server" />
         <uc4:wid_guide ID="wid_guide1" runat="server" />     
    </div>
    <div class="widget-place" id="widget-place-2">
        <uc5:wid_Shop ID="wid_Shop1" runat="server" />
        <uc6:wid_Product ID="wid_Product1" runat="server" />        
        
          <uc7:wid_article ID="wid_article2" runat="server" ChannelID="{33a2857b-fa4d-428c-b841-3c4877356c79}" PageSize="10" IncludeChildren="True" />
    </div>
</asp:content>
