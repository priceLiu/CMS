<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Temple_File.aspx.cs" Inherits="ln2012.Admin.Class.Temple_File" %>

 <table style="width:100%;" border="0" cellpadding="0" cellspacing="1"  class="black_border">
      <tr>
        <td class="topic">
                    栏目模板列表</td>
    </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
      <tr>
        <td width="46%" height="25" bgcolor="#F5F5F5"><div align="center">标题</div></td>
        <td width="22%" bgcolor="#F5F5F5"><div align="center">大小</div></td>
        <td width="32%" bgcolor="#F5F5F5"><div align="center">日期</div></td>
      </tr>
        <tr>
        <td height="22" colspan="3" bgcolor="#FFFFFF">&nbsp;&nbsp;<a href="#" onclick="javascript:history.back();" title="back"><img src="images/back.gif" alt="BACK" width="15" height="15" border="0" /></a></td>
      </tr>
      <asp:Repeater ID="FileList" runat="server">
        <ItemTemplate>
          <tr>
          <td height="22" bgcolor="#FFFFFF">
	          <div align="left">&nbsp;
	          <img src='images/<%# Convert.ToBoolean(Eval("IsFolder"))?"tree_folder.gif":"file.gif"%>' width="18" height="18" border="0" align="absmiddle" alt="" />
	          <a href="<%# GetLink(Eval("Name"),Eval("IsFolder")) %>"><%# Eval("Name") %></a>
	          </div>	
	        </td>
          <td bgcolor="#FFFFFF"><div align="center"><%# Eval("Size") %></div></td>
          <td bgcolor="#FFFFFF"><div align="center"><%# Eval("LastUpdated") %></div></td>
        </tr>
        </ItemTemplate>
      </asp:Repeater>      
    </table>

<script type="text/javascript">


    function SelectFile(filename) {

        var opener = window.opener;
        var cateobj = opener.document.form1.txtList;
        cateobj.value = filename;
        window.close();
    }
</script>