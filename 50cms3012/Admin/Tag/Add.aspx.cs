using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using Models;


    public partial class Add : AdminBase
    {
        public int _Id=0;

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.CacheControl = "no-cache";
                //chkLoginLevel("addArticle");
                ////绑定类别

            
                //if (!string.IsNullOrEmpty(Request.Params["classId"]))
                //{
                //    ddlClassId.SelectedValue = Request.Params["classId"].Trim();
                //}

                //if (!int.TryParse(Request.Params["id"] as string, out this.Id))
                //{
                //    // JscriptMsg(350, 230, "错误提示", "<b>出现错误啦！</b>您要修改的信息不存在或参数不正确。", "back", "Error");
                //    return;
                //}


            if (!string.IsNullOrEmpty(Request.Params["ID"]))
            {
                _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);

            }

            if (!Page.IsPostBack)
            {
               
                if (_Id != 0)
                {
                    ShowInfo(_Id);
                }

            }
               
           
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
             Entities mydb = new Entities();
                  {
                      L_Tags Lt = new L_Tags();
                   if (_Id != 0)
                       Lt = mydb.L_Tags.First(p => p.TID == _Id);

                   Lt.TName = txtName.Text.Trim();
                   Lt.TContent = this.txtTag.Text;
                   Lt.TNotice = "";
                    
   
                if (_Id == 0)
                {
                    mydb.L_Tags.AddObject(Lt);
                    mydb.SaveChanges();
                    JscriptPrint("自定义标签添加成功啦！", "list.aspx", "Success");
                }
                else
                {
                    mydb.SaveChanges();
                    JscriptPrint("自定义标签修改成功啦！", "list.aspx", "Success");
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

             L_Tags _lt = mydb.L_Tags.First(p => p.TID == _id);    
             txtName.Text = _lt.TName;
             txtTag.Text = _lt.TContent;
             //txtTag2.Text = _lx.CTag2;
             //txtTag3.Text = _lx.CTag3;

         
          }
        }

    }

