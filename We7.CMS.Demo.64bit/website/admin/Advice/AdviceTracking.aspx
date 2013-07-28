<%@ Page Language="C#" MasterPageFile="~/admin/theme/classic/content.Master" AutoEventWireup="true"
    CodeBehind="AdviceTracking.aspx.cs" Inherits="We7.CMS.Web.Admin.AdviceTracking"
    Title="Untitled Page" %>

<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <script type="text/javascript" language="javascript" src="/Scripts/we7/we7.loader.js">
    we7("#<%=StartTimeText.ClientID %>").pickDate();
    we7("#<%=EndTimeText.ClientID %>").pickDate();
    </script>

    <script type="text/javascript">
        function deleteCompanyInfo() {
            if (confirm('��ȷ��Ҫ������Ϣɾ���𣿴˲������ɻָ�����ȷ�ϣ�')) {
                var DeleteBtn = document.getElementById("<%=DeleteBtn.ClientID %>");
                DeleteBtn.click();
            }
        }
    </script>

    <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/logo_admin.gif" />
        <asp:Label ID="NameLabel" runat="server" Text="ϵͳ������־"></asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="">ϵͳ������־����ϸ��Ϣ���ڴ˿ɽ���ɾ������ѯ��
            </asp:Label>
        </span>
    </h2>
    <div class="toolbar">
        <asp:HyperLink ID="DeleteHyperLink" NavigateUrl="javascript:deleteCompanyInfo();"
            runat="server">
            <asp:Image ID="DeleteImage" runat="server" ImageUrl="~/admin/Images/icon_refresh.gif" />
            ɾ��</asp:HyperLink>
    </div>
    <div>
        ��������:
        <asp:TextBox ID="TypeTextBox" runat="server"></asp:TextBox>
        ������:
        <asp:TextBox ID="ProcessTextBox" runat="server"></asp:TextBox>
        ����ʱ�䣺��<input id="StartTimeText" value="����ѡ������" runat="server" type="text" 
            readonly="readOnly" style="width: 170px" />
        ��<input id="EndTimeText" runat="server" type="text" value="����ѡ������"
            readonly="readOnly" style="width: 170px" />
            <asp:Button ID="SeleteButton" runat="server" Text="��ѯ" OnClick="SeleteButton_Click" />
    </div>
    <WEC:MessagePanel runat="Server" ID="Messages">
    </WEC:MessagePanel>
    <table id="personalForm" cellpadding="0" cellspacing="0">
        <asp:GridView ID="DataGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True"
            CssClass="List">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkHeader" runat="server" OnClick="javascript:SelectAll(this);"
                            AutoPostBack="false" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkItem" runat="server" />
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("AccountID") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="30px" />
                    <ItemStyle Width="30px" />
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="ID" HeaderText="��������" DataNavigateUrlFormatString=""
                    DataTextField="ProcessDirection" DataTextFormatString="{0}" Target="_blank" />
                <asp:BoundField HeaderText="����ʱ��" DataField="UpdateDate"></asp:BoundField>
                <asp:TemplateField HeaderText="������">
                    <ItemTemplate>
                        <%# GetProcessNameByAccountID(Eval("ProcessAccountID").ToString())%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="��������">
                    <ItemTemplate>
                        <%# GetTypeByID(Eval("ID").ToString())%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="����IP">
                    <ItemTemplate>
                       <%# GetUserIPByAccountID(Eval("AccountID").ToString())%>
                    </ItemTemplate>
                    <ItemStyle Width="80px" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </table>
    <div class="pagination">
        <p>
            <WEC:Pager ID="CompanyPager" PageSize="15" PageIndex="0" runat="server" OnFired="Pager_Fired" />
        </p>
    </div>
    <div style="display: none">
      <asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click" />
<%--          <asp:Button ID="StopToCommendBtn" runat="server" Text="OutPut" OnClick="StopToCommendBtn_Click" />
--%>        <asp:TextBox ID="ItemTextBox" runat="server"></asp:TextBox>
    </div>
</asp:Content>
