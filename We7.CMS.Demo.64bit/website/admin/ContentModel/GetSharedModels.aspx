<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/theme/classic/content.Master"
    AutoEventWireup="true" CodeBehind="GetSharedModels.aspx.cs" Inherits="We7.CMS.Web.Admin.ContentModel.GetSharedModels" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <style type="text/css">
        .popu
        {
            list-style-type: none;
            z-index: 500;
            position: absolute;
            width: 100px;
            background-color: White;
            border: solid 1px;
            display: none;
        }
        .popu a:hover
        {
            background-color: #3399FF;
            color: #FFFFFF;
        }
        .popu li
        {
            display: block;
            padding-left: 2px;
            padding-top: 2px;
        }
        a.headlink
        {
            width: 70px;
            text-align: left;
            display: block;
            cursor: pointer;
        }
        a.headlink:hover
        {
            background: none repeat scroll 0 0 #6CC8EF;
            cursor: pointer;
            color: Green;
        }
    </style>
    <script type="text/javascript" src="/scripts/we7/we7.loader.js">
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
                function Update(){
                    var button = document.getElementById("<%=UpdateButton.ClientID %>");
                    button.click();
                }
                function ReCreateModelIndex(){
                     var button = document.getElementById("<%=ReCreateModelIndexButton.ClientID %>");
                    button.click();
                }
                function UpdateWiget(){
                     var button = document.getElementById("<%=UpdateWigetButton.ClientID %>");
                    button.click();
                }
                function ReCreateWidgetIndexHyperLink(){
                     var button = document.getElementById("<%=ReCreateWidgetIndexButton.ClientID %>");
                    button.click();
                }
        </script>
    <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icon_settings.png" />
       管理外站信息模型
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="可以获取、更新外站信息模型">
            </asp:Label>
        </span>
    </h2>
    <WEC:MessagePanel ID="Msg" runat="server" Width="900px">

    </WEC:MessagePanel>
     <div class="toolbar">
        <asp:HyperLink ID="UpdateHyperLink" NavigateUrl="javascript:Update();" runat="server">更新模型</asp:HyperLink>
        <asp:HyperLink ID="UpdateWigetHyperLink" NavigateUrl="javascript:UpdateWiget();" runat="server">更新部件</asp:HyperLink>
        <asp:HyperLink ID="ReCreateModelIndexHyperLink" NavigateUrl="javascript:ReCreateModelIndex();" runat="server">重建模型索引</asp:HyperLink>
        <asp:HyperLink ID="ReCreateWidgetIndexHyperLink" NavigateUrl="javascript:ReCreateWidgetIndexHyperLink();" runat="server">重建部件索引</asp:HyperLink>
        <asp:HyperLink ID="RefreshHyperLink" NavigateUrl="javascript:window.location=window.location;" runat="server">
                刷新</asp:HyperLink>
   </div>
<div class="list">
        <asp:GridView ID="ContentModelExGridView" runat="server" AutoGenerateColumns="False" Width="90%">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkHeader" runat="server" onclick="javascript:SelectAll(this);"
                            AutoPostBack="false" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox Checked="false" ID="chkItem" runat="server"/>
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("SiteID") %>' Visible="False"></asp:Label>
                        <asp:Label ID="lblmodelname" runat="server" Text='<%# Eval("Name") %>' Visible="False"></asp:Label>
                        <asp:Label ID="lblSiteUrl" runat="server" Text='<%# Eval("SiteUrl") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="40px" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        名称
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%# Eval("ModelName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        站点
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%# Eval("SiteName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        更新时间
                    </HeaderTemplate>
                    <ItemTemplate>
                          <%# Eval("Updated").ToString()%>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField>
                    <HeaderTemplate>
                        同步状态
                    </HeaderTemplate>
                    <ItemTemplate>
                          <%# Eval("Status").ToString()%>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField>
                    <HeaderTemplate>
                        操作
                    </HeaderTemplate>
                    <ItemTemplate>
                        <a href="/admin/manage/AddMenu.aspx?modelname=<%# Eval("SiteID") %>.<%# Eval("Name") %>" target="_self">
                            添加到左边菜单</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
         </asp:GridView>
      </div>
      <div style="display: none">
        <asp:Button ID="UpdateButton" runat="server" Text="Stop" OnClick="UpdateButton_Click" />
        <asp:Button ID="UpdateWigetButton" runat="server" Text="Stop" OnClick="UpdateWigetButton_Click" />
        <asp:Button ID="ReCreateModelIndexButton" runat="server" Text="Stop" OnClick="ReCreateModelIndexButton_Click" />
        <asp:Button ID="ReCreateWidgetIndexButton" runat="server" Text="Stop" OnClick="ReCreateWidgetIndexButton_Click" />
    </div>
</asp:Content>

