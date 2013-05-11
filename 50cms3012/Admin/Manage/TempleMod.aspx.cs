using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.IO;
using System.Text;
using System.Web.Configuration;
using Models;


    public partial class TempleMod : AdminBase
    {
        protected string file = "";
        private string lockpath = "~/"+WebConfigurationManager.AppSettings["skin"];
        protected void BindData()
        {
            if (!string.IsNullOrEmpty(this.file) && this.file.IndexOf(lockpath) > -1 && !(this.file.IndexOf("../") > -1))
            {
                this.Labelname.Text = this.file;
                string content = ReadFile(base.Server.MapPath(this.file));
                this.Content.Text = content;
            }

        
            using (Entities bll = new Entities())
                {
            
                    var m =bll.L_Tags;
                    foreach (var n in m)
                    {
                        DDzdy.Items.Add(new ListItem(n.TName.ToString(), "{$use_" + n.TName.ToString() + "$}"));
                      
                    }
                }
           

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(this.file) && this.file.IndexOf(lockpath) > -1 && !(this.file.IndexOf("../") > -1))
            {
                string content = this.Content.Text;
                WriteFile(base.Server.MapPath(this.file), content);
                JscriptPrint("模板修改成功啦！", "Temple.aspx", "Success");
            }
          
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.file = getString(base.Request, "file");
            if (!base.IsPostBack)
            {
                this.BindData();
            }
        }



        public static string getString(HttpRequest request, string parameter)
        {
            return request.QueryString[parameter];
        }


        public static void WriteFile(string FileName, string content)
        {

            byte[] data = Encoding.UTF8.GetBytes(content);
            FileStream file = null;
            try
            {
                file = new FileStream(FileName, FileMode.Create);
                file.Write(data, 0, data.Length);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (file != null)
                {
                    file.Close();
                }
            }
        }


        public static string ReadFile(string FileName)
        {
            string ret = "";
            FileStream files = null;
            try
            {
                files = new FileStream(FileName, FileMode.Open, FileAccess.Read);
                StreamReader sr = new StreamReader(files);
                ret = sr.ReadToEnd();
                sr.Close();
            }
            catch (Exception ex)
            {
               // throw ex;
            }
            finally
            {
                if (files != null)
                {
                    files.Close();
                }
            }
            return ret;
        }
    }

