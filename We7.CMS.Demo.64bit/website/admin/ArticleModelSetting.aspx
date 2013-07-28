<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArticleModelSetting.aspx.cs" Inherits="We7.CMS.Web.Admin.ArticleModelSetting"
	MasterPageFile="~/admin/theme/classic/content.Master" ValidateRequest="false" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
     <asp:Panel runat="server" ID="ContentPanel">
        <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icon_settings.png" />
        信息模型配置
        <span class="summary">
        </span>
    </h2>
     <div>
          <WEC:MessagePanel ID="Messages" runat="server">
          </WEC:MessagePanel>
     </div>
      <div> 
      <b>设置信息模型查看权限：</b><br /><br />
        <asp:RadioButton ID="permissionType1" GroupName="permissionType" runat="server" />只允许查看本部门
        <br /><br />
         <asp:RadioButton ID="permissionType3"  GroupName="permissionType" runat="server" />只允许查看自己发布的信息
        <br /><br />
         <asp:RadioButton ID="permissionType4" GroupName="permissionType" runat="server" />不限制
        <br /><br />
        <asp:Button ID="SaveButton" OnClick="SaveButton_Click" class="Btn" runat="server" Text="保存设置" /></div>
     </asp:Panel>
</asp:Content>
