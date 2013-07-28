<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sites.ascx.cs"
    Inherits="We7.CMS.Web.Admin.ContentModel.Controls.Sites" %>
 <%--   <asp:DropDownList ID="ddlsites" runat="server">
    </asp:DropDownList>--%>
    <script type="text/javascript" src="/admin/ajax/jquery/jquery.tree.js"></script>
	<script type="text/javascript" src="/admin/ajax/jquery/plugins/jquery.tree.checkbox.js"></script>
    <script type="text/javascript" src="/scripts/we7/we7.loader.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#menuTree").tree({
                ui: {
                    theme_name: "checkbox"
                },
                callback: {
                    onselect: function (node) {
                        if (node.id == "") {
                            $("#<%=SiteIDsTextBox.ClientID %>").val(getAllMenuIds());
                        } else {
                            var tempIds = getMenuIds();
                          //  alert(tempIds);
                            if (tempIds.indexOf(node.id) > -1) {
                                tempIds = tempIds.replaceAll(node.id + ";", "", true);
                                tempIds = tempIds.replaceAll(node.id, "", true);
                            } else {
                                tempIds = tempIds + node.id + ";";
                            }
                           // alert(tempIds);
                            $("#<%=SiteIDsTextBox.ClientID %>").val(tempIds);
                        }
                    }
                },
                plugins: {
                    checkbox: {}
                }
            });
        });
        function getMenuIds() {
            //取得所有选中的节点，返回节点对象的集合
            var menu = jQuery.tree.plugins.checkbox.get_checked($.tree.reference($("#menuTree")));
            //得到节点的id，拼接成字符串
            var ids = "";
            for (i = 0; i < menu.size(); i++) {
                ids += menu[i].id + ";";
            }
            return ids;
        }
        function getAllMenuIds() {
            //取得所有选中的节点，返回节点对象的集合
            var menu = jQuery.tree.plugins.checkbox.get_checked($.tree.reference($("#menuTree")));
            //得到节点的id，拼接成字符串
            var ids = "";
            for (i = 0; i < menu.size(); i++) {
                ids += menu[i].id + ";";
            }
            var menu2 = jQuery.tree.plugins.checkbox.get_unchecked($.tree.reference($("#menuTree")));
            for (i = 0; i < menu2.size(); i++) {
                ids += menu2[i].id + ";";
            }
            return ids;
        }
        String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {

            if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
                return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
            }
            else {
                return this.replace(reallyDo, replaceWith);
            }
        }
    </script>
    <div id="menuTree">
    	<ul>
			<li id="" class="open "><a href="#"  class="open "><ins>&nbsp;</ins>全部站点</a>
                <ul>
                    <%=SitesTreeHtml%>
                 </ul>
             </li>
        </ul>
    </div>
    <div style="display:none;">
        <asp:TextBox ID="SiteIDsTextBox" runat="server"></asp:TextBox>
    </div>
