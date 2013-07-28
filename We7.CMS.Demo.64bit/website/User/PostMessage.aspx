<%@ Page Language="C#" MasterPageFile="~/User/DefaultMaster/content.Master" AutoEventWireup="true"
    CodeBehind="PostMessage.aspx.cs" Inherits="We7.CMS.Web.User.PostMessage" Title="发短消息" %>

<%@ Register Assembly="We7.CMS.UI" Namespace="We7.CMS.Controls" TagPrefix="WEC" %>
<%@ Register tagPrefix="WEC" tagName="AttachmentUpload" src="~/ModelUI/Controls/system/Attachment.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyHeadPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <div class="realRight ml10">
        <div class="mybox">
            <div class="mytit">
                发送短消息</div>
            <div class="con">
                <ul style="<%= SMDisplay %>">
                    <li class="notetitle">
                        <%= Subject %></li>
                    <li class="notetime">发送人:
                        <%= Receivers %> &nbsp;(<%= SendTime %>)</li>
                    <li class="notecontent"><%= Content %></li>
                    <% if (null != CurrentMessage){%>
                    <li class="notecontent">
                      <label class="labelshort" for="attachments">附件:</label>
                        <ul>
                            <% string ___someid;foreach (We7.CMS.Common.Attachment attachment in MessageHelper.GetAttachments(CurrentMessage, out ___someid)){%>
					            <li><a href="<%=attachment.DownloadUrl %>&authtype=user&key=<%=Guid.NewGuid().ToString("n") %>" target="_blank"><%= String.Format("{0} [{1}]", attachment.FileName, attachment.FileSizeText) %></a> </li>
					        <% } %>
                        </ul>
                    </li>
                    <% } %>
                    <li class="notecontent">
                        <br />
                        <img alt="查看信息" src="style/images/leftdot.gif">
                        <a href="message.aspx?state=inbox">返回列表</a>
                        <%--				<a href="usercppostpm.aspx?action=re&amp;pmid=2370">回复</a>
				<a href="usercppostpm.aspx?action=fw&amp;pmid=2370">转发</a>
				<a href="usercpshowpm.aspx?action=noread&amp;pmid=2370">标记为未读</a>
				<a href="usercpshowpm.aspx?action=delete&amp;pmid=2370">删除</a>--%>
                    </li>
                </ul>
                <dl style="<%=MessageDisplay %>">
                    <dd class="pad" style="color: Red">
                        <%=Get("Message") %>
                    </dd>
                </dl>
                <form id="Form1" runat="server">
                <label class="labelshort" for="user">
                    选择收件人:</label><input id="txtReceiver" runat="server" type="text" size="20" onblur="this.className='colorblue';"
                           onfocus="this.className='colorfocus';" class="colorblue" name="Receivers" required="required" /><select id="account-list"></select><br />
                <br />
                <label class="labelshort" for="email">
                    标题:
                </label>
                <input id="txtSubject" runat="server" type="text" size="40" onblur="this.className='colorblue';"
                       onfocus="this.className='colorfocus';" class="colorblue" name="Subject" required="required"/><br />
                <br />
                <label class="labelshort" for="comment">内容:</label>
                <textarea id="txtContent" runat="server"  style="width: 80%;" onkeydown="if((event.ctrlKey &amp;&amp; event.keyCode == 13) || (event.altKey &amp;&amp; event.keyCode == 83)) document.getElementById('postpm').submit();"
                        onblur="this.className='colorblue';" onfocus="this.className='colorfocus';" class="colorblue"
                        rows="20" cols="80" name="Content"></textarea><br>
                <label class="labelshort" for="attachments">附件:</label><WEC:AttachmentUpload runat="server" ID="AttachmentUploader"></WEC:AttachmentUpload>
                <span>为确保网络畅通和服务器安全，附件需为小于 4 MB 的文件。</span>
				</form>
                <form onsubmit="return addingMsg(this);" id="<%=ActionID %>" action="/User/Action/AddMessage.ashx?Action=send" method="post" target="_self">
                    <input type="checkbox" style="border: 0pt none;" value="1" name="SavetoOutbox" />发送的同时保存到发件箱
                    <br /><br />
                    <input type="submit" class="sbutton" value="立即发送" />
                    <input type="submit" class="sbutton" value="存为草稿" onclick="submitAction('saveDraft')" />&nbsp;&nbsp;[完成后可按Ctrl+Enter提交]
                    <input name="_ActionID" type="hidden" value="<%=ActionID %>" />
                    <input name="AttachmentArticleId" type="hidden" value="<%=AttachmentArticleID %>"/>
                    <input type="hidden" name="Receivers"/>
                    <input type="hidden" name="Subject"/>
                    <input type="hidden" name="Content"/>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    function addingMsg(form) {
        var txtR = $("#<%= txtReceiver.ClientID %>"),
            txtS = $("#<%= txtSubject.ClientID %>");
        var receivers =txtR.val(),
            subject = txtS.val();
        if(!receivers) {
            alert("必须至少指定一个收件人");
            txtR[0].focus();
            return false;
        }
        
		if(!subject && subject.length < 4) {
            alert("必须填写标题，且长度为 4 以上");
            txtS[0].focus();
            return false;
        }
        
        $("input[name='Receivers']").val(receivers);
        $("input[name='Subject']").val(subject);
        $("input[name='Content']").val($("#<%= txtContent.ClientID %>").val());
        return true;
    }

    function submitAction(action) {
        document.getElementById("<%= ActionID %>").action = "/User/Action/AddMessage.ashx?Action=" + action;
        //document.getElementById("<%= ActionID %>").submit();
    }

    var accounts = [<%=AccountNameList %>];
    var selectAccount = $("#account-list");
    if(accounts.length) {
        for(var _i=0;_i<accounts.length;_i++) {
            var text = unescape(accounts[_i]);
            $("<option />").attr({value:text}).text(text).appendTo(selectAccount);
        }
    }else {
        selectAccount.hide();
    }
    selectAccount.change(function() {
        var txt = $("#<%= txtReceiver.ClientID %>"), c = txt.val();
        var go = true, val = this.value;
        if(c) {
            $.each(c.split(','), function(i,item) {
                if(item == val) {
                    go = false;
                    return false;
                }
            });
        }
        if(go) {
            txt.val(c ? (c + ',' + this.value) : this.value);
        }
    });
</script>
</asp:Content>
