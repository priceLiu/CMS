<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/theme/classic/content.Master"
	CodeBehind="system.aspx.cs" Inherits="We7.CMS.Web.Admin.system" %>

<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<%@ Register Src="controls/System_image.ascx" TagName="System_image" TagPrefix="uc1" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
	<link rel="stylesheet" type="text/css" href="<%=AppPath%>/ajax/jquery/css/ui.tabs.css"
		media="all" />
	<script src="<%=AppPath%>/ajax/jquery/ui.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function () {
			$('#container-1 > ul').tabs();
		});
	</script>
	<script type="text/javascript">
		function selectTemplate() {
			showDialog("TemplateGroupList.aspx", hanldeTempalteListCallback);
		}

		function hanldeTempalteListCallback(v, t) {
			document.getElementById("DefaultTemplateGroupTextBox").value = t;
			document.mainForm.DefaultTemplateGroupFileNameTextBox.value = v;
		}
		function doStyle() {
			showDialog("<%=AppPath%>/cgi-bin/controls/StyleEditor/StyleEditor.aspx", onStyleEditorCallback, "color:#ffffff");
		}
		function onStyleEditorCallback(v, t) {
		}
		function onSaveButtonClick() {
			document.getElementById("<%=SaveButton.ClientID %>").click();
		}

		function SelectAll(tempControl) {
			var theBox = tempControl;
			xState = theBox.checked;

			elem = theBox.form.elements;
			for (i = 0; i < elem.length; i++)
				if (elem[i].type == "checkbox" && elem[i].id != theBox.id) {
					if (elem[i].checked != xState)
						elem[i].click();
				}
	}

	function startCache() {
		var EnableCache = document.getElementById("<%=EnableCache.ClientID %>");
		var CacheTimeSpanTextBox = document.getElementById("<%=CacheTimeSpanTextBox.ClientID %>");
		if (EnableCache.checked) {
			CacheTimeSpanTextBox.removeAttribute("disabled");
		} else {
			CacheTimeSpanTextBox.setAttribute("disabled", "disabled");
		}
	}

	function urlFormat(obj) {
		var item = obj.options[obj.selectedIndex].value;
		if (item == "custom")
			$("#customUrl").css("display", "");
		else
			$("#customUrl").css("display", "none");
	}
	var IDIPStrategy = "<%=hddnIPStrategy.ClientID %>";
	</script>
	<input id="xyz" type="text" style="display: none" />
	<h2 class="title">
		<asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_img.gif" />
		<asp:Label ID="NameLabel" runat="server" Text="��վ��������">
		</asp:Label>
		<span class="summary">
			<asp:Label ID="SummaryLabel" runat="server" Text="We7ϵͳ�ĸ���������á�">
			</asp:Label>
		</span>
	</h2>
	<div class="toolbar">
		<asp:HyperLink ID="UpdateHyperLink" NavigateUrl="javascript:onSaveButtonClick()"
			runat="server">
            �������</asp:HyperLink>
		<span></span>
		<asp:HyperLink ID="RefreshHyperLink" NavigateUrl="system.aspx" runat="server">
            ˢ��</asp:HyperLink>
	</div>
	<WEC:MessagePanel ID="Messages" runat="server">
	</WEC:MessagePanel>
	<div style="margin-top: 10px">
		<div id="container-1">
			<ul>
				<li><a href="#fragment-1"><span>��վ����</span></a></li>
				<li><a href="#fragment-2"><span>���������Ż�</span></a></li>
				<li><a href="#fragment-3"><span>ϵͳ��ʼֵ</span></a></li>
				<li><a href="#fragment-4"><span>�ʼ�����</span></a></li>
				<li><a href="#fragment-5"><span>��������/����</span></a></li>
				<li><a href="#fragment-6"><span>ͼƬ����</span></a></li>
				<li id="ipset" runat="server"><a id="#fragment-7" href="#fragment-7"><span>IP����</span></a></li>
			</ul>
			<div id="fragment-1">
				<table style="border: solid 0px #fff;">
					<tr>
						<td align="right">
							վ�����ƣ�
						</td>
						<td>
							<asp:TextBox ID="SiteNameTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td align="right">
							��վ��ַ��
						</td>
						<td>
							<asp:TextBox ID="RootUrlTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							��˾���ƣ�
						</td>
						<td align="left">
							<asp:TextBox ID="txtSiteFullName" runat="server" class="colorblur" Columns="35" MaxLength="100"
								onblur="this.className='colorblur';" onfocus="this.className='colorfocus';" />
							<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSiteFullName"
								ErrorMessage="����д��˾����"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td align="right">
							վ��logo��
						</td>
						<td align="left">
							<img id="logo_preview" src="<%=ImageValue.Text%>" alt="logoԤ��ͼ" style="max-width: 175px;max-height:175px;" /><br />
							<asp:TextBox ID="ImageValue" runat="server" Width="238" MaxLength="400" /><asp:RequiredFieldValidator
								ID="RequiredFieldValidator4" runat="server" ControlToValidate="ImageValue" ErrorMessage="�����ϴ�վ��logo"></asp:RequiredFieldValidator><br />
							<asp:FileUpload ID="fuImage" runat="server" CssClass="file_style" Style="width: 200px;" />&nbsp;&nbsp;
							<asp:Button ID="bttnUpload" runat="server" Text="�ϴ�" CssClass="button_style" OnClick="bttnUpload_Click"
								CausesValidation="false" />
						</td>
					</tr>
					<tr>
						<td align="right">
							��̬URL���º�׺��
						</td>
						<td>
							<asp:RadioButton ID="AshxRadioButton" runat="server" Text="aspx" GroupName="urlFormat"
								Checked="true" />
							<asp:RadioButton ID="HtmlRadioButton" runat="server" Text="html" GroupName="urlFormat" />
						</td>
					</tr>
					<tr>
						<td align="right">
							��̬URL��д����
						</td>
						<td>
							<asp:RadioButton ID="IISRadioButton" runat="server" Text="IIS" GroupName="urlRewriter" />
							<asp:RadioButton ID="ASPNETRadioButton" runat="server" Text="Asp.net" GroupName="urlRewriter"
								Checked="true" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="color: Red; padding-left: 50px; padding-right: 200px">
							��1�����ѡ��IIS����Ļ�����Ҫ������IISվ�������н��С�ISAPI������������
							<br />
							��2�����ѡ��Asp.net���𣬲�ϣ��ʹ��HTML��չ���Ļ�����Ҫ����ͨ���<br />
							��� <a href="http://help.we7.cn/library/94.html" target="_blank">We7���ã����þ�̬URL</a>
							��
						</td>
					</tr>
					<tr>
						<td align="right">
							���¾�̬URL��ʽ��
						</td>
						<td>
							<asp:DropDownList ID="ArticleUrlGeneratorDropDownList" runat="server" onchange="urlFormat(this)">
								<asp:ListItem Selected="True" Value="yyyy-MM-dd">���磺2010-01-27-372.html</asp:ListItem>
								<asp:ListItem Value="0">���磺372.html</asp:ListItem>
								<asp:ListItem Value="">���磺cca652ee_f166_4787_8cd5_19b37342e152.html</asp:ListItem>
								<asp:ListItem Value="custom">�Զ���</asp:ListItem>
							</asp:DropDownList>
							<div id="customUrl" style="display: none">
								<asp:TextBox ID="ArticleUrlGeneratorTextBox" runat="server" Columns="60"></asp:TextBox>
								<input id="Button1" type="button" value="��ΪĬ��ֵ" onclick="javascript:<%=ArticleUrlGeneratorTextBox.ClientID %>.value='yyyy-MM-dd';" />
								<br />
								����Url�����ɸ�ʽ������ˮ�š�ǰ��ɼ�ǰ׺������Ϊ��������ǰ׺��ʽy - �꣬M-�£�d-�գ� ��0Ϊ����Ҫǰ׺�������ȱʡΪ��GUID����
							</div>
						</td>
					</tr>
					<tr>
						<td align="right">
							��վ״̬��
						</td>
						<td>
							<asp:DropDownList ID="SiteStateDropDownList" runat="server">
								<asp:ListItem Value="debug">���ԣ�����Ա���ڵ��Կؼ�</asp:ListItem>
								<asp:ListItem Selected="True" Value="edit">���裺������Ա���ڽ�����վ��δ����</asp:ListItem>
								<asp:ListItem Value="run">���У���վ�ѿ�ͨ</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td align="right">
							����̵����кţ�
						</td>
						<td>
							<asp:TextBox ID="txtSN" runat="server" TextMode="MultiLine" Width="300px" Rows="1"></asp:TextBox>
						</td>
					</tr>
					<tr style="display: none">
						<td align="right">
							�����½ͬ����֤վ�㣺
							<br />
							(��ʽ��http://www.a.com;http://www.b.com)
						</td>
						<td>
							<asp:TextBox ID="txtSSOUrls" runat="server" TextMode="MultiLine" Rows="1" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							��̨�汾��Ϣ��
							<br />
							(�޸�ֻ��OEM����Ч)
						</td>
						<td>
							<asp:TextBox ID="txtCopyright" runat="server" TextMode="MultiLine" Rows="2" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							��վ������Ϣ
							<br />
							(�޸�ֻ��OEM����Ч)
						</td>
						<td>
							<asp:TextBox ID="txtIcpInfo" runat="server" TextMode="MultiLine" Rows="2" Columns="60" />
							<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtIcpInfo"
								ErrorMessage="����д��վ������Ϣ" Display="Dynamic" runat="server" />
						</td>
					</tr>
					<tr>
						<td align="right">
							��̨������Ϣ��
							<br />
							(�޸�ֻ��OEM����Ч)
						</td>
						<td>
							<asp:TextBox ID="txtLinks" runat="server" TextMode="MultiLine" Rows="2" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<%--<tr>
                        <td align="right">
                            ��̨������
                        </td>
                        <td>
                            &nbsp;<asp:DropDownList ID="ThemeDropDownList" runat="server">
                                <asp:ListItem Selected="True" Value="default">�ִ�</asp:ListItem>
                                <asp:ListItem Value="classic">����</asp:ListItem>
                                </asp:DropDownList></td>
                    </tr>--%>
				</table>
			</div>
			<div id="fragment-2">
				<table style="border: solid 0px #fff;">
					<tr>
						<td align="right">
							��վ��ҳ���⣺
						</td>
						<td>
							<asp:TextBox ID="HomePageTitleTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							��Ŀ����ҳ���⣺
						</td>
						<td>
							<asp:TextBox ID="ChannelPageTitleTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							����ҳ���⣺
						</td>
						<td>
							<asp:TextBox ID="ContentPageTitleTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							ҳ��ؼ���(keyword)��
						</td>
						<td>
							<asp:TextBox ID="KeywordPageMetaTextBox" runat="server" TextMode="MultiLine" Rows="5"
								Columns="48"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							ҳ������(description)��
						</td>
						<td>
							<asp:TextBox ID="DescriptionPageMetaTextBox" runat="server" TextMode="MultiLine"
								Rows="5" Columns="48"></asp:TextBox>
						</td>
					</tr>
				</table>
			</div>
			<div id="fragment-3">
				<table>
					<tr>
						<td align="right">
							������˺��Ƿ��Զ�������
						</td>
						<td>
							<asp:CheckBox ID="ArticleAutoPublish" runat="server" />
						</td>
					</tr>
					<tr>
						<td align="right">
							�����Ƿ��Զ�����ͬ����
						</td>
						<td>
							<asp:CheckBox ID="ArticleAutoShare" runat="server" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="color: Red; padding-left: 20px; padding-right: 200px">
							��ʼ��Ĭ�Ͻ�ɫ��������Ϊ�û�ע����ҵ��Ա��ע����˻�ԱʱĬ�ϵĽ�ɫ
						</td>
					</tr>
					<%--                    <tr>
                        <td align="right">
                            ��ʼ����ҵ��ԱĬ�Ͻ�ɫ��
                        </td>
                        <td>
                            <asp:DropDownList ID="CompanyDropDownList" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            ��ʼ�����˻�ԱĬ�Ͻ�ɫ��
                        </td>
                        <td>
                            <asp:DropDownList ID="PersonDropDownList" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>--%>
					<tr>
						<td align="right">
							������ԴĬ�ϣ�
						</td>
						<td>
							<asp:TextBox ID="ArticleSourceDefaultTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
				</table>
			</div>
			<div id="fragment-4">
				<table style="border: solid 0px #fff;">
					<tr>
						<td align="right">
							���������������
						</td>
						<td>
							<asp:TextBox ID="SysMailServerTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							���������������
						</td>
						<td>
							<asp:TextBox ID="SysPopServerTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							ϵͳ���䣺
						</td>
						<td>
							<asp:TextBox ID="SystemMailTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							�����û���
						</td>
						<td>
							<asp:TextBox ID="SySMailUserTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							�������룺
						</td>
						<td>
							<asp:TextBox ID="SysMailPassTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td align="right">
							����Ա��Ϣ֪ͨ���䣺
						</td>
						<td>
							<asp:TextBox ID="NotifyMailTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
				</table>
			</div>
			<div id="fragment-5">
				<table style="border: solid 0px #fff;">
					<tr>
						<td align="right">
							�û�ע����֤ģʽ��
						</td>
						<td>
							<asp:DropDownList ID="drpUserRegiseterMode" runat="server" DataTextField="Text" DataValueField="Value" />
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<asp:CheckBox ID="AllowSignupCheckBox" runat="server" />�����û�����ע���ʻ���
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<asp:CheckBox ID="AllCutCheckBox" runat="server" />�����û��ü�ͼƬ��
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<asp:CheckBox ID="IsHashedPasswordCheckBox" runat="server" Enabled="False" />����Ա�������
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<asp:CheckBox ID="IsAddLogCheckBox" runat="server" />������־��¼����
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<asp:CheckBox ID="IsAuditCommentCheckBox" runat="server" />վ��������˺󷢲�
						</td>
					</tr>
					<tr style="display: none;">
						<td align="right">
							ͳһ�û��������ͣ�
						</td>
						<td>
							<asp:TextBox ID="GenericUserManageTextBox" runat="server" Columns="60"></asp:TextBox>
						</td>
					</tr>
					<tr><!--style="display: none;"-->
						<td align="right">
							���վ���ַ��
						</td>
						<td>
							http://<asp:TextBox ID="ADUrlTextBox" runat="server" Columns="60"></asp:TextBox>
							<a href="javascript:showNotice(divADUrlTextBoxExp)">[?]</a>
							<br />
							<span id="divADUrlTextBoxExp" class="notice" style="display: none">�˴�����дվȺ���������վ��ַ��
							</span>
						</td>
					</tr>
                    <tr>
                        <td align="right">�Ƿ��ǹ����վ:</td>
                        <td>
                            <input type="checkbox" id="chkADVisbleToSite" runat="server"/>
                        </td>
                    </tr>
					<tr style="display: none;">
						<td align="right">
							��������ϵͳ��
						</td>
						<td>
							<input type="checkbox" id="EnableCache" checked="checked" runat="server" onclick="startCache();" />
							<asp:TextBox ID="CacheTimeSpanTextBox" runat="server" Text="60" Enabled="false"></asp:TextBox>��
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<asp:CheckBox ID="OnlyLoginUserCanVisitCheckBox" runat="server" />�������¼�û�������վ
						</td>
					</tr>
					<tr>
						<td align="right">
							����ģ���ͼ��
						</td>
						<td>
							<input type="checkbox" id="StartTemplateMapCheckbox" runat="server" />
						</td>
					</tr>
					<tr>
						<td align="right">
							��¼�Ƿ���Ҫ��֤��
						</td>
						<td>
							<asp:CheckBox ID="EnableLoginAuhenCodeCheckBox" runat="server" />
						</td>
					</tr>
					<tr>
						<td align="right">
							�������¾߱����ӹ�ϵ��
						</td>
						<td>
							<asp:CheckBox ID="AllowParentArticleCheckBox" runat="server" />
						</td>
					</tr>
					<tr style="display:none;">
						<td align="right">
							��������ģ�͵���洢��
						</td>
						<td>
							<asp:CheckBox ID="EnableSingleTable" runat="server" />
						</td>
					</tr>
					<tr>
						<td align="right">
							Ĭ��ģ��༭��ʹ�ÿ��ӻ��༭����
						</td>
						<td>
							<asp:CheckBox ID="UseVisualTemplateCheckBox" runat="server" />
						</td>
					</tr>
					<tr>
						<td align="right">
							����Html��̬����ģ�壺
						</td>
						<td>
							<asp:CheckBox ID="EnableHtmlTemplate" runat="server" />
						</td>
					</tr>
				</table>
			</div>
			<div id="fragment-6" style="min-height: 800px;">
				&nbsp;<uc1:System_image ID="System_image1" runat="server" />
			</div>
			<div id="fragment-7" style="min-height: 800px;">
				<iframe id="ipstrategy" width="500px" height="400px" frameborder="0" runat="server"
					src="SystemStrategy.aspx" scrolling="no"></iframe>
				<asp:HiddenField ID="hddnIPStrategy" runat="server" />
			</div>
		</div>
	</div>
	<div style="display: none">
		<asp:Button ID="SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click" />
		<asp:TextBox ID="DefaultTemplateGroupFileNameTextBox" runat="server"></asp:TextBox>
	</div>
	<script type="text/javascript">		$("#container-1 ul:eq(0) li").length == 7 ? $("#fragment-7").show() : $("#fragment-7").hide();</script>
</asp:Content>
