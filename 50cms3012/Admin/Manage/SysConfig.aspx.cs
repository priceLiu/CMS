using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models;
using System.Linq;


    public partial class SysConfig : AdminBase
    {
        public int _Id=0;

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.CacheControl = "no-cache";


            if (!Page.IsPostBack) 
            {
                sysset = new SysSet().loadCacheConfig(Utils.GetMapPath("~/App_Data/WebSet.config"));
             //   myhelp = myhelp.getXml("../config/sysparm2.xml");

            txtWebName.Text = sysset.WebName;
            txtWebTel.Text = sysset.WebTel;
            txtWebEmail.Text = sysset.WebEmail;
            txtWebCrod.Text = sysset.WebCrod;
            txtWebKeywords.Text = sysset.WebKeywords.ToString();
            txtWebDescription.Text = sysset.WebDescription.ToString();
            Textfuj.Text = sysset.WebFileType.ToString();
            //if (sysset..FLock == "1")
            this.CBLog.Checked = sysset.WebLog;
            this.CBNews.Checked = sysset.NewsRule;

            }
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {


            try
            {
                //赋值给MODEL
                SysSet model = new SysSet();
                model.WebName = txtWebName.Text;
       
                model.WebTel = txtWebTel.Text;
              
                model.WebEmail = txtWebEmail.Text;
                model.WebCrod = txtWebCrod.Text;       
                model.WebKeywords = txtWebKeywords.Text.Trim();
                model.WebDescription = txtWebDescription.Text.Trim();
                model.WebFileType = Textfuj.Text.Trim();

                model.WebLog = CBLog.Checked;
                model.NewsRule=CBNews.Checked;
                ////修改配置信息

                model = new SysSet().saveConifg(model, Server.MapPath("~/App_Data/WebSet.config"));
                //保存日志
                SaveLogs("[系统管理]修改系统配置文件");
                JscriptPrint("系统设置成功啦！", "SysConfig.aspx", "Success");
           }
            catch
            {

                JscriptMsg(350, 280, "错误提示", "<b>文件写入失败！</b>请检查是否有写入权限，如果没有，请联系管理员开启写入该文件的权限！", "admin_config.aspx", "Error");
            }
   
       

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }

    
    }

