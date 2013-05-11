<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Copy.aspx.cs" Inherits="Add" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>复制</title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />
</head>
<body style="padding:10px;">
    <form id="form1" runat="server">
    <%--<div class="navigation">
      <span class="back"><a href="List.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 表单管理 &gt; 添加表单</b>
    </div>--%>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <th colspan="2" align="left">复制新闻</th>
        </tr>
        <tr>
            <td align="right">选择目标栏目：</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">文档ID：</td>
            <td>
             <asp:TextBox ID="txtName" runat="server"  CssClass="input w250 required" 
            maxlength="50"  Enabled="False"></asp:TextBox>
            
            </td>
        </tr>
    </table>
    <div style="margin-top:10px;text-align:center;">
  <asp:Button ID="btnSave" runat="server" Text="确认操作" CssClass="submit" onclick="btnSave_Click" />
</div>
    </form>
</body>
</html>
