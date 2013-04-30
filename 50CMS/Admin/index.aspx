<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="ln2012.Admin.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>- 后台管理</title>
    <link href="../Content/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="images/style.css">
    <script src="../js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/jquery-ui.js"></script>
    <script type="text/javascript" src="js/function.js"></script>
</head>
<body>
<form id="form1" runat="server">

<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" style="background:#EBF5FC;">
<tbody>
  <tr>
    <td height="70" colspan="3" style="background:url(images/head_bg.gif);">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="24%" height="70"><img src="images/head_logo.png" width="233" height="50"></td>
        <td width="76%" valign="bottom">
	  <!--导航菜单,与下面的相关联,修改时注意参数-->
          <div id="tabs">
          <ul>
          
			<asp:Label ID="navmenu" runat="server" Text=""></asp:Label>

          </ul>
          </div>

        </td>
      </tr>
    </table>
    <table  width="100%">
      <tr>
    <td height="30"  style="padding:0px 10px;font-size:12px;">
    <div style="float:right;line-height:20px;"><a href="center.aspx" target="sysMain">管理中心</a> | 
        <a target="_blank" href="../">预览网站</a> | 
        <asp:LinkButton 
            ID="lbtnExit" runat="server" onclick="lbtnExit_Click">安全退出</asp:LinkButton>
        </div>
    <div style="padding-left:20px;line-height:20px;background:url(images/siteico.gif) 0px 0px no-repeat;">当前登录用户：<font color="#FF0000"><asp:Label
        ID="lblAdminName" runat="server" Text=""></asp:Label></font>您好，欢迎光临。</div>
    </td>
  </tr>
    </table>
    
    </td>
  </tr>


  <tr>
    <td align="middle" id="mainLeft" valign="top" style="background:#FFF;">
	  <div style="text-align:left;width:185px;height:100%;font-size:12px;">
        <!--导航顶部-->
        <div style="padding-left:10px;height:29px;line-height:29px;background:url(images/menu_bg.gif) no-repeat;">
          <span style="padding-left:15px;font-weight:bold;color:#039;background:url(images/menu_dot.gif) no-repeat;">功能导航</span>
        </div>
        <!--导航菜单,修改时注意顺序-->
     
         
         <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
      
        
      </div>
	</td>
  
	<td valign="middle" style="background:url(images/line.jpg) repeat-y; background-color:#FFF;">
      <div id="sysBar" style="cursor:pointer;"><img id="barImg" src="images/butClose.gif" alt="关闭/打开左栏" /></div>
	</td>
	<td style="width:100%" valign="top">
   
 

   <div align="center" style="display:block; padding:100px 0 100px 0;text-align:center;color:#999999;font-size:12px; z-index: 1;" id="load"><img src="images/loading.gif" />&nbsp;loading...</div>
<iframe  onreadystatechange=stateChangeIE(this) onload=stateChangeFirefox(this) name="sysMain" id="sysMain" scrolling="yes" src="center.aspx" style="visibility:hidden;height:100%;width:100%;z-index:1;" frameborder="0"  marginheight="0"></iframe>
<script>
    function stateChangeIE(_frame) {
        if (_frame.readyState == "interactive") {
            var loader = document.getElementById("load");
            loader.innerHTML = "";
            loader.style.display = "none";
            _frame.style.visibility = "visible";
        }
    }
    function stateChangeFirefox(_frame) {
        var loader = document.getElementById("load");
        loader.innerHTML = "";
        loader.style.display = "none";
        _frame.style.visibility = "visible";
    }
    sysMain.location.href = "center.aspx"; 
</script>   


    
    </td>
  </tr>
  <tr>
    <td height="28" colspan="3" bgcolor="#EBF5FC" style="padding:0px 10px;font-size:10px;color:#2C89AD;background:url(images/foot_bg.gif) repeat-x;"></td>
  </tr>
  </tbody>
</table>

</form>
</body>
</html>
