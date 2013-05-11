using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models;


public partial class Temple_File : AdminBase
    {
        private string folder = "";
        private string lockpath = "~/temple";
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!base.IsPostBack)
            {
                this.BindData();
                Literal1.Text = GetUrl();
            }
        }

        /// <summary>
        /// 处理返回文件夹链接字符串
        /// </summary>
        /// <param name="fullname"></param>
        /// <returns></returns>
        public string GetUrl()
        {
            string urlpath = Request.Url.AbsolutePath;
            string result = "<a href='" + urlpath + "'>temple</a>";
            string getpath = Request.QueryString["folder"];
            if (!string.IsNullOrEmpty(getpath))
            {
                getpath=getpath.Remove(0,1);
                string addstr = urlpath + "?folder=";
                string[] allpath = getpath.Split('/');
                foreach (string item in allpath)
                {
                    addstr += "/"+item;
                    result += string.Format("<a href='{0}'>{1}</a>", addstr, "/" + item);
                }
            }
            return result;
        }

        protected void BindData()
        {
            this.folder = base.Request.QueryString["folder"];

            if (string.IsNullOrEmpty(this.folder))
            {

                this.FileList.DataSource = GetFileList(base.Server.MapPath(this.lockpath + this.folder));
                this.DataBind();
            }
            else
            {
                if (!(this.folder.IndexOf("..") > -1))
                {
                    this.FileList.DataSource = GetFileList(base.Server.MapPath(this.lockpath + this.folder));
                    this.DataBind();            
                }
            
            }
        }

        protected string GetLink(object filename, object flag)
        {
            if (Convert.ToBoolean(flag))
            {
                return string.Concat(new object[] { "?folder=", this.folder, "/", filename });
            }

            string str = "";
            if (!string.IsNullOrEmpty(this.folder))
            {
                str = this.folder.Substring(1, this.folder.Length - 1)+"/";//删除第一个字母
            }
            return "javascript:SelectFile('" + str + filename + "')";

        }

        



        protected  List<FileBean> GetFileList(string folder)
        {
            List<FileBean> list = new List<FileBean>();
            DirectoryInfo di;
            DirectoryInfo[] DirectList;
            try
            {
                 di = new DirectoryInfo(folder);
                 DirectList = di.GetDirectories();
            }
            catch (Exception)
            {

                di = new DirectoryInfo(HttpContext.Current.Server.MapPath(this.lockpath));
                DirectList = di.GetDirectories();
            }
            
            //获取目录
            DirectList = di.GetDirectories();
            foreach (DirectoryInfo oneFilelist in DirectList)
            {
                    FileBean fb = new FileBean();
                    fb.Name = oneFilelist.Name;
                    fb.Path = folder;
                    fb.Size = 0L;
                    fb.LastUpdated = oneFilelist.CreationTime;
                    fb.IsFolder = true;
                    fb.FlieType = "folder";
                    list.Add(fb);
            }
            //获取文件
            FileInfo[] filelist = di.GetFiles();
            foreach (FileInfo item in filelist)
            {
                FileBean fb = new FileBean();
                fb.Name = item.Name;
                fb.Path = item.FullName;
                fb.Size = item.Length;
                fb.LastUpdated = item.CreationTime;
                fb.IsFolder = false;
                fb.FlieType =item.Extension.Remove(0,1);
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
            private string _flieType;

            public string FlieType
            {
                get { return _flieType; }
                set { _flieType = value; }
            }
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
