<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />
     <script type="text/javascript">
         function popupWindow(mypage, myname, w, h, scroll) {
             var winl = (screen.width - w) / 2;
             var wint = (screen.height - h) / 2;
             winprops = 'height=' + h + ',width=' + w + ',top=' + wint + ',left=' + winl + ',scrollbars=' + scroll + ',resizable'+',location=no'
             win = window.open(mypage, myname, winprops)
             if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
         }
     </script>

</head>
<body>
    <form id="form1" runat="server">
    <div class="navigation">
      <span class="back"><a href="List.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 分类管理 &gt; 添加分类</b>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <th colspan="2" align="left">添加分类</th>
        </tr>
        <tr>
            <td width="15%" align="right">上级分类：</td>
            <td width="85%">
               <asp:DropDownList ID="aClassddl" CssClass="required" runat="server" Width="209px">
				</asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">分类名称：</td>
            <td>
             <asp:TextBox ID="txtName" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="分类名称" HintInfo="控制在50个字数内，如“新闻动态”。"></asp:TextBox>
            
            </td>
        </tr>
        <tr>
            <td align="right">类型：</td>
            <td>
               <asp:DropDownList ID="DropDownList1" runat="server" style="margin-right: 0px">
                      <asp:ListItem Value="1">文章</asp:ListItem>
                      <asp:ListItem Value="2">单页</asp:ListItem>
                      <asp:ListItem Value="3">链接</asp:ListItem>
                  </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right">Meta关键字：</td>
            <td>
            <asp:TextBox ID="txtKeyword" runat="server" CssClass="input w250" 
            maxlength="100" HintTitle="Meta关键字" HintInfo="用于搜索引擎，如有多个关健字请用英文的,号分隔。"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">Meta描述：</td>
            <td>
            <asp:TextBox ID="txtZhaiyao" runat="server" CssClass="textarea wh380"  
            maxlength="250" HintTitle="Meta描述" 
                    HintInfo="用于搜索引擎，控制在250个字数内" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
  
        <tr>
            <td align="right">列表模板：</td>
            <td>
            
             <asp:TextBox ID="txtList" runat="server"  CssClass="textarea wh50" HintTitle="列表模板" 
                    maxlength="50" HintInfo="为空默认为lsit.htm 自定义请填写模板全称（不需要路径）" ></asp:TextBox>
          <input id="add3" type="button" value="..." onclick="popupWindow('Temple_File.aspx','列表模板',400,300,1)" />
              
            
            </td>
        </tr>
        <tr>
            <td align="right">内容模板：</td>
            <td>
                 <asp:TextBox ID="txtRead" runat="server"  CssClass="textarea wh50" HintTitle="内容模板" 
                    maxlength="50" HintInfo="为空时默认为read.htm 自定义请填写模板全称（不需要路径）" ></asp:TextBox>
         <input id="Button2" type="button" value="..." onclick="popupWindow('Template_Files2.aspx','内容模板',400,300,1)" />
      
            </td>
        </tr>
              <tr>
            <td align="right">自定义代码：</td>
            <td>
            <asp:TextBox ID="txtTag" runat="server" CssClass="textarea wh1020" HintTitle="自定义代码" 
                    maxlength="1020" HintInfo="调用方法<!--#Dex_Tag*1#-->。" 
                    TextMode="MultiLine" Height="150px" Width="540px"></asp:TextBox>
            </td>
        </tr>
              <tr>
            <td align="right">自定义代码2：</td>
            <td>
            <asp:TextBox ID="txtTag2" runat="server" CssClass="textarea wh1020" HintTitle="自定义代码" 
                    maxlength="1020" HintInfo="调用方法<!--#Dex_Tag*2#-->。" 
                    TextMode="MultiLine" Height="150px" Width="540px"></asp:TextBox>
            </td>
        </tr>
              <tr>
            <td align="right">自定义代码3：</td>
            <td>
            <asp:TextBox ID="txtTag3" runat="server" CssClass="textarea wh1020" HintTitle="自定义代码" 
                    maxlength="1020" HintInfo="调用方法<!--#Dex_Tag*3#-->。" 
                    TextMode="MultiLine" Height="150px" Width="540px"></asp:TextBox>
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
