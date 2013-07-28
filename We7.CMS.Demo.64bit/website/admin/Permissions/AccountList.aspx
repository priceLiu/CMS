<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountList.aspx.cs" Inherits="We7.CMS.Web.Admin.AccountList"
    MasterPageFile="~/admin/theme/classic/content.Master" ValidateRequest="false" %>

<%@ Import Namespace="We7.CMS.Common.Enum" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
 
    <div>
        <h2 class="title">
            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_user.gif" />
            <asp:Label ID="NameLabel" runat="server" Text="�û�����">
            </asp:Label>
            <span class="summary">
                <asp:Label ID="SummaryLabel" runat="server" Text="">
                </asp:Label>
            </span>
        </h2>
        <div id="position">
            &nbsp;<asp:Label ID="FullPathLabel" runat="server" Text=""> </asp:Label>
        </div>
        <div class="toolbar">
            <asp:HyperLink ID="NewUserHyperLink" runat="server">
            �½��û�</asp:HyperLink>
            <span></span>
            <asp:HyperLink ID="RefreshHyperLink" runat="server">
            ˢ��</asp:HyperLink>
        </div>
        <WEC:MessagePanel ID="Messages" runat="server">
        </WEC:MessagePanel>
    </div>

    <script type="text/javascript" src="/scripts/we7/we7.loader.js">
	
		// ��������
		var FromSiteID = new we7.BindCondition("FromSiteID", we7.bindVerb.equals, "<%=SiteID%>");
       
		var CurrentState=null;
         <%if (CurrentState!=OwnerRank.All)
       {%>
         CurrentState= new we7.BindCondition("UserType", we7.bindVerb.equals, "<%=(int)CurrentState%>");
       <%}%>
		// ����Ҫ�󶨵���Դ��Ŀ��
		var bindDestination = new we7.BindOption({
			tableName: "Account"
		    , fields: { "ID":{},"LoginName":{},"Department":{},"ModelState":{},"Created":{},"UserType":{value:{"1":"��ͨ�û�","0":"�����û�"}}}
			, sortField: "Created"
			, sortOrder: "desc"
            , rows:10
		});
		bindDestination.conditions.push(FromSiteID);
        bindDestination.conditions.push(CurrentState);
		
		//�󶨹���
		function bindData(){
			var options = {
				caption: "�û��б�",
				height: 220,
                rowNum:10,
                autowidth:true,
                editColumnHeader:"����",
                deletableRow:true,
                isSiteGroup: true                
			};
			
			we7("#ModelList").bind(bindDestination, options);
		}
		
		$(document).ready(function () {
			
			bindData();
			
		});
    </script>
    <table id="ModelList" style="display:none">
    <tr><td header="����"><img src="/admin/images/icon_User.gif" style="border-width:0px;"><a href="AccountEdit.aspx?id=${ID}">${LoginName}</a></td><td header="��������">${Department}</td><td editable="select" header="����" editkey="UserType">{{if UserType==0}}�����û�{{else}}��ͨ�û� {{/if}}</td><td header="ע������">{{html Created.substr(0,10)}}</td><td header="����"><a href="AccountEdit.aspx?id=${ID}&tab=2">��ɫ����</a>  <a href="AccountEdit.aspx?id=${ID}&tab=6">ģ��Ȩ��</a></td>
    </tr>
    </table>
    <script type="text/javascript">
        $(function () {
            $('#KeyWord').bind('keyup', function (event) {
                if (event.keyCode == 13) {
                    window.location = "AccountList.aspx?keyword=" + encodeURIComponent(this.value);
                }
            });
            $('#SearchButton').click(function () {
                window.location = "AccountList.aspx?keyword=" + encodeURIComponent($('#KeyWord').val());
            });
            if (QueryString('keyword'))
                $('#KeyWord').val(QueryString('keyword'));
        });
    </script>
</asp:Content>
