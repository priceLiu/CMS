<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ThumbnailEx.ascx.cs"
    Inherits="We7.CMS.Web.Admin.ContentModel.Controls.ThumbnailExText" %>
<div id="<%=ClientID %>">
</div>

<script type="text/javascript">
    $(function () {
        if ("<%=Imgs %>".length > 0) {
            var result = eval("<%=Imgs %>");
            for (var it in result) {
                var sizes = result[it][1].size.split("*");
                $("#<%=ClientID %>").append($("<img>").attr("src", result[it][1].src).attr("width", sizes[0]).attr("height", sizes[1]));
                $("#<%=ClientID %>").append("<br /><br />");
            }
        }
    });
</script>


