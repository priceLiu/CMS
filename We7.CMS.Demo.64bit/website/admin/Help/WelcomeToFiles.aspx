<%@ Page Language="C#" MasterPageFile="~/admin/theme/ContentNoMenu.Master" AutoEventWireup="true" CodeBehind="WelcomeToFiles.aspx.cs" Inherits="We7.CMS.Web.Admin.WelcomeToFiles" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <table cellpadding="2" cellspacing="1" class="List"  >
        <tr >
            <th   colspan="2">
                �����ļ���˵��&nbsp;</th>
        </tr>
        <tr  >
            <td  style="width: 15%">
                <a href="../Folder.aspx?folder=_data" ><span style="color: #0000ff">
                    _data</span></a>
            </td>
            <td>
                ���ͼƬ�������� ����Ŀchannel��Ϊÿ����Ŀ��Ӧ���ļ��У���Ÿ���Ŀ������ͼƬ��������</td>
        </tr>
        <tr >
            <td >
                <a  href="../Folder.aspx?folder=_skin"><span style="color: #0000ff">
                    _skin</span></a>
            </td>
            <td>
                ���ģ�����ļ���ÿ��ģ����һ��������Ŀ¼��
            </td>
        </tr>
        <tr >
            <td >
                <a href="../Folder.aspx?folder=_templates" ><span style="color: #0000ff">
                    _templates</span></a>
            </td>
            <td>
                ��ģ�����ģ���ŵء�&nbsp;</td>
        </tr>
        <tr >
            <td >
                <a ><span style="color: #0000ff">
                    </span></a>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

</asp:Content>
