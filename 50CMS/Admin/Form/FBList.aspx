<%@ Page Language="C#" AutoEventWireup="true" Inherits="ln2012.Admin.Form.FBList" CodeFile="FBList.aspx.cs" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
     <link rel="stylesheet" type="text/css" href="../images/style.css" />
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
         $("a[rel='editClass']").click(function () {
             $(this).colorbox({
                 width: 800,
                 heigth: 500,
                 overlayClose: false,
                 close: "关闭",
                 onComplete: function () {
                     $("#btnCancel").click(function () {
                         $.colorbox.close();
                     });

                     $("#form1").validate({
                         //出错时添加的标签
                         errorElement: "span",
                         success: function (label) {
                             //正确时的样式
                             label.text(" ").addClass("success");
                         }
                     });

                 },
                 onClosed: function () {
                     $.colorbox.remove();
                 }
             });
         });
      
     });
    </script>


</head>
<body>
    <form id="form1" runat="server">
   <div class="navigation"><span class="add"></span><b>您当前的位置：首页 &gt; 评论管理 &gt; 评论列表</b></div>
    <div class="spClear"></div>                
    <div class="spClear"></div>
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
    <HeaderTemplate>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
      <tr>
    
        <th width="8%">编号</th>
        <th width="8%">对应新闻</th>
        <th width="55%">内容</th>
         <th width="15%">时间</th>
        <th width="8%">操作</th>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
      <tr>       
      
        <td align="center"><asp:Label ID="lb_id" runat="server" Text='<%#Eval("FID")%>'></asp:Label></td>
        <td> <asp:Literal ID="Literal2" runat="server"  Text='<%# Eval("NID") %>'></asp:Literal>  </td>
        <td> <asp:Literal ID="Literal1" runat="server"  Text='<%# Eval("Fcontent") %>'></asp:Literal></td>
         <td align="center"><asp:Label ID="Labeltm" runat="server" Text='<%#Eval("FTime")%>'></asp:Label></td>
        <td align="center"><span><a href="FBadd.aspx?id=<%#Eval("FID") %>" rel="editClass">详  细</a></span></td>
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
