<%@ Page Language="C#" AutoEventWireup="true" Codebehind="GetPassword.aspx.cs" Inherits="We7.CMS.Web.Admin.GetPassword" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <h2 class="title">
    <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_tools.gif" />
            <asp:Label ID="NameLabel" runat="server" Text="��ȡ����"></asp:Label>
            <span class="summary">
                <asp:Label ID="SummaryLabel" runat="server" Text="ȡ���û�����"></asp:Label>
            </span>
        </h2>
        <p>
            <span >
                <table style="width: 295px; height: 156px;border-width:0px">
                    <tr>
                        <td style="text-align: right">
                            ע���û���
                        </td>
                        <td style="width: 197px">
                            <asp:TextBox ID="LoginNameTextBox" runat="server" Columns="40" 
                                Width="165px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LoginNameTextBox"
                                ErrorMessage="�������û���">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            �����ַ��
                        </td>
                        <td style="width: 197px">
                            <asp:TextBox ID="MailTextBox" runat="server" Columns="40"
                                Width="165px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="MailTextBox"
                                ErrorMessage="��������ע��ʱ��д�������ַ��">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="MailTextBox"
                                ErrorMessage="�����ַ���Ϸ���" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></td>
                    </tr>
                    <tr>
                        <td style="height: 19px; text-align: right">
                            </td>
                        <td style="width: 197px; height: 19px">
                            </td>
                    </tr>
                    <tr>
                        <td style="height: 19px; text-align: right;">
                            </td>
                        <td style="width: 197px; height: 19px">
                            &nbsp;<asp:Button ID="SendButton" runat="server" OnClick="SendButton_Click" Text="�������뵽����" /></td>
                    </tr>
                    <tr>
                        <td style="height: 42px">
                        </td>
                        <td style="width: 197px; height: 42px">
                            <asp:Label ID="MessageLabel" runat="server" ForeColor="red" Text=""></asp:Label></td>
                    </tr>
                </table>
            </span>
        </p>
        <div>
            &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            &nbsp;&nbsp;<br />
            &nbsp;</div>
</asp:Content>
