<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Thumbnail.ascx.cs" Inherits="We7.CMS.Web.Admin.ContentModel.Controls.Thumbnail" %>
<div>
    <asp:TextBox ID="txtPath" runat="server" Width="200" onblur="this.className='input_blur'"
        onfous="this.className='input_focus'"></asp:TextBox>
    <input type="button" value="上传图片" onclick="<%=ClientID %>()" class="button_style" />
   <%-- <input type="button" value="选择..." onclick="alert('添加图片')" class="button_style" />
    <input type="button" value="裁剪图片" onclick="alert('添加图片')" class="button_style" />--%>
    <script type="text/javascript">
//        var userAgent = navigator.userAgent.toLowerCase();
//        var isFireFox=/mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent);
//        if(isFireFox)
//        {
//            window.showModelessDialog = function(url) {
//                var windowName = (arguments[1] == null ? "" : arguments[1].toString());
//                var feature = (arguments[2] == null ? "" : arguments[2].toString());
//                var OpenedWindow = window.open(url, windowName, feature);
//                window.addEventListener('click', function() { OpenedWindow.focus(); }, false);
//                return OpenedWindow;
//            };
//        }
//        else {
//            //子窗口中调用父窗口
//            //IE中用window.parent.document
//            //FF中用window.opener.document
//            //下面的代码将 作用于IE '重载' window.showModelessDialog 方法 统一用 window.opener访问父窗口
//            var originFn = window.showModelessDialog;
//            window.showModelessDialog = function(url) {
//                var OpenedWindow = originFn(url, arguments[1], arguments[2]);
//                OpenedWindow.opener = window;
//            };
//        }
        

        function <%=ClientID %>()
        {
            //var isMSIE= (navigator.appName == "Microsoft Internet Explorer"); 
            //if(isMSIE)
            //{
                window.showModelessDialog('/ModelUI/Controls/Page/ImageUpload.aspx?aid=<%=ArticleID %>&v='+$("#<%=txtPath.ClientID %>").val(),$("#<%=txtPath.ClientID %>")[0],'scroll:0;status:0;help:0;resizable:0;dialogWidth:500px;dialogHeight:450px;width=400;height=400');
            //}
            //else
            //{
            //    alert('请用IE进行数据添加');
            //}
        }
    </script>

</div>
