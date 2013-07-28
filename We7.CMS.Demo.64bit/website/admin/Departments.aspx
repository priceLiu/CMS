<%@ Page Language="C#" AutoEventWireup="true" Codebehind="Departments.aspx.cs"  Inherits="We7.CMS.Web.Admin.Departments" MasterPageFile="~/admin/theme/classic/content.Master" ValidateRequest="false" %>
<%@ Import Namespace="We7.CMS.Common.Enum" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>

<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">

    <script language="javascript" type="text/javascript">
    function DeleteConfirm(id,name) {
		var msg = "ɾ�����ţ���"+name+"��\r\n"+
                "ɾ�����Ų���������ɾ���ò����Լ����������Ӳ��š��û�����Ϣ��\r\n" +
                "����һ����ɾ���������ܹ��ָ������Ƿ�ȷ��ɾ����";

		var IDTextBox=document.getElementById("<%=IDTextBox.ClientID %>"),
			NameTextBox=document.getElementById("<%=NameTextBox.ClientID %>"),
			DeleteButton=document.getElementById("<%=DeleteDepartmentButton.ClientID %>");
			IDTextBox.value=id;
			NameTextBox.value = name;

			function doDelete() {
				DeleteButton.click(); 
			}

			if (window.we7 && we7.confirm) {
				we7.confirm('<div style="text-align:left">' + msg.replace("\r\n", "<br />") + '</div>', "ɾ��", { autoTip: false }).ok(doDelete);
			} else if(window.confim(msg)){
				doDelete();
			}
    }
    </script>
    <div>
    <h2 class="title">
        <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_user.gif"/>
        <asp:Label ID="NameLabel" runat="server" Text="���Ź���">
        </asp:Label>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text=""></asp:Label>
        </span>
    </h2>
   <div id="position">
       &nbsp;<asp:Label ID="FullPathLabel" runat="server" Text=""> </asp:Label>
   </div>
   
    <div class="toolbar">
        <!--<asp:HyperLink ID="GoParentHyperLink" runat="server">
            ��һ��</asp:HyperLink><span></span>
        <asp:HyperLink ID="EditHyperLink" runat="server">
            �༭</asp:HyperLink>-->
            <span>  </span>
        <asp:HyperLink ID="NewDepartmentHyperLink" runat="server">
            �½�����</asp:HyperLink>
            <span>  </span>
        <asp:HyperLink ID="NewUserHyperLink" runat="server">
            �½��û�</asp:HyperLink>
            <span>  </span>
        <asp:HyperLink ID="RefreshHyperLink" runat="server">
            ˢ��</asp:HyperLink>
    </div>
	<div style="display:none" id=""><WEC:MessagePanel ID="Messages" runat="server"></WEC:MessagePanel></div>
    </div>
    <!--
    <div style="display:table;width:100%">
         <ul class="subsubsub">
            <asp:Literal ID="StateLiteral" runat="server"></asp:Literal>
         </ul>  
         <p class="search-box" >
	        <label class="hidden" for="user-search-input">��������:</label>
	        <input type="text" class="search-input" id="KeyWord" name="KeyWord" value=""    />
	        <input type="button" value="��������" class="button" id="SearchButton"    />
        </p>
    </div>
    <div style="min-height: 35px;">
        <asp:GridView ID="DepartmentsGridView" runat="server" AutoGenerateColumns="False"  CssClass="List"  GridLines="Horizontal"  ShowFooter="True" >
        <AlternatingRowStyle CssClass="alter" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
                <asp:BoundField DataField="Mode" HeaderText="ģʽ" Visible="False" />
                <asp:ImageField DataImageUrlField="Mode" DataImageUrlFormatString="/admin/images/icon_{0}.gif">
                    <HeaderStyle Width="20px" />
                </asp:ImageField>
                <asp:HyperLinkField DataNavigateUrlFields="Url" DataNavigateUrlFormatString="{0}"
                    DataTextField="Text" DataTextFormatString="{0}" HeaderText="����">
                    <HeaderStyle Width="200px" />
                </asp:HyperLinkField>
                <asp:BoundField HeaderText="����" DataField="Summary"></asp:BoundField>
                <asp:BoundField HeaderText="����" DataField="State"></asp:BoundField>
                <asp:BoundField HeaderText="ע������" DataField="RegisterDate"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                      <%# Eval("ManageLinks")%>   <a href="<%# Eval("EditUrl") %>">�༭</a>
                        <a href="<%# Eval("DeleteUrl") %>">ɾ��</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="pagination" style="display:none">
			 <WEC:URLPager ID="UPager" runat="server" UseSpacer="False" UseFirstLast="true"  PageSize="10"  FirstText="<< ��ҳ" LastText="βҳ >>"
			LinkFormatActive='<span class=Current>{1}</span>' UrlFormat="Departments.aspx?pg={0}"
			CssClass="Pager" />
    </div>-->
    <div style="display:none">
        <input type="submit"  id="DoNothingButton" onclick="return false"  />
        <asp:TextBox ID="IDTextBox" runat="server"></asp:TextBox>
        <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
        <asp:Button ID="DeleteDepartmentButton" runat="server" OnClick="DeleteDepartmentButton_Click" />
        <asp:Button ID="DeleteAccountButton" runat="server" OnClick="DeleteAccountButton_Click" />
    </div>
    <script type="text/javascript">
        $(function () {
            $('#KeyWord').bind('keyup', function (event) {
                if (event.keyCode == 13) {
                    window.location = "Departments.aspx?keyword=" + encodeURIComponent(this.value);
                }
            });
            $('#SearchButton').click(function () {
                window.location = "Departments.aspx?keyword=" + encodeURIComponent($('#KeyWord').val());
            });
            if (QueryString('keyword'))
                $('#KeyWord').val(QueryString('keyword'));
        });
