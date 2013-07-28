<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="true" CodeBehind="AdviceListControl.ascx.cs"
    Inherits="We7.CMS.Web.Admin.AdviceListControl" %>
<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>


<script type="text/javascript">
    function ProcessRemark(adviceID) {
        var title = "ģʽ����";
        var nWidth = "300";
        var nHeight = "200";
        var strFile = "../manage/ScanProcessHistory.aspx?from=advice&ID=" + adviceID + "";
        weShowModelDialog(strFile);
    }

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
    function DeleteBtnClick() {

        if (confirm('��ȷ��Ҫ�����Է���ɾ���𣿴˲������ɻָ�����ȷ�ϣ�')) {
            var deleteBtn = document.getElementById("<%=DeleteBtn.ClientID %>");
            deleteBtn.click();
        }
    }

    function HastenButtonClick() {
        var hastenButton = document.getElementById("<%=HastenButton.ClientID %>");
        hastenButton.click();
    }
    function MustHandleButtonClick() {
        var mustHandleButton = document.getElementById("<%=MustHandleButton.ClientID %>");
        mustHandleButton.click();
    }

    function ReceiveClick() {
        if (confirm('��ȷ���ڽ��մ洢�ʼ���ɾ���������ϵ��ʼ��𣿴˲������ɻָ�����ȷ�ϣ�')) {
            var deleteBtn = document.getElementById("<%=DeleteEmailTextBox.ClientID %>");
            deleteBtn.value = "1";
        }
        var receiveBtn = document.getElementById("<%=ReceiveBtn.ClientID %>");
        receiveBtn.click();

    }

    function DisplayButtonClick() {
        var DisplayButton = document.getElementById("<%=DisplayButton.ClientID %>");
        DisplayButton.click();
    }

    function UndisplayButtonClick() {
        var UndisplayButton = document.getElementById("<%=UndisplayButton.ClientID %>");
        UndisplayButton.click();
    }

    function UnControlDisplayButtonClick() {
        var UnControlDisplayButton = document.getElementById("<%=UnControlDisplayButton.ClientID %>");
        UnControlDisplayButton.click();
    }
</script>

<script type="text/javascript" src="<%=AppPath%>/cgi-bin/search.js"></script>

<h2 class="title">
    <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_comment.gif" />
    <asp:Label ID="NameLabel" runat="server" Text="�����б�">
    </asp:Label>
    <span class="summary">
        <asp:Label ID="SummaryLabel" runat="server" Text="">
        </asp:Label>
    </span>
</h2>
<div class="toolbar">
    <li>
        <asp:HyperLink ID="DeleteHyperLink" NavigateUrl="javascript:DeleteBtnClick();" runat="server">
          ɾ��
        </asp:HyperLink>
    </li>
    <li>
        <asp:HyperLink ID="HastenHyperLink" NavigateUrl="javascript:HastenButtonClick();"
            runat="server" ToolTip="�߰�ֻ�ܶԱ���ظ�����У�">
            �߰�</asp:HyperLink>
    </li>
    <li>
        <asp:HyperLink ID="MustHandleHyperLink" NavigateUrl="javascript:MustHandleButtonClick();"
            runat="server">
            ����ظ�</asp:HyperLink>
    </li>
    <li class="smallButton8">
        <asp:HyperLink ID="ReceiveHyperLink" NavigateUrl="javascript:ReceiveClick();" runat="server">
            ���շ����ظ��ʼ�
        </asp:HyperLink>
    </li>
    <li>
        <asp:HyperLink ID="DisplayHyperLink" NavigateUrl="javascript:DisplayButtonClick();"
            runat="server">
            ���⹫��</asp:HyperLink>
    </li>
    <li>
        <asp:HyperLink ID="UndisplayHyperLink" NavigateUrl="javascript:UndisplayButtonClick();"
            runat="server">
            ������</asp:HyperLink>
    </li>
    <li>
        <asp:HyperLink ID="UnControlDisplayHyperLink" NavigateUrl="javascript:UnControlDisplayButtonClick();"
            runat="server" Visible="false">
            ǰ̨������</asp:HyperLink>
    </li>
