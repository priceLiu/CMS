<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppAdd.aspx.cs" MasterPageFile="~/Admin/theme/classic/content.Master"
         Inherits="We7.CMS.Web.Admin.App.AppAdd" %>
<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>

<asp:Content ID="We7Content" runat="server" ContentPlaceHolderID="MyContentPlaceHolder">
    <link rel="stylesheet" type="text/css" href="/admin/theme/Style/article.css" media="screen" />

    <h2 class="title">
        <asp:Image runat="server" ImageUrl="/Admin/Images/icons_plugins.gif" />
        <asp:Label runat="server" Text="安装应用">
        </asp:Label>
        <span class="summary"><span id="navChannelSpan"></span>
            <asp:Label runat="server" Text="通过安装应用，可以轻易扩展网站后台及前台功能。">
            </asp:Label>
        </span>
    </h2>
    <div id="position">
        <a href="Apps.aspx">
            应用管理</a>&gt;安装应用
    </div>
    <div id="mycontent">
        <div class="Tab menuTab">
            <ul class="Tabs">
                <asp:Label runat="server"></asp:Label>
            </ul>
        </div>
        <div>
            <img src="/admin/images/bulb.gif" align="absmiddle" />
            <label class="block_info">
                <asp:Literal runat="server" Text="应用可以无限扩展We7的功能。您可以从We7 应用网站自动安装应用或者在这个页面上传 .zip 格式的应用包。"></asp:Literal></label>
        </div>
        <br />
        
        <div class="clear">
        </div>
        <div id="rightWrapper">
            <div id="container" style="display: table">
                <asp:PlaceHolder runat="server"></asp:PlaceHolder>
            </div>
        </div>
    </div>
    <div id="conbox">
	<dl>
		<dt>»使用.Zip格式安装一个应用<br>
			<dd>
				<div>
					<table>
						<tr>
							<td>
								如果您有一个 .zip 格式的应用文件，您可以在这里通过上传并安装它。
							</td>
						</tr>
						<tr>
							<td>
								<asp:FileUpload ID="ZipFileUpload" runat="server" />
								<asp:Button ID="UploadButton" runat="server" Text="添加应用" OnClick="UploadButtonClick"
									CssClass="button" />
							</td>
						</tr>
						<tr>
							<td>
								<WEC:MessagePanel ID="messages" runat="server">
								</WEC:MessagePanel>
							</td>
						</tr>
						<tr>
							<td>
								<asp:Button ID="InstallButton" Visible="false" Style="margin: 0; width: 100px;" CssClass="button"
									runat="server" Text="马上安装" OnClientClick='return  LocalInstall();' />
								<asp:Button ID="BackButton" Visible="false" Style="margin: 0; width: 100px;" CssClass="button"
									runat="server" Text="返回" OnClientClick='location.href="PluginList.aspx";return false' />
							</td>
						</tr>
					</table>
				</div>
			</dd>
		</dt>
	</dl>
</div>
</asp:Content>