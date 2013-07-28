<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartmentDetail.aspx.cs"
    MasterPageFile="~/admin/theme/classic/content.Master" Inherits="We7.CMS.Web.Admin.DepartmentDetail" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<%@ Register Assembly="FCKeditor.net" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
<script type="text/javascript" src="/scripts/we7/we7.loader.js">
	$(document).ready(function () {
        we7("#<%=EmailTextBox.ClientID %>").validateRules({
			type:"email"
		});
         we7("#<%=SiteUrlTextBox.ClientID %>").validateRules({
			type:"url"
		});
         we7("#<%=PhoneTextBox.ClientID %>").validateRules({
			//pattern:"([0-9]{3,4}-[1-9]{1}[2-8]{6,7})|((13)|(15)|(18)[0-9]{9})"
		});
         we7("#<%=FaxTextBox.ClientID %>").validateRules({
			//pattern:"([0-9]{3,4}-[1-9]{1}[2-8]{6,7})|((13)|(15)|(18)[0-9]{9})"
			//pattern:"[+](\d)[ ]?([-]?((\d)|[ ]))+"
		});
		we7("#personalForm").attachValidator({
			inputEvent: 'blur',
            errorInputEvent:null
		});
	});    
</script>
<script language="JavaScript" type="text/javascript">
    $(document).ready(function () {
        $("#SaveButton").click(function () {
            var div = $("#personalForm");
            var enable = we7(div).validate();

            if (enable) {
                $("#<%=SaveButton.ClientID %>").click();
            } else {
                we7.status('���������Ϣ��д������Ҫ���밴��ʾ��������');
            }
        });
        
        if (window.parent.SetIFrame)
            window.parent.SetIFrame(this.body.scrollWidth, document.getElementById("breadcrumb").scrollHeight);
    });
</script>
    <asp:Panel runat="Server" ID="ContentPanel">
        <div id="breadcrumb" >
            <h2 class="title">
                <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_user.gif" />
                <asp:Label ID="DepartmentNameLabel" runat="server" Text="New Department">
                </asp:Label>
            </h2>
            <div class="toolbar">
                <asp:HyperLink ID="ReturnHyperLink" runat="server" NavigateUrl="" style="display:none">
                                    ����</asp:HyperLink>
            </div>
            <div>
                <WEC:MessagePanel ID="Messages" runat="server">
                </WEC:MessagePanel>
            </div>
            <div>
                <table class="personalForm" id="personalForm">
                    <tr>
                        <td style="text-align: right">
                            �������ţ�
                        </td>
                        <td>
                            <asp:Label ID="FullPathLabel" runat="server" Text="">
                            </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ���ƣ�
                        </td>
                        <td>
                            <asp:TextBox ID="NameTextBox" runat="server" Columns="50" MaxLength="128" required="required"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ��飺
                        </td>
                        <td>
                            <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Rows="4"
                                Columns="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ��λ��ţ�
                        </td>
                        <td>
                            <asp:TextBox ID="NumberTextBox" runat="server" Columns="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ��λ��ַ��
                        </td>
                        <td>
                            <asp:TextBox ID="AddressTextBox" runat="server" Columns="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ��ϵ�绰��
                        </td>
                        <td>
                            <asp:TextBox ID="PhoneTextBox" runat="server" Columns="50" errmsg="��������ȷ����ϵ�绰"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ���棺
                        </td>
                        <td>
                            <asp:TextBox ID="FaxTextBox" runat="server" Columns="50" errmsg="��������ȷ�Ĵ���"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            �������䣺
                        </td>
                        <td>
                            <asp:TextBox ID="EmailTextBox" runat="server" Columns="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ��ͼλ�ñ�Ǵ��룺
                        </td>
                        <td>
                            <asp:TextBox ID="MapScriptTextBox" runat="server" TextMode="MultiLine" Rows="4" Columns="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ����վ����ַ��
                        </td>
                        <td>
                            <asp:TextBox ID="SiteUrlTextBox" runat="server" Columns="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ��ţ�
                        </td>
                        <td>
                            <asp:TextBox ID="IndexTextBox" runat="server" Text="0" Columns="5" MaxLength="4" min="0"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-left: 25px">
                            <ul>
                                ����ְ��������
                                <div runat="server" id="BodyDiv">
                                    <FCKeditorV2:FCKeditor ID="ContentTextBox" EnableSourceXHTML="true" EnableXHTML="true"
                                        HtmlEncodeOutput="false" runat="server" Height="300px" Width="545px" BasePath="/admin/fckeditor/">
                                    </FCKeditorV2:FCKeditor>
                                    <div class="editorFooter inputWidth">
                                    </div>
                                </div>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ID:
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            ����ʱ�䣺
                        </td>
                        <td>
                            <asp:Label ID="CreatedLabel" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 39px">
                        </td>
                        <td style="padding-top: 15px; padding-left: 0px; height: 39px">
                            <input class="button" id="SaveButton" type="button" value="����" />
                            <input class="button" id="DeleteButtun" runat="server" type="submit" value="ɾ���˲���">
                        </td>
                    </tr>
                </table>
            </div>
            <div style="display: none">
            <asp:Button ID="SaveButton" CssClass="button" runat="server" Text="����" OnClick="SaveButton_Click" />
                <asp:TextBox ID="ParentTextBox" runat="server" Text="0"></asp:TextBox>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
