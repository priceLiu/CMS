<%@ Page Language="C#" AutoEventWireup="true" Codebehind="TemplateUpload.aspx.cs"
    Inherits="We7.CMS.Web.Admin.TemplateUpload" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
<script type="text/javascript">
 function ItemSave()
        {
            var ItemSaveBtn=document.getElementById("<%=UploadButton.ClientID%>");
            ItemSaveBtn.click();
        }

        function ItemSaveButton() {
            var ItemSaveBtn = document.getElementById("<%=SaveButton.ClientID%>");
            ItemSaveBtn.click();
        }
             </script>
                           <h2 class="title">
                            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_look.gif" />
                            <span>�ϴ�ģ��</span>
                        </h2>
                        <div class="toolbar">
                            <asp:HyperLink ID="BackHyperLink" NavigateUrl="TemplateGroups.aspx" runat="server">
                                <asp:Image ID="BackImage" runat="server" ImageUrl="~/admin/Images/icon_prev.gif" />
                                ����</asp:HyperLink>
                        </div>
                        <asp:Panel runat="server" ID="UploadPanel">
                            <div>
                                <h4>
                                    ��һ��: ѡ��һ��ģ�����ݰ���</h4>
                                <asp:FileUpload ID="DataControlFileUpload" runat="server" Style="width: 300px" />
                                <br />
                                <span>����� </span>
                                    <asp:HyperLink ID="DeleteHyperLink" runat="server" NavigateUrl="javascript:ItemSave();">
                                    <asp:Image ID="DeleteImage" runat="server" ImageUrl="~/admin/Images/icon_fx.jpg" />
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
                                        <asp:BoundField DataField="Name" DataFormatString="{0}" HeaderText="����" />
                                        <asp:BoundField DataField="Description" DataFormatString="{0}" HeaderText="����" />
                                        <asp:BoundField DataField="FileName" HeaderText="�ļ�" />
                                        <asp:BoundField DataField="Created" HeaderText="��������" />
                                    </Columns>
                                </asp:GridView>
                                <span>�����</span>
                                <asp:HyperLink ID="SaveHyperLink" runat="server" NavigateUrl="javascript:ItemSaveButton();">
                                    <asp:Image ID="SaveImage" runat="server" ImageUrl="~/admin/Images/icon_save.gif" />
                                    ����</asp:HyperLink>
                                <span>���������ݿؼ���</span>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="DonePanel">
                        <div>
                        <h4>
                        <asp:Label ID="DoneLabel" runat="server" Text=""></asp:Label></h4>
                        <asp:HyperLink ID="MakeTPGHyperLink" runat="server" NavigateUrl="~/admin/TemplateGroups.aspx" Visible="false" Target="_blank">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/admin/Images/logo_setting.jpg" />
                                    ��������</asp:HyperLink>
                                    
                                   </div> 
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
