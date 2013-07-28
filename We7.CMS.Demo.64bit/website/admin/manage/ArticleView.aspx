<%@ Page Language="C#" MasterPageFile="~/admin/theme/ContentNoMenu.Master" AutoEventWireup="true" CodeBehind="ArticleView.aspx.cs" Inherits="We7.CMS.Web.Admin.ArticleView" Title="文章预览" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
     <script type="text/javascript" language="javascript">
         function iframeAutoFit()
         {
             try
             {
                 if(window!=parent)
                 {
                     var a = parent.document.getElementsByTagName("IFRAME");
                     for(var i=0; i<a.length; i++) //author:meizz
                     {
                         if(a[i].contentWindow==window)
                         {
                             var h1=0, h2=0;
                             a[i].parentNode.style.height = a[i].offsetHeight +"px";
                             a[i].style.height = "10px";
                             if(document.documentElement&&document.documentElement.scrollHeight)
                             {
                                 h1=document.documentElement.scrollHeight;
                             }
                             if(document.body) h2=document.body.scrollHeight;
                             var h=Math.max(h1, h2);
                             if(document.all) {h += 4;}
                             if(window.opera) {h += 1;}
                             a[i].style.height = a[i].parentNode.style.height = h+h*0.3 +"px";
                         }
                     }
                 }
             }
             catch (ex){}
         }
         if(window.attachEvent)
         {
             window.attachEvent("onload",iframeAutoFit);
         }
         else if(window.addEventListener)
         {
             window.addEventListener('load',   iframeAutoFit,   false);
         }
     </script>
<script type="text/javascript">
    // 用于显示文章分页的脚本与样式
    window.setupArticlePager = function (id, pageCount) {
        var pagerUrl = '/Admin/VisualTemplate/WidgetEditor/pager.js'; if (pageCount < 2) { return; }
        function nth(n) { return "div.article-pages-" + n; }
        function preSetupPager() { var selector = "#" + id, i = 2, first = $(nth(1), selector); do { $(nth(i), selector).hide().insertAfter($(nth(i - 1), selector)); } while (++i <= pageCount); first.show(); }
        function doSetup() { var selector = "#" + id, pager, holder = $('<div rel="pager-bar"/>').addClass('we7article-pagerbar').appendTo(selector); pager = new window.Pager(holder, pageCount); pager.onpaged(function (page, lastPage) { $("div[class^='article-pages']", selector).hide(); $(nth(page), selector).show(); }); pager.page(1); }
        var script, timeTried = 0; function checker() { if (window.Pager) { doSetup(); } else { if (timeTried < 50) { timeTried++; setTimeout(checker, 150); } } }
        if (!window.Pager) { script = document.createElement("SCRIPT"); script.type = "text/javascript"; script.setAttribute("src", pagerUrl); script.src = pagerUrl; document.getElementsByTagName('head')[0].appendChild(script); }
        preSetupPager(); checker();
    }
</script>
<style type="text/css">
.pager-spliter{display: block;float:left;height: 25px;width: 25px;text-align: center;}
.pager-spinner-prev,.pager-spinner-next {display: none}
.we7article-pagerbar{ }
</style>
  <h2 class="title" style="text-align:center">
        <asp:Label ID="TitleLabel" runat="server" Text="">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="预览">
            </asp:Label>
        </span>
    </h2>
<%--    <div class="toolbar" style="text-align:center">
        <a href="javascript:window.close()">关闭</a>
    </div>--%>
    <hr />
    <div style="padding:30px">
    <asp:Label ID="ContentLabel" runat="server" Text="">
    </asp:Label>
    </div>
    
     <div class="Attachment">
        <h3>附件</h3>
        <%for (int i = 0; i < Attachments.Count; i++)
          { %>
          <p>
        <%=(i+1).ToString() %>. <%=Attachments[i].FileName%>
         （大小：<%=Attachments[i].FileSizeText%>）  
        <a href="<%=Attachments[i].DownloadUrl %>" target="_blank">下载</a> 
        <a href="<%=Attachments[i].FilePath+"/"+Attachments[i].FileName %>" target="_blank">打开</a>
           </p>
        <%}%>
   </div>
        
</asp:Content>
