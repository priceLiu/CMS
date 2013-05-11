<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>发布资讯</title>
    <link rel="stylesheet" type="text/css" href="../images/style.css" />
    <script type="text/javascript" src="../../js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../../js/messages_cn.js"></script>
    <script type="text/javascript" src="../../js/jquery.form.js"></script>
    <script type="text/javascript" src="../js/function.js"></script>
    <script type="text/javascript" src="../../KindEditor/kindeditor.js"></script>
    <script charset="utf-8" src="../../KindEditor/lang/zh_CN.js"></script>
    <script src="../../Content/My97DatePicker/WdatePicker.js" type="text/javascript"></script>


    <script type="text/javascript">
        var editor;
        KindEditor.ready(function(K) {
                editor = K.create('#txtContent', {
                        resizeType : 2,
                        uploadJson : '../../../Content/Tools/upload_json.ashx', // 相对于当前页面的路径
                        fileManagerJson : '../../../Content/Tools/file_manager_json.ashx',
                        allowFileManager: true
                });
                });

                $(function () {

            //表单验证JS
            $("#form1").validate({

                //出错时添加的标签
                errorElement: "span",
                success: function(label) {
                    //正确时的样式
                    label.text(" ").addClass("success");
                }
            });
            //显示关闭高级选项
            $("#upordown").toggle(function() {
                $(this).text("关闭高级选项");
                $(this).removeClass();
                $(this).addClass("up-01");
                $(".upordown").show();
            }, function() {
                $(this).text("显示高级选项");
                $(this).removeClass();
                $(this).addClass("up-02");
                $(".upordown").hide();
            });

            var imgurl = document.getElementById("txtImgUrl").value;
            if (imgurl != "")
             {
            $(".imgbox").empty();
            $(".imgbox").css({ background: "none" });
            $(".imgbox").append("<img src=\"" + imgurl + "\" />");
            }
        });


    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="navigation">
      <span class="back"><a href="List.aspx">返回列表</a></span><b>您当前的位置：首页 &gt; 资讯管理 &gt; 发布资讯</b>
    </div>



      <div id="contentTab">  
     <ul class="tab_nav">
        <li class="selected"><a onclick="tabs2('#contentTab',0);" href="javascript:;">基础信息</a></li>
        <li><a onclick="tabs2('#contentTab',1);" href="javascript:void(0);">封面图片</a></li>
       <li><a onclick="tabs2('#contentTab',2);" href="javascript:void(0);">扩展信息</a></li>
    </ul>

     <div class="tab_con" style="display:block;">

    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">       
            <tr>
            <td width="80" align="right">文章标题：</td>
            <td >
            <asp:TextBox ID="txtTitle" runat="server" CssClass="input w380 required" 
            maxlength="250" minlength="1" HintTitle="发布的文章标题" HintInfo="控制在100个字数内，标题文本尽量不要太长。"></asp:TextBox>
            </td>
         
        </tr>
   
        <tr>
            <td align="right">所属栏目：</td>
            <td><asp:DropDownList id="ddlClassId" CssClass="required" runat="server" HintTitle="类型" HintInfo="类型为单页或者跳转的默认只取该分类下最新一篇文章"></asp:DropDownList></td>
        </tr>

          <tr>
            <td align="right">跳转地址：</td>
            <td> <asp:TextBox ID="txtUrl" runat="server" CssClass="input w250" 
            maxlength="100" HintTitle="跳转地址" HintInfo="外网地址请写完整URL如：http://www.lnkj.cc 本站地址可以用相对地址如：list12.aspx"></asp:TextBox></td>
        </tr>
        <tr>
            <td align="right">文章属性：</td>
            <td >
                <asp:CheckBoxList ID="cblItem" runat="server" 
                    RepeatDirection="Horizontal" RepeatLayout="Flow">
                    <asp:ListItem Value="1">锁定</asp:ListItem>
                    <asp:ListItem Value="1">置顶</asp:ListItem>
                    <asp:ListItem Value="1">推荐</asp:ListItem>
                    <asp:ListItem Value="1">热点</asp:ListItem>
                    <asp:ListItem Value="1">图片</asp:ListItem>
                </asp:CheckBoxList>       
                 <span id="upordown" class="up-02">显示高级选项</span>



            </td>
        </tr>
        
          <tr class="upordown hide">
            <td align="right">文章作者：</td>
            <td>
            <asp:TextBox ID="txtAuthor" runat="server" CssClass="input w250 required" 
            maxlength="50" HintTitle="文章作者" HintInfo="控制在50个字数内，如“管理员”。">管理员</asp:TextBox>
            </td>
        </tr>
        <tr class="upordown hide">
            <td align="right">文章来源：</td>
            <td>
            <asp:TextBox ID="txtForm" runat="server" CssClass="input w250 required" 
            maxlength="100" HintTitle="信息来源" HintInfo="控制在50个字数内，如“本站”。">本站</asp:TextBox>
          
            </td>
        </tr>
       

            <tr class="upordown hide">
            <td align="right" >Word上传：</td>
            <td >
  
  <input id="Fileword" type="file" runat="server"  class="fileword" />
  <asp:Button ID="Button2" runat="server" OnClick="btnUpload_Click" Text="提交"  CssClass="cancel"/> 
   
   <!--a href="javascript:void(0);" class="fileword"><input type="file" id="Fileip" name="Fileip" onchange="WordUpload('txtContent','Fileip')" /></a>
   <span class="uploadingw">正在上传，请稍候...</span-->

   可以直接上传word文件至发布系统，并自动上传WORD中的图片文件，注意word文件大小不要超过2m为宜。
            </td>
          </tr>

        <tr>
            <td align="right" valign="top">文章内容：</td>
            <td colspan="2">
                <textarea id="txtContent" cols="100" rows="8" style="width:100%;height:400px;visibility:hidden;" runat="server"></textarea>
            </td>
        </tr>
       
 <tr>
            <td align="right" valign="top"></td>
            <td colspan="2">
  <div style="margin-top:10px;">
  <asp:Button ID="btnSave" runat="server" Text="确认保存" CssClass="submit" onclick="btnSave_Click"  />
  &nbsp;
  <input name="重置" type="reset" class="submit" value="重置" />
