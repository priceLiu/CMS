<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelEditor.aspx.cs" MasterPageFile="~/User/DefaultMaster/content.Master"
    Inherits="We7.CMS.Web.User.ModelEditor" %>

<%@ Register Src="~/ModelUI/Panel/system/EditorPanel.ascx" TagName="EditorPanel"
    TagPrefix="uc1" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyHeadPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" href="/ModelUI/skin/default.css" media="screen" />
    <script src="/Admin/Ajax/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/Admin/Ajax/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function iframeAutoFit() {
            try {
                if (window != parent) {
                    var a = parent.document.getElementsByTagName("IFRAME");
                    for (var i = 0; i < a.length; i++) //author:meizz
                    {
                        if (a[i].contentWindow == window) {
                            var h1 = 0, h2 = 0;
                            a[i].parentNode.style.height = a[i].offsetHeight + "px";
                            a[i].style.height = "10px";
                            if (document.documentElement && document.documentElement.scrollHeight) {
                                h1 = document.documentElement.scrollHeight;
                            }
                            if (document.body) h2 = document.body.scrollHeight;
                            var h = Math.max(h1, h2);
                            if (document.all) { h += 4; }
                            if (window.opera) { h += 1; }
                            a[i].style.height = a[i].parentNode.style.height = h + h * 0.3 + "px";
                        }
                    }

                    if (parent.closeBar) parent.closeBar();
                }
            }
            catch (ex) { }
        }
        if (window.attachEvent) {
            window.attachEvent("onload", iframeAutoFit);
        }
        else if (window.addEventListener) {
            window.addEventListener('load', iframeAutoFit, false);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <form id="mainForm" runat="server">
       <div class="realRight ml10">
           <div class="mybox">
              <uc1:EditorPanel ID="ucEditor" runat="server" PanelName="edit" />
           </div>
       </div>
       <script type="text/javascript">
           $(document).ready(function () {
               $("#conbox").hide();
               $("#imgDoBack").remove();
               var aTxt = $(".Tabs").find("a");
               $(".mytit").html(aTxt.text());
               aTxt.remove();
           });
       </script>
    </form>
</asp:Content>
