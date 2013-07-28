<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoUpload.ascx.cs"
	Inherits="We7.CMS.Web.Admin.ChannelModule.PhotoUpload" %>
<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<link href="/ModelUI/Controls/system/page/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="/ModelUI/Controls/system/page/uploadify/swfobject.js"></script>
<script src="/ModelUI/Controls/system/page/uploadify/jquery.uploadify.v2.1.0.min.js"
	type="text/javascript"></script>
<div id="conbox">
	<dl>
		<dt>»上传照片组<br>
			<img src="/admin/images/bulb.gif" align="absmiddle" /><label class="block_info">上传照片组。</label>
		</dt>
		<dd>
			<div style="padding: 10px; line-height: 30px;">
				裁剪尺寸1:<asp:DropDownList ID="ddlSize" runat="server">
				</asp:DropDownList>
				裁剪尺寸2:<asp:DropDownList ID="ddlSize2" runat="server">
				</asp:DropDownList>
				<input class="Btn" id="SaveButton2" style="display: none;" runat="server" type="submit"
					value="添加图片" onserverclick="SaveButton_ServerClick" /><br />
				<br />
				<script type="text/javascript">
					$(document).ready(function () {
						//$("#<%=ddlSize2.ClientID %>").append($("#<%=ddlSize.ClientID %> option").clone());
						var fileTypes = '.jpg|.jpeg|.png|.gif';
						var maxLength = 30;
						$("#allowExts").text("支持格式：" + fileTypes + "；低于" + maxLength + "张");
						var notAllowed = '';
						$("#uploadify").uploadify({
							'uploader': '/ModelUI/Controls/system/page/uploadify/uploadify.swf',
							'script': '/ModelUI/Controls/system/page/uploadify/UpDownloadHandler.ashx?GetFunction=ArticleImages',
							'cancelImg': '/ModelUI/Controls/system/page/uploadify/cancel.png',
							'folder': '<%= CurArticle.AttachmentUrlPath %>',
							'queueID': 'fileQueue',
							'buttonText': '浏览本地图片',
							'sizeLimit': '5242880', //5M 
							'auto': false,
							'multi': true, 'queueSizeLimit': maxLength,
							'onComplete': function (event, response, status, d) {
								$("#<%=imagesValues.ClientID %>").val($("#<%=imagesValues.ClientID %>").val() + "|" + d);
							},
							'onAllComplete': function () {
								$('#actionCacel').hide();
								$("#<%=SaveButton2.ClientID %>").trigger("click");
							},
							'onSelect': function (a, b, c) {
								$("#actionOK").show(); $('#actionCacel').show();
								if (fileTypes.indexOf(c.type) < 0) {
									notAllowed += b + "|";
									jQuery('#uploadify').uploadifyCancel(b);
								}
							},
							'onSelectOnce': function () {
								for (var notall in notAllowed.split('|'))
									if (notAllowed.split('|')[notall] != '')
										$("#uploadify" + notAllowed.split('|')[notall]).remove();
							},
							'onError': function (a, b, c, d) {
								if (d.status == 404)
									alert('Could not find upload script.');
								else if (d.type === "HTTP")
									alert('error ' + d.type + ": " + d.status);
								else if (d.type === "File Size")
									alert(c.name + ' ' + d.type + ' Limit: ' + Math.round(d.sizeLimit / 1024) + 'KB');
								else
									alert('error ' + d.type + ": " + d.info);
							}
						});
					});
				</script>
				<input type="file" name="uploadify" id="uploadify" /><label id="allowExts"></label>
				<div style="float: right; width: 100px; margin-right: 20px; direction: rtl;">
					<a id="actionOK" style="display: none;" href="javascript:$('#uploadify').uploadifyUpload();$('#actionOK').hide();void(0);">
						上传</a> <a id="actionCacel" style="display: none;" href="javascript:$('#uploadify').uploadifyClearQueue();$('#actionCacel').hide();$('#actionOK').hide();void(0);">
							取消</a></div>
			</div>
			<div id="fileQueue">
			</div>
			<input type="hidden" id="imagesValues" runat="server" />
		</dd>
	</dl>
</div>
<hr />
<div class="smallButton4">
	<a class="selectAll">全选</a>
	<asp:LinkButton ID="MutilDel" runat="server" OnClientClick="return getDelData();"
		OnClick="MutilDel_Click">批量删除</asp:LinkButton></div>
<input type="hidden" id="DelData" runat="server" />
<asp:DataList ID="dlstPhotos" runat="server" RepeatColumns="4" OnItemCommand="dlstPhotos_ItemCommand">
	<ItemStyle Width="100" Height="100" HorizontalAlign="Center" />
	<ItemTemplate>
		<div style="padding: 3px; border: solid #e6e6e6 1px; background: #f6f6f6; margin-bottom: 5px;">
			<img src="<%# Container.DataItem %>" style="border: 0;" />
		</div>
		<asp:Button ID="bttnDel" runat="server" Text="删除" CommandName="del" />
	</ItemTemplate>
</asp:DataList>
<style type="text/css">
	.select
	{
		background-color: Gray;
		opacity: 0.5;
	}
</style>
<script type="text/javascript">
	$(".selectAll").toggle(function () {
		$("#<%=dlstPhotos.ClientID %> td:not(:empty)").addClass("select");
	}, function () {
		$("#<%=dlstPhotos.ClientID %> td:not(:empty)").removeClass("select");
	});
	$("#<%=dlstPhotos.ClientID %> td:not(:empty)").click(function () {
		if ($(this).hasClass("select")) {
			$(this).removeClass("select");
		}
		else {
			$(this).addClass("select");
		}
	});
	function getDelData() {
		var delData = "";
		$("#<%=dlstPhotos.ClientID %> td.select img").each(function () {
			delData += $(this).attr("src").replace('_S.', '.') + "|";
		});
		if (delData == '') return false;
		$("#<%=DelData.ClientID %>").val(delData);
		return true;
	}

</script>