</div>
           </td>
        </tr>




    </table>
   
   </div>


   
         <div class="tab_con">
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">       
            <tr >
             <td width="343" rowspan="9" align=center>
             
              <div class="imgbox"></div>
         
             <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input w250 left" style="display:none;"></asp:TextBox>
                <a href="javascript:void(0);" class="files">
                <input type="file" id="FileUpload" name="FileUpload" onchange="SingleUpload('txtImgUrl','FileUpload')" /></a>
                <a class="uploading">正在上传，请稍候...</a>
            
            </td>
           </tr>
      
           </table>
        </div>

        <div class="tab_con">
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="msgtable">  
         
             <tr >
            <td align="right">Meta关键字：</td>
            <td >
            <asp:TextBox ID="txtKeyword" runat="server" CssClass="input w250" 
            maxlength="100" HintTitle="Meta关键字" HintInfo="用于搜索引擎，如有多个关健字请用英文的,号分隔，不填写将自动提取标题。"></asp:TextBox>
            </td>
             </tr>    
            <tr >
            <td align="right">Meta描述：</td>
            <td colspan="2">
            <asp:TextBox ID="txtZhaiyao" runat="server" CssClass="textarea wh380"  
            maxlength="250" HintTitle="Meta描述" 
                    HintInfo="用于搜索引擎，控制在250个字数内，不填写将自动提取。" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr >
            <td align="right">文章导读：</td>
            <td colspan="2">
            <asp:TextBox ID="txtDaodu" runat="server" CssClass="textarea wh380" HintTitle="文章导读属性" 
                    maxlength="250" HintInfo="控制在250个字数内，纯文本，不填写将自动提取。" 
                    TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
          <tr>
            <td align="right">浏览次数：</td>
            <td >
            <asp:TextBox ID="txtClick" runat="server" CssClass="input required number" size="10" 
            maxlength="10" HintTitle="文章的浏览次数" HintInfo="纯数字，本文章被阅读的次数。">0</asp:TextBox>
     
            </td>
          </tr>
        <tr >
            <td align="right">发布日期：</td>
            <td> <asp:TextBox ID="txtRQ" runat="server" CssClass="input w250" 
            maxlength="100" HintTitle="发布日期" HintInfo="日期为空自动取服务器当前日期"></asp:TextBox>
            <img onclick="WdatePicker({el:'txtRQ',dateFmt:'yyyy/MM/dd HH:mm:ss'})" src="../../Content/My97DatePicker/skin/datePicker.gif" align="absmiddle">
            
            </td>
        </tr>
           </table>
        </div>


   </div>
    
    </form>
</body>
</html>
