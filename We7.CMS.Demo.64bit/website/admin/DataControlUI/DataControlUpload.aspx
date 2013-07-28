<%@ Page Language="C#" AutoEventWireup="true" Codebehind="DataControlUpload.aspx.cs"
    Inherits="We7.CMS.Web.Admin.DataControlUpload" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">

                        <h2>
                            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icon_attach.gif" />
                            <span>�ϴ����ݿؼ�</span>
                        </h2>
                        <div class="toolbar">
                            <asp:HyperLink ID="BackHyperLink" NavigateUrl="DataControls.aspx" runat="server">
                                <asp:Image ID="BackImage" runat="server" ImageUrl="~/admin/Images/icon_cancel.gif" />
                                ����</asp:HyperLink>
                        </div>
                        <asp:Panel runat="server" ID="UploadPanel">
                            <div>
                                <h4>
                                    ��һ��: ѡ��һ���ؼ����ݰ���</h4>
                                <asp:FileUpload ID="DataControlFileUpload" runat="server" Style="width: 300px" />
                                <br />
                                <span>����� </span>
                                <asp:HyperLink ID="DeleteHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.UploadButton.click();">
                                    <asp:Image ID="DeleteImage" runat="server" ImageUrl="~/admin/Images/icon_attach.gif" />
                                    ��������</asp:HyperLink>
                                <span>����ʼ���д��� </span>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="ReviewPanel" Visible="false">
                            <div>
                                <h4>
                                    �ڶ�����ȷ�Ͽؼ�������Ϣ</h4>
                                <asp:GridView ID="DataControlsGridView" runat="server" AutoGenerateColumns="False"
                                    ShowFooter="True">
                                    <Columns>
                                        <asp:BoundField DataField="Name" HeaderText="����" />
                                        <asp:BoundField DataField="Description" HeaderText="����" />
                                        <asp:BoundField DataField="FileName" HeaderText="�ļ�" />
                                        <asp:BoundField DataField="Author" HeaderText="����" />
                                        <asp:BoundField DataField="Created" HeaderText="����ʱ��" />
                                    </Columns>
                                </asp:GridView>
                                <span>�����</span>
                                <asp:HyperLink ID="SaveHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.SaveButton.click();">
                                    <asp:Image ID="SaveImage" runat="server" ImageUrl="~/admin/Images/icon_save.gif" />
                                    ����</asp:HyperLink>
                                <span>���������ݿؼ���</span>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="DonePanel">
                        </asp:Panel>
                        <div style="display: none">
                            <asp:Button ID="UploadButton" runat="server" Text="Upload" OnClick="UploadButton_Click" />
                            <asp:Button ID="SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click" />
                        </div>
                    <asp:Panel ID="MessagePanel" runat="server" Visible="false">
                        <asp:Image ID="MessageImage" runat="server" ImageUrl="~/admin/Images/icon_warning.gif" />
                        <asp:Label ID="MessageLabel" runat="server" Text="Ready to process."></asp:Label>
                    </asp:Panel>
</asp:Content>
