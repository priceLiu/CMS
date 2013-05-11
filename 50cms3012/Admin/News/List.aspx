<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="List" EnableEventValidation="false" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link rel="stylesheet" type="text/css" href="../images/style.css" />
    <script type="text/javascript" src="../../js/jquery-1.4.1.min.js"></script>

  <script type="text/javascript">
      function popupWindow(mypage, myname, w, h, scroll) {
          var winl = (screen.width - w) / 2;
          var wint = (screen.height - h) / 2;
          winprops = 'height=' + h + ',width=' + w + ',top=' + wint + ',left=' + winl + ',scrollbars=' + scroll + ',resizable'
          win = window.open(mypage, myname, winprops)
          if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
      }


      $(function () {
          $(".msgtable tr:nth-child(odd)").addClass("tr_bg"); //隔行变色
          $(".msgtable tr").hover(
			    function () {
			        $(this).addClass("tr_hover_col");
			    },
			    function () {
			        $(this).removeClass("tr_hover_col");
			    }
		    );


          //全选
          $("#btn1").click(function () {
              $(".checkall input:checkbox").attr("checked", true);
          });
          //取消
          $("#btn2").click(function () {
              $(".checkall input:checkbox").attr("checked", false);
          });
          //复制
          $("#btn3").click(function () {
              var allid="";
              $(".checkall input:checked").each(function () {
                  allid += $(this).next("label").html()+"-";
              });
              popupWindow('copy.aspx?ids='+allid, '复制', 400, 300, 1);
          });
          //移动
          $("#btn4").click(function () {
              var allid = "";
              $(".checkall input:checked").each(function () {
                  allid += $(this).next("label").html() + "-";
              });
              popupWindow('move.aspx?ids=' + allid, '移动', 400, 300, 1);
          });
      });


    </script>

    <script type="text/javascript">
        function delete_confirm(e) {
            if (event.srcElement.outerText == "删除" || event.srcElement.value == "删除")
                event.returnValue = confirm("删除后将不能恢复，您确认执行删除操作么？");
        }
        document.onclick = delete_confirm;
</script>

</head>
<body>
    <form id="form1" runat="server">
   <div class="navigation"><span class="add"><a href="Add.aspx?CID=<%=classId%>">添加该类新闻</a></span><b>您当前的位置：首页 &gt; 资讯管理 &gt; 资讯列表</b></div>
    <div class="spClear"></div>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
                
           <img src="../Images/ico-4.png" />&nbsp;所属栏目：<asp:DropDownList ID="Classddl" runat="server" AutoPostBack="True" 
      onselectedindexchanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
                 
             
            &nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/ico-2.png" />&nbsp;筛选属性：<asp:DropDownList ID="ddlProperty" runat="server" CssClass="select" 
                onselectedindexchanged="ddlProperty_SelectedIndexChanged" 
                AutoPostBack="True">
                <asp:ListItem Value="">所有属性</asp:ListItem>
                <asp:ListItem Value="IsTop">置顶</asp:ListItem>
                <asp:ListItem Value="IsRed">推荐</asp:ListItem>
                <asp:ListItem Value="IsHot">热门</asp:ListItem>
                <asp:ListItem Value="IsSlide">幻灯片</asp:ListItem>
                <asp:ListItem Value="IsVIP">会员文章</asp:ListItem>
            </asp:DropDownList>
            
            &nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/add.gif" />&nbsp;<a href="Add.aspx?CID=<%=classId%>">添加该类新闻</a>
                   
    <div class="spClear"></div>
    <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
    <HeaderTemplate>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">
      <tr>
        <th width="6%">选择</th>
        
        <th align="left">文章标题</th>
        <th width="13%">所属类别</th>
        <th width="16%">发布时间</th>
        <th width="110">属性</th>
        <th width="18%">操作</th>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
      <tr>
        <td align="center"><asp:CheckBox ID="cb_id" CssClass="checkall" runat="server" Text='<%#Eval("NId")%>' /></td>
        
        <td><a href="/pages_<%#Eval("Classid") %>_<%#Eval("NId")%>.aspx" target=_blank><%#Eval("Title")%></a></td>
        <td align="center"><%# Eval("Classid")%></td>
        <td><%#string.Format("{0:g}", Eval("Time"))%></td>
        <td>
          
          <asp:ImageButton ID="ibtnTop" CommandName="ibtnTop" CommandArgument='<%#Eval("NId")%>' runat="server" ImageUrl='<%# Convert.ToBoolean(Eval("IsTop"))? "../Images/ico-1.png" : "../Images/ico-1_.png"%>' ToolTip='<%# Convert.ToBoolean(Eval("IsTop"))? "取消置顶" : "设置置顶"%>' />
          <asp:ImageButton ID="ibtnRed" CommandName="ibtnRed" CommandArgument='<%#Eval("NId")%>'  runat="server" ImageUrl='<%# Convert.ToBoolean(Eval("IsRed"))? "../Images/ico-2.png" : "../Images/ico-2_.png"%>' ToolTip='<%# Convert.ToBoolean(Eval("IsRed"))? "取消推荐" : "设置推荐"%>' />
          <asp:ImageButton ID="ibtnHot" CommandName="ibtnHot" CommandArgument='<%#Eval("NId")%>'  runat="server" ImageUrl='<%# Convert.ToBoolean(Eval("IsHot"))? "../Images/ico-3.png" : "../Images/ico-3_.png"%>' ToolTip='<%# Convert.ToBoolean(Eval("IsHot"))? "取消热门" : "设置热门"%>' />
          <asp:ImageButton ID="ibtnSlide" CommandName="ibtnSlide" CommandArgument='<%#Eval("NId")%>'  runat="server" ImageUrl='<%# Convert.ToInt32(Eval("IsSlide")) == 1 ? "../Images/ico-4.png" : "../Images/ico-4_.png"%>' ToolTip='<%# Convert.ToBoolean(Eval("IsSlide"))? "设置图片标记" : "取消图片标记"%>' />
        </td>
        <td align="center"><span><a href="add.aspx?id=<%#Eval("NID") %>">修改</a> &nbsp;</span>
      <asp:LinkButton ID="ibtnlock" CommandName="ibtnLock" runat="server"  CommandArgument='<%#Eval("NId")%>'><%# Convert.ToBoolean(Eval("IsLock"))? "<font color=red>锁定状态</font>" : "正常状态"%></asp:LinkButton> &nbsp;
           <asp:LinkButton ID="LinkButton1" runat="server" CommandName="del" CommandArgument='<%#Eval("NId")%>' >删除</asp:LinkButton>

		
        
        </td>
      </tr>
      </ItemTemplate>
      <FooterTemplate>
      </table>
      </FooterTemplate>
      </asp:Repeater>               

 <webdiyer:AspNetPager ID="AspNetPager1"  runat="server"  PageSize="20"  FirstPageText="首页"  LastPageText="末页" NextPageText="下一页" PrevPageText="上一页" AlwaysShow="true"  onpagechanging="AspNetPager1_PageChanging" CssClass="paginator"   CurrentPageButtonClass="cpb">

         </webdiyer:AspNetPager>
     <div class="spClear"></div>
      <div style="line-height:30px;height:30px;">
            <div id="Pagination" class="right flickr"></div>
            <div class="left">
                <span class="btn_all" id="btn1">全选</span>
                <span class="btn_all" id="btn2">取消</span>
                <span class="btn_all" id="btn3">复制</span>
                <span class="btn_all" id="btn4">移动</span>
                <%--<span class="btn_all" id="btn5">删除</span>--%>
            </div>
	</div>
    </form>
</body>
</html>
