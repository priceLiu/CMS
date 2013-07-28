<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelViewer.aspx.cs" MasterPageFile="~/User/DefaultMaster/content.Master"
    Inherits="We7.CMS.Web.User.ModelViewer" %>

<%@ Register Src="~/ModelUI/Panel/system/EditorPanel.ascx" TagName="EditorPanel"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyHeadPlaceHolder" runat="server">
    <link rel="stylesheet" type="text/css" href="/ModelUI/skin/default.css" media="screen" />
    <script src="/Admin/Ajax/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/Admin/Ajax/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <form id="mainForm" runat="server">
        <div class="realRight ml10">
            <div class="mybox">
               <uc1:EditorPanel ID="ucEditor" runat="server" PanelName="edit" />
            </div>
         </div>
       </div>
       <script type="text/javascript">
           $(document).ready(function () {
               $("input.Btn").each(function () {
                   $(this).remove();
               });
           });
       </script>
    </form>
</asp:Content>
