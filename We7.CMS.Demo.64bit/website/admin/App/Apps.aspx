<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/theme/classic/content.Master"
    CodeBehind="Apps.aspx.cs" Inherits="We7.CMS.Web.Admin.App.Apps" %>
<%@ Import Namespace="We7.CMS.Common" %>
<%@ Import Namespace="We7.CMS.Common.AppFoundation" %>
<asp:Content ID="We7ContentPanel" runat="server" ContentPlaceHolderID="MyContentPlaceHolder">
    <link rel="stylesheet" type="text/css" href="/admin/theme/Style/article.css" />
     <link rel="Stylesheet" href="" id="scrollshow" type="text/css" />
    <script src="/Admin/Ajax/Mask.js" type="text/javascript"></script>
    <h2 class="title">
        <asp:Image runat="server" ImageUrl="~/admin/Images/icons_plugins.gif" />
        <label id="NameLabel">
            应用管理</label>
        <span class="summary">
            <label id="SummaryLabel">
                通过安装应用，可以轻易扩展系统功能</label>
        </span>
    </h2>
    <div id="position">
        <a href="Apps.aspx">应用管理</a>&gt;应用管理
    </div>
    <br />
    <div id="conbox">
        <dl>
            <dt>»当前可用的应用
                <div style="padding: 0px 0 0 12px">
                    <img src="/admin/images/bulb.gif" align="absmiddle" />
                    <label class="block_info">
                        应用扩展、增强 We7 的功能。应用安装后，您可以在这里启用或者停用它。</label>
                </div>
                <dd>
                    <div>
                        <div id="plugin" class="toolbar2">
                            <li class="smallButton4"><a onsubmit="false" href="AppAdd.aspx"> 安装</a> </li>
                        </div>
                        <div style="min-height: 35px; width: 100%">
                            <div>
                                 <input type="hidden" name="AppId"/>
                                 <input type="hidden" name="IsEnabled" value=""/>    
                                 <input type="hidden" name="AppUnInstall"/>
                                <table class="List" cellspacing="0" rules="rows" border="1" style="border-collapse: collapse;">
                                    <tbody>
                                        <tr>
                                            <th scope="col">
                                                <input type="checkbox" name="EnableSeletedHeaderCheckbox" onclick="$('input[name=EnableSeletedCheckbox]').attr('checked',$(this).attr('checked'))">
                                            </th>
                                            <th scope="col">名称</th>
                                            <th scope="col">版本</th>
                                            <th scope="col">描述</th>
                                            <th scope="col">作者</th>
                                            <th scope="col">操作</th>
                                        </tr>
                                        <% foreach (AppInfo app in AppList)
                                           {%>
                                        <tr valign="middle">
                                            <td style="width: 20px;">
                                                <input type="checkbox" name="EnableSeletedCheckbox" value="<%=app.Id %>">
                                            </td>
                                            <td style="width: 100px;">
                                                <%=app.Name %>
                                            </td>
                                            <td style="width: 60px;">
                                                <%=app.Metadata.Version %>
                                            </td>
                                            <td style="width: 500px;">
                                                <%=app.Metadata.Description %>
                                            </td>
                                            <td style="width: 70px;">
                                                <%=app.Metadata.Author %>
                                            </td>
                                            <td style="width: 100px;">
                                                <%=!app.IsEnabled ? "<a rel='"+app.Id+"' href='#' onclick=\"$('input[name=IsEnabled]').val('true');\" >启用</a>" : "<a rel='"+app.Id+"' onclick=\"$('input[name=IsEnabled]').val('false')\" href='#'>禁用</a>"%>
                                                 | <a rel='<%=app.Id%>' href="#" onclick="$('input[name=AppUnInstall]').val('true')">卸载</a>
                                                <%if (app.IsEnabled && (null != app.Metadata.MenuItems) && (app.Metadata.MenuItems.Length > 0)){%>
                                                 | <a rel='<%=app.Id%>' onsubmit='false' href="javascript:new MaskWin().showFrame('/Admin/Plugin/PluginMenu.aspx?AppId=<%=Server.UrlEncode(app.Id) %>&action=', '更新菜单', { width: 500, height: 225});void(0);">菜单</a>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </dd>
            </dt>
        </dl>
    </div>
        <asp:Button ID="refresh" CssClass="refreshbutton" runat="server" OnClick="OnClearMenuClick" Style="display: none" />
    <script type="text/javascript">
        var refreshbutton = '<%=refresh.ClientID %>';
        $(document).ready(function () {
            $("#conbox a:not([onsubmit='false'])").each(function () {
                $(this).bind('click', function () {
                    $("#conbox input[name=AppId]").val($(this).attr("rel"));
                    if (confirm("你确定要进行此操作吗？")) {
                        document.forms[0].submit();
                    }
                });
            });
        });
    </script>
</asp:Content>
