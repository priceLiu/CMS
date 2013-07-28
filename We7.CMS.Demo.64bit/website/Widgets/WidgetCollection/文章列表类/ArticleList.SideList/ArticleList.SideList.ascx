<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ArticleList.SideList.cs"
    Inherits="We7.CMS.Web.Widgets.ArticleList_SideList" %>
<script type="text/C#" runat="server">    
    [RemoveParameter("DateFormat")]
    string MetaData;
</script>
<div class="<%=Css %>">
    <div class="notice ">
        <h3 <%=BackgroundIcon() %>>
            <a target="_blank" title="更多" href="<%=Channel.RealUrl %>" style="font-weight: bold;">
                <img align="absmiddle" alt="更多" src="<%=ThemePath %>/images/more.gif"></a>
            <%=Channel.Name %></h3>
        <ul <%=SetBoxBorderColor() %>>
            <% foreach (Article article in Articles)
               {
                   string title = ToStr(article.Title, TitleLength);
                   
                   if(article.Updated.ToShortDateString() == DateTime.Now.ToShortDateString())
                   {
                       title = "<span style='color:black;'>" + title + "</span>";
                   }
%>
            <li><a target="_blank" href="<%=article.Url %>">
                <%=title%></a> </li>
            <%} %>
        </ul>
    </div>
</div>
<%--
tablename:"article"
tabledesc:"文章表"
--%>