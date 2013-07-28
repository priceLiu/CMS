<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdviceReplyUserList.aspx.cs"
    Inherits="We7.CMS.Web.Admin.AdviceReplyUserList" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ѡ��һ��������</title>
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
    </script>

</head>
<body id="classic" style="padding-left: 10px; padding-right: 10px">
    <form id="mainForm" runat="server">
    <h2>
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/logo_template.gif" />
        <asp:Label ID="NameLabel" runat="server" Text="ѡ��һ��������">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="">
            </asp:Label>
        </span>
    </h2>
    <div class="toolbar">
        <span></span>
    </div>
    <p class="search-box">
        �����������Ʋ��ң�
        <asp:TextBox ID="SearchTextBox" runat="server" Columns="20" MaxLength="64"></asp:TextBox>
        <asp:HyperLink ID="SearchHyperLink" runat="server" NavigateUrl="javascript:SearchUserOnClick();">
            <asp:Image ID="SearchImage1" runat="server" ImageUrl="~/admin/Images/icon_search.gif" />
            ����</asp:HyperLink>
    </p>
    <br />
    <div id="messageLayer">
        <asp:Image ID="MessageImage" runat="server" ImageUrl="~/admin/Images/icon_info.gif" />
        <asp:Label ID="MessageLabel" runat="server" Text="">
        </asp:Label>
    </div>
    <br />
    
    <div style="display: table; min-height: 35px; width: 100%">
        <asp:GridView ID="DetailGridView" runat="server" AutoGenerateColumns="False" GridLines="Horizontal"
            ShowFooter="false" CssClass="List">
            <Columns>
                <asp:ImageField DataImageUrlField="ID" DataImageUrlFormatString="~/admin/Images/icon_folder.gif">
                    <ItemStyle Width="16px" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="����������">
                    <ItemTemplate>
                        <a href="javascript:onSelectHyperLinkClick('<%#Eval("ID")%>');">
                            <%#Eval("LoginName")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="�����˲���">
                    <ItemTemplate>
                        <%# GetDeptNameByID(Eval("DepartmentID").ToString())%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
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
