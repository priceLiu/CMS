<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttachmentExText.ascx.cs" Inherits="We7.Model.UI.Controls.we7.AttachmentExText" %>
<div id="<%=ClientID %>">
 
</div>
<script type="text/javascript">
    $(function () {
        if ("<%=Attachments %>>".length > 0) {
            var result = eval("<%=Attachments %>");
            var currentItem, tempItem;
            for (var it in result) {
                currentItem = result[it];
                tempItem = result[it].split('/');
                tempItem = tempItem[tempItem.length - 1];
                $("#<%=ClientID %>").append($("<a>").attr("href", currentItem).html(tempItem));
                $("#<%=ClientID %>").append("<br />");
            }

        }
    });
</script>
