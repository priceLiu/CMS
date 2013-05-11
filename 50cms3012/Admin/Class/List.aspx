<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="List" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title></title>

     <link rel="stylesheet" type="text/css" href="../images/style.css" />
 <style>
 .msgtable td{
	padding:0px;
}
</style>

 <script src="../../js/jquery-1.4.1.js" type="text/javascript"></script>

  <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
 <script src="../../Js/messages_cn.js" type="text/javascript"></script>

 <link href="../../content/colorbox/colorbox.css" rel="stylesheet" type="text/css" />
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
                     $("#form1").validate({
                         //出错时添加的标签
                         errorElement: "span",
                         success: function (label) {
                             //正确时的样式
                             label.text(" ").addClass("success");
                         }
                     }); 
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


                     $("#form1").validate({
                         //出错时添加的标签
                         errorElement: "span",
                         success: function (label) {
                             //正确时的样式
                             label.text(" ").addClass("success");
                         }
                     });                     

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
   <div class="navigation"><span class="add"><a href="#addClass" rel="addClass">添加类别</a></span><b>您当前的位置：首页 &gt; 分类管理 &gt; 分类列表</b></div>
    <div class="spClear"></div>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
              
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
    <HeaderTemplate>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
      <tr>
    
        <th width="10%">编号</th>
        <th width="60%" align="left">分类标题</th>
        <th width="20%">属性</th>
        <th width="10%">操作</th>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
      <tr>       
      
        <td align="center"><asp:Label ID="lb_id" runat="server" Text='<%#Eval("Classid")%>'></asp:Label></td>
        <td><a href="add.aspx?id=<%#Eval("Classid") %>"><%#Eval("ClassName")%></a></td>
        <td align="center"><%#Eval("lb")%></td>
        <td ><span><a href="add.aspx?id=<%#Eval("Classid") %>" rel="editClass">修改</a></span>
             <asp:LinkButton ID="LinkButton1" runat="server" CommandName="del" >删除</asp:LinkButton>

		
		</td>
      </tr>
      </ItemTemplate>

      <FooterTemplate>
      </table>
      </FooterTemplate>
      </asp:Repeater>               

     <div class="spClear"></div>
      <div style="line-height:30px;height:30px;">
            <div id="Pagination" class="right flickr"></div>
      
	</div>
    </form>
</body>
</html>
