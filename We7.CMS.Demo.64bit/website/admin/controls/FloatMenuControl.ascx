<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FloatMenuControl.ascx.cs" Inherits="We7.CMS.Web.Admin.controls.FloatMenuControl" %>
	
<!--��ʾ��ݲ˵�-->		
<script>
function setshorcutmenu(setoption)
{

    var shorcutmenu=document.getElementById('shorcutmenu');
    if(shorcutmenu)
      shorcutmenu.style.display=setoption;
}
</script>		
<div style="Z-INDEX: 10; POSITION: absolute;  left:0px;top:0px;border:solid 1px 0;background-color:#333;color:#fff;font-size:12px;" onmouseout="setshorcutmenu('none')" 
onmouseover="setshorcutmenu('block')" title="����˵���ɿ��ٽ����̨�༭���ݻ�ģ��">We7����</div>
<div id="shorcutmenu"  class="DropWindow" style="Z-INDEX: 10; POSITION: absolute; left:10px;top:12px;display:none;border:solid 1px #999;background-color:#f0f0f0;font-size:12px;padding:5px;margin:3px;" 
onmouseout="setshorcutmenu('none')" onmouseover="setshorcutmenu('block')">
<%=MenuItems%>
</div>
<!--��ʾ��ݲ˵�-->  