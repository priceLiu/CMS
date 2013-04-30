using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;


    public partial class Add : AdminBase
    {
        public int _Id=0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "no-cache";
            if (!string.IsNullOrEmpty(Request.Params["ID"]))
            {
                _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            }
            if (!Page.IsPostBack)
            {
                if (_Id != 0)
                ShowInfo(_Id);
            }        
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
             Entities mydb = new Entities();
                  {
                      L_Form Lt = new L_Form();
                   if (_Id != 0)
                       Lt = mydb.L_Form.First(p => p.FID == _Id);

                   Lt.FNmae = txtName.Text.Trim();
                   Lt.Fother = this.txtTag.Text;
                   Lt.F1 = this.TextC.Text.Trim();
                   Lt.FStat = 0;
                    
   
                if (_Id == 0)
                {
                    mydb.L_Form.AddObject(Lt);
                    mydb.SaveChanges();
                    JscriptPrint("表单发布成功啦！", "list.aspx", "Success");
                }
                else
                {
                    mydb.SaveChanges();
                    JscriptPrint("表单修改成功啦！", "list.aspx", "Success");
                }
         }
       

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }

        private void ShowInfo(int _id)
        {

            Entities mydb = new Entities();
            {

              L_Form _lt = mydb.L_Form.First(p => p.FID == _id);    
              txtName.Text = _lt.FNmae;
              txtTag.Text = _lt.Fother;
              TextC.Text = _lt.F1;

             //txtTag2.Text = _lx.CTag2;
             //txtTag3.Text = _lx.CTag3;

         
          }
        }

    }

