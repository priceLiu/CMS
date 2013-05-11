<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Temple_File.aspx.cs" Inherits="Temple_File" %>
<link rel="stylesheet" type="text/css" href="../images/style.css" />
<style>
table{
	color:#666;
	font-family:Verdana, Geneva, sans-serif;
	font-size:12px;
}
</style>
 <table style="width:100%;" border="0" cellpadding="0" cellspacing="1" >
      <tr>
        <td class="topic">
                    栏目模板列表</td>
    </tr>
    </table>
    <br />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
      <tr>
        <td class="topic">
                    目录:<asp:Literal ID="Literal1" runat="server"></asp:Literal></td>
    </tr>
    </table>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
      <tr>
        <td width="46%" height="25" bgcolor="#F5F5F5"><div align="center">标题</div></td>
        <td width="10%" bgcolor="#F5F5F5"><div align="center">大小</div></td>
        <td width="44%" bgcolor="#F5F5F5"><div align="center">日期</div></td>
      </tr>
        <tr>
        <td height="22" colspan="3" bgcolor="#FFFFFF">&nbsp;&nbsp;<a href="javascript:history.back();"  title="back"><img src="../images/back.gif" alt="BACK" width="15" height="15" border="0" /></a></td>
      </tr>
      <asp:Repeater ID="FileList" runat="server">
        <ItemTemplate>
          <tr>
          <td height="22" bgcolor="#FFFFFF">
	          <div align="left">&nbsp;
	          <img src='../images/icon/<%#Eval("FlieType")%>.gif'  border="0" align="absmiddle" alt="" />
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
        var cateobj = opener.document.getElementById('txtList');
        cateobj.value = filename;
        window.close();
    }
</script>