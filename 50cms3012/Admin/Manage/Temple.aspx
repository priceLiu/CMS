<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Temple.aspx.cs" Inherits="Temple" %>

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
     });
    </script>


</head>
<body>
    <form id="form1" runat="server">
   <div class="navigation"><span class="add"><a a href="#addClass" rel="addClass">添加类别</a></span><b>您当前的位置：首页 &gt; 自定义标签管理 &gt; 自定义标签列表</b></div>
    <div class="spClear"></div>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
               
    <asp:Repeater ID="rptList" runat="server" >
    <HeaderTemplate>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
      <tr>
    
        <th width="10%">标题</th>
        <th width="20%">大小</th>
        <th width="10%">日期</th>
      </tr>

      <tr>
    
        <td width="10%">  &nbsp;&nbsp;<a href="javascript:history.back();"  title="back"><img src="../images/back.gif" alt="BACK" width="15" height="15" border="0" /></a></th>
        <td width="20%"></td>
        <td width="10%"></td>
      </tr>
      
      </HeaderTemplate>
      <ItemTemplate>

        <tr>
      
          <td height="22" bgcolor="#FFFFFF">
	          <div align="left">&nbsp;

	          <img src='../images/icon/<%#Eval("FlieType")%>.gif'  border="0" align="absmiddle" alt="" />
	          <a href="<%# GetLink(Eval("Name"),Eval("FlieType")) %>"><%# Eval("Name") %></a>
	          </div>	
	        </td>
          <td bgcolor="#FFFFFF"><div align="center"><%# Eval("Size") %></div></td>
          <td bgcolor="#FFFFFF"><div align="center"><%# Eval("LastUpdated") %></div></td>
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
