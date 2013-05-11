<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TempleMod.aspx.cs" Inherits="TempleMod" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加自定义标签</title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />

 
    <script src="../js/Prototype.js" type="text/javascript"></script>
    <script src="../js/public.js" type="text/javascript"></script>
    <link href="../images/css.css" rel="stylesheet" type="text/css" />

</head>
<body>
   
    <form id="fromeditor" runat="server" method="post" action="" name="fromeditor">
    <div class="navigation">
      <span class="back"><a href="Temple.aspx">返回列表</a></span><b>您当前的位置：首 页 &gt; 系统标签管理 &gt; 文件修改</b>
      <span id="adress"></span>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <th colspan="2" align="left">  修改模板文件：<asp:Label ID="Labelname" runat="server" Text=""></asp:Label></th>
        </tr>

         <tr>
            <td align="right"></td>
            <td>

       <span class="reshow">
       
          Read页面标签：
       
        </span><asp:DropDownList ID="LabelList1" runat="server">
        <asp:ListItem Value="">=Read页面标签=</asp:ListItem>
        <asp:ListItem Value="<!--Read_title-->">页面标题</asp:ListItem> 
        <asp:ListItem Value="<!--Read_auth-->">作者</asp:ListItem>  
        <asp:ListItem Value="<!--Read_content-->">页面内容</asp:ListItem>
        <asp:ListItem Value="<!--Read_time-->">发布时间 </asp:ListItem>
        <asp:ListItem Value="<!--Read_from-->">来源</asp:ListItem>  
        <asp:ListItem Value="<!--Read_click-->">点击数</asp:ListItem>  
        <asp:ListItem Value="<!--Read_key-->">meta关键字KEY</asp:ListItem>
        <asp:ListItem Value="<!--Read_desc-->">meta描述</asp:ListItem>
        <asp:ListItem Value="{--LnFeedBack*N,all,2--}">留言评论标签</asp:ListItem>
        </asp:DropDownList>

 <input id="Button1" class="submit" type="button" value="插入" onclick="javascript:getValue(document.getElementById('LabelList1').value);" />
 </td></tr>
 <tr>
 <td align="right"></td>
 <td>
 	频道标签:
 <input id="Button6"  class="submit" type="button" value="内容列表标签生成" onclick="javascript:show('ChannelLabel',document.getElementById('adress'),'频道标签(点击选择)',700,380);" />
 
 	
    <span class="reshow">   
          频道其他标签：
        </span><asp:DropDownList ID="LabelList2" runat="server">
        <asp:ListItem Value="">=其他频道标签=</asp:ListItem>
        <asp:ListItem Value="{--LnTag*1--}">频道自定义标签一</asp:ListItem> 
        <asp:ListItem Value="{--LnTag*2--}">频道自定义标签二</asp:ListItem>  
        <asp:ListItem Value="{--LnTag*3--}">频道自定义标签三</asp:ListItem>
        <asp:ListItem Value="{--LnClassList*1--}">带链接栏目列表标签</asp:ListItem>
        <asp:ListItem Value="{--LnClassList*2--}">带链接栏目列表标签同级</asp:ListItem>
        <asp:ListItem Value="{--LnClassList*3--}">带链接栏目列表标签下级</asp:ListItem>
        <asp:ListItem Value="{--LnClassNav*1--}">带链接栏目导航</asp:ListItem>
        <asp:ListItem Value="{--LnClassNav*0--}">不带链接栏目导航</asp:ListItem>
        <asp:ListItem Value="{--LnClassName*1--}">带链接栏目名称</asp:ListItem>
        <asp:ListItem Value="{--LnClassName*0--}">不带链接栏目名称</asp:ListItem>
        
          
        </asp:DropDownList>  
  <input id="Button2" class="submit" type="button" value="插入" onclick="javascript:getValue(document.getElementById('LabelList2').value);" />


 </td></tr>
 <tr>
 <td align="right"></td>
 <td>
   全站通用自定义标签：
       
       <asp:DropDownList ID="DDzdy" runat="server">

        </asp:DropDownList>
        
   <input id="Button2" class="submit" type="button" value="插入" onclick="javascript:getValue(document.getElementById('DDzdy').value);" />
        
             
            </td>
        </tr>


    
        <tr>
            <td align="right"> </td>
            <td>     
             <asp:TextBox ID="Content" runat="server"  CssClass="input w250 required"  TextMode="MultiLine" Height="300px" 
              Width="700px"
            maxlength="50" ></asp:TextBox>
            
            </td>
        </tr>
     
 
    </table>
    <div style="margin-top:10px;text-align:center;">
  <asp:Button ID="btnSave" runat="server" Text="确认保存" CssClass="submit" onclick="Button1_Click" />
  &nbsp;
  <input type="button" class="submit" id="btnCancel" value="取消" onclick="javascript:UnDo();" />


</div>
    </form>
</body>

<script language="javascript" type="text/javascript">

    function UnDo() {
        if (confirm('你确定要取消所做的更改吗?')) {
            document.getElementById('fromeditor').reset();
        }
    }
    function getValue(value) {
        if (value != "")
            insert(value);
    }
</script>

</html>
