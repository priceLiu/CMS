<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VideoSelect.ascx.cs"
	Inherits="We7.Model.UI.Controls.we7.VideoSelect" %>
<script src="/admin/fckeditor/editor/ckfinder/ckfinder.js" type="text/javascript"></script>
<div>
	<asp:TextBox ID="txtPath" runat="server" Width="200" onblur="this.className='input_blur'"
		onfous="this.className='input_focus'"></asp:TextBox>
	<input type="button" value="选择视频" onclick="BrowseServer('<%=txtPath.ClientID %>');"
		class="button_style" />
	<%--    <input type="button" value="选择..." onclick="alert('添加图片')" class="button_style" />
    <input type="button" value="裁剪图片" onclick="alert('添加图片')" class="button_style" />--%>
	<script type="text/javascript">
		function BrowseServer(inputId) {
			var finder = new CKFinder();
			finder.BasePath = '/admin/fckeditor/editor/ckfinder/'; //导入CKFinder的路径 
			finder.SelectFunction = SetFileField; //设置文件被选中时的函数 
			finder.selectFunctionData = inputId; //接收地址的input ID
			Popup(finder);
		}
		//文件选中时执行 
		function SetFileField(fileUrl, data) {
			$("#<%=txtPath.ClientID %>").val(fileUrl);

		}
		function Popup(finder, width, height) {
			width = width || '80%';
			height = height || '70%';

			if (typeof width == 'string' && width.length > 1 && width.substr(width.length - 1, 1) == '%')
				width = parseInt(window.screen.width * parseInt(width) / 100);

			if (typeof height == 'string' && height.length > 1 && height.substr(height.length - 1, 1) == '%')
				height = parseInt(window.screen.height * parseInt(height) / 100);

			if (width < 200)
				width = 200;

			if (height < 200)
				height = 200;

			var top = parseInt((window.screen.height - height) / 2);
			var left = parseInt((window.screen.width - width) / 2);

			var options = 'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes' +
			',width=' + width +
			',height=' + height +
			',top=' + top +
			',left=' + left;

			var popupWindow = window.open('', 'CKFinderPopup', options, true);

			// Blocked by a popup blocker.
			if (!popupWindow)
				return false;

			popupWindow.moveTo(left, top);
			popupWindow.resizeTo(width, height);
			popupWindow.focus();
			popupWindow.location.href = finder._BuildUrl() + "&type=Media";
		}
	</script>
</div>
