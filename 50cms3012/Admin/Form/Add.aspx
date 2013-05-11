<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加自定义标签</title>
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
      <span class="back"><a href="List.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 表单管理 &gt; 添加表单</b>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <th colspan="2" align="left">添加表单</th>
        </tr>
    
        <tr>
            <td align="right">表单名称：</td>
            <td>
             <asp:TextBox ID="txtName" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="表单名称" HintInfo="控制在50个字数内，如“留言板”。"></asp:TextBox>
            
            </td>
        </tr>

          <tr>
            <td align="right">是否开放：</td>
            <td>
             <asp:CheckBox ID="CheckBox1" runat="server"  />
            </td>
        </tr>
       
       
        <tr>
            <td align="right">表单简介：</td>
            <td>
            <asp:TextBox ID="txtTag" runat="server" CssClass="textarea wh380" HintTitle="自定义代码" 
                    maxlength="250" HintInfo="调用方法$use_自定义标签代码$。" 
                    TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
      
        <tr>
            <td align="right">表单项目：</td>
            <td>
            <asp:TextBox ID="TextC" runat="server" CssClass="textarea wh380" HintTitle="表单项目" 
                    maxlength="250" HintInfo="注：  用   |  分开每个表单标题，并以 | 结尾" 
                    TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>

  
      
    
    </table>
    <div style="margin-top:10px;text-align:center;">
  <asp:Button ID="btnSave" runat="server" Text="确认保存" CssClass="submit" onclick="btnSave_Click" />
  &nbsp;
  <input type="button" class="submit" id="btnCancel" value="取消" onclick="javascript:jQuery().colorbox.close();" />


</div>
    </form>
</body>
</html>
