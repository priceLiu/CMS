<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TagsManage.aspx.cs" Inherits="We7.CMS.Web.Admin.TagsManage"
    MasterPageFile="~/admin/theme/classic/content.Master" %>
<%@ Register TagPrefix="WEC" Namespace="We7.CMS.Controls" Assembly="We7.CMS.UI" %>

<asp:Content ID="We7Content" ContentPlaceHolderID="MyContentPlaceHolder"   runat="server">
   <div>
        <h2 class="title">
            <asp:Image ID="LogoImage" runat="server" ImageUrl="~/admin/Images/icons_article.gif" />
            <asp:Label ID="NameLabel" runat="server" Text="标签管理">
            </asp:Label>
            <span class="summary">
                <asp:Label ID="SummaryLabel" runat="server" Text="">
                </asp:Label>
            </span>
        </h2>
        <div id="position">
            &nbsp; <a href='/admin/'>控制台</a> >  <a  href="javascript:void(0);">标签管理</a> 
        </div>
      
        <WEC:MessagePanel ID="Messages" runat="server">
        </WEC:MessagePanel>
    </div>
       <script type="text/javascript" src="/scripts/we7/we7.loader.js">
              // 定义要绑定的资源的目标
        var bindDestination = new we7.BindOption({
            tableName: "Tags"
		    , fields: { "ID": {}, "Identifier": {}, "Frequency": {}, "Updated": {}, "Created": {} }
			, sortField: "Created"
			, sortOrder: "desc"
            , rows: 10
        });

        //绑定过程
        function bindData() {
            var options = {
                caption: "标签表",
                height: 220,
                rowNum: 10,
                autowidth: true,
                editColumnHeader: "管理",
                editableRow:false,
                deletableRow: true,
                isSiteGroup: false
            };

            we7("#ModelList").bind(bindDestination, options);
        }

        $(document).ready(function () {

            bindData();

        });

    </script>
  
    <table id="ModelList" style="display: none">
        <tr>
            <td header="标签">
                <a href="Permissions/AccountEdit.aspx?id=${ID}">${Identifier}</a>
            </td>
            <td header="使用次数">
                ${Frequency}
            </td>
     
            <td header="创建日期">
                {{html Created.substr(0,10)}}
            </td>
          
        </tr>
    </table>
</asp:Content>
