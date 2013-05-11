<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bmxx.aspx.cs" Inherits="bmxx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" type="text/css" href="../images/style.css" />
     <style type="text/css">
*{
font-size:14px; padding-top:5px; margin-top:5px;
}
</style>



</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" >
                  
                    <tr>
                      <td align="right"  width="20%">姓名:</td>
                      <td width="25%" align="left">
                          <asp:TextBox ID="TBname" runat="server" CssClass="required" HintTitle="*" HintInfo="不能为空"></asp:TextBox>
                      </td>
                      <td align="right" width="20%">姓名:</td>
                      <td width="25%" align="left">
                          <asp:TextBox ID="TBname2" runat="server" CssClass=" required"></asp:TextBox>
                      </td>
                    </tr>
                    <tr>
                      <td align="right">联系电话:</td>
                      <td align="left">
                          <asp:TextBox ID="TBtel" runat="server"  CssClass="required"></asp:TextBox>
                      </td>
                      <td align="right">联系电话:</td>
                      <td align="left">
                          <asp:TextBox ID="TBtel2" runat="server"></asp:TextBox>
                      </td>
                    </tr>
                    <tr>
                      <td align="right">身份证号码:</td>
                      <td align="left">
                          <asp:TextBox ID="TBid" runat="server"  CssClass="required"></asp:TextBox>
                      </td>
                      <td align="right">身份证号码:</td>
                      <td align="left">
                          <asp:TextBox ID="TBid2" runat="server"  CssClass="required"></asp:TextBox>
                      </td>
                    </tr>
                    <tr>
                      <td align="right">工作单位:</td>
                      <td align="left">
                          <asp:TextBox ID="TBcom" runat="server"  CssClass="required"></asp:TextBox>
                      </td>
                      <td align="right">工作单位:</td>
                      <td align="left">
                          <asp:TextBox ID="TBcom2" runat="server"  CssClass="required"></asp:TextBox>
                      </td>
                    </tr>
                    <tr>
                      <td align="right">邮箱:</td>
                      <td align="left">
                          <asp:TextBox ID="TBmail" runat="server"  CssClass="required"></asp:TextBox>
                      </td>
                      <td align="right">邮箱:</td>
                      <td align="left">
                          <asp:TextBox ID="TBmail2" runat="server"></asp:TextBox>
                      </td>
                    </tr>
                 
             
                    <tr>
                      <td colspan="2" align="center">
                      新郎
      
                      <asp:Image ID="Image1"  runat="server" CssClass="img1" Width=120px Height=85 />       </td>
                      <td colspan="2" align="center">
                      新娘
                       <asp:Image ID="Image2"  runat="server" CssClass="img1" Width=120px Height=85 />     <br>
         </td>
                    </tr>


                       <tr>
                      <td colspan="4" align="center">
        <input   type="button"   name="back"   value="返回"   onclick="javascript:history.go(-1)">


                      </td>
                    </tr>
              
                  </table>
    </div>
    </form>
</body>
</html>
