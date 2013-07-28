<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryThreeCascade.ascx.cs"
    Inherits="We7.Model.UI.Controls.system.CategoryThreeCascade" %>

<script type="text/javascript" src="/ModelUI/js/CategoryDoubleCascade.js?20111207001"></script>

<asp:DropDownList ID="Field1DropDownList" runat="server">
</asp:DropDownList>
<asp:DropDownList ID="Field2DropDownList" runat="server">
    <asp:ListItem Value="">请选择</asp:ListItem>
</asp:DropDownList>
<asp:DropDownList ID="Field3DropDownList" runat="server">
    <asp:ListItem Value="">请选择</asp:ListItem>
</asp:DropDownList>
<asp:HiddenField ID="Field3Hidden" runat="server" Value="" />
