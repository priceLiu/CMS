<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplateGroupDetail.aspx.cs"
    Inherits="We7.CMS.Web.Admin.TemplateGroupDetail" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls"
    TagPrefix="WEC" %>
<asp:content id="We7Content" contentplaceholderid="MyContentPlaceHolder" runat="server">
    <script src="<%=AppPath%>/cgi-bin/DialogHelper.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="<%=AppPath%>/ajax/jquery/css/ui.tabs.css" media="all" />
    <script src="<%=AppPath%>/ajax/jquery/jquery-1.2.3.pack.js" type="text/javascript"></script>
    <script src="<%=AppPath%>/ajax/jquery/ui.tabs.pack.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $('#container-1 > ul').tabs();
        });
    </script>

    <script type="text/javascript">
        function doDeleteItem(fa, isd) {
            if (confirm("��ȷ��Ҫɾ��ģ�� " + fa + " ��")) {
                document.getElementById("<%=DeleteItemAliasTextBox.ClientID %>").value = fa;
                document.getElementById("<%=DeleteItemIsDetailTextBox.ClientID %>").value = isd;
                document.getElementById("<%=DeleteItemButton.ClientID %>").click();
            }
        }

        function doDeleteFile(fa) {
            if (confirm("��ȷ��Ҫɾ��ģ���ļ� " + fa + " ��")) {
                document.getElementById("<%=FileTextBox.ClientID %>").value = fa;
                document.getElementById("<%=DeleteFileButton.ClientID %>").click();
            }
        }

        function onSaveButtonClick() {
            document.getElementById("<%=SaveButton.ClientID %>").click();
        }
        function importTemplate() {

            weShowModelDialog("/admin/Folder.aspx?folder=<%=path %>", null);
        }
    </script>

                       <h2   class="title">
                            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_look.gif" />
                            <asp:Label ID="NameLabel" runat="server" Text="">
                            </asp:Label>
                            <span class="summary">
                                <asp:Label ID="SummaryLabel" runat="server" Text="">
                                </asp:Label>
                            </span>
                        </h2>
                        <div class="toolbar">
                        <li  class="smallButton4">
                            <asp:HyperLink ID="SaveHyperLink" runat="server" NavigateUrl="javascript:onSaveButtonClick();">
                                ����</asp:HyperLink></li>
                        <li  class="smallButton4">
                            <asp:HyperLink ID="NewHyperLink" NavigateUrl="TemplateDetail.aspx" runat="server">
                                �½�ģ��</asp:HyperLink></li>
                         <li  class="smallButton8">
                           <a href="javascript:;" onclick="importTemplate();">ģ���ļ�Ŀ¼</a>
                          <li  class="smallButton4">
                            <asp:HyperLink ID="ReturnHyperLink" runat="server" NavigateUrl="TemplateGroups.aspx">
                                ����</asp:HyperLink></li>
                        </div>
                        <br />
                        <div>
                            <div id="container-1">
                                <ul>
                                    <li><a href="#fragment-1"><span>��ϸ��Ϣ</span></a></li>
                                    <li><a href="#fragment-2" id="fragmentTwo" runat="server"><span>ģ���ļ��б�</span></a></li>
                                    <li><a href="#fragment-3" id="fragmentThree" runat="server"><span>ģ���б�</span></a></li>
                                </ul>
                                <div id="fragment-1">
                                    <div>
                                        <table>
                                            <tr>
                                                <th style="width: 20%">
                                                    ��Ŀ</th>
                                                <th style="width: 443px">
                                                    ����</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    ���ƣ�</td>
                                                <td style="width: 443px">
                                                    <asp:TextBox ID="NameTextBox" runat="server" Text="" Columns="50" MaxLength="64"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                                                        ErrorMessage="����ָ�����ƣ�" ValidationGroup="Detail" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server"
                                                        Display="Dynamic" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z0-9_-\u4e00-\u9fa5]+$"
                                                        ControlToValidate="NameTextBox" ValidationGroup="Detail">��������ƷǷ�</asp:RegularExpressionValidator><br />
                                                    &nbsp;<asp:Image ID="TNameImage" runat="server" ImageUrl="~/admin/Images/icon_warning.gif"
                                                        Visible="false" />
                                                    <asp:Label ID="TNameLabel" runat="server" Text="" Style="position: relative" Width="162px"
                                                        Visible="False" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    <span class="note">ģ��������ֻ��ΪӢ����ĸ���ֺ��»��ߣ�һ�����潫�����ٸ��ġ� </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <tr>
                                                    <td>
                                                        ������</td>
                                                    <td style="width: 443px">
                                                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text="" TextMode="MultiLine"
                                                            Columns="40" Rows="5"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        ���ڣ�</td>
                                                    <td style="width: 443px">
                                                        <asp:Label ID="CreatedLabel" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        �ϴ�Ԥ��ͼ��</td>
                                                    <td style="width: 443px">
                                                        <asp:FileUpload ID="PreviewFileUploador" runat="server" Style="position: relative" />
                                                        <asp:Panel ID="MessagePanel" runat="server" Style="position: relative" Visible="false">
                                                            <asp:Image ID="MessageImage" runat="server" ImageUrl="~/admin/Images/icon_warning.gif" />
                                                            <asp:Label ID="MessageLabel" runat="server" Text="Ԥ��Ч��ͼƬ�ĸ�ʽΪjpg�ļ�."></asp:Label>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                        </table>
                                    </div>
                                </div>
                                <div id="fragment-2">
                                    <div>
                                        <h3>
                                            <span class="summary">
                                                <asp:Label ID="TempldatesLabel" runat="server" Text="">
                                                </asp:Label>
                                            </span>
                                        </h3>
                                        <asp:GridView ID="TempldatesGridView" runat="server" AutoGenerateColumns="False"
                                            ShowFooter="True">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        ����
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="NameHyperLink" runat="server" NavigateUrl='<%# GetUrlByTpName(Eval("FileName").ToString())%>'
                                                            Text='<%# Eval("Name", "{0}") %>' ToolTip="����޸�ģ����ϸ��Ϣ"></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        �ļ�
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="EditAscxHyperLink" runat="server" NavigateUrl='<%# GetEditUrl(Eval("FileName").ToString())%>'
                                                            ToolTip="����޸�ģ���ļ�" Target="_blank" Text='<%# Eval("FileName", "{0}") %>'></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="IsSubTemplateText" HeaderText="ģ������" />
                                                <asp:BoundField DataField="Created" HeaderText="��������" />
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        ɾ��ģ���ļ�
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="DeleteHyperLink" runat="server" NavigateUrl='<%# GeDeletetUrlByTpName(Eval("FileName").ToString())%>'
                                                            Target="_blank" Text="ɾ��"></asp:HyperLink>
                                                    </ItemTemplate>
                                                     <ItemTemplate>
                                                        <a href="javascript:doDeleteFile('<%#DataBinder.Eval(Container.DataItem, "FileName") %>');">
                                                            <asp:Image ID="DeleteImage" runat="server" ImageUrl="~/admin/Images/icon_delete.gif" />ɾ��
                                                        </a>
                                                    </ItemTemplate> 
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                                <div id="fragment-3">
                                    <div>
                                        <h3>
                                            <span class="summary">
                                                <asp:Label ID="DetailLabel" runat="server" Text="">
                                                </asp:Label>
                                            </span>
                                        </h3>
                                        <asp:GridView ID="DetailGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True">
                                            <Columns>
                                                <asp:BoundField DataField="Alias" HeaderText="����">
                                                    <HeaderStyle />
                                                </asp:BoundField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        ����
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="NameHyperLink" runat="server" NavigateUrl='<%# GetUrl(Eval("Alias").ToString(),Eval("IsDetailTemplate").ToString(),Eval("Template").ToString())%>'
                                                            Target="_blank" Text='<%# GetTemplateNamel(Eval("Template").ToString())%>' ToolTip="����޸�ģ����ϸ��Ϣ"></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        �ļ�
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="EditAscxHyperLink" runat="server" NavigateUrl='<%# GetEditUrl(Eval("Template").ToString())%>'
                                                            ToolTip="����޸�ģ���ļ�" Target="_blank" Text='<%# Eval("Template", "{0}") %>'></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField>
                                                    <HeaderTemplate>
                                                       �Ƿ���ϸģ��
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <%#GetIsDetailText((bool)DataBinder.Eval(Container.DataItem, "IsDetailTemplate"))%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        ɾ��ģ��
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <a href="javascript:doDeleteItem('<%#DataBinder.Eval(Container.DataItem, "Alias") %>','<%#DataBinder.Eval(Container.DataItem, "IsDetailTemplate") %>');">
                                                            <asp:Image ID="DeleteImage" runat="server" ImageUrl="~/admin/Images/icon_delete.gif" />ɾ��
                                                        </a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                            <WEC:MessagePanel ID="Messages" runat="server" Visible="false">
                            </WEC:MessagePanel>
                        </div>
                        <div style="display: none">
                            <asp:TextBox ID="FileTextBox" runat="server"></asp:TextBox>
                            <asp:TextBox ID="TemplateTextBox" runat="server"></asp:TextBox>
                            <asp:TextBox ID="DetailTemplateTextBox" runat="server"></asp:TextBox>
                            <asp:Button ID="SaveButton" runat="server" OnClick="SaveButton_Click" ValidationGroup="Detail" />
                            <asp:Button ID="DeleteItemButton" runat="server" OnClick="DeleteItemButton_Click"  />
                            <asp:Button ID="DeleteFileButton" runat="server" OnClick="DeleteFileButton_Click"  /> 
                            <asp:TextBox ID="DeleteItemAliasTextBox" runat="server" />
                            <asp:TextBox ID="DeleteItemIsDetailTextBox" runat="server" />
                        </div>
</asp:content>
