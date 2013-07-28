<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdviceModelSetting.aspx.cs" Inherits="We7.CMS.Web.Admin.AdviceModelSetting"
	MasterPageFile="~/admin/theme/classic/content.Master" ValidateRequest="false" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
     <asp:Panel runat="server" ID="ContentPanel">
         <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icon_settings.png" />
        反馈模型配置
        <span class="summary">
        </span>
    </h2>
     <div>
          <WEC:MessagePanel ID="Messages" runat="server">
          </WEC:MessagePanel>
     </div>
      <div> 
      <b>设置反馈模型查看权限：</b><br /><br />
        <asp:RadioButton ID="permissionType1" GroupName="permissionType" runat="server" />只允许查看本部门
        <br /><br />
         <asp:RadioButton ID="permissionType4" GroupName="permissionType" runat="server" />不限制
        <br /><br />
        <asp:Button ID="SaveButton" OnClick="SaveButton_Click" class="Btn" runat="server" Text="保存设置" /></div>
     </asp:Panel>
</asp:Content>
