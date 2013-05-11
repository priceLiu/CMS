<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminAdd.aspx.cs" Inherits="AdminAdd" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />
    <script type="text/javascript" src="../../js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../js/messages_cn.js"></script>
    <script type="text/javascript" src="../js/function.js"></script>

    <script type="text/javascript">
        $(function () {
             $("a[rel='editClass']").click(function () {
             $(this).colorbox({
                 width: 1000,
                 heigth: 500,
                 overlayClose: false,
                 close: "关闭",
                 onComplete: function () {


                     $("#form1").validate({
                         //出错时添加的标签
                         errorElement: "span",
                         success: function (label) {
                             //正确时的样式
                             label.text(" ").addClass("success");
                         }
                     });                     

                     $("#btnCancel").click(function () {
                         $.colorbox.close();
                     });
                 },
                 onClosed: function () {
                     $.colorbox.remove();
                 }
             });
         });
         
     });
</script>
<script type="text/javascript">
            $(function () {
                //表单验证JS
                $("#form1").validate({
                    //出错时添加的标签
                    errorElement: "span",
                    success: function (label) {
                        //正确时的样式
                        label.text(" ").addClass("success");
                    }
                });

            });
</script>

<style>
input[type="checkbox"] 
{
margin: 2px 3px 0px 1px;
}
</style>

</head>
<body>
    <form id="form1" runat="server">
    <div class="navigation">
      <span class="back"><a href="AdminList.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 用户管理 &gt; 用户管理</b>
    </div>
    <div class="spClear"></div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
        <tr>
            <td align="right">登录名：</td>
            <td>
             <asp:TextBox ID="txtName" runat="server"  CssClass="input w250 required" 
            maxlength="50" HintTitle="分类名称" HintInfo="控制在50个字数内，如“页面头部”。"></asp:TextBox>
            
            </td>
        </tr>


           <asp:Panel ID="Panel2" runat="server" Visible="false">
        <tr>
            <td align="right"> 密码：</td>
            <td>
               
          <a id="A1" href="PwAdd.aspx?ID=<asp:Literal ID="Literal1" runat="server"></asp:Literal>" rel="editClass">修改该用户密码</a>
            </td>
        </tr>
        </asp:Panel>

        <asp:Panel ID="Panel1" runat="server" Visible=false>
        <tr>
            <td align="right"> 密码：</td>
            <td>
            <asp:TextBox ID="txtTag" runat="server" CssClass="input w250 required" HintTitle="用户密码" 
                    HintInfo="用户密码" 
                  ></asp:TextBox>
            </td>
        </tr>

        </asp:Panel>

         <tr>
                <td align="right">管理类型：</td>
                <td>
                    <asp:RadioButtonList ID="rblUserType" runat="server" 
                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem Selected="True" Value="1">超级管理员</asp:ListItem>
                        <asp:ListItem Value="2">系统管理员</asp:ListItem>
                    </asp:RadioButtonList>
                
                </td>
        </tr>

            </table>


    <div id="contentTab">  
     <ul class="tab_nav">
        <li class="selected"><a onclick="tabs2('#contentTab',0);" href="javascript:;">系统权限设置</a></li>
        <li><a onclick="tabs2('#contentTab',1);" href="javascript:void(0);">新闻权限设置</a></li>
       
    </ul>

     <div class="tab_con" style="display:block;">
      <table id="tbList1" width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable" style="margin-top:5px;">
                <tr>
                <td>  <asp:Literal ID="ltMasterSetting" runat="server"></asp:Literal></td>
              </tr>
                <tr>
                <td>   </td>
              </tr>
                
              
          </table>
          </div>

          <div class="tab_con">
           <table width="100%" id="tbList2" border="0" cellspacing="0" cellpadding="0" class="msgtable">

      <tr>
    
        <th width="10%">编号</th>
        <th width="90%">分类标题</th>
     
  
      </tr>
         <asp:Repeater ID="rptList" runat="server" >
      <ItemTemplate>
      <tr>       
      
        <td align="center"><asp:Label ID="lb_id" runat="server" Text='<%#Eval("Classid")%>'></asp:Label></td>
        <td>
        
          <a href="add.aspx?id=<%#Eval("Classid") %>"><%#Eval("ClassName")%></a></td>
   
      </tr>
      </ItemTemplate>
      </asp:Repeater>               
      </table>
     
          </div>

        </div>
    


   
    <div style="margin-top:10px;text-align:center;">
 <span class="btn_all" onclick="checkAll(this);">全选</span> <asp:Button ID="btnSave" runat="server" Text="确认保存" CssClass="submit" onclick="btnSave_Click" />
  &nbsp;
  <input type="button" class="submit" id="btnCancel" value="取消" onclick="javascript:jQuery().colorbox.close();"/>


</div>
    </form>
</body>
</html>