<%@ Control Language="C#" AutoEventWireup="true" Debug="true" CodeFile="ChannelMenu.CurrLocation.cs" Inherits="We7.CMS.Web.Widgets.ChannelMenu_CurrLocation" %>
<script type="text/C#" runat="server">
    [ControlDescription(Desc = "当前位置1", Author = "系统")]
    [RemoveParameter("Tag")]
    string MetaData;
    protected string GetLocation()
    {
        StringBuilder location=new StringBuilder();
        string tmp = string.Empty;
        string hrefTemplate = "<a href=\"{1}\">{0}</a>";
        if (CurrentChannel != null && !string.IsNullOrEmpty(CurrentChannel.FullPath))
        {
            string[] paths = CurrentChannel.FullPath.Trim('/').Split('/');
            string[] urls = CurrentChannel.RealUrl.Trim('/').Split('/');
            for(int i=0;i< paths.Length;i++)
            {
                tmp += string.Format("/{0}", urls[i]);
                location.Append(string.Format(hrefTemplate, paths[i], tmp));
            }
            return location.ToString();
        }
        return "";    
    }
</script>
<div class="<%=CssClass %>">
<div <%=BackgroundIcon() %> class="sitepath">
    您现在的位置：<em><%=GetLocation()%></em>
</div>
</div>
<%--
tablename:"channel"
tabledesc:"栏目表"
--%>