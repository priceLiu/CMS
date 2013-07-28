<%@ Page Language="C#" MasterPageFile="~/admin/theme/ContentNoMenu.Master"
    AutoEventWireup="true" CodeBehind="ScanProcessHistory.aspx.cs" Inherits="We7.CMS.Web.Admin.ScanProcessHistory"
    Title="��ת��ʷ" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<%@ Register Src="controls/ProcessHistoryList.ascx" TagName="ProcessHistoryList"
    TagPrefix="uc1" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
<style>
    body
    {
        padding: 10px;
        margin: 10px;
        width: 90%;
    }
    </style>
    <div id="breadcrumb">
        <h2>
            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/logo_info.gif" />
            <asp:Label ID="TitleLabel" runat="server" Text="������">
            </asp:Label>
            <span class="summary">
                <asp:Label ID="SummaryLabel" runat="server" Text="��ת���̱�">
                </asp:Label>
            </span>
        </h2>
        <div class="toolbar" style="float: right; text-align: right">
            <li class="smallButton4"><a href="javascript:window.close()">�رմ���</a> </li>
            <li class="smallButton4">
                <asp:HyperLink ID="SubmitHyperLink" NavigateUrl="javascript:onPreviewClick();" runat="server">
                ��ӡԤ��
                </asp:HyperLink>
            </li>
        </div>
        <hr />
        <div>
            <uc1:ProcessHistoryList ID="ProcessHistoryList1" runat="server" />
        </div>
    </div>
    <script type="text/javascript" language="javascript">
        function onPreviewClick() {
            window.print();
        }
    </script>
</asp:Content>
