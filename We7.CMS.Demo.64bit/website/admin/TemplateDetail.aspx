<%@ Page Language="C#" AutoEventWireup="true" Codebehind="TemplateDetail.aspx.cs"
    Inherits="We7.CMS.Web.Admin.TemplateDetail" %>
<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <script type="text/javascript"> 
function onSelectAliasHyperLinkClick() 
{
    var title="ģʽ����";
     var nWidth="650";
     var nHeight="480";
     var strFile="TagsList.aspx";
     var ret = window.showModalDialog(strFile,window,"dialogWidth:" + nWidth + "px;dialogHeight:" + nHeight + "px;center:yes;status:no;scroll:auto;help:no;");
     if (ret != null) {
             var arry = new Array();
             arry = ret.split(",");//һ�㷵��һ���ַ������ö��ŷָ�
             document.all["<%= AliasWordsTextBox.ClientID%>"].value = arry[0];
            //document.all["AliasLabel"].innerText = arry[1];
             document.all["<%= AliasTextBox.ClientID%>"].innerText = arry[0]; 
      } 
}

function onCancelAliasHyperLinkClick() 
{
    document.all["<%= AliasWordsTextBox.ClientID%>"].value = "";
    document.all["<%= AliasTextBox.ClientID%>"].innerText = "";
} 

function onSaveButtonClick() {
    document.getElementById("<%=SaveButton.ClientID %>").click();
}
    </script>

                        <h2 class="title">
                            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_look.gif" />
                            <asp:Label ID="TitleLabel" runat="server" Text="��ģ��">
                            </asp:Label>
                            <span class="summary">
                                <asp:Label ID="SummaryLabel" runat="server" Text="����һ����ģ��">
                                </asp:Label>
                            </span>
                        </h2>
                        <div class="toolbar">
                            <asp:HyperLink ID="SaveHyperLink" NavigateUrl="javascript:onSaveButtonClick();"   runat="server">
                                ����</asp:HyperLink>
                            <asp:HyperLink ID="ComposeHyperLink" NavigateUrl="Compose.aspx" runat="server" Target="_blank">
                                ģ��༭</asp:HyperLink>
                            <asp:HyperLink ID="ReturnHyperLink" NavigateUrl="Templates.aspx" runat="server">
                            ����</asp:HyperLink>
                            <br />
                        </div>
                        <div>
                            <table>
                                <tr>
                                    <th style="width: 20%">
                                        ��Ŀ</th>
                                    <th>
                                        ֵ</th>
                                </tr>
                                <tr>
                                    <td>
                                        ���ƣ�</td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" Columns="50"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        ������</td>
                                    <td>
                                        <asp:TextBox ID="DescriptionTextBox" runat="server" Columns="40" Rows="5" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 22px">
                                        �ļ�����</td>
                                    <td style="height: 22px">
                                        <asp:TextBox ID="FileNameTextBox" runat="server" Columns="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ���ͣ�</td>
                                    <td>
                                        <asp:DropDownList ID="TypeList" runat="server" OnSelectedIndexChanged="TypeList_SelectedIndexChanged"
                                            AutoPostBack="true">
                                            <asp:ListItem Value="False">��ͨģ��</asp:ListItem>
                                            <asp:ListItem Value="True">��ģ��</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ����ʱ�䣺</td>
                                    <td>
                                        <asp:Label ID="CreatedLabel" runat="server" BorderStyle="None"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="CodeDropDownList" runat="server" Visible="False">
                                            <asp:ListItem Selected="True" Value="False">HTML���ӻ��༭��</asp:ListItem>
                                            <asp:ListItem Value="True">������༭��</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <asp:Panel ID="AliasPanel" runat="server">
                                    <tr>
                                        <td>
                                            ������
                                        </td>
                                        <td>
                                            <asp:TextBox ID="AliasTextBox" runat="server" Columns="20" ReadOnly="True"></asp:TextBox>
                                            <span></span>
                                            <asp:HyperLink ID="CancelAliasHyperLink" NavigateUrl="javascript:onCancelAliasHyperLinkClick()"
                                                runat="server">
                                                <asp:Image ID="CancelAliasImage" runat="server" ImageUrl="~/admin/Images/icon_cancel.gif" />
                                                ȡ��</asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="TemplatesTagDropDownList" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="TemplatesTagDropDownList_SelectedIndexChanged">
                                                <asp:ListItem Value="">--ѡ��ϵͳ����--</asp:ListItem>
                                                <asp:ListItem Value="[homepage]">��ҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[channel]">��Ŀҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[contentpage]">��ϸ��Ϣҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[search]">�������ҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[login]">��¼ҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[error]">���󱨸�ҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[forgetPassword]">��������ҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[productcontentpage]">��Ʒ��ϸҳģ��</asp:ListItem>
                                                <asp:ListItem Value="[ContentMode]">����ģ����ϸҳģ��</asp:ListItem>
                                                      <asp:ListItem Value="[AdviceMode]">����ģ����ϸҳģ��</asp:ListItem>
                                                 <asp:ListItem Value="[sesearch]">վȺ�������ҳģ��</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:HyperLink ID="SelectAliasHyperLink" NavigateUrl="javascript:onSelectAliasHyperLinkClick();"
                                                runat="server">
                                                <asp:Image ID="SelectAliasImage" runat="server" ImageUrl="~/admin/Images/icon_jtem.gif" />
                                                �ӱ����ֵ�ѡ��
                                            </asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            <span class="note">ϵͳ������ϵͳ��ҳ����෽ʽ��</span>
                                        </td>
                                    </tr>
                                     <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    <span class="note">�����ֵ���վ���Դ���ģ����෽ʽ,�ɴ��ֵ���ѡ���������Ŀ���������</span>
                                                </td>
                                            </tr> 
                                    <tr>
                                        <td>
                                            �Ƿ���ϸģ�壺
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="IsDetailTemplateDropDownList" runat="server" OnSelectedIndexChanged="IsDetailTemplateDropDownList_SelectedIndexChanged">
                                                <asp:ListItem Value="False">��</asp:ListItem>
                                                <asp:ListItem Value="True">��</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    <span class="note">��ϸģ����ָ����ҳ����ϸ��Ϣ��ҳ�� </span>
                                                </td>
                                            </tr> 
                                </asp:Panel>
                            </table>
                        </div>
                       <WEC:MessagePanel ID="Messages" runat="server" Visible="false">
                        </WEC:MessagePanel>
                        <div style="display: none">
                            <asp:Button ID="SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click" />
                            <asp:TextBox ID="OldFileTextBox" runat="server"></asp:TextBox>
                            <asp:TextBox ID="AliasWordsTextBox" runat="server"></asp:TextBox>
                            <asp:TextBox ID="DeleteItemAliasTextBox" runat="server" />
                            <asp:TextBox ID="DeleteItemIsDetailTextBox" runat="server" />
                             <asp:TextBox ID="FileDetailTextBox" runat="server" />
                        </div>
</asp:Content>
