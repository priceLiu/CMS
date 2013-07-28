<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Channel_template.ascx.cs"
	Inherits="We7.CMS.Web.Admin.controls.Channel_template" %>
<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<script language="javascript">
	//模板:======================================================
	function onSelectTemplateClick(txtTemplate) {
		var title = "模式窗口";
		var nWidth = "650";
		var nHeight = "480";
		var strFile = "TemplateList.aspx";
		strFile += "?file=" + curmode;
		var ret = window.showModalDialog(strFile, window, "dialogWidth:" + nWidth + "px;dialogHeight:" + nHeight + "px;center:yes;status:no;scroll:auto;help:no;");
		if (ret != null) {
			var arry = new Array();
			arry = ret.split(";"); //一般返回一个字符串，用斗号分割           
			var textBox = document.getElementById(txtTemplate);
			if (arry[1])
				$("a[mode='" + arry[1] + "']").trigger("click");
			textBox.value = arry[0];
			freshData();
		}
	}
	function freshData() {
		$("#<%=curmode.ClientID %>").val(curmode);
		if (curmode == "pc") {
			$("#<%= TemplateIDTextBox.ClientID%>").val($("#indexTemplateText").val() + "$" + $("#<%= TemplateIDTextBox.ClientID%>").val().split("$")[1]);
			$("#<%= DetailTemplateIDTextBox.ClientID%>").val($("#detailTemplateText").val() + "$" + $("#<%= DetailTemplateIDTextBox.ClientID%>").val().split("$")[1]);
			$("#<%= ListTemplateIDTextBox.ClientID%>").val($("#listTemplateText").val() + "$" + $("#<%= ListTemplateIDTextBox.ClientID%>").val().split("$")[1]);
			$("#<%= SearchTemplateIDTextBox.ClientID%>").val($("#searchTemplateText").val() + "$" + $("#<%= SearchTemplateIDTextBox.ClientID%>").val().split("$")[1]);
		}
		else {
			$("#<%= TemplateIDTextBox.ClientID%>").val($("#<%= TemplateIDTextBox.ClientID%>").val().split("$")[0] + "$" + $("#indexTemplateText").val());
			$("#<%= DetailTemplateIDTextBox.ClientID%>").val($("#<%= DetailTemplateIDTextBox.ClientID%>").val().split("$")[0] + "$" + $("#detailTemplateText").val());
			$("#<%= ListTemplateIDTextBox.ClientID%>").val($("#<%= ListTemplateIDTextBox.ClientID%>").val().split("$")[0] + "$" + $("#listTemplateText").val());
			$("#<%= SearchTemplateIDTextBox.ClientID%>").val($("#<%= SearchTemplateIDTextBox.ClientID%>").val().split("$")[0] + "$" + $("#searchTemplateText").val());
		}
		return true;
	}

	function loadData(i) {
		document.getElementById("indexTemplateText").value = document.getElementById("<%= TemplateIDTextBox.ClientID%>").value.split('$')[i];
		document.getElementById("detailTemplateText").value = document.getElementById("<%= DetailTemplateIDTextBox.ClientID%>").value.split('$')[i];
		document.getElementById("listTemplateText").value = document.getElementById("<%= ListTemplateIDTextBox.ClientID%>").value.split('$')[i];
		document.getElementById("searchTemplateText").value = document.getElementById("<%= SearchTemplateIDTextBox.ClientID%>").value.split('$')[i];
	}
	var curmode = "pc";
	$(document).ready(function () {
		$("#selectTabs a").css({ padding: "0 10px", cursor: "pointer", marginRight: "10px" }).click(function () {
			if ($(this).hasClass("cur")) return;
			curmode = $("#selectTabs .cur").attr("mode");
			$("#selectTabs .cur").removeClass("cur");
			$(this).addClass("cur");
			$("#" + curmode).hide();
			curmode = $(this).attr("mode");
			$("#" + curmode).show();
			loadData($(this).index());
			if (curmode == "pc") {
				$("input:checkbox").show();
				$("input:checkbox.M").hide();
			}
			else {
				$("input:checkbox").hide();
				$("input:checkbox.M").show();
			}
		});
		loadData(0);
		$("input.M").hide();
	});
</script>
<style>
	.cur
	{
		background-color: #333366;
		color: #fff;
	}