</script>

    <script type="text/javascript" src="/scripts/we7/we7.loader.js"></script>
    
	<%--<script type="text/javascript">
		we7.load.ready(function () {
		    function bindData() {
                // ��������
		        var FromSiteID = new we7.BindCondition("FromSiteID", we7.bindVerb.equals, "<%=siteID%>");
       
		        var CurrentState=null;
                 <%if (CurrentState!=OwnerRank.All)
               {%>
                 CurrentState= new we7.BindCondition("UserType", we7.bindVerb.equals, "<%=(int)CurrentState%>");
               <%}%>
				var bindDestination = new we7.BindOption({
					tableName: "Department"
					, fields: { "ID": {}, "Name": {}, "Description": {}, "Created": {} }
					, sortField: "Created"
					, sortOrder: "desc"
				});
                bindDestination.conditions.push(FromSiteID);
                bindDestination.conditions.push(CurrentState);

				var options = {
					caption: "�����б�",
					height: 240,
					autowidth: true,
					rowNum: 30,
					deletableRow: true,
					onBeforeDelete: function (e, id, row) {
						e.preventDefault();
						DeleteConfirm(row.ID, row.Title, "Department");
						return false;
					},
		            isSiteGroup: true
				};
               
				we7("#ModelList").bind(bindDestination, options);
			}

			$(document).ready(function () {
				var msg = $("#message_panel").find("div.MessagePanel td:last").html();

				if ($.trim(msg)) {
					we7.info(msg);
				}

				bindData();
			});
		});
	</script>
    <table id="ModelList" style="display:none">
		 <tr><td header="����"><img src="/admin/images/icon_Department.gif" style="border-width:0px;"><a href="DepartmentDetail.aspx?id=${ID}">${Title}</a></td><td header="����" editable="text">${Description}</td><td header="����"><a href="/admin/DepartmentDetail.aspx?pid=${ID}">����Ӳ���</a></td><td header="�������" editable="date" editkey="Created">{{html Created.substr(0,10)}}</td></tr>
    </table>--%>
    <div style="width:300px;float:left;">
    <div id="dtree"></div>
    </div>
    <div style="width:auto;float:left;">
        <iframe id="edit"  style="background-color:transparent;display:none;"   scrolling="no" frameborder="0"  allowTransparency="true"></iframe>
    </div>
    <script type="text/javascript">
        function SetIFrame(width,height){
            $("#edit").width(600);//width
            $("#edit").height(height+50);
        }
        function decodeId(t) {
	        return t ? decodeURIComponent(t).replace('-_-', '{').replace('_-_', '}') : t;
        }
        we7.load.ready(function () {
                // ��������
		        var FromSiteID = new we7.BindCondition("FromSiteID", we7.bindVerb.equals, "<%=siteID%>");
		        var CurrentState=null;
                 <%if (CurrentState!=OwnerRank.All)
               {%>
                 CurrentState= new we7.BindCondition("UserType", we7.bindVerb.equals, "<%=(int)CurrentState%>");
               <%}%>
				var bindDestination = new we7.BindOption({
					 title: function(){return '<span style="cursor: pointer;" class="linkDepart"  href="/admin/DepartmentDetail.aspx?notiframe=1&id='+this.ID+'">'+this.Title+'<span>'}//'Title'
					, tableName: "Department"
                    , parentFieldName: "ParentID"
					, fields: "ID,Name,Created"
					, sortField: "Created"
					, sortOrder: "desc"
				});
                bindDestination.conditions.push(FromSiteID);
                CurrentState && bindDestination.conditions.push(CurrentState);
                we7("#dtree").bindTree(bindDestination,{
					ajax:{
						success:function(data){
							if(data.code != 200){
								return {"Title":"���س���"}
							}else{return data.rows;}
						}
					},
					menu:[
							{
							text:'ˢ��',
							action:function(source, sender, menu){
								var tree = we7.tree.getTree(source);
								if(tree){
									tree.refresh();
								}
							}
						},

						{
							text:'����Ӳ���',
							    action:function(source, sender, menu){
                                var objId,treeNode = we7.tree.getTree( source );
	                            if(treeNode){
		                            objId = decodeId( treeNode.id );
	                            }
							        $("#edit").show().attr("src", "/admin/DepartmentDetail.aspx?notiframe=1&pid=" + objId);
                            }
						}
                        ,{
							text:'����û�',
							    action:function(source, sender, menu){
                                var objId,treeNode = we7.tree.getTree( source );
	                            if(treeNode){
		                            objId = decodeId(treeNode.id);
	                            }
							        window.location = "/admin/Permissions/AccountEdit.aspx?d=" + objId;
                            }
						}
                        ,{
                            text:"ɾ��",
                            action:function(source,sender,menu){
                                var objId,treeNode = we7.tree.getTree(source);
	                            if(treeNode){
		                            objId = decodeId( treeNode.id );
	                            }
                                DeleteConfirm(objId,$(treeNode.text).text());
                            }
                        }
					]
				});	
         });
        $("li[tree] span.linkDepart").live("click",function(){
            $("#edit").show().attr("src",$(this).attr("href"));
        });
    </script>
</asp:Content>
