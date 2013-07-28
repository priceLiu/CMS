<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="wid_article.ascx.cs" Inherits="We7.CMS.Web.Admin.tools.widget.wid_article" %>
<%@ Import Namespace="We7.Framework.Util" %>
<script type="text/C#" runat="server">
    private int titleLength = 30;
    /// <summary>
    /// 标题长度
    /// </summary>
    public int TitleLength
    {
        get { return titleLength; }
        set { titleLength = value; }
    }    
  //<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# GetUrl(Eval("ID").ToString())%>' Target="_parent" Text='<%# Eval("Title", "{0}") %>'></asp:HyperLink>
</script>
   <div class="widget movable collapsable removable  closeconfirm" id="widget-myarticle">
    <div class="widget-header">
     <strong><%=Channel.Name%></strong>
    </div>
    <div class="widget-content">
       <div class="inside">      
           <asp:GridView ID="DataGridView" runat="server" AutoGenerateColumns="False" >
           <Columns>
            <asp:TemplateField>
                    <HeaderTemplate>
                    <span style="text-decoration:underline">标题</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                      <a href='<%# String.Format("{0}{1}", Eval("ChannelFullUrl").ToString(), Eval("FullUrl").ToString()) %>' target='_parent'> <%# Utils.GetUnicodeSubString(Eval("Title").ToString(), TitleLength, "")%> </a>     
                    </ItemTemplate>
                    </asp:TemplateField>
                     <asp:BoundField DataField="Created" DataFormatString="{0:yyyy-MM-dd}" HeaderText="创建时间" /></Columns>
           </asp:GridView>
       <p class="textright"><a href="/admin/AddIns/ArticlesMy.aspx"  >
                查看全部</a></p>
    </div>
   </div>
  </div>                          