<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TempleAdd.aspx.cs" Inherits="TempleAdd" ValidateRequest="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加自定义标签</title>
 
 <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /> 
    <link rel="stylesheet" type="text/css" href="../images/style.css" />


</head>
<body>
    <form id="form1" runat="server">
    
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable" >
        <tr>
            <th colspan="2" align="left">添加自定义标签</th>
        </tr>

           <tr>
            <td width="15%" align="right">选择分类：</td>
            <td width="85%">
          
                <asp:DropDownList ID="aClassddl" runat="server" CssClass=" required" runat="server" 
                    Width="209px" AutoPostBack="True" 
                    onselectedindexchanged="aClassddl_SelectedIndexChanged" >
                </asp:DropDownList>
                
            </td>
        </tr>


          <tr>
            <td align="right"> 新闻列表条数：</td>
            <td>
             <asp:TextBox ID="txtName" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="条数" HintInfo="条数" 
                    ontextchanged="txtName_TextChanged" AutoPostBack="True">10</asp:TextBox>
            
            </td>
        </tr>
        
        
          <tr>
            <td align="right">标题字数：</td>
            <td>
             <asp:TextBox ID="txtNu" runat="server"  CssClass="input w250 required" 
            maxlength="50" >10</asp:TextBox>
            
            </td>
        </tr>
        
        
         <tr>
            <td align="right">摘要字数：</td>
            <td>
             <asp:TextBox ID="txtZy" runat="server"  CssClass="input w250 required" 
            maxlength="50" >10</asp:TextBox>
            
            </td>
        </tr>
        
         <tr>
            <td align="right">是否分页：</td>
            <td>
             <asp:TextBox ID="txtFy" runat="server"  CssClass="input w250 required" 
            maxlength="50" >1为分页,0不分</asp:TextBox>
            
            </td>
        </tr>
        
        
       
    
        <tr>
            <td align="right">内置样式：</td>
            <td>
           <asp:DropDownList ID="ddStyle" runat="server" AutoPostBack="True"
                    onselectedindexchanged="ddStyle_SelectedIndexChanged">
               <asp:ListItem Value="<li><a href='#link#'>#title#</a></li>">纯文字标题</asp:ListItem>
               <asp:ListItem Value="<li><h2></><a href='#link#'>#title#</a></h2><h3>#time#</h3></li>">标题+日期</asp:ListItem>
               <asp:ListItem Value="<li><h1><a href='#link#'><img  src='#img#' width='230' height='153' /></a></h1><h2><a href='#link#'>#title#</a></h2></li>">图片+标题</asp:ListItem>
               <asp:ListItem Value="<li><h1><a href='#link#'><img width='517' height='168' src='#img#' border='0'/></a></h1><h2>#title#</h2><h3>#info#</h3></li>">图片+摘要</asp:ListItem>
               <asp:ListItem Value="<img  src='#img#' width='120' height='99' />">纯图片</asp:ListItem>
           
                </asp:DropDownList>
            
            </td>
        </tr>
       
       
        <tr>
            <td align="right">构造：</td>
            <td>
            <asp:TextBox ID="txtTag" runat="server" CssClass="textarea wh480" HintTitle="自定义代码" 
                    maxlength="350" HintInfo="调用方法$use_自定义标签代码$。" 
                    TextMode="MultiLine"></asp:TextBox>

            </td>
        </tr>    
    </table>
    <div style="margin-top:10px;text-align:center;">                             
   <input id="Button1" class="submit" type="button" value="插入" onclick="javascript:selectLabel(document.getElementById('txtTag').value);" />

  &nbsp;
  <input type="button" class="submit" id="btnCancel" value="取消" />


</div>

    </form>
</body>


<script language="javascript" type="text/javascript">
    function selectLabel(rvalue) {
        parent.ReturnLabelValueText(rvalue);
    }
</script>



</html>
