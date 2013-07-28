<%@ Page Language="C#" AutoEventWireup="true" Codebehind="ChannelList.aspx.cs" Inherits="We7.CMS.Web.Admin.ChannelList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>ѡ��һ����Ŀ</title>
   <base target="_self" />
   <link rel="stylesheet" type="text/css" href="<%=AppPath%>/theme/Style/main.css" media="screen" />
    <script src="<%=AppPath%>/cgi-bin/DialogHelper.js" type="text/javascript"></script>
    <script src="<%=AppPath%>/cgi-bin/search.js"  type="text/javascript"></script> 
    <script type="text/javascript">
function onSelectHyperLinkClick(id,fullpath) {
    var v = id;
    var t = fullpath;
    weCloseDialog(v, t);
}

function onCancelHyperLinkClick() {
    weCloseDialog(null, null);
}

    </script>

</head>
<body id="classic"  style="padding-left:10px;padding-right:10px" >
    <form id="mainForm" runat="server">
                        <h2>
                            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/logo_template.gif" />
                            <asp:Label ID="NameLabel" runat="server" Text="ѡ��һ����Ŀ">
                            </asp:Label>
                            <span class="summary">
                                <asp:Label ID="SummaryLabel" runat="server" Text="">
                                </asp:Label>
                            </span>
                        </h2>
                        <div class="toolbar">
                      <li class="smallButton4">
                            <asp:HyperLink ID="CancelHyperLink" runat="server" NavigateUrl="javascript:onCancelHyperLinkClick();">
                                ȡ��</asp:HyperLink></li>
                   <li  class="smallButton4">
                            <asp:HyperLink ID="RefreshHyperLink" runat="server"  NavigateUrl="javascript:window.location.Reload();" >
                                ˢ��</asp:HyperLink></li>
                      <li  class="smallButton4">
                            <a href="javascript:onSelectHyperLinkClick('{00000000-0000-0000-0000-000000000000}','');" >
                               ���ظ�Ŀ¼</a>
                      </li>           
                        </div>
                        <p class="search-box" runat="server" id="searchBox" >
      <asp:Literal ID="SearchSimpleLiteral" runat="server" ></asp:Literal>       
    </p>
                        <br />
                        <div id="messageLayer">
                            <asp:Image ID="MessageImage" runat="server" ImageUrl="~/admin/Images/icon_info.gif" />
                            <asp:Label ID="MessageLabel" runat="server" Text="">
                            </asp:Label>
                        </div>
                        <br />
                        <%--<div id="tree-div" style="overflow:visible; height:400px;width:170px;border:0px solid #fff; "></div>--%>
                        <div style="display:table;min-height:35px;width:100%">
                            <asp:GridView ID="DetailGridView" runat="server" AutoGenerateColumns="False" 
                                GridLines="Horizontal" CssClass="List" >
                                <Columns>
                                    <asp:TemplateField HeaderText="����">
                                        <ItemTemplate>
                                            <a href="javascript:onSelectHyperLinkClick('<%# Eval("ID", "{0}") %>','<%# Eval("ChannelName", "{0}") %>');" title="���ѡ��" >
                                            <%# Eval("FullPath", "{0}") %></a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Description" DataFormatString="{0}" HeaderText="����" />
                                    <asp:BoundField DataField="StateText" DataFormatString="{0}" HeaderText="״̬" />
                                    <asp:BoundField DataField="Created" DataFormatString="{0}" HeaderText="����ʱ��" />
                                </Columns>
                            </asp:GridView>
                        </div>
                        <br />
                  
    </form>
</body>
</html>