</div>
<div style="display: table; width: 100%">
    <ul class="subsubsub">
        <asp:Literal ID="StateLiteral" runat="server"></asp:Literal>
    </ul>
    <p class="search-box">
        ������Ϣ��ѯ��<asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
        <asp:DropDownList ID="ddlSearchKey" runat="server">
            <asp:ListItem Text="name" Value="name">����</asp:ListItem>
            <asp:ListItem Text="phone" Value="phone">�绰</asp:ListItem>
            <asp:ListItem Text="fax" Value="fax">����</asp:ListItem>
            <asp:ListItem Text="email" Value="">E_mail</asp:ListItem>
            <asp:ListItem Text="address" Value="email">סַ</asp:ListItem>
            <asp:ListItem Text="title" Value="title">����</asp:ListItem>
            <asp:ListItem Text="content" Value="content">����</asp:ListItem>
        </asp:DropDownList>
        <input type="button" class="button" id="QueryButton" runat="server" value="��ѯ" onserverclick="QueryButton_ServerClick" />
    </p>
</div>
<WEC:MessagePanel ID="Messages" runat="server">
</WEC:MessagePanel>
<div style="min-height: 35px; width: 100%">
    <asp:GridView ID="AdviceGridView" runat="server" AutoGenerateColumns="False" CssClass="List"
        GridLines="Horizontal" OnRowDataBound="AdviceGridView_RowDataBound">
        <AlternatingRowStyle CssClass="alter" />
        <Columns>
            <asp:TemplateField>
                <HeaderStyle Width="5px" />
                <HeaderTemplate>
                    <asp:CheckBox ID="chkHeader" runat="server"  onclick="javascript:SelectAll(this);"
                        AutoPostBack="false" />
                </HeaderTemplate>
                <ItemTemplate>                
                    <asp:CheckBox ID="chkItem" runat="server" />
                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="����">
                <ItemTemplate>
                      <%# Eval("IsRead").ToString() == "1" ? "<img src='/Admin/images/NoRead.jpg' title='δ��' style='cursor:pointer;' />" : ""%>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ID","/admin/Advice/AdviceDetail.aspx?from=advice&ID={0}") %>'
                        Target="_parent" Text='<%# Eval("Title", "{0}") %>' ToolTip='����������'></asp:HyperLink>                      
                    <%# GetIcons(Eval("MustHandle"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="�ύ��">
                <ItemTemplate>
                    <%# Eval("Name", "{0}")%>
                </ItemTemplate>
                <ItemStyle Width="80px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="�ύ����">
                <ItemTemplate>
                    <%# Eval("TimeNote")%>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="ת��">
                <ItemTemplate>
                    <%# Eval("ToHandleTimeText")%><%# GetUserName(Eval("ID").ToString(), Eval("ToOtherHandleUserID","{0}"))%>
                </ItemTemplate>
                <ItemStyle Width="150px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="��ת״̬">
                <ItemTemplate>
                    <a href="javascript:ProcessRemark('<%#Eval("ID")%>');" onclick="return <%#GetProcessEable(Eval("ID") as string)%> ">
                        <%# GetProcessState(Eval("ID") as string)%></a>
                </ItemTemplate>
                <ItemStyle Width="80px" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="��ע">
                <ItemTemplate>
                    <%# GetDisplayStyle(Eval("EnumState") as string, Eval("MustHandleText", "{0}"))%>
                    <asp:Label runat="server" ID="NoteLabel"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="AlertLabel" runat="server" Text='<%# Eval("MustHandle") %>' Visible="False"></asp:Label>
                    <asp:Label ID="CreateLabel" runat="server" Text='<%# Eval("CreateDate") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
<asp:Label ID="lblNoRecord" runat="server"></asp:Label>
<div class="pagination">
    <WEC:URLPager ID="AdviceUPager" runat="server" UseSpacer="False" UseFirstLast="true"
        PageSize="15" FirstText="<< ��ҳ" LastText="βҳ >>" LinkFormatActive='<span class=Current>{1}</span>'
        CssClass="Pager" />
</div>
<div style="display: none">
    <asp:TextBox ID="AdviceTypeIDS" runat="server" Text=""></asp:TextBox>
    <asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click" />
    <asp:Button ID="HastenButton" runat="server" Text="Hasten" OnClick="HastenButton_Click" />
    <asp:Button ID="MustHandleButton" runat="server" Text="MustHandle" OnClick="MustHandleButton_Click" />
    <asp:TextBox ID="UserIDTextBox" runat="server"></asp:TextBox>
    <asp:Button ID="ReceiveBtn" runat="server" Text="Receive" OnClick="ReceiveBtn_Click" />
    <asp:TextBox ID="DeleteEmailTextBox" runat="server"></asp:TextBox>
    <asp:Button ID="DisplayButton" runat="server" Text="Hasten" OnClick="DisplayButton_Click" />
    <asp:Button ID="UndisplayButton" runat="server" Text="Hasten" OnClick="UndisplayButton_Click" />
    <asp:Button ID="UnControlDisplayButton" runat="server" Text="Hasten" OnClick="UnControlDisplayButton_Click" />
</div>
