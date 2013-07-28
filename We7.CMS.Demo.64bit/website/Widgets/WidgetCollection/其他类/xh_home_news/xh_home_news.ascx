<%@ Control Language="C#" AutoEventWireup="true" Debug="true" CodeFile="xh_home_news.cs"
    Inherits="We7.CMS.Web.Widgets.xh_home_news" %>
<div class="<%= CssClass %> ">
    <div class="area">
        <dl>
            <dt><h3 <%=BackgroundIcon() %>>
                西湖要闻<span> XiHu News</span></h3>
            </dt>
            <dd> <ul <%=SetBoxBorderColor() %>>
           <a title="更多" target="_blank" href="<%=Channel.FullUrl %>"></a>
           <% foreach (Article article in Articles)
               { %>
            <li><a target="_self" href="<%=article.Url %>">
                <%=ToStr(article.Title,TitleLength) %></a><span class="datetime"><%=ToDateStr(article.Updated,DateFormat) %></span></li>
            <%} %>
        </ul></dd>
        </dl>    
    </div>
</div>