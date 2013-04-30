using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ln2012.Models;
using System.Linq;


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

         
               //JscriptMsg(350, 230, "错误提示", "<b>出现错误啦！</b>您要修改的信息不存在或参数不正确。", "back", "Error");
               //return;
          

            if (!Page.IsPostBack)
            {
                ClassTreeBind("一级分类...", this.aClassddl);

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
                      L_Classs lx = new L_Classs();
                   if (_Id != 0)
                       lx = mydb.L_Classs.First(p => p.CID == _Id);

                lx.CType = int.Parse(this.DropDownList1.SelectedValue);
                lx.CNmae = txtName.Text.Trim();
                lx.CKeyWord = this.txtKeyword.Text;
                // lx.C_discrp = this.txtTxt.Text;
                lx.CTag = this.txtTag.Text;
                lx.CTag2 = this.txtTag2.Text;
                lx.CTag3 = this.txtTag3.Text;
                lx.CSkin = this.txtList.Text;
                lx.CSubSkin = this.txtRead.Text;
                lx.CUrl = "";
                lx.CpareID = short.Parse(aClassddl.SelectedValue);
       

                if (_Id == 0)
                {
                    mydb.L_Classs.AddObject(lx);
                    mydb.SaveChanges();
                    JscriptPrint("类别添加成功啦！", "list.aspx", "Success");
                }
                else
                {
                    mydb.SaveChanges();
                    JscriptPrint("类别修改成功啦！", "list.aspx", "Success");
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

             L_Classs _lx = mydb.L_Classs.First(p => p.CID == _id);
             DropDownList1.SelectedValue = _lx.CType.ToString();
             txtName.Text = _lx.CNmae;
             txtKeyword.Text = _lx.CKeyWord;
            // txtTxt.Text = _lx.;
             txtTag.Text = _lx.CTag;
             txtTag2.Text = _lx.CTag2;
             txtTag3.Text = _lx.CTag3;
             txtList.Text = _lx.CSkin;
             txtRead.Text = _lx.CSubSkin;
             aClassddl.SelectedValue = _lx.CpareID.ToString();
         
          }
        }

    }

