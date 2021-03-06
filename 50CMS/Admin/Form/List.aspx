﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="ln2012.Admin.Form.List" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <link rel="stylesheet" type="text/css" href="../images/style.css" />
 <script src="../../js/jquery-1.4.1.js" type="text/javascript"></script>
 <link href="../../content/colorbox/colorbox.css" rel="stylesheet" type="text/css" />
 <link href="../../Content/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
 <script src="../../js/jquery-ui.min.js" type="text/javascript"></script>
 <script src="../../Content/colorbox/jquery.colorbox.js" type="text/javascript"></script>

 <script type="text/javascript">
     $(function () {
         $(".msgtable tr:nth-child(odd)").addClass("tr_bg"); //隔行变色
         $(".msgtable tr").hover(
			    function () {
			        $(this).addClass("tr_hover_col");
			    },
			    function () {
			        $(this).removeClass("tr_hover_col");
			    }
		    );
     });
     $(function () {
         $("a[rel='addClass']").click(function () {
             $(this).colorbox({
                 width: 1000,
                 heigth: 500,
                 href: "Add.aspx",
                 overlayClose: false,
                 close: "关闭",
                 onComplete: function () {
            
                     $("#btnCancel").click(function () {
                         $.colorbox.close();
                     });
                 }
             });
         });
         $("a[rel='editClass']").click(function () {
             $(this).colorbox({
                 width: 1000,
                 heigth: 500,
                 overlayClose: false,
                 close: "关闭",
                 onComplete: function () {
                     $("#btnCancel").click(function () {
                         $.colorbox.close();
                     });
                 },
                 onClosed: function () {
                     $.colorbox.remove();
                 }
             });
         });
         $("a[rel='addExper']").click(function () {
             $(this).colorbox({
                 width: 950,
                 overlayClose: false,
                 close: "",
                 onComplete: function () {
                 
                     $("#btnCancel").click(function () {
                         $.colorbox.close();
                     });
                 },
                 onClosed: function () {
                     $.colorbox.remove();
                 }
             });
         });
     });
    </script>
        <script type="text/javascript">
            function delete_confirm(e) {
                if (event.srcElement.outerText == "删除" || event.srcElement.value == "删除")
                    event.returnValue = confirm("删除后将不能恢复，您确认执行删除操作么？");
            }
            document.onclick = delete_confirm;
</script>

</head>
<body>
    <form id="form1" runat="server">
   <div class="navigation"><span class="add"><a a href="#addClass" rel="addClass">添加表单</a></span><b>您当前的位置：首页 &gt; 表单管理 &gt; 表单列表</b></div>
    <div class="spClear"></div>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
               
                 
    <div class="spClear"></div>
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
    <HeaderTemplate>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
      <tr>
    
        <th width="10%">编号</th>
        <th width="20%">标题</th>
        <th width="40%">预览表单</th>
        <th width="20%">操作</th>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
      <tr>       
      
        <td align="center"><asp:Label ID="lb_id" runat="server" Text='<%#Eval("FID")%>'></asp:Label></td>
        <td><a href="add.aspx?id=<%#Eval("FID") %>"><%#Eval("FNmae")%></a></td>
        <td><a href="/Form<%#Eval("FID") %>.aspx"  target=_blank>预览表单</a></span>
            <a href="RList.aspx?ID=<%#Eval("FID") %>" >内容管理</a></span>
         </td>
        <td align="center">
        <span>
        <span><a href="add.aspx?id=<%#Eval("FID") %>" rel="editClass">修改</a></span>
           <asp:LinkButton ID="LinkButton1" runat="server" CommandName="del" >删除</asp:LinkButton>
        </td>
      </tr>
      </ItemTemplate>
      <FooterTemplate>
      </table>
      </FooterTemplate>
      </asp:Repeater>               
      
 <webdiyer:AspNetPager ID="AspNetPager1"  runat="server"  PageSize="10"  FirstPageText="首页"  LastPageText="末页" NextPageText="下一页" PrevPageText="上一页" AlwaysShow="true"  onpagechanging="AspNetPager1_PageChanging" CssClass="paginator"   CurrentPageButtonClass="cpb"></webdiyer:AspNetPager>

     <div class="spClear"></div>
      <div style="line-height:30px;height:30px;">
            <div id="Pagination" class="right flickr"></div>
      
	</div>
    </form>
</body>
</html>
