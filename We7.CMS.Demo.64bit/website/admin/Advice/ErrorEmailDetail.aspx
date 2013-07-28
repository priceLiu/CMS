<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorEmailDetail.aspx.cs"
    Inherits="We7.CMS.Web.Admin.ErrorEmailDetail" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<%@ Register Assembly="FCKeditor.net" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:content id="We7Content" contentplaceholderid="MyContentPlaceHolder" runat="server">

<script type="text/javascript">
    function AdviceClick() {
        var title = document.getElementById("<%=TitleTextBox.ClientID %>");
        var url = "/admin/Advice/ErrorEmailReplyAdvice.aspx?title=" + title.value;
        weShowModelDialog(url, onChannelListCallback);
    }
    function onChannelListCallback(v) {
    
        var title = document.getElementById("<%=AdviceIDTextBox.ClientID %>");
        title.value = v;
        var adviceBtn = document.getElementById("<%=AdviceBtn.ClientID %>");
        adviceBtn.click();
    }

    function AdviceCreateClick() {
        var adviceBtn = document.getElementById("<%=AdviceBtnCreate.ClientID %>");
        adviceBtn.click();
    }
    </script>
  <h2 class="title">                  
      <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_comment.gif" />
      <asp:Label ID="NameLabel" runat="server" Text="ϵͳδ���Զ������ʼ���ϸ��Ϣ">
      </asp:Label>
      <span class="summary">
          <asp:Label ID="SummaryLabel" runat="server" Text="">
          </asp:Label>
      </span>
  </h2>
      <div id="position">
        <asp:Literal ID="PagePathLiteral" runat="server"></asp:Literal>
    </div>
    <br />
        <div class="toolbar">
        <li class="smallButton8">
            <asp:HyperLink ID="AdviceHyperLink" NavigateUrl="javascript:AdviceClick();"
                runat="server">ָ����������Ϣ...
            </asp:HyperLink>
            </li>
            <li> &nbsp;&nbsp;|&nbsp;&nbsp;</li>
            <li>
                <div id="adviceTypeList" runat="server" class="channelSelect">
                    ��ѡ�������
                    <asp:DropDownList ID="AdviceTypeDropDownList" runat="server" EnableViewState="false">
                    </asp:DropDownList>
                </div>
            </li>
            <li class="smallButton8">
            <asp:HyperLink ID="AdviceHyperLinkCreate" NavigateUrl="javascript:AdviceCreateClick();"
                runat="server">���ݴ��ʼ���������
            </asp:HyperLink>
            </li> 
       
        </div>
           
        
        
<wec:messagepanel id="Messages" runat="server">
</wec:messagepanel>

        <br />
        <div>
            <asp:panel id="CtrlContainer" runat="server">
            </asp:panel>
        </div>
        <table>
            <tr>
                <td>
                   <b>�����ˣ�</b><asp:Label id="UserLabel" runat="server" ></asp:Label>
                </td>

            </tr>
            <tr>
               <td>
                   <b> ���⣺</b> <asp:Label id="EmailTitleLabel" runat="server" ></asp:Label>
               </td>

            </tr>
            <tr>
                <td >
                    <b>�ظ����ݣ�</b><br />
                        <div id="ReplayContent" runat="server" style="margin-left:40px; width:500px">
                        </div>
                </td>
           </tr>
        </table>
      
   <div style="display: none">
       <asp:TextBox ID="TitleTextBox" runat="server"></asp:TextBox>
       <asp:Button ID="AdviceBtn" runat="server" Text="Advice" OnClick="AdviceBtn_Click" />
       <asp:Button ID="AdviceBtnCreate" runat="server" Text="AdviceBtnCreate" OnClick="AdviceBtnCreate_Click" />
       <asp:TextBox ID="AdviceIDTextBox" runat="server"></asp:TextBox>
       <div id="InfoRawManage" runat="server"></div>
   </div>
</asp:content>
