<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdviceListControlEx.ascx.cs"
    Inherits="We7.CMS.Web.Admin.AdviceListControlEx" %>
<%@ Import Namespace="We7.CMS" %>
<%@ Import Namespace="We7.CMS.Accounts" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<script type="text/javascript">

    function SelectAll(el) {
        if ($(el).attr("checked")) {
            $("input:checkbox").attr("checked", "true");
        }
        else {
            $("input:checkbox").removeAttr("checked");
        }
    }
</script>
<script type="text/C#" runat="server">
    private IAccountHelper helper = AccountFactory.CreateInstance();    
</script>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<div class="toolbar">
    <%if (Permisstions.Contains("Advice.Admin"))
      { %>
    <asp:LinkButton ID="lnkDel" runat="server" OnClick="lnkDel_Click">删除</asp:LinkButton>
    <%} %>
    <%if (ShowType == 2 && (Permisstions.Contains("Advice.Accept") || Permisstions.Contains("Advice.Admin")))
      { %>
    <asp:LinkButton ID="lnkUrge" runat="server" OnClick="lnkUrge_Click">催办</asp:LinkButton>
    <%} %>
    <%if (ShowType != 3 && (Permisstions.Contains("Advice.Admin") || Permisstions.Contains("Advice.Handle") || Permisstions.Contains("Advice.Accept")))
      { %>
    <asp:LinkButton ID="lnkShow" runat="server" OnClick="lnkShow_Click">审核通过</asp:LinkButton>
    <asp:LinkButton ID="lnkHide" runat="server" OnClick="lnkHide_Click">审核不通过</asp:LinkButton>
    <asp:LinkButton ID="lnkSetTop" runat="server" OnClick="lnkSetTop_Click">置顶</asp:LinkButton>
    <asp:LinkButton ID="lnkCancelTop" runat="server" OnClick="lnkCancelTop_Click">取消置顶</asp:LinkButton>
    <%} %>
    <% if (Permisstions.Contains("Advice.Accept") && ShowType == 0)
       { %>
    <asp:LinkButton ID="lnkAccept" runat="server" OnClick="lnkAccept_Click">受理</asp:LinkButton>
    <asp:LinkButton ID="lnkRefuse" runat="server" OnClick="lnkRefuse_Click">不受理</asp:LinkButton>
    <%} %>
    <% if (ShowType != 3)
       { %>
    <p class="search-box">
        <asp:TextBox ID="txtQuery" runat="server"></asp:TextBox>
        <asp:Button class="button" ID="bttnQuery" runat="server" Text=" 查询" OnClick="bttnQuery_Click" />
    </p>
    <%} %>
</div>
<div style="min-height: 35px; width: 100%">
    <asp:GridView ID="AdviceGridView" runat="server" AutoGenerateColumns="False" CssClass="List"
        GridLines="Horizontal" ShowHeader="true" Width="100%">
        <AlternatingRowStyle CssClass="alter" />
        <Columns>
            <asp:TemplateField>
                <HeaderStyle Width="5px" />
                <HeaderTemplate>
                    <asp:CheckBox ID="chkHeader" runat="server" onclick="javascript:SelectAll(this);"
                        AutoPostBack="false" />
                </HeaderTemplate>
                <ItemTemplate>
                    <input type="checkbox" name="ids" value="<%# Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="标题">
                <ItemTemplate>
                    <%# GetTitle((We7.CMS.Common.AdviceInfo)Container.DataItem) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="类型">
                <ItemTemplate>
                    <%# GetAdviceTypeName(Eval("TypeID").ToString())%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="处理状态">
                <ItemTemplate>
                    <%# Eval("StateText")%>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="所属部门">
                <ItemTemplate>
                    <%# helper.GetDepartment(Eval("Display1").ToString(),null)!=null?helper.GetDepartment(Eval("Display1").ToString(),null).Name:"" %>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="优先级">
                <ItemTemplate>
                    <%# Eval("PriorityText")%>
                </ItemTemplate>
                <ItemStyle Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="前台显示">
                <ItemTemplate>
                    <%# Eval("IsShowText")%>/<%# Eval("IsTopText")%>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="提交日期">
                <ItemTemplate>
                    <%# FormatDate(Eval("Created")) %>
                </ItemTemplate>
                <ItemStyle Width="120px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="评论">
                <ItemTemplate>
                    <a title="查看评论" href="/admin/AddIns/Comment.aspx?aid=<%#Eval("ID") %>&Category=<%#((We7.CMS.Common.AdviceInfo)Container.DataItem).ModelName  %>&TypeId=<%=TypeID %>">
                        <img title="点击查看评论信息" src="/admin/images/pinglun.png"></a>
                </ItemTemplate>
                <ItemStyle Width="120px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:GridView ID="TransferGridView" runat="server" AutoGenerateColumns="False" CssClass="List"
        GridLines="Horizontal" ShowHeader="true" Width="100%">
        <AlternatingRowStyle CssClass="alter" />
        <Columns>
            <asp:TemplateField>
                <HeaderStyle Width="5px" />
                <HeaderTemplate>
                    <asp:CheckBox ID="chkHeader" runat="server" onclick="javascript:SelectAll(this);"
                        AutoPostBack="false" />
                </HeaderTemplate>
                <ItemTemplate>
                    <input type="checkbox" name="ids" value="<%# Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="标题">
                <ItemTemplate>
                    <%# GetTitle(((We7.CMS.Common.AdviceTransfer)Container.DataItem).Advice) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="处理状态">
                <ItemTemplate>
                    <%# Eval("Advice.StateText")%>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="转办方向">
                <ItemTemplate>
                    <%# GetAdviceTypeName(Eval("ToTypeID") as string) %>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="转办时间">
                <ItemTemplate>
                    <%# FormatDate(Eval("Created")) %>
                </ItemTemplate>
                <ItemStyle Width="180px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
<asp:Label ID="lblNoRecord" runat="server"></asp:Label>
<div class="pagination">
    <WEC:URLPager ID="AdviceUPager" runat="server" UseSpacer="False" UseFirstLast="true"
        PageSize="15" FirstText="<< 首页" LastText="尾页 >>" LinkFormatActive='<span class=Current>{1}</span>'
        CssClass="Pager" />
</div>