</style>
<script src="<%=AppPath%>/cgi-bin/pinyin.js" type="text/javascript"></script>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<div id="conbox">
	<dl>
		<dt>»栏目的模板设置<span id="selectTabs" style="float: right;"><a mode="pc" class="cur">PC版</a><a
			mode="mobile">手机版</a></span><br />
			<img src="/admin/images/bulb.gif" align="absmiddle" alt="" /><label class="block_info">修改栏目具体绑定模板，不设置的话通过模板索引图自动匹配模板组的默认模板；</label>
		</dt>
		<dd>
			<h1>
				栏目模板自动匹配如下：</h1>
			<div id="pc" style="font-size: 14px; font-weight: lighter; line-height: 150%; color: #888">
				<asp:Literal runat="server" ID="MapListLiteral"></asp:Literal>
			</div>
			<div id="mobile" style="font-size: 14px; font-weight: lighter; line-height: 150%;
				display: none; color: #888;">
				<asp:Literal runat="server" ID="MobileMapListLiteral"></asp:Literal>
			</div>
			<br />
			如果上述匹配不够准确的话，请重新生成模板索引地图再试试。<br />
			<asp:LinkButton runat="server" ID="CreateMapLink" OnClick="CreateMapLink_Click">重新生成模板索引地图</asp:LinkButton>
		</dd>
		<dd>
			<h1>
				本栏目特殊指定模板如下：</h1>
			<div>
				<table cellpadding="0" cellspacing="0" style="font-size: 12px; width: 500px;">
					<tr>
						<td style="width: 80px">
							栏目主页 ：
						</td>
						<td style="width: 80px">
							<input type="text" size="30" id="indexTemplateText" />
						</td>
						<td style="width: 12px">
							<input type="button" value="..." onclick="onSelectTemplateClick('indexTemplateText')" />
						</td>
						<td style="width: 8px">
							<input type="checkbox" value="" runat="server" id="indexCheckbox" />
							<input type="checkbox" class="M" value="" runat="server" id="indexCheckboxM" />
						</td>
						<td>
							子栏目继承
						</td>
					</tr>
					<tr style="display: none">
						<td>
							栏目列表页：
						</td>
						<td>
							<input type="text" size="30" id="listTemplateText" />
						</td>
						<td>
							<input type="button" value="..." onclick="onSelectTemplateClick('listTemplateText')" />
						</td>
						<td>
							<input type="checkbox" value="" runat="server" id="listCheckbox" />
							<input type="checkbox" class="M" value="" runat="server" id="listCheckboxM" />
						</td>
						<td>
							子栏目继承
						</td>
					</tr>
					<tr>
						<td>
							栏目详细页：
						</td>
						<td>
							<input type="text" size="30" id="detailTemplateText" />
						</td>
						<td>
							<input type="button" value="..." onclick="onSelectTemplateClick('detailTemplateText')" />
						</td>
						<td>
							<input type="checkbox" value="" runat="server" id="detailCheckbox" />
							<input type="checkbox" class="M" value="" runat="server" id="detailCheckboxM" />
						</td>
						<td>
							子栏目继承
						</td>
					</tr>
					<tr>
						<td>
							栏目搜索页：
						</td>
						<td>
							<input type="text" size="30" id="searchTemplateText" />
						</td>
						<td>
							<input type="button" value="..." onclick="onSelectTemplateClick('searchTemplateText')" />
						</td>
						<td>
							<input type="checkbox" value="" runat="server" id="searchCheckbox" />
							<input type="checkbox" class="M" value="" runat="server" id="searchCheckboxM" />
						</td>
						<td>
							子栏目继承
						</td>
					</tr>
				</table>
			</div>
		</dd>
	</dl>
	<dl>
		<dd>
			<input class="Btn" id="SaveButton2" runat="server" type="submit" value="修改栏目模板" onclick="return freshData()"
				onserverclick="SaveButton_ServerClick">
		</dd>
	</dl>
	<div style="display: none">
		<input type="hidden" value="pc" runat="server" id="curmode" />
		<asp:TextBox ID="ParentIDTextBox" runat="server"></asp:TextBox>
		<asp:TextBox ID="ChannelNameHidden" runat="server"></asp:TextBox>
		<asp:TextBox ID="TemplateIDTextBox" runat="server"></asp:TextBox>
		<asp:TextBox ID="DetailTemplateIDTextBox" runat="server"></asp:TextBox>
		<asp:TextBox ID="ListTemplateIDTextBox" runat="server"></asp:TextBox>
		<asp:TextBox ID="SearchTemplateIDTextBox" runat="server"></asp:TextBox>
	</div>
</div>
<script type="text/javascript">
	loadData();
</script>
