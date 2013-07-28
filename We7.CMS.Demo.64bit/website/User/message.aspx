﻿<%@ Page Language="C#" MasterPageFile="~/User/DefaultMaster/content.Master" AutoEventWireup="true"
    CodeBehind="message.aspx.cs" Inherits="We7.CMS.Web.User.message" Title="短消息" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyHeadPlaceHolder" runat="server">
    <script type="text/javascript">
        function SelectAll(tempControl) {
            var theBox = tempControl;
            xState = theBox.checked;

            elem = theBox.form.elements;
            for (i = 0; i < elem.length; i++)
                if (elem[i].type == "checkbox" && elem[i].id != theBox.id) {
                    if (elem[i].checked != xState)
                        elem[i].click();
                }
        }

        function deleteMsg() {
            var button = document.getElementById("<%=DeleteBtn.ClientID %>");
            button.click();
        }
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <form runat="server" id="mainForm">
    <WEC:MessagePanel ID="Messages" runat="server">
    </WEC:MessagePanel>
    <div class="realRight ml10">
        <div class="mybox">
            <div class="mytit">
                短消息</div>
            <div class="con">
                <p class="newmessage">
                    <a href="PostMessage.aspx" target="_parent" class="submitbutton">发送短信</a></p>
                <asp:GridView ID="DataGridView" runat="server" AutoGenerateColumns="False" Width="100%"
                    CellSpacing="0" ShowFooter="True" CssClass="List" GridLines="Horizontal">
                    <AlternatingRowStyle CssClass="alter" />
                    <HeaderStyle HorizontalAlign="Left" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle Width="5px" />
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkHeader" runat="server" onclick="javascript:SelectAll(this);"
                                    AutoPostBack="false" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkItem" runat="server" />
								<asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
						<asp:TemplateField>
                            <HeaderStyle Width="200px" HorizontalAlign="Center"/>
                            <HeaderTemplate>
                            	<div style="text-align: left;padding-left:10px">消息标题</div>
                            </HeaderTemplate>
                            <ItemTemplate>
                            	<div style="text-align: left;padding-left:10px">
									<a href="PostMessage.aspx?id=<%# Eval("ID") %>"><%# Eval("Subject") %></a>
								</div>
                            </ItemTemplate>
                        </asp:TemplateField>
						<asp:TemplateField>
                            <HeaderStyle Width="200px" HorizontalAlign="Center"/>
                            <HeaderTemplate>
                            	<div style="text-align: left;padding-left:10px">发件人</div>
                            </HeaderTemplate>
                            <ItemTemplate>
                            	<div style="text-align: left;padding-left:10px">
									<asp:Label runat="server" Text='<%# AccountHelper.GetAccount((Eval("AccountID")).ToString(),new string[]{"LoginName"}).LoginName  %>'></asp:Label>
								</div>
                            </ItemTemplate>
                        </asp:TemplateField>
						<asp:TemplateField>
                            <HeaderStyle Width="200px" HorizontalAlign="Center"/>
                            <HeaderTemplate>
                            	<div style="text-align: left;padding-left:10px">发送时间</div>
                            </HeaderTemplate>
                            <ItemTemplate>
                            	<div style="text-align: left;padding-left:10px">
									<asp:Label ID="Label1" runat="server" Text='<%# Eval("SendTime") %>'></asp:Label>
								</div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div style="width: 160px;" class="pannelleft">
                    <a class="selectall" href="javascript:SelectAll(this);">全选</a> <a class="selectall"
                        href="javascript:deleteMsg();">删除</a>
                </div>
                <div class="pagination">
                    <WEC:URLPager ID="ArticleUPager" runat="server" UseSpacer="False" UseFirstLast="true"
                        PageSize="15" FirstText="<< 首页" LastText="尾页 >>" LinkFormatActive='<span class=Current>{1}</span>'
                        CssClass="Pager" />
                </div>
                <div style="display: none">
                    <asp:Button ID="DeleteBtn" runat="server" Text="删除" OnClientClick="return confirm('您确认要将选中的文章都删除吗？')"
                        OnClick="DeleteBtn_Click" />
                </div>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
