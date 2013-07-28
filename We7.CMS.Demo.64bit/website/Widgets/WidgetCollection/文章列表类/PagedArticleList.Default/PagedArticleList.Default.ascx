<%@ Control Language="C#" AutoEventWireup="true" Debug="true" CodeFile="PagedArticleList.Default.cs"
    Inherits="We7.CMS.Web.Widgets.PagedArticleList_Default" %>
<div class="<%=Css %>">
    <div class="article_list ">
        <h3 <%=BackgroundIcon() %>>
            <%= Channel!=null ? Channel.Name: "" %></h3>
        <ul <%=SetBoxBorderColor() %>>
            <% foreach (Article article in Articles)
               { %>
            <li><em><a target="_self" href="<%=article.Url %>">
                <%
                   string title = ToStr(article.Title, TitleLength);
                   if (!string.IsNullOrEmpty(KeyWord))
                       title = title.Replace(KeyWord, "<em>" + KeyWord + "</em>");
                %>
                <%=title%></a></em><span class="datetime"><%=ToDateStr(article.Updated,DateFormat) %></span><div
                    class="clear">
                </div>
            </li>
            <%} %>
        </ul>
        <%= Pager.PagedHtml%>
        <div class="clear">
        </div>
        <div class="underline_left">
        </div>
    </div>
</div>
<%--
tablename:"article"
tabledesc:"文章表"
--%>