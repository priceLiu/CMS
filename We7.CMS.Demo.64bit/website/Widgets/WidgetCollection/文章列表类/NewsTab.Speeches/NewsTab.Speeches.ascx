<%@ Control Language="C#" AutoEventWireup="true" Debug="true" CodeFile="NewsTab.Speeches.cs"
    Inherits="We7.CMS.Web.Widgets.NewsTab_Speeches" %>
<script type="text/C#" runat="server">
    [ControlDescription(Desc = "显示指定栏目信息-纵向", Author = "西部动力")]
    string MetaData;    
</script>
<div class="<%=Css %>">
    <div class="ttnew_right_ldjh">
        <div class="ttnew_right_ldjh_nr">
            <div class="ttnew_right_ldjh_nr_12">
                <ul>
                    <% List<Article> list = QueryArticlesByChannels();
                       foreach (Article article in list)
                       { %>
                    <li><a target="_self" href="<%=article.Url %>">
                        <%=ToStr(article.Title, TitleLength)%></a><span class="datetime"><%=ToDateStr(article.Updated, DateFormat)%></span></li>
                    <%} %>
                </ul>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
</div>
<%--
tablename:"article"
tabledesc:"文章表"
--%>