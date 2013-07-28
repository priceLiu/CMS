<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplateCreate.aspx.cs"
    MasterPageFile="~/admin/theme/ContentNoMenu.Master" Inherits="We7.CMS.Web.Admin.TemplateCreate" %>

<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
     <style type="text/css">
         .styleName
         {
         	 height:22px;
             width: 100px;
             text-align:right;
         }
         .styleText
         {
         	height:22px;
         	text-align:left;
         }
     </style>     
<script type="text/javascript" src="/scripts/we7/we7.loader.js">
	$(document).ready(function () {
		we7('.tipit').tip();
		we7('span[rel=xml-hint]').help();
		we7("#form-region").attachValidator({
			inputEvent: 'blur',
            ajaxOnSoft:true,
            errorInputEvent:null
		});
        we7("#<%= FileNameTextBox.ClientID%>").attachValidator().validateAjax({
            url:function(){
                return "WidgetAjaxService.ashx?action=checktempexist&file="+getFileVal();
                },
            callback:function(json,textStatus){
                if(json.Message=="")
                    return true;                
                else
                    return json.Message;
            },
            error:function(data,textStatus){
                return "������æ";
            }
            });
	});    
</script>
<script type="text/javascript">
    function onSaveButtonClick() {
        var submitBtn = document.getElementById("<%=SaveButton.ClientID %>");
        var div = $("#form-region");
        var enable = we7(div).validate();
        if (enable) {
            submitBtn.click();
        }
    }
    function getFileVal() {
        return $("#<%= FileNameTextBox.ClientID%>").val();
    }
</script>
<center>
<table cellpadding="0" cellspacing="0" border="0" style="width:300px;height:100%; margin-top:80px; border:solid 10px #f0f0f0"   >
<tr><td valign="middle" >
    <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_look.gif" />
        <asp:Label ID="TitleLabel" runat="server" Text="������ģ��">
        </asp:Label>
        <span class="summary" >
          <asp:Label ID="SummaryLabel" runat="server" Text="�������������ӻ�ģ��">
            </asp:Label></span>

        <ul style="font-size:16px; margin-top:20px; padding-left:30px;" >
            <span style="color:Red">��ģ�������Ϣ</span>  ��ѡ��ģ�岼��   �ۿ�ʼ�������ģ��
        </ul>
    </h2>
    <div>
        <table width="500px" id="form-region">
            <tr>
                <td class="styleName">
                    ���ƣ�
                </td>
                <td class="styleText">
                    <asp:TextBox ID="NameTextBox" runat="server"  Columns="50" Width="120px" required="required"></asp:TextBox>
                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="ģ�����Ʋ���Ϊ�ա�" ControlToValidate="NameTextBox"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="styleName">
                    �ļ�����
                </td>
                <td class="styleText">
                    <asp:TextBox ID="FileNameTextBox" runat="server" Columns="50" Width="120px" Text="�������ļ���" required="required" />
                    .ascx
                </td>
            </tr>
             <tr>
                <td class="styleName">
                    ������
                </td>
                <td class="styleText">
                    <asp:TextBox ID="DescriptionTextBox" runat="server" Columns="40" Rows="5" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
            <td style="height:50px; padding-left:20px" colspan="2">
             <WEC:MessagePanel ID="Messages" runat="server">
    </WEC:MessagePanel>
            </td>
            </tr>
             <tr>
            <td  >
            </td>
            <td >
             <div class="toolbar"><asp:HyperLink ID="SaveHyperLink" NavigateUrl="javascript:onSaveButtonClick();" runat="server">
         ����</asp:HyperLink></div>
            </td>
            </tr>
        </table>
                
    </div>
    <div style="display: none">
        <asp:Button ID="SaveButton" runat="server" OnClick="SaveButton_Click"  />
    </div>

   </td></tr>
   </table>
   </center>
</asp:Content>
