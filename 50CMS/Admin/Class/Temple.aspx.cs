using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ln2012.Models;
using System.Data;
using System.IO;

namespace ln2012.Admin.Class
{
    public partial class Temple : AdminBase
    {
        private string folder = "";
        private string lockpath = "~/temple";
        //      public string formname="";


        protected void BindData()
        {
            this.folder = base.Request.QueryString["folder"];
            this.rptList.DataSource = GetFileList(base.Server.MapPath(this.lockpath + this.folder));
            this.DataBind();
        }

        protected string GetLink(object filename, object flag)
        {
            if (Convert.ToBoolean(flag))
            {
                return string.Concat(new object[] { "?folder=", this.folder, "/", filename });
            }


            return "javascript:SelectFile('" + filename + "')";
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!base.IsPostBack)
            {
                //               formname = Request.QueryString["nm"];
                this.BindData();
            }
        }



        public static List<FileBean> GetFileList(string folder)
        {
            List<FileBean> list = new List<FileBean>();
            string[] fileList = Directory.GetFileSystemEntries(folder);
            foreach (string file in fileList)
            {
                FileBean fb = new FileBean();
                if (Directory.Exists(file))
                {
                    fb.Name = Path.GetFileName(file);
                    fb.Path = file;
                    fb.Size = 0L;
                    fb.LastUpdated = new DirectoryInfo(file).LastWriteTime;
                    fb.IsFolder = true;
                }
                else
                {
                    fb.Name = Path.GetFileName(file);
                    fb.Path = file;
                    fb.Size = new FileInfo(file).Length;
                    fb.LastUpdated = File.GetLastWriteTime(file);
                    fb.IsFolder = false;
                }
                list.Add(fb);
            }
            return list;
        }

        public class FileBean
        {
            // Fields
            private bool _isfolder;
            private DateTime _lastupdated;
            private string _name;
            private string _path;
            private long _size;

            // Methods
            public FileBean() { }

            // Properties

            public bool IsFolder
            {
                set { _isfolder = value; }
                get { return _isfolder; }
            }
            public DateTime LastUpdated
            {
                set { _lastupdated = value; }
                get { return _lastupdated; }
            }
            public string Name
            {
                set { _name = value; }
                get { return _name; }
            }
            public string Path
            {
                set { _path = value; }
                get { return _path; }
            }
            public long Size
            {
                set { _size = value; }
                get { return _size; }
            }
        }

        public static string[] GetFileSystemEntries(string path)
        {
            return GetFileSystemEntries(path);
        }    
       


           

     }
  
}