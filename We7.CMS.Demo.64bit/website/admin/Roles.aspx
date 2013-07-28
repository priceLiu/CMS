<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="We7.CMS.Web.Admin.Roles"
    MasterPageFile="~/admin/theme/classic/content.Master" %>

<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <script language="javascript" type="text/javascript">
        function DeleteConfirm(id, name, state) {
            if (state == "true") {
                alert("�Բ����ɫ��" + name + "��ΪվȺ��ɫ��������ɾ����");
            }
            else {
                var messages = "ɾ����ɫ����" + name + "��\r\n" +
                "�˲�����ɾ����ɫ��Ϣ���Լ���ý�ɫ��ص���Ȩ��Ϣ��\r\n" +
                "��ɫһ����ɾ���������ܹ��ָ������Ƿ�ȷ��ɾ����";
                var ifConfirm = window.confirm(messages);
                if (ifConfirm) {
                    var IDTextBox = document.getElementById("<%=IDTextBox.ClientID %>");
                    IDTextBox.value = id;
                    var NameTextBox = document.getElementById("<%=NameTextBox.ClientID %>");
                    NameTextBox.value = name;
                    var DeleteButton = document.getElementById("<%=DeleteButton.ClientID %>");
                    DeleteButton.click();
                }
            }

        }
    </script>
    <script type="text/javascript" src="<%=AppPath%>/cgi-bin/search.js"></script>
    <h2 class="title">
        <asp:Image ID="RoleImage" runat="server" ImageUrl="~/admin/Images/icons_user.gif" />
        <asp:Label ID="RoleLabel" runat="server" Text="��ɫ����">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="RoleSummaryLabel" runat="server" Text="">
            </asp:Label>
        </span>
    </h2>
    <WEC:MessagePanel ID="Messages" runat="server">
    </WEC:MessagePanel>
    <div class="toolbar">
        <asp:HyperLink ID="NewRoleHyperLink" NavigateUrl="Permissions/RoleEdit.aspx" runat="server">
            <asp:Image ID="NewRoleImage" runat="server" ImageUrl="~/admin/Images/icon_new.gif"
                Visible="false" />
            �����ɫ</asp:HyperLink>
        <span></span>
        <asp:HyperLink ID="RefreshHyperLink" NavigateUrl="Roles.aspx" runat="server">
            <asp:Image ID="RefreshImage" runat="server" ImageUrl="~/admin/Images/icon_refresh.gif"
                Visible="false" />
            ˢ��</asp:HyperLink>
    </div>
    <div style="display: table; width: 100%">
        <ul class="subsubsub">
            <asp:Literal ID="StateLiteral" runat="server"></asp:Literal>
        </ul>
        <!--
        <p class="search-box">
            <label class="hidden" for="user-search-input">
                ������ɫ:</label>
            <input type="text" class="search-input" id="KeyWord" name="KeyWord" value="" onkeydown="javascript:KeyPressSearch('Roles.aspx',event);" />
            <input type="button" value="������ɫ" class="button" id="SearchButton" onclick="javascript:doSearch('Roles.aspx');" />
        </p>-->
    </div>
    <div style="min-height: 35px; width: 100%">
        <%--    <asp:Repeater ID="ListRepeater" runat="server" >
    <HeaderTemplate>
    <table class="List">
    <tr><td>����</td></tr>
    </HeaderTemplate>
    <ItemTemplate>
    <tr>
    <td><a href="Permissions/RoleEdit.aspx?id=<%# Eval("ID") %>"><%# Eval("Name")%></a></td>
    <td></td>
    </tr>
    </ItemTemplate>
    <FooterTemplate></table></FooterTemplate>
    </asp:Repeater>--%>
    <!--
        <asp:GridView ID="DataGridView" runat="server" AutoGenerateColumns="False" Width="100%"
            CellSpacing="0" ShowFooter="True" CssClass="List" GridLines="Horizontal" EnableViewState="false">
            <AlternatingRowStyle CssClass="alter" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="Permissions/RoleEdit.aspx?id={0}"
                    DataTextField="Name" DataTextFormatString="{0}" HeaderText="����">
                    <HeaderStyle Width="200px" />
                </asp:HyperLinkField>
                <asp:BoundField HeaderText="����" DataField="Description"></asp:BoundField>
                <asp:BoundField HeaderText="����" DataField="TypeText"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <a href="Permissions/RoleEdit.aspx?id=<%# Eval("ID") %>">�༭</a> <a href="Permissions/RoleEdit.aspx?id=<%# Eval("ID") %>&tab=2">
                            �����û�</a> <a href="Permissions/RoleEdit.aspx?id=<%# Eval("ID") %>&tab=3">ģ��Ȩ��</a>
                        <%--                        <a href="Permissions/RoleEdit.aspx?id=<%# Eval("ID") %>&tab=4">
                            ����Ȩ��</a>--%>
                        <a href="javascript:DeleteConfirm('<%# Eval("ID") %>','<%# Eval("Name") %>','<%# Eval("IsGroupRole") %>');">
                            ɾ��</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="pagination">
        <p>
            <WEC:Pager ID="Pager" PageSize="15" PageIndex="0" runat="server" />
        </p>
    </div>
    <div style="display: none">
        <asp:TextBox ID="IDTextBox" runat="server"></asp:TextBox>
        <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
        <input type="submit" id="DoNothingButton" onclick="return false" />
        <input type="submit" id="DeleteButton" runat="server" onserverclick="DeleteButton_Click" />
    </div>-->
    <script type="text/javascript" src="/scripts/we7/we7.loader.js">
	
		// ��������
        var FromSiteID = new we7.BindCondition("FromSiteID", we7.bindVerb.equals, "<%=SiteID%>");
		var CurrentState=null;
         <%if (CurrentState!=OwnerRank.All)
       {%>
         CurrentState= new we7.BindCondition("RoleType", we7.bindVerb.equals, "<%=(int)CurrentState%>");
       <%}%>
		
		// ����Ҫ�󶨵���Դ��Ŀ��
		var bindDestination = new we7.BindOption({
			tableName: "Role"
		    , fields: {
                      "ID":{},"Name":{},"Description":{},"Created":{},
                      "RoleType":{
                        value:{"0":"����Ա��ɫ","1":"��ͨ�û���ɫ"}
                      }
            }
			, sortField: "Created"
			, sortOrder: "desc"
		});
		bindDestination.conditions.push(FromSiteID);
		bindDestination.conditions.push(CurrentState);
		//�󶨹���
		function bindData(){
			var options = {
				caption: "��ɫ�б�",
				height: 220,
                autowidth:true,
                rowNum:10,
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
        <tr><td header="����"><a href="Permissions/RoleEdit.aspx?id=${ID}">${Title}</a></td><td header="����" editable="text">${Description}</td><td header="����" editable="select" editkey="RoleType" sortkey="RoleType">{{if RoleType==0}}����Ա��ɫ{{else}}��ͨ�û���ɫ{{/if}}</td><td header="����"><a href="Permissions/RoleEdit.aspx?id=${ID}&tab=2">�����û�</a> <a href="Permissions/RoleEdit.aspx?id=${ID}&tab=3">ģ��Ȩ��</a></td></tr>
    </table>
</asp:Content>
