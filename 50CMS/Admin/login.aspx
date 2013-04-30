<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="ln2012.Admin.login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="zh-cn">
<head>
<meta charset="utf-8" />
<title>管理登陆</title>
<meta name="author" content="lf" />
	<script type="text/javascript" src="../js/jquery-1.4.1.min.js"></script>
	<script type="text/javascript" src="js/player.js"></script>


        <!--[if lte IE 6]>
        <script src="js/pngfixed.js" type="text/javascript"></script>
        <script> DD_belatedPNG.fix('img,#lbtn,#loginarea .filed .input,#loginarea .filedBtn .subBtn,#area li,#BalloonA,#BalloonB,#regbox,#rbtn,#aside #sidetop,#aside #dasbard,#wrap,#postblog .pop,#header #tool #side #menuSideBtn,#header #nav li.current,#header #logo a,#aside #search input.btn,#aside #search,#aside .hr,#article .box .top .jiao,.contentTop');</script>
        <![endif]-->

<script src="js/login.js"></script>    
<link href="js/css/login.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div id="wrap">

  <div id="main">
	<div id="rbtn"><a href="/">返回首页</a></div>
    <div id="logo"><a href="/"><img src="Images/head_logo.png"  alt="logo" /></a></div> <div id="BalloonA"></div><div id="BalloonB"></div> 
     <div style="height:65px; clear:both"></div>
     
  <table border="0" align="center" cellpadding="0" cellspacing="0" id="regbox">
      <tr>
        <td width="386" rowspan="2" valign="top"> 
        <form id="form1" runat="server">
        <div id="regarea">
              <h1>登  陆 </h1>  <div style="background:url(Images/hint.gif) 0 6px no-repeat; padding-left:15px;padding-top:5px; float:right">提示：<asp:Label ID="lbMsg" 
                          runat="server" Text="如果登录失败3次，需关闭后才能重新登录"  ForeColor="Red"></asp:Label>
                    </div>
                             <div class="clear"></div>
              <div class="filed"><label class="nocontent">用户名</label>
              <asp:TextBox ID="txtUserName" runat="server" CssClass="input" 
                            HintTitle="请输入登录帐号" HintInfo="用户名必须是字母或数字，不能包含空格或其它非法字符，不区分大小写。"></asp:TextBox>
                </div><div class="clear"></div>
              <div class="filed"><label class="nocontent">密码</label>
              <asp:TextBox ID="txtUserPwd" runat="server" CssClass="input" 
                            HintTitle="请输入登录密码" HintInfo="登录密码必须>=6位且是字母或数字，不能包含空格或其它非法字符，不区分大小写。" 
                            TextMode="Password"></asp:TextBox>
			 </div><div class="clear"></div>
            <div class="filed" style="margin:0px">
            <label class="nocontent">验证码
           
            </label>
              <script type="text/javascript" language="JavaScript">
                                    var numkey = Math.random();
                                    numkey = Math.round(numkey * 10000);
                                    document.write("<img src=\"js/imgcode.aspx?k=" + numkey + "\" width=\"70\" onClick=\"this.src+=Math.random()\" alt=\"图片看不清？点击重新得到验证码\" style=\"cursor:pointer;\" height=\"25\" hspace=\"4\">");
          </script>
           <asp:TextBox ID="TextCode" runat="server" CssClass="input2" 
                            HintTitle="请输入验证码" HintInfo="验证" 
                            TextMode="Password"></asp:TextBox>
           </div><div class="clear"></div>
                
               <div class="filed"><label class="nocontent"></label>
              
			  <asp:ImageButton ID="loginsubmit" runat="server" CssClass="login_btn" 
                            ImageUrl="images/login_btn.gif" onclick="loginsubmit_Click" />

			  <span class="regcurr"></span></div><div class="clear"></div>

         

        </div> 
       
        </form>
        </td>
      </tr>
    </table>   
  </div>
  
  
  <div id="footer"></div>
  <div id="copyright">
  
        <div class="copy">
         <a href="#" target="_blank">Powered by 50CMS  3.0β build 20120801 </a></div>
  </div>
    

</div>
</body>
</html>



