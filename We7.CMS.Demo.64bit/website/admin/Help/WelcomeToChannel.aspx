<%@ Page Language="C#" MasterPageFile="~/admin/theme/ContentNoMenu.Master" AutoEventWireup="true" CodeBehind="WelcomeToChannel.aspx.cs" Inherits="We7.CMS.Web.Admin.WelcomeToChannel" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <table cellpadding="2" cellspacing="1" class="List">
        <tr>
            <th colspan="2">
                ��Ŀͨ�ò���
            </th>
        </tr>
        <tr >
            <td style="width: 15%">
                <span style="color: #0000ff">
                    �����Ŀ�ڵ�</span>
            </td>
            <td>
            ����κ���Ŀ����Ҽ��������ֲ˵������д�����Ŀ������<br />
                Ϊ���������������н���Ϣ����ɡ�������Ϣ��������Ŀѡ�������Ŀģ�塱������Ŀ��ǩ��������ĿȨ�ޡ�����ǩʽ����ѡ��Է��㰴��ݷ���������Ϣѡ�����д�������Ϣ�󣬵���ҳ��ײ�����ӡ���ť��������ӵ���Ŀ�ڵ㡣
            </td>
        </tr>
        <tr >
            <td >
                <span style="color: #0000ff">
                    �ƶ���Ŀ</span>
            </td>
            <td>
                �������ǽ�һ����Ŀ�ڵ��ԭ��λ���ƶ����µ�λ�ã��ı��������븸�ӹ�ϵ��
            </td>
        </tr>
        <tr >
            <td >
                <span style="color: #0000ff">
                    ����ɾ��</span>
            </td>
            <td>
                ������������ɾ����Ŀ�ڵ����ݣ��ò�����ͬʱɾ����Ŀ��������Ϣ�����ԣ��粻��ɾ��������ϢӦ���Ƚ�������Ϣ�ƶ��������Ŀ�ٽ���ɾ����
            </td>
        </tr>
         <tr >
            <td colspan="2" style="padding:10px" >
            <a href="/admin/ChannelEdit.aspx?pid=" class="NewBtn" >���̴���һ��������Ŀ</a>
            </td>
            </tr>
    </table>
</asp:Content>
