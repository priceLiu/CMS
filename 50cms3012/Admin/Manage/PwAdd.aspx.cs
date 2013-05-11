using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models;
using System.Linq;


    public partial class PwAdd : AdminBase
    {
        private int _Id=0;
        private int _isOne = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "no-cache";
            if (!string.IsNullOrEmpty(Request.Params["ID"]))
            {
                _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
                _isOne = 1;
            }
            else
            {
                _Id = int.Parse(Session["AdminID"].ToString());
            }
            if (!Page.IsPostBack)
            {

                if (_isOne != 0)
                {
                    this.Panel1.Visible = false;
                    Entities mydb = new Entities();
                    {
                        Manages _lt = mydb.Manages.First(p => p.MID == _Id);
                        this.Literal1.Text = "用户："+_lt.MName;
                    }
                }
                 

            }        
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
             Entities mydb = new Entities();
                  {
                   Manages Lt = new Manages();
                   if (_Id != 0) 
                   {
                       Lt = mydb.Manages.First(p => p.MID == _Id);
                       if (txtNew.Text.Trim().Equals("") || txtNew2.Text.Trim().Equals(""))
                       {
                           JscriptPrint("密码不能为空！", "", "Error");
                           return;
                       }
                       if (txtNew.Text.Trim() != txtNew2.Text.Trim())
                       {
                           JscriptPrint("两次密码不一致！", "", "Error");
                           return;
                       }
                       if (_isOne != 0)
                       {
                           Lt.MPWD = DESEncrypt.Encrypt(this.txtNew.Text.Trim());
                           mydb.SaveChanges();
                           JscriptPrint("对用户密码修改成功！", "", "Success");
                       }
                       else
                       {

                           if (txtOld.Text.Trim().Equals(""))
                           {
                               JscriptPrint("密码不能为空！", "", "Error");
                               return;
                           }
                           if (DESEncrypt.Encrypt(this.txtOld.Text.Trim()) != Lt.MPWD)
                           {
                               JscriptPrint("老密码不正确！", "", "Error");
                               return;
                           }
                           else
                           {

                               Lt.MPWD = DESEncrypt.Encrypt(this.txtNew.Text.Trim());
                               mydb.SaveChanges();
                               JscriptPrint("修改成功！", "", "Success");
                           }

                       }
                   }  
              
         }
       

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }

        //private void ShowInfo(int _id)
        //{

        //    Entities mydb = new Entities();
        //    {

          
        //     //txtTag2.Text = _lx.CTag2;
        //     //txtTag3.Text = _lx.CTag3;

         
        //  }
        //}

    }

