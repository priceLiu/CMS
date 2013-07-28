    <%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/theme/ContentNoMenu.Master"
    CodeBehind="CategoryEdit.aspx.cs" Inherits="We7.CMS.Web.Admin.CategoryEdit" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <style type="text/css">
        .repeatTb label{
            margin:0 10px 0 2px;
        }
    </style>
    <script type="text/javascript" src="<%=AppPath%>/ajax/jquery/jquery.tree.js"></script>
	<script type="text/javascript" src="<%=AppPath%>/ajax/jquery/plugins/jquery.tree.checkbox.js"></script>
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
	            plugins: {
	                checkbox: {}
	            }
	        });
	    });
	    //取得选中的菜单id 
	    function getMenuIds() {
	        //取得所有选中的节点，返回节点对象的集合
	        var menu = jQuery.tree.plugins.checkbox.get_checked($.tree.reference($("#menuTree")));
	        //得到节点的id，拼接成字符串
	        var ids = "";
	        for (i = 0; i < menu.size(); i++) {
	            ids += menu[i].id + ";";
	        }
	        return (ids);
	    }
         function onSaveClick() {
	        var AddsTextBox;
	        var SaveButton;
	        AddsTextBox = document.getElementById("<%=AddsTextBox.ClientID %>");
	        SaveButton = document.getElementById("<%=SaveLinkbutton.ClientID %>");
	        AddsTextBox.value = getMenuIds();
	        //alert(AddsTextBox.value);
	        SaveButton.click();
	    }
    </script>
    <h2 class="title">
        <asp:Image ID="LogImage" runat="server" ImageUrl="~/admin/Images/icon_settings.png" />
        <asp:Label ID="TitleLabel2" runat="server" Text="添加类别数据项">
        </asp:Label>
        <span rel="xml-hint" title="类别：一种层级的数据结构，与内容模型结合使用后，能为您的应用提供更多的功能。" style="margin-left:10px" ></span>
        <span class="summary">
            <asp:Label ID="SummaryLabel" runat="server" Text="为指定类别添加数据项。">
            </asp:Label>
        </span>
    </h2>
    <div id="position">
        <a href="CatTypeMgr.aspx">自定义类别</a> > <a href="CategoryList.aspx?typeId=<%=TypeID %>"><%=TypeName%></a> > <asp:Literal ID="TitleLabel" runat="server"
            Text="数据项"></asp:Literal></div>
    <div id="DIV1">
        <div id="conbox">
            <dl>
                <dt>
                    <img src="/admin/images/bulb.gif" align="absmiddle" />数据项编辑
                    <div style="border-top: solid 1px #e0e0e0; width: 760px; font-size: 1px">
                    </div>
                    <dl>
                        <dd style="padding: 0px;">
                            <WEC:MessagePanel runat="Server" ID="Messages">
                            </WEC:MessagePanel>
                            <table id="personalForm" cellpadding="0" cellspacing="1" style="width: 700px" border="0">
                                <tr id="trParentCategory" runat="server">
                                    <td class="formTitle" style="width: 60px; text-align:left;">
                                        <asp:Label ID="lblParentCategory" runat="server" Text="上级分类:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlParentCategory" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle" style="width: 60px; vertical-align: middle; text-align:left;">
                                        <asp:Label ID="ConfigNameLabel" runat="server" Text="名称:"></asp:Label>
                                    </td>
                                    <td colspan="3" class="formValue">
                                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="rfvName" Display="Dynamic" runat="server" ErrorMessage="不能为空" ControlToValidate="txtName"
                                            Text="*"></asp:RequiredFieldValidator><label id="NameCheckLable" style="color: Red;"
                                                visible="false" runat="server">名称重复</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle" style="width: 60px; vertical-align: middle; text-align:left;">
                                        <asp:Label ID="Label1" runat="server" Text="标识符:"></asp:Label>
                                    </td>
                                    <td colspan="3" class="formValue">
                                        <asp:TextBox ID="txtKey" runat="server" Width="101px" />
                                        <span rel="xml-hint" 
                                        title="标识符：<br/>在内容模型的页面布局里，<br/>此标识符被用于类别控件（类别选择器，类别联动）的【分类关键字】中，<br/>以实现与内容模型的绑定。" 
                                        style="margin-left:10px" ></span>
                                        <asp:RequiredFieldValidator
                                            ID="rfvKey" runat="server" Text="*" Display="Dynamic" ControlToValidate="txtKey"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                ID="revKey" runat="server" ErrorMessage="请输入1至20位字母或数字" ControlToValidate="txtKey"
                                                Display="Dynamic" ValidationExpression="^[0-9a-zA-Z]{1,20}$"></asp:RegularExpressionValidator><label
                                                    visible="false" id="KeyCheckLable" style="color: Red;" runat="server">关键字重复</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle" style="width: 60px; vertical-align: middle; text-align:left;">
                                        <asp:Label ID="Label2" runat="server" Text="选项:"></asp:Label>
                                    </td>
                                    <td colspan="3" class="formValue">
                                        <asp:CheckBoxList CssClass="repeatTb" ID="chkOptions" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" RepeatLayout="Flow" />
                                        <span rel="xml-hint" title="为应用程序提供附加选项<br/>配置来源：/Config/CategoryOptions.config" style="margin-left:10px" ></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle" style="width: 60px; vertical-align: middle; text-align:left;">
                                        <asp:Label ID="Label3" runat="server" Text="排序:"></asp:Label>
                                    </td>
                                    <td colspan="3" class="formValue">
                                        <asp:TextBox ID="txtIndex" runat="server" Width="50px" Text="0"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formTitle" style="width: 60px; vertical-align: middle; text-align:left;">
                                        <asp:Label ID="Label5" runat="server" Text="描述:"></asp:Label>
                                    </td>
                                    <td colspan="3" class="formValue">
                                        <asp:TextBox TextMode="MultiLine" ID="txtDesc" runat="server" Width="300px" Height="70px"></asp:TextBox>
                                    </td>
                                </tr>
                               
                                 <tr>
                                    <td class="formTitle" style="width: 60px; vertical-align: middle; text-align:left;">
                                        <asp:Label ID="Label4" runat="server" Text="所属部门:"></asp:Label>
                                    </td>
                                    <td colspan="3" class="formValue">
                                         <div id="menuTree">
    		                                <ul>
			                                <li id="" class="open "><a href="#"  class="open "><ins>&nbsp;</ins>全部部门</a>
                                            <ul>
                                            <%=DepartmentsTreeHtml %>
                                            </ul>
                    </li>
                    </ul>
            </div>
                                    </td>
                                </tr>
                                 <tr>
                                    <td></td>
                                    <td>            
                                        <asp:CheckBox ID="ApplyDepartmentsToSubCategory" Checked="true" runat="server" Text="所属部门设置应用到子分类"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                         <asp:TextBox style="display:none;" ID="AddsTextBox" runat="server"></asp:TextBox>
                                         
                                        <a href="javascript:onSaveClick();" class="button">　保存　</a>
                                        <asp:Button style="display:none;" runat="server" Text="　保存　"  CssClass="ArrowButton" ID="SaveLinkbutton"
                                            OnClick="SaveLinkbutton_Click" />
                                        &nbsp;&nbsp;<input value="　返回　" type="button" class="ArrowButton" onclick="location.href='CategoryList.aspx?typeId=<%=TypeID %>'" />
                                    </td>
                                </tr>
                            </table>
                        </dd>
                    </dl>
                </dt>
            </dl>
</asp:Content>
