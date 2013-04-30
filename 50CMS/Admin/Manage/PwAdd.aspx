<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PwAdd.aspx.cs" Inherits="ln2012.PwAdd" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>用户修改密码</title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />

  

</head>
<body style="padding:10px;">
    <form id="form1" runat="server">
    <div class="navigation">
      <span class="back"><a href="AdminList.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 系统管理 &gt; 密码修改</b>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <th colspan="2" align="left">密码修改<asp:Literal ID="Literal1" runat="server"></asp:Literal></th>
        </tr>
        <asp:Panel ID="Panel1" runat="server" >
             <tr>
            <td align="right">原密码：</td>
            <td>
             <asp:TextBox ID="txtOld" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="原密码" HintInfo="原密码"></asp:TextBox>
            
            </td>
        </tr>
        </asp:Panel>
   

          <tr>
            <td align="right">新密码：</td>
            <td>
             <asp:TextBox ID="txtNew" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="新密码" HintInfo="新密码"></asp:TextBox>
            </td>
        </tr>
       
       
        <tr>
            <td align="right">确认新密码：</td>
            <td>
           <asp:TextBox ID="txtNew2" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="原密码" HintInfo="原密码"></asp:TextBox>
            </td>
        </tr>
      
        
  
      
    
    </table>
    <div style="margin-top:10px;text-align:center;">
  <asp:Button ID="btnSave" runat="server" Text="确认保存" CssClass="submit" onclick="btnSave_Click" />
  &nbsp;
  <input type="button" class="submit" id="btnCancel" value="取消" onclick="javascript:jQuery().colorbox.close();"/>


</div>
    </form>
</body>
</html>
