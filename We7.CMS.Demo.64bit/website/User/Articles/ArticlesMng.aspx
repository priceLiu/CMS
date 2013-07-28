<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ArticlesMng.aspx.cs" MasterPageFile="~/User/DefaultMaster/content.Master" Inherits="We7.CMS.Web.User.Articles.ArticlesMng"  %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyHeadPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" href="/ModelUI/skin/default.css" media="screen" />
    <script src="/Admin/Ajax/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/Admin/Ajax/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/admin/cgi-bin/search.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <form id="mainForm" runat="server">
       <div class="realRight ml10">
           <div class="mybox">
              <h2 class="mytit">
                  文章管理
              </h2>
              <div id="mycontent">
                  <WEC:MessagePanel ID="Messages" runat="server">
                  </WEC:MessagePanel>
                  <div style="display: table; width: 100%">
                     <ul class="subsubsub">
                        <asp:Literal ID="StateLiteral" runat="server"></asp:Literal>
                        <asp:Literal ID="IncludeSubLiteral" runat="server"></asp:Literal>
                     </ul>
                     <p class="search-box" runat="server" id="searchBox">
                        <asp:Literal ID="SearchSimpleLiteral" runat="server"></asp:Literal>
                     </p>
                  </div>
                  <asp:GridView ID="DataGridView" runat="server" AutoGenerateColumns="false" CssClass="List" GridLines="Horizontal" RowStyle-VerticalAlign="Top">
                     <AlternatingRowStyle CssClass="alter" />
                     <Columns>
                         <asp:TemplateField>
                             <HeaderStyle Width="5px" HorizontalAlign="Right" />
                             <HeaderTemplate>
                                 <asp:CheckBox ID="chkHeader" runat="server" onclick="javascript:SelectAll(this);" AutoPostBack="false" />
                             </HeaderTemplate>
                             <ItemTemplate>
                                 <asp:CheckBox ID="chkItem" runat="server" />
                                 <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' Visible="False"></asp:Label>
                             </ItemTemplate>
                             <ItemStyle VerticalAlign="Top" Width="5px" HorizontalAlign="Right" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                             <HeaderTemplate>
                                 <asp:HyperLink ID="OrderByTitleHyperLink" NavigateUrl="javascript:orderByTitle();" runat="server"><span style="text-decoration:underline">标题</span></asp:HyperLink>
                             </HeaderTemplate>
                             <ItemTemplate>
                                 <%# GetUrl(Eval("ID").ToString(),Convert.ToInt32(Eval("State")),Eval("Title").ToString())%>
                                 <%# GetIcons(Eval("IsImage").ToString(), Eval("IsLinkArticle").ToString(), Eval("IsShow").ToString())%>
                                 <%# GetActionsLink(Eval("ID").ToString(), Convert.ToInt32(Eval("State")), Eval("LinkUrl").ToString())%>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="作者">
                             <ItemTemplate>
                                 <span title="<%# Eval("Author")%>" style="cursor: pointer">
                                     <%# We7.Framework.Util.Utils.GetUnicodeSubString(Eval("Author").ToString(), 10,"") %></span>
                             </ItemTemplate>
                             <ItemStyle Width="60px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="标签">
                             <ItemTemplate>
                                 <%# Eval("Tags", "{0}")%>
                             </ItemTemplate>
                             <ItemStyle Width="50px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="点击数">
                             <ItemTemplate>
                                 <%# Eval("Clicks", "{0}")%>
                             </ItemTemplate>
                             <ItemStyle Width="50px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="所属栏目">
                             <ItemTemplate>
                                 <a href="ArticlesMng.aspx?oid=<%# Eval("OwnerID", "{0}")%>&type=<%# Eval("ContentType", "{0}")%>" title="<%# Eval("FullChannelPath", "{0}")%>">
                                     <%# Eval("ChannelName", "{0}")%>
                                 </a>
                             </ItemTemplate>
                             <ItemStyle Width="90px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                             <HeaderTemplate>
                                 <asp:HyperLink ID="OrderByDateHyperLink" NavigateUrl="javascript:orderByDate();" runat="server"><span style="text-decoration:underline">修改日期</span></asp:HyperLink>
                             </HeaderTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label1" runat="server" Text='<%# Bind("TimeNote", "{0}") %>' ToolTip='<%# Bind("Updated", "{0}") %>'></asp:Label>
                             </ItemTemplate>
                             <ItemStyle Width="80px" Font-Size="11px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="状态">
                             <ItemTemplate>
                                 <%# Eval("AuditText", "{0}") %>
                             </ItemTemplate>
                             <ItemStyle Width="50px" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="审核">
                             <ItemTemplate>
                                 <a href="javascript:ProcessRemark('<%#Eval("ID")%>');" onclick="return true">
                                     <%# GetProcessState(Eval("ID").ToString())%>
                                 </a>
                             </ItemTemplate>
                             <ItemStyle Width="80px" />
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
                 <div class="pagination">
                    <ul class="subsubsub">
                        <asp:Literal ID="PageLiteral" runat="server"></asp:Literal>
                     </ul>
                    <WEC:URLPager ID="ArticleUPager" runat="server" UseSpacer="False" UseFirstLast="true" PageSize="15" FirstText="<< 首页" LastText="尾页 >>" LinkFormatActive='<span class=Current>{1}</span>' CssClass="Pager" />
                 </div>
              </div>
           </div>
       </div>
       <script type="text/javascript">
           $(document).ready(function () {
               $(".ArticleTree").colorbox({ width: "70%", height: "80%", iframe: true });
           });
       </script>
    </form>
</asp:Content>