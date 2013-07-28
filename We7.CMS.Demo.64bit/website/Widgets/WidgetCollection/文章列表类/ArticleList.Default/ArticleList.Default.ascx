<%@ Control Language="C#" AutoEventWireup="true" Debug="true" CodeFile="ArticleList.Default.cs"
    Inherits="We7.CMS.Web.Widgets.ArticleList_Default" %>
<%@ Register Src="~/Widgets/WidgetCollection/文章列表类/NewsTab.Default/NewsTab.Default.ascx"
    TagName="ChannelMenu" TagPrefix="wec" %>
<div class="<%= CssClass %> <%=MarginCss %> ">
    <div class="area">
        <dl>
            <dt>
                <h3 <%=BackgroundIcon() %>>
                    <a title="更多" target="_blank" href="<%=Channel.FullUrl %>">
                        <%=Channel.Name %></a><a title="更多" target="_blank" href="<%=Channel.FullUrl %>">
                            <img align="absmiddle" alt="更多" src="<%=ThemePath %>/images/more.gif" /></a></h3>
            </dt>
            <dd>
                <ul <%=SetBoxBorderColor() %>>
                    <a title="更多" target="_blank" href="<%=Channel.FullUrl %>"></a>
                    <% foreach (Article article in Articles)
                       { %>
                    <li><a target="_self" href="<%=article.ContentType==8?article.ContentUrl:article.Url %>">
                        <%=ToStr(article.Title,TitleLength) %></a><span class="datetime"><%=ToDateStr(article.Created,DateFormat) %></span></li>
                    <%} %>
                </ul>
            </dd>
        </dl>
    </div>
</div>
<%--
tablename:"article"
tabledesc:"文章表"
--%>