<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BmList.aspx.cs" Inherits="ln2012.Admin.Form.BmList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
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
   <div class="navigation"><span class="add"><a a href="#addClass" rel="addClass">添加类别</a></span><b>您当前的位置：首页 &gt; 分类管理 &gt; 分类列表</b></div>
    <div class="spClear"></div>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
               
                 
    <div class="spClear"></div>
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
    <HeaderTemplate>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
      <tr>
    
        <th width="10%">编号</th>
        <th width="10%">新郎名</th>
        <th width="10%">新娘名</th>
         <th width="30%">电话</th>
        <th width="20%">时间</th>
        
        <th width="20%">操作</th>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
      <tr>       
      
        <td align="center"><asp:Label ID="lb_id" runat="server" Text='<%#Eval("BID")%>'></asp:Label></td>
        <td><a href="add.aspx?id=<%#Eval("BID") %>"><%#Eval("Bname")%></a></td>
        <td><a href="add.aspx?id=<%#Eval("BID") %>"><%#Eval("Bname2")%></a></td>
        <td><%#Eval("Btel")%>  <%#Eval("Btel2")%> </td>
        <td><%#Eval("Btime")%></td>
        <td align="center"><span><a href="BMxx.aspx?id=<%#Eval("BID") %>" rel="editClass">详细</a></span>
             <asp:LinkButton ID="LinkButton1" runat="server" CommandName="del" >删除</asp:LinkButton>

		
		</td>
      </tr>
      </ItemTemplate>

      <FooterTemplate>
      </table>
      </FooterTemplate>
      </asp:Repeater>               
       <webdiyer:AspNetPager ID="AspNetPager1"  runat="server"  PageSize="20"  FirstPageText="首页"  LastPageText="末页" NextPageText="下一页" PrevPageText="上一页" AlwaysShow="true"  onpagechanging="AspNetPager1_PageChanging" CssClass="paginator"   CurrentPageButtonClass="cpb">

         </webdiyer:AspNetPager>
     <div class="spClear"></div>
      <div style="line-height:30px;height:30px;">
            <div id="Pagination" class="right flickr"></div>
      
	</div>
    </form>
</body>
</html>
