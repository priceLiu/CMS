<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdviceReplyStatisticsControl.ascx.cs"
    Inherits="We7.CMS.Web.Admin.AdviceReplyStatisticsControl" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>

<script type="text/javascript" language="javascript" src="/Scripts/we7/we7.loader.js">
    we7("#<%=starttime.ClientID %>").pickDate();
    we7("#<%=endtime.ClientID %>").pickDate();
</script>
<script type="text/javascript">
    function SearchButtonClick() {
        var searchButton = document.getElementById("<%=SearchButton.ClientID %>");
        searchButton.click();
    }
</script>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<div id="conbox">
    <dl>
        <dt>»反馈信息统计<br />
            <img src="/admin/images/bulb.gif" align="absmiddle" />
            <label class="block_info">
                此处对反馈回复信息按模型进行统计，点击模型进入，则按模型内的反馈类别进行统计。</label>
        </dt>
        <dd style="width: 650px">
            <div style="display: table; width: 100%">
                <ul class="subsubsub">
                    <asp:Literal ID="StateLiteral" runat="server"></asp:Literal>
                </ul>
                <p class="search-box">
                    <div id="Departmenttr">部门选择： <asp:DropDownList runat="server" ID="departments"></asp:DropDownList></div>

                    反馈信息统计： 从<input id="starttime" name="starttime" runat="server" style="width: 92px" />
                    到
                    <input id="endtime" name="endtime" runat="server" style="width: 90px" />
                    <input type="button" value="查询" class="button" id="SearchBut" onclick="javascript:SearchButtonClick();" />
                </p>
            </div>
            <asp:GridView ID="StatisticsDataGridView" runat="server" AutoGenerateColumns="False"
                ShowFooter="True" CssClass="List" GridLines="Horizontal">
                <Columns>
                    <asp:TemplateField HeaderText="名称">
                        <ItemTemplate>
                            <%if (IsAdviceModel)
                              {%>
                            <a href="/admin/advice/AdviceListEx.aspx?typeID=<%# Eval("AdviceTypeID","{0}") %>">
                                <%#Eval("AdviceTypeTitle","{0}") %></a>
                            <%} %>
                            <%else
                              {%>
                            <%#Eval("AdviceInfoType", "{0}")%>
                            <%} %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:HyperLinkField DataNavigateUrlFields="AdviceTypeID" HeaderText="模型名称" DataTextField="AdviceTypeTitle"
                        DataTextFormatString="{0}" DataNavigateUrlFormatString="/advice/AdviceStatistics.aspx?tab=1" />--%>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "总数" : "总件数"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("AdviceCount", "{0}")%>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "待受理" : "未处理数"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("NoHandleCount", "{0}")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "待办中" : "必答项"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%#Eval("HandleNumber")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "不受理" : "非必答项"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("NoHandleNumber", "{0}")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField >
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "已办结" : "处理数"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("HandleCount", "{0}")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "已审核" : "未处理数"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("AuditedNumber", "{0}")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <%=IsAdviceModel ? "未审核" : "未处理数"%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("AuditNumber", "{0}")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="解决率">
                        <ItemTemplate>
                            <%# Eval("HandleRate", "{0}")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div class="pagination">
                <WEC:Pager ID="AdviceReplyStatisticsPager" PageSize="10" PageIndex="0" runat="server"
                    OnFired="Pager_Fired" />
                <%--<WEC:URLPager ID="UPager" runat="server" UseSpacer="False" UseFirstLast="true" PageSize="10"
                    FirstText="<< 首页" LastText="尾页 >>" LinkFormatActive='<span class=Current>{1}</span>'
                    UrlFormat="Departments.aspx?pg={0}" CssClass="Pager" />--%>
            </div>
            <div style="display: none">
                <asp:Button ID="SearchButton" runat="server" Text="Search" OnClick="SearchButtonClick" />
                <asp:TextBox ID="xmlTitleText" runat="server"></asp:TextBox>
                <asp:TextBox ID="DeleteEmailTextBox" runat="server"></asp:TextBox>
            </div>
        </dd>
    </dl>
</div>
