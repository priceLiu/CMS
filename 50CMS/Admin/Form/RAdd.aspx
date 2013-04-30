<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RAdd.aspx.cs" Inherits="RAdd" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加自定义标签</title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />

</head>
<body style="padding:10px;">
    <form id="form1" runat="server">
    <div class="navigation">
      <span class="back"><a href="RList.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 表单管理 &gt; 回复表单</b>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <th colspan="2" align="left">添加表单</th>
        </tr>
    
        <tr>
            <td align="right">表单名称：</td>
            <td>
                <asp:Label ID="Labtitle" runat="server" Text="Label"></asp:Label>

       
            </td>
        </tr>

    
       
       
    
      
        <tr>
            <td align="right">表单项目：</td>
            <td>
               <asp:Table ID="Table1" runat="server" Width="100%" CssClass="bluetable"  HorizontalAlign="Center">
        </asp:Table>
            </td>
        </tr>


              <tr>
            <td align="right">前台是否显示：</td>
            <td>
             <asp:CheckBox ID="CheckBox1" runat="server"  />
            </td>
        </tr>
  
          <tr>
            <td align="right">回复内容：</td>
            <td>
            <asp:TextBox ID="txtRe" runat="server" CssClass="textarea wh380" 
                    maxlength="250" 
                    TextMode="MultiLine"></asp:TextBox>
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
