<%@ Control Language="C#" AutoEventWireup="true" Debug="true" CodeFile="SiteMap.cs" Inherits="We7.CMS.Web.Widgets.SiteMap" %>
<%@ Import Namespace="We7.CMS" %>
<script type="text/C#" runat="server">
    [ControlDescription(Desc = "网站导航菜单", Author = "系统")]
    [RemoveParameter("Tag")]
    string MetaData;
</script>
<div class="<%=Css %>">
    <div class="menu">
        <div class="main_menu" id="menubox">
            <ul>
                    <li>
                        <a target="_self" href="/"><span><em>网站首页</em></span></a></li>
                    <% foreach (Channel ch in FirstLevelChannels)
                       { %>
                        <li>
                            <a target="_self" href="<%=ch.RealUrl %>"><span><em>
                                <%=ch.Name %></em></span></a>
                            <ul>
                                <div class="sub_menu">
                                    <div class="sub_center">
                                        <ul>
                                            <% 
                                            List<Channel> childChannel = GetSecondLevelChannels(ch.ID);
                                            foreach (Channel ch2 in childChannel)
                                            { %>
                                            <li><a target="_self" href="<%=ch2.RealUrl %>">
                                                <%=ch2.Name %></a></li>
                                            <%} %>
                                        </ul>
                                    </div>
                                </div>
                            </ul>
                        </li>
                        <%} %>
            </ul>
        </div>
    </div>
</div>
<%--
tablename:"channel"
tabledesc:"栏目表"
--%>