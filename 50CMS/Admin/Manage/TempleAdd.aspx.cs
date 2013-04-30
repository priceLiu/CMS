using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ln2012.Models;
using System.Linq;

namespace ln2012.Admin.Manage
{
    public partial class TempleAdd : AdminBase
    {
        public int _Id=0;

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.CacheControl = "no-cache";
             
            if (!Page.IsPostBack)
            {

                ClassTreeBind("请选择所属类别...", this.aClassddl);
               
            }
               
           
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {

   ///<a href=\"javascript:selectLabel('{NT_DynSpecialC_" + dt.Rows[i]["SpecialID"].ToString() + "}');\"  class=\"list_link\" style=\"font-size:11.5px;font-family:Verdana;\">[导读]</a></td></tr>";
           
       

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }


        protected void CreatTable()
        {

            this.txtTag.Text = "{--LnNL*" + this.aClassddl.SelectedItem.Value + "," + this.ddStyle.SelectedItem.Value + "," + this.txtName.Text + ",15,40,0,4--}";

       }


        protected void aClassddl_SelectedIndexChanged(object sender, EventArgs e)
        {
            CreatTable();
        }

        protected void ddStyle_SelectedIndexChanged(object sender, EventArgs e)
        {
            CreatTable();
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            CreatTable();
        }
}
}
