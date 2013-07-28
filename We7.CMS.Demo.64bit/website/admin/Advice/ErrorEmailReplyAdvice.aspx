<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="ErrorEmailReplyAdvice.aspx.cs"
    Inherits="We7.CMS.Web.Admin.ErrorEmailReplyAdvice" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls"
    TagPrefix="WEC" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ѡ��һ��������Ϣ</title>
    <base target="_self"></base>
    <link rel="stylesheet" type="text/css" href="<%=AppPath%>/theme/Style/main.css" media="screen" />
    <script src="<%=AppPath%>/cgi-bin/DialogHelper.js" type="text/javascript"></script>

    <script type="text/javascript">
        function SearchUserOnClick() {
            var searchButtonBtn = document.getElementById("<%=SearchButton.ClientID %>");
            searchButtonBtn.click();
        }

        function onSelectHyperLinkClick(id) {
            var v = id;
            weCloseDialog(v);
        }
        function SearchUserOnClick() {
            var searchButtonBtn = document.getElementById("<%=SearchButton.ClientID %>");
            searchButtonBtn.click();
        }
    </script>

</head>
<body id="classic" style="padding-left: 10px; padding-right: 10px">
    <form id="mainForm" runat="server">
    <h2>
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/logo_template.gif" />
        <asp:Label ID="NameLabel" runat="server" Text="ѡ��һ��������Ϣ">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="">
            </asp:Label>
        </span>
    </h2>
    <p class="search-box">
            <asp:DropDownList ID="AdviceTypeDropDownList" runat="server" AutoPostBack="true"
                onselectedindexchanged="AdviceTypeDropDownList_SelectedIndexChanged"></asp:DropDownList>
        ������������ң�
        <asp:TextBox ID="SearchTextBox" runat="server" Columns="20" MaxLength="64"></asp:TextBox>
        <asp:HyperLink ID="SearchHyperLink" runat="server" NavigateUrl="javascript:SearchUserOnClick();">
            <asp:Image ID="SearchImage1" runat="server" ImageUrl="~/admin/Images/icon_search.gif" />
            ����</asp:HyperLink>
    </p>

    <div id="messageLayer">
        <asp:Image ID="MessageImage" runat="server" ImageUrl="~/admin/Images/icon_info.gif" />
        <asp:Label ID="MessageLabel" runat="server" Text="">
        </asp:Label>
    </div>
    <br />
    <div style="display: table; min-height: 35px; width: 100%">
         <asp:GridView ID="AdviceGridView" runat="server" AutoGenerateColumns="False" CssClass="List"
        GridLines="Horizontal">
        <AlternatingRowStyle CssClass="alter" />
        <Columns>
            <asp:TemplateField HeaderText="����">
                <ItemTemplate>
                  <a href="javascript:onSelectHyperLinkClick('<%#Eval("ID")%>');" ><%#Eval("Title")%></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="�ύ����">
                <ItemTemplate>
                    <%# Eval("CreateDate", "{0:yyyy-MM-dd}")%>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="�ύ��">
                <ItemTemplate>
                    <%# Eval("Name", "{0}")%>
                </ItemTemplate>
                <ItemStyle Width="80px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="״̬">
                <ItemTemplate>
                    <%# Eval("StateText", "{0}")%>
                </ItemTemplate>
                <ItemStyle Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="������">
                <ItemTemplate>
                    <%# GetUserName(Eval("ID").ToString())%>
                </ItemTemplate>
                <ItemStyle Width="80px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="����ظ�">
                <ItemTemplate>
                    <%# Eval("MustHandleText", "{0}")%>
                </ItemTemplate>
                <ItemStyle Width="70px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>
    <div class="pagination">
    <p>
        &nbsp;<WEC:URLPager ID="AdviceUPager" runat="server" UseSpacer="False" UseFirstLast="true"
            PageSize="10" FirstText="<< ��ҳ" LastText="βҳ >>" LinkFormatActive='<span class=Current>{1}</span>'
            CssClass="Pager" />
</div>
    <br />
    <div style="display: none">
        <asp:Button ID="SearchButton" runat="server" Text="Search" OnClick="SearchButton_Click" />
        <asp:TextBox ID="IDTextBox" runat="server" Text=""></asp:TextBox>
        <asp:TextBox ID="AliasTextBox" runat="server" Text=""></asp:TextBox>
        <asp:TextBox ID="FullPathTextBox" runat="server" Text=""></asp:TextBox>
    </div>
    </form>
</body>
</html>
