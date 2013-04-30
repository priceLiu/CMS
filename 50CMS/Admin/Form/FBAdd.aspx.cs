using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;


    public partial class FBAdd : AdminBase
    {
        public int _Id=0;
        public int textnum = 0;
        public int Mtextnum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "no-cache";
            if (!string.IsNullOrEmpty(Request.Params["ID"]))
            {
                _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            }
            if (!Page.IsPostBack)
            {
                Entities mydb = new Entities();
                {

                    L_Feedback Lfb = mydb.L_Feedback.First(p => p.FID== _Id);
                    this.Labtitle.Text = Lfb.FName;
                    this.Labconte.Text = Lfb.FContent;

                     if (Lfb.FLock == "1")
                        CheckBox1.Checked = true;

                     txtRe.Text = Lfb.FReContent;
                    //txtName.Text = _lt.FNmae;
                    //txtTag.Text = _lt.Fother;
                    //TextC.Text = _lt.F1;
                    //txtTag2.Text = _lx.CTag2;
                    //txtTag3.Text = _lx.CTag3;


                }
            }        
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
             Entities mydb = new Entities();
                  {
                      L_Feedback Lfb = new L_Feedback();
                      Lfb = mydb.L_Feedback.First(p => p.FID == _Id);

                   //Lt.FNmae = txtName.Text.Trim();
                   //Lt.Fother = this.txtTag.Text;
                   //Lt.F1 = this.TextC.Text.Trim();
           
                      if  (this.CheckBox1.Checked)
                          Lfb.FLock = "1";
                      else
                          Lfb.FLock = "0";
                      Lfb.FReContent = this.txtRe.Text.Trim();

                      Lfb.FReTime = DateTime.Now.ToString();

                    mydb.SaveChanges();
                    JscriptPrint("回复成功啦！", "FBlist.aspx", "Success");
                }
   
       

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }


    }

