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
       

                JscriptPrint("没有选择任何文档！", "", "Success");
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
                    L_Newss ln = new L_Newss();
                    ln.ClassId = fid;
                    ln.Title = onenews.Title;
                    ln.Author=onenews.Author;
                    ln.From=onenews.From;
                    ln.Tag=onenews.Tag;
                    ln.ZhaiYao=onenews.ZhaiYao;
                    ln.Img=onenews.Img;
                    ln.Content=onenews.Content;
                    ln.Click=onenews.Click;
                    ln.Url=onenews.Url;
                    ln.Time=DateTime.Now;
                    ln.IsTop=onenews.IsTop;
                    ln.IsHot=onenews.IsHot;
                    ln.IsSlide=onenews.IsSlide;
                    ln.IsLock=onenews.IsLock;
                    ln.IsRed=onenews.IsRed;
             
                    mydb.L_Newss.AddObject(ln);
                    mydb.SaveChanges();
                    
                }

                JscriptPrint("复制完成！", "", "Success");
                
            }
            
        }
}

