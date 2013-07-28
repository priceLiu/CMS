<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataControlList.aspx.cs"
    Inherits="We7.CMS.Web.Admin.DataControlList" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls"
    TagPrefix="WEC" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ѡ��һ�����ݿؼ�</title>
    <base target="_self" />
    <link rel="stylesheet" type="text/css" href="<%=AppPath%>/theme/Style/main.css" media="screen" />
	<meta content="noindex, nofollow" name="robots" />
	<script src="/fckeditor/editor/dialog/common/fck_dialog_common.js" type="text/javascript"></script>
	<script type="text/javascript">
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded() ;

// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

	</script>
	
    <script src="<%=AppPath%>/cgi-bin/DialogHelper.js" type="text/javascript"></script>
     <script src="<%=AppPath%>/cgi-bin/search.js" type="text/javascript"></script>

    <style type="text/css">
        #site-mode
        {
            position: absolute;
            right: 0px;
            top: 0;
            width: 70px;
            height: 31px;
        }

    </style>

    <script type="text/javascript">

        function onSelectThis(v)
        {
             var tempFile=QueryStringFromUrl("file",top.location.search);
             var url= "DataControlBuilder.aspx?isFirst=1&file=" +  v+"&template=" + tempFile;
             window.location=url;
        }

        function onDocumentLoad() {
//           dialog.SetOkButton( true ) ;
        }

        function onModeTypeClick(stylelist) {
            if (stylelist == "list") {
                ListControl.style.display = "";
                ImageControl.style.display = "none";
            }
            if (stylelist == "icon") {
                ListControl.style.display = "none";
                ImageControl.style.display = "";
            }
        }
    </script>

</head>
<body onload="onDocumentLoad()"  >
    <form id="mainForm" runat="server">
        <div>
            <span>����������</span>
            <asp:DropDownList ID="FieldDropDownList" runat="server">
                <asp:ListItem Value="Name">���ؼ��ֲ���</asp:ListItem>
                <asp:ListItem Value="FileName">���ļ�������</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="SearchTextBox" runat="server" Columns="20" MaxLength="64"></asp:TextBox>
            <asp:HyperLink ID="SearchHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.QueryButton.click();">
                <asp:Image ID="SearchImage1" runat="server" ImageUrl="~/admin/Images/icon_search.gif" />
                ִ��</asp:HyperLink>
        </div>
        <br />
        <div id="sortHyperLink">
            <span>�����ͷ��ࣺ</span>
            <asp:HyperLink ID="ArticleHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.ArticleButton.click();"
                CssClass="hypelink">������ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="ChannelHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.ChannelButton.click();"
                CssClass="hypelink">��Ŀ��ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="ImgHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.ImgButton.click();"
                CssClass="hypelink">ͼƬ��ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="ListLink" runat="server" NavigateUrl="javascript:document.mainForm.ListButton.click();"
                CssClass="hypelink">�б���ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="MenuLink" runat="server" NavigateUrl="javascript:document.mainForm.MenuButton.click();"
                CssClass="hypelink">�˵���ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="AdHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.AdButton.click();"
                CssClass="hypelink">�����ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="LoginHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.LoginButton.click();"
                CssClass="hypelink">��½��ؿؼ�</asp:HyperLink>
            <asp:HyperLink ID="StoreHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.StoreButton.click();"
                CssClass="hypelink">���̿ؼ�</asp:HyperLink>
            <asp:HyperLink ID="OtherHyperLink" runat="server" NavigateUrl="javascript:document.mainForm.OtherButton.click();"
                CssClass="hypelink">�����ؼ�</asp:HyperLink>
        </div>
        <br />
        <div id="messageLayer">
            <asp:Image ID="MessageImage" runat="server" ImageUrl="~/admin/Images/icon_info.gif" />
            <asp:Label ID="MessageLabel" runat="server" Text="">
            </asp:Label>
        </div>
        <br />
 
       <asp:DataList ID="ModeDataList" runat="server" AutoGenerateColumns="False" ShowFooter="True">
                <ItemTemplate>
                    <div style="width: 100%;padding:10px;">
                        <div style="float: left; ">
                          <a href="javascript:onSelectThis('<%#DataBinder.Eval(Container.DataItem, "FileName") %>');"> <img alt="<%#DataBinder.Eval(Container.DataItem, "Description") %>" id="ModeImage" src="/cgi-bin/templates/controls/CDControlImage/<%#Eval("DemoUrl")%>"
                                title="���ѡ��ؼ� <%#DataBinder.Eval(Container.DataItem, "Description") %>"  /></a>
                        </div>
                        <div style="margin-left:210px">
                            <div >
                            <h2>
                                 <a href="javascript:onSelectThis('<%#DataBinder.Eval(Container.DataItem, "FileName") %>');"> 
                                 <%#Eval("Description")%></a>
                                   </h2>                            
                            </div>
                            <div>
                               �ļ���<%#Eval("FileName")%><br />
                                ���ߣ�<%#Eval("Author")%><br />
                                ����ʱ�䣺<%#Eval("Created")%>
                            </div>
                              <div style="font-weight:lighter">
                              ������
                                <%#Eval("Remark")%>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

        <div id="ListControl" style="display: none;" runat="server">
                        <asp:GridView ID="DetailGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" Visible="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemStyle Width="10px" />
                                    <ItemTemplate>
                                        <input type="radio" name="Radios" value="<%#DataBinder.Eval(Container.DataItem, "FileName") %>"
                                            title="<%#DataBinder.Eval(Container.DataItem, "Name") %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Description" HeaderText="����" />
                                <asp:BoundField DataField="FileName" HeaderText="�ļ�" />
                                <asp:BoundField DataField="Author" HeaderText="����" />
                                <asp:BoundField DataField="Created" HeaderText="����ʱ��" />
                            </Columns>
                        </asp:GridView>
   </div>
        <br />
        <div style="display: none">
            <asp:Button ID="QueryButton" runat="server" Text="Query" OnClick="QueryButton_Click" />
            <asp:Button ID="ArticleButton" runat="server" Text="Sort" OnClick="ArticleButton_Click" />
            <asp:Button ID="ChannelButton" runat="server" Text="Sort" OnClick="ChannelButton_Click" />
            <asp:Button ID="ListButton" runat="server" Text="Sort" OnClick="ListButton_Click" />
            <asp:Button ID="MenuButton" runat="server" Text="Sort" OnClick="MenuButton_Click" />
            <asp:Button ID="ImgButton" runat="server" Text="Sort" OnClick="ImgButton_Click" />
            <asp:Button ID="AdButton" runat="server" Text="Sort" OnClick="AdButton_Click" />
            <asp:Button ID="LoginButton" runat="server" Text="Sort" OnClick="LoginButton_Click" />
            <asp:Button ID="StoreButton" runat="server" Text="Sort" OnClick="StoreButton_Click" />
            <asp:Button ID="OtherButton" runat="server" Text="Sort" OnClick="OtherButton_Click" />
            <asp:TextBox ID="IDTextBox" runat="server" Text=""></asp:TextBox>
        </div>
    </form>
</body>
</html>
