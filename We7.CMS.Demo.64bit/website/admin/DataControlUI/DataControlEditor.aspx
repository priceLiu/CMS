﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataControlEditor.aspx.cs"
    Inherits="We7.CMS.Web.Admin.DataControlUI.DataControlEditor" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>样式编辑</title>
    <base target="_self" />
   <style type="text/css">
        input, selectd
        {
            margin: 0;
        }
        td
        {
            font-size: 14px;
        }        
        body{
            margin:0px auto;  
        }    
        .CodeMirror-wrapping{
            border:1px solid #aaa;
        }    
    </style>
    <link rel="stylesheet" type="text/css" href="/admin/ajax/CodeMirror/css/docs.css"/>
    <script src="/admin/ajax/CodeMirror/js/codemirror.js" type="text/javascript"></script>

    <script type="text/javascript">
        function store()
        {
            document.getElementById("hdKey").value="";
            document.getElementById("hdValue").value="";
            var r=window.showModalDialog('FieldControl/storeCtrCopy.htm','<%=Request["ctr"] %>','scrollbars=no;resizable=no;help=no;status=no;center=1; dialogHeight=170px;dialogwidth=430px;');
            if(r)
            {
                if(r.t)
                {
                    document.getElementById("hdValue").value=r.v.name+"|"+r.v.key+"|"+r.v.desc;
                }
                document.getElementById("hdKey").value=r.t;
                return true;
            }
            return false;
        }    
    </script>

</head>
<body  style="Margin:0 auto;Padding:0;">
    <form id="form1" runat="server">
    <div>
        <table width="100%">
            <tr>
                <td>
                    <asp:TextBox ID="CtrCodeTextBox" runat="server" TextMode="MultiLine" Height="470px" Width="700px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="SaveButton" runat="server" Text="　　保存　　" OnClick="SaveButton_Click" OnClientClick="getCurrentValue();" />
                            </td>
                            <td>
                                <asp:Button ID="StoreButton" OnClientClick="getCurrentValue();return store();" runat="server" Text="　　归库　　" OnClick="StoreButton_Click" />
                                <asp:HiddenField ID="hdKey" runat="server" />
                                <asp:HiddenField ID="hdValue" runat="server" />
                            </td>
                            <td>
                                <asp:Label ID="msgLabel" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <script type="text/javascript">
        var editor = CodeMirror.fromTextArea('<%=CtrCodeTextBox.ClientID %>', {
            parserfile: ["parsexml.js", "parsecss.js", "tokenizejavascript.js", "parsejavascript.js", "parsehtmlmixed.js"],
            //              stylesheet: "/admin/Ajax/CodeMirror/contrib/csharp/css/csharpcolors.css",
            stylesheet: ["/admin/Ajax/CodeMirror/css/xmlcolors.css"
                    , "/admin/Ajax/CodeMirror/css/jscolors.css", "/admin/Ajax/CodeMirror/css/csscolors.css"],
            path: "/admin/Ajax/CodeMirror/js/",
            height: "420px",
            width: "660px",
            indentUnit: 4,
            lineNumbers: "true"
        });

        function getCurrentValue() {
             document.getElementById('<%=CtrCodeTextBox.ClientID %>').value = editor.getValue();
        }
    </script>
</body>
</html>
