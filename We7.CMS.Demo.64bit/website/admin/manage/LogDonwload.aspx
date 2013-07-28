<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogDonwload.aspx.cs" MasterPageFile="~/admin/theme/classic/content.Master"
    Inherits="We7.CMS.Web.Admin.LogDonwload" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls"
    TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">

    <script type="text/javascript">
        function copyCode(obj) {
            var rng = document.body.createTextRange();
            rng.moveToElementText(obj);
            rng.scrollIntoView();
            rng.select();
            rng.execCommand("Copy");
            rng.collapse(false);
            alert("�����Ȱ����Ĵ����ѱ����Ƶ�������");
        }

        function saveCode(obj) {
            var winname = window.open('', '_blank', 'top=1000');
            winname.document.open('html', 'replace');
            winname.document.writeln(obj.value);
            winname.document.execCommand('saveas', 'true', 'logs.html');
            winname.close();
        }  
    </script>

    <h2 class="title">
        <asp:Image ID="LogImage" runat="server" ImageUrl="~/admin/Images/logo_task.gif" />
        <asp:Label ID="LogNameLabel" runat="server" Text="������־">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="RoleSummaryLabel" runat="server" Text="">
            </asp:Label>
        </span>
    </h2>
    <div class="toolbar">
        <asp:HyperLink ID="RefreshHyperLink" NavigateUrl="Logs.aspx" runat="server">
            <asp:Image ID="RefreshImage" runat="server" ImageUrl="~/admin/Images/icon_refresh.gif" />
            ˢ��</asp:HyperLink>
        <span>|</span>
        <asp:HyperLink ID="ReturnHyperLink" runat="server" NavigateUrl="Logs.aspx">
            <asp:Image ID="ReturnImage" runat="server" ImageUrl="~/admin/Images/icon_prev.gif" />
            ����</asp:HyperLink>
    </div>
    <h3>
        <span>��־��ϸ��Ϣ</span>
    </h3>
    <button onclick="saveCode(LogsTextBox)">
        ����ΪHTML</button>
    <button onclick="copyCode(LogsTextBox)">
        ���Ƶ�������</button>
    <p>
        <asp:TextBox ID="LogsTextBox" runat="server" Height="374px" TextMode="MultiLine"
            Width="585px"></asp:TextBox></p>
</asp:Content>
