<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BMapPicker.ascx.cs" Inherits="We7.Model.UI.Controls.we7.BMapPicker" %>
<script type="text/javascript">
    function selectUserID() {
        var url = "/ModelUI/Controls/page/BMapPickerPage.aspx";
        weShowModelDialog(url, onAdviceListCallback);
    }
    function onAdviceListCallback(v, t) {
        //    debugger;
        var LatLng = document.getElementById("<%=txtInput.ClientID %>");
        LatLng.value = v;
    }
 </script>
<asp:TextBox runat="server" ID="txtInput" onblur="this.className='input_blur'"></asp:TextBox>
<a href="javascript:selectUserID();" >[地图]</a>
