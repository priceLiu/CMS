    <%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TemplateGroup_File.ascx.cs"
    Inherits="We7.CMS.Web.Admin.TemplateGroup_File" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>

<script type="text/javascript" src="/Admin/Ajax/jquery/jquery.dataTables.min.js"></script>

<script type="text/javascript">

    function doDeleteFile(fa) {
        
        if (confirm("��ȷ��Ҫɾ��ģ���ļ� " + fa + " ��")) {
        
            document.getElementById("<%=FileTextBox.ClientID %>").value = fa;
            document.getElementById("<%=DeleteFileButton.ClientID %>").click();
        }
        return false;
    }

    function RefreshRpt() {
        document.getElementById("<%=btnRefresh.ClientID %>").click();
        return false;
    }
</script>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
        var flag = ($.browser.msie && $.browser.version >= 7) || (!$.browser.msie);

        if (flag) {

            $('#templatesTable').dataTable({
                "bPaginate": false,
                "bLengthChange": false,
                "bInfo": false,
                "oLanguage": {
                    "sLengthMenu": "ÿҳ��ʾ _MENU_ ��",
                    "sZeroRecords": "��Ǹ��û�м�¼��",
                    "sInfo": "���� _TOTAL_ ������ҳΪ�� _START_ ������ _END_ ��",
                    "sInfoEmpty": "û��ģ�塣",
                    "sInfoFiltered": "(�� _MAX_ ��ģ���й���)",
                    "sSearch": "���ٲ�ѯ"
                }
            });

        }
        $(".bindAction").colorbox({ width: "80%", height: "80%", iframe: true, onClosed: function () { RefreshRpt(); } });

    });
</script>

<div style="display: table; width: 100%; z-index: 1000">
    <ul class="subsubsub">
        <asp:Literal ID="StateLiteral" runat="server"></asp:Literal>
    </ul>
</div>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<div style="z-index: 0">
    <asp:Repeater ID="TempldatesRepeater" runat="server">
        <HeaderTemplate>
            <table class="List display" border="0" cellpadding="3" cellspacing="0" id="templatesTable">
                <thead>
                    <tr>
                        <th style="width: 100px">
                            ģ������
                        </th>
                        <th style="width:150px;">
                            ģ���ļ�
                        </th>
                        <th style="width:95px;">
                            ģ������
                        </th>
                        <th style="width: 90px">
                            ��ģ��/ĸ��
                        </th>
                        <th style="width: 130px">
                            Ĭ��ָ��
                        </th>
                        <th style="width: 140px">
                            ��������
                        </th>
                        <th style="width: 170px">
                            ����
                        </th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <%# GetVisualEditUrl(Eval("IsVisualTemplate"), Eval("FileName").ToString(),Eval("Name")??"".ToString())%>
                </td>
                <td>
                    <%# Eval("FileName", "{0}") %>
                </td>
                <td>
                    <%# (bool)Eval("IsVisualTemplate") ? "<img src=\"/admin/Images/visual.png\" title=\"���ӻ�ģ��\" />" : "��ͨģ��"%>
                </td>
                <td>
                    <%# Eval("IsSubTemplateText", "{0}")%>
                </td>
                <td style="color: Red">
                    <%# Eval("DefaultBindText", "{0}")%>
                </td>
                <td>
                    <%# Eval("Created", "{0}")%>
                </td>
                <td>
                    <%# GetVisualEditUrl(Eval("IsVisualTemplate"), Eval("FileName").ToString(),"�༭")%>
                    | <a href="javascript:void(0)" onclick="javascript:return doDeleteFile('<%#DataBinder.Eval(Container.DataItem, "FileName") %>');">
                        ɾ�� </a>| <a class='bindAction' href="TemplateBindTo.aspx?filename=<%# Eval("FileName", "{0}") %>&file=<%=Request["file"] %>">
                            Ĭ��ָ��</a>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody> </table>
        </FooterTemplate>
    </asp:Repeater>
</div>
<div style="display: none">
    <asp:TextBox ID="FileTextBox" runat="server"></asp:TextBox>
    <asp:Button ID="DeleteFileButton" runat="server" OnClick="DeleteFileButton_Click" />
     <asp:Button ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" />
</div>
