<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SysConfig.aspx.cs" Inherits="SysConfig" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />
    <script type="text/javascript" src="../../js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../js/messages_cn.js"></script>
    <script type="text/javascript" src="../../js/jquery.form.js"></script>
    <script type="text/javascript" src="../js/function.js"></script>

    <script type="text/javascript">  
        $(function() {
            //表单验证JS
            $("#form1").validate({
                //出错时添加的标签
                errorElement: "span",
                success: function(label) {
                    //正确时的样式
                    label.text(" ").addClass("success");
                }
            });
          
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="navigation">
      <span class="back"><a href="#">返回列表</a></span><b>您当前的位置：首页 &gt; 系统管理 &gt; 系统信息修改</b>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
    <td width="25%" align="right">网站名称：</td>
    <td width="75%">
        <asp:TextBox ID="txtWebName" runat="server" CssClass="input required" size="48" 
            maxlength="50" HintTitle="系统的名称" HintInfo="给你的系统起个有意义的名字哦，长度不能超过50个字符。"></asp:TextBox>
    </td>
  </tr>

  <tr>
    <td align="right">办公电话：</td>
    <td>
	<asp:TextBox ID="txtWebTel" runat="server" CssClass="input required" size="25" 
            maxlength="50" HintTitle="办公电话号码" HintInfo="格式如：0757-22228888。"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">管理员信箱：<br /></td>
    <td><asp:TextBox ID="txtWebEmail" runat="server" CssClass="input" size="25" 
            maxlength="50" HintTitle="网站管理员信箱" HintInfo="方便客户需要咨询时发送邮件。"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">网站备案号：</td>
    <td><asp:TextBox ID="txtWebCrod" runat="server" CssClass="input" size="25" 
            maxlength="50" HintTitle="网站备案号码" HintInfo="信息产业部申请的合法TCP/IP备案号。"></asp:TextBox></td>
  </tr>
  <tr>
    <td align="right">网站关健字：</td>
    <td>
      <asp:TextBox ID="txtWebKeywords" runat="server" CssClass="input" style="width:300px;" maxlength="250" HintTitle="网站关健字" HintInfo="搜索引擎可根据网站设置的关健字，以“,”号分隔开。"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">网站描述：</td>
    <td>
      <asp:TextBox ID="txtWebDescription" runat="server" CssClass="textarea" style="width:300px;height:45px;" maxlength="250" HintTitle="网站描述" HintInfo="搜索引擎可根据网站设置的描述信息，字符小于等于250位字符。" 
            TextMode="MultiLine"></asp:TextBox>
        &nbsp;</td>
  </tr>
    <tr>
    <td align="right">允许上传附件类型：</td>
    <td>
    <asp:TextBox ID="Textfuj" runat="server" CssClass="input required" size="75" 
            maxlength="150" HintTitle="允许上传附件类型" HintInfo="用 | 隔开大写 格式如：GIF|JPG|PNG|BMP|RAR|DOC|XLS|TXT"></asp:TextBox>
       </td>
  </tr>

    <tr>
    <td align="right">开启日志：</td>
    <td>
     <asp:CheckBox ID="CBLog" runat="server"  />
     
     </td>
     </tr>

     <tr>
    <td align="right">开启新闻栏目权限：</td>
    <td>
     <asp:CheckBox ID="CBNews" runat="server"  />
     
     </td>
     </tr>
      
    
    </table>
    <div style="margin-top:10px;text-align:center;">
  <asp:Button ID="btnSave" runat="server" Text="确认保存" CssClass="submit" onclick="btnSave_Click" />
  &nbsp;
  <input type="button" class="submit" id="btnCancel" value="取消" />


</div>
    </form>
</body>
</html>
