<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SharedModelCommand.ascx.cs" Inherits="We7.Model.UI.Container.we7.SharedModelCommand" %>
<script type="text/javascript" src="/Admin/cgi-bin/search.js"></script>
<script type="text/javascript" src="/Admin/ajax/jquery/jquery.DMenu.js"></script>
<script type="text/javascript">
	function GoToSortPage() {
		var result = window.showModalDialog('/admin/contentmodel/sort.aspx<%=URLParam %>', '', 'dialogHeight:500px;dialogWidth:700px;status:no');
		if (result == 'ok')
		__doPostBack('<%=lnkRefresh.ClientID.Replace('_','$') %>', '')
		return false;
	}
</script>
<style type="text/css">
	.style1
	{
		width: 589px;
	}
	.style2
	{
		width: 3px;
	}
	#tagsContainer
	{
		border: 1px solid #990000;
		padding: 5px 10px;
		width: 105px;
		height: 204px;
		background-color: #ffe;
	}
</style>
<div class="toolbar2">
	<li class="smallButton4">
		<asp:HyperLink ID="lnkNewArticle" runat="server">新增</asp:HyperLink>
	</li>
	<li class="smallButton4">
		<asp:LinkButton ID="lnkPubLish" OnClick="lnkPubLish_Click" CommandName="setPublish"
			CommandArgument="multirow" runat="server">发布</asp:LinkButton>
	</li>
	<li class="smallButton4">
		<asp:LinkButton ID="lnkDelSel" OnClick="OnButtonSubmit" CommandName="delSel" CommandArgument="multirow"
			runat="server">删除</asp:LinkButton>
	</li>
	<li class="smallButton4">
		<asp:LinkButton ID="lnkRefresh" OnClick="OnButtonSubmit" CommandName="refresh" CommandArgument="multirow"
			runat="server">刷新</asp:LinkButton>
	</li>
	<li class="smallButton4">
		<asp:LinkButton ID="lnkSort" OnClientClick="return GoToSortPage();" runat="server">排序</asp:LinkButton>
	</li>
</div>
