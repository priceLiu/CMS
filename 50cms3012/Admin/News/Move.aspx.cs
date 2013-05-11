using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using Models;


    public partial class Add : AdminBase
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClassTreeBindFV("0", "请选择所属类别...", this.DropDownList1);
                string allids = Request.QueryString["ids"];
                if (allids != "")
                {
                    this.txtName.Text = allids.Remove(allids.Length - 1);
                }
            }
            
            
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
           
            if (this.txtName.Text == "")
            {
                JscriptPrint("没有选择任何文档！","","Success");
              
            }
            else
            {
                Entities mydb = new Entities();
                string allids = Request.QueryString["ids"];
                string[] allidss = allids.Remove(allids.Length - 1).Split('-');
                foreach (var item in allidss)
                {
                    int newid = int.Parse(item);
                    int fid = int.Parse(this.DropDownList1.SelectedValue);
                    L_Newss onenews = mydb.L_Newss.Single(p => p.NID == newid);
                    onenews.ClassId = fid;
                    mydb.SaveChanges();
                    
                }
                
                JscriptPrint("移动完成！", "", "Success");
            }
            
        }
}

