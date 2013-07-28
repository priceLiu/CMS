<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountList.aspx.cs" Inherits="We7.CMS.Web.Admin.AccountList"
    MasterPageFile="~/admin/theme/classic/content.Master" ValidateRequest="false" %>

<%@ Import Namespace="We7.CMS.Common.Enum" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
 
    <div>
        <h2 class="title">
            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_user.gif" />
            <asp:Label ID="NameLabel" runat="server" Text="用户管理">
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
            新建用户</asp:HyperLink>
            <span></span>
            <asp:HyperLink ID="RefreshHyperLink" runat="server">
            刷新</asp:HyperLink>
        </div>
        <WEC:MessagePanel ID="Messages" runat="server">
        </WEC:MessagePanel>
    </div>

    <script type="text/javascript" src="/scripts/we7/we7.loader.js">
	
		// 定义条件
		var FromSiteID = new we7.BindCondition("FromSiteID", we7.bindVerb.equals, "<%=SiteID%>");
       
		var CurrentState=null;
         <%if (CurrentState!=OwnerRank.All)
       {%>
         CurrentState= new we7.BindCondition("UserType", we7.bindVerb.equals, "<%=(int)CurrentState%>");
       <%}%>
		// 定义要绑定的资源的目标
		var bindDestination = new we7.BindOption({
			tableName: "Account"
		    , fields: { "ID":{},"LoginName":{},"Department":{},"ModelState":{},"Created":{},"UserType":{value:{"1":"普通用户","0":"管理用户"}}}
			, sortField: "Created"
			, sortOrder: "desc"
            , rows:10
		});
		bindDestination.conditions.push(FromSiteID);
        bindDestination.conditions.push(CurrentState);
		
		//绑定过程
		function bindData(){
			var options = {
				caption: "用户列表",
				height: 220,
                rowNum:10,
                autowidth:true,
                editColumnHeader:"管理",
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
    <tr><td header="名称"><img src="/admin/images/icon_User.gif" style="border-width:0px;"><a href="AccountEdit.aspx?id=${ID}">${LoginName}</a></td><td header="所属部门">${Department}</td><td editable="select" header="类型" editkey="UserType">{{if UserType==0}}管理用户{{else}}普通用户 {{/if}}</td><td header="注册日期">{{html Created.substr(0,10)}}</td><td header="操作"><a href="AccountEdit.aspx?id=${ID}&tab=2">角色设置</a>  <a href="AccountEdit.aspx?id=${ID}&tab=6">模块权限</a></td>
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
