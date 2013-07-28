<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sites.ascx.cs"
    Inherits="We7.CMS.Web.Admin.ContentModel.Controls.Sites" %>
 <%--   <asp:DropDownList ID="ddlsites" runat="server">
    </asp:DropDownList>--%>
        <script type="text/javascript" src="/admin/ajax/jquery/jquery.tree.js"></script>
	<script type="text/javascript" src="/admin/ajax/jquery/plugins/jquery.tree.checkbox.js"></script>
    <script type="text/javascript" src="/scripts/we7/we7.loader.js">
	$(document).ready(function(){
		we7('.tipit').tip();
		we7('span[rel=xml-hint]').help();
	});
    $(function () {
	        $("#menuTree").tree({
	            ui: {
	                theme_name: "checkbox"
	            },
                callback: {
                    ondeselect: function (node) {
                        var AddsTextBox;
                        AddsTextBox = document.getElementById("<%=SiteIDsTextBox.ClientID %>");
                        if (AddsTextBox.value.indexOf(node.id) > 0) AddsTextBox.value = AddsTextBox.value.replaceAll(node.id + ";", "", true);
                        alert(AddsTextBox.value);
                    },
                    onselect: function (node) {
                        var AddsTextBox;
                        AddsTextBox = document.getElementById("<%=SiteIDsTextBox.ClientID %>");
                        if (AddsTextBox.value.indexOf(node.id) > 0) AddsTextBox.value = AddsTextBox.value + ";" + node.id;
                        alert(AddsTextBox.value);
                    } 
                },
	            plugins: {
	                checkbox: {}
	            }
	        });
	    });
         String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {
        
        if (!RegExp.prototype.isPrototypeOf(reallyDo)) 
        {
            return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
        } 
        else 
        {
            return this.replace(reallyDo, replaceWith);
        } 
    }
         function AddID(id) {
            
	         
	    }
        function DeleteID(id){
            
	    }
    </script>
    <div id="menuTree">
    	<ul>
			<li id="" class="open "><a href="#"  class="open "><ins>&nbsp;</ins>全部部门</a>
                <ul>
                    <%=SitesTreeHtml%>
                 </ul>
             </li>
        </ul>
    </div>
    <div style="display:none;">
        <asp:TextBox ID="SiteIDsTextBox" runat="server"></asp:TextBox>
    </div>
