<%@ Page Language="C#" MasterPageFile="~/admin/theme/classic/content.Master" AutoEventWireup="true"
    Codebehind="MenuUpdate.aspx.cs" Inherits="We7.CMS.Web.Admin.MenuUpdate" Title="Untitled Page" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls"
    TagPrefix="WEC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">

    <script type="text/javascript">
  function SubmitClick()
   {
        var submitBtn=document.getElementById("<%=SaveButton.ClientID %>");
        submitBtn.click();
   }
   function CheckNumber() {
       var obj = document.getElementById("<%=SaveButton.ClientID %>");
       if (obj.value.replace(/[\d+]/ig, "").length > 0) {
       alert('����������');
       }
   }
    </script>

      <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icon_settings.png" />
        <asp:Label ID="NameLabel" runat="server" Text="�˵��༭"></asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="�Բ˵����޸�">
            </asp:Label>
        </span>
    </h2>
    <div class="toolbar">
        <asp:HyperLink ID="SubmitHyperLink" NavigateUrl="javascript:SubmitClick();" runat="server">
            �����޸�
        </asp:HyperLink>
    </div>
    <WEC:MessagePanel runat="Server" ID="Messages">
    </WEC:MessagePanel>
    <div>
        <table style="border: solid 0px #fff;">
            <tr>
                <td align="right">
                    �˵����ƣ�</td>
                <td>
                    <asp:TextBox ID="TitleTextBox" runat="server" Columns="60"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    �˵�������</td>
                <td>
                    <asp:TextBox ID="DesTextBox" runat="server" Columns="60"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DesTextBox"
                        ErrorMessage="����Ϊ��"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    �˵�����ţ�</td>
                <td>
                    <asp:TextBox ID="IndexTextBox" runat="server" Columns="60"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="IndexTextBox"
                        ErrorMessage="����Ϊ��"></asp:RequiredFieldValidator>&nbsp;
                </td>
            </tr>
            <tr>
                <td align="right">
                    �˵�Url��</td>
                <td>
                    <asp:TextBox ID="UrlTextBox" runat="server"  Columns="60"></asp:TextBox>
                </td>
            </tr>
             <tr style="display: <%=TwoButtonSelect%>">
                <td align="right">
                    �˵�ͼ�꣺</td>
                <td>
                    <asp:FileUpload ID="IconFileUpload" runat="server" />
                </td>
            </tr>
            <tr  style="display: <%=OneButtonSelect%>">
                <td align="right">
                    ���˵�����ţ�</td>
                <td>
                 <asp:TextBox ID="GroupTextBox" runat="server"  Columns="60" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    �˵�����ʱ�䣺</td>
                <td>
                    <asp:Label ID="CreateDateLabel" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            </table>
    </div>
    <div style="display: none">
        <asp:Button ID="SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click" />
           <asp:TextBox ID="ImgUrlText" runat="server"></asp:TextBox>
    </div>
</asp:Content>
