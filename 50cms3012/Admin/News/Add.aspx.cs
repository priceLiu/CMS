using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models;
using System.Linq;
using System.Text.RegularExpressions;
using System.IO;
using System.Threading;
using System.Text;
using Aspose.Words;
using Models;


    public partial class Add : AdminBase
    {
        private int _Id=0;


        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "no-cache";
                //chkLoginLevel("addArticle");
                ////绑定类别
                //ChannelTreeBind(0, "请选择所属类别...", (int)Channel.Article, this.ddlClassId);
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
                ClassTreeBindFV("","请选择所属类别...", this.ddlClassId);

                if (_Id != 0)
                {
                    ShowInfo(_Id);
                }
                else
                {
                    if (!string.IsNullOrEmpty(Request.Params["CID"]))
                    {
                        string _CId = HttpContext.Current.Request.QueryString["CID"];
                        ddlClassId.SelectedValue = _CId;
                    }
                }


              //  chkLoginLevel("editArticle");
                //绑定类别
              //  ChannelTreeBind(0, "请选择所属类别...", (int)Channel.Article, this.ddlClassId);
  
            }
               
           
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Entities mydb = new Entities();
            {
                L_Newss _news = new L_Newss();

                if (_Id != 0)
                _news = mydb.L_Newss.First(p => p.NID == _Id);
               

                _news.Title = txtTitle.Text.Trim();
                _news.Author = txtAuthor.Text.Trim();
                _news.From = txtForm.Text.Trim();
                _news.Url = txtUrl.Text.Trim();

                //自动提取关健字
                if (txtKeyword.Text.Trim() != string.Empty)
                {
                    _news.Tag = txtKeyword.Text.Trim();
                }
                else
                {
                    _news.Tag = txtTitle.Text.Trim();
                }
                //自动提取摘要
                if (txtZhaiyao.Text.Trim() != string.Empty)
                {
                    _news.ZhaiYao = Utils.DropHTML(txtZhaiyao.Text, 250);
                }
                else
                {
                    _news.ZhaiYao = Utils.DropHTML(txtContent.Value, 250);
                }
                //自动提取导读

             
                _news.Img = txtImgUrl.Text.Trim();
                _news.Content = txtContent.Value;
                _news.Click = txtClick.Text.Trim();
                _news.ClassId = int.Parse(this.ddlClassId.SelectedValue);


                _news.IsTop = false;
                _news.IsRed = false;
                _news.IsHot = false;
                _news.IsSlide = false;
                _news.IsLock = false;

                if (cblItem.Items[0].Selected == true)
                {
                    _news.IsLock = true;
                }
                if (cblItem.Items[1].Selected == true)
                {
                    _news.IsTop = true;
                }
                if (cblItem.Items[2].Selected == true)
                {
                    _news.IsRed = true;
                }
                if (cblItem.Items[3].Selected == true)
                {
                    _news.IsHot = true;
                }
                if (cblItem.Items[4].Selected == true)
                {
                    _news.IsSlide = true;
                }

                if (txtRQ.Text.Trim() != string.Empty)
                {
                    _news.Time = DateTime.Parse(txtRQ.Text.ToString());
                }
                else
                {
                    _news.Time = DateTime.Now;
                }

                if (_Id == 0)
                {
                    
                    mydb.L_Newss.AddObject(_news);
                    mydb.SaveChanges();
                    JscriptPrint("文章发布成功啦！", "list.aspx?CID="+_news.ClassId, "Success");
                }
                else
                {
                  
                    mydb.SaveChanges();
                    JscriptPrint("文章修改成功啦！", "list.aspx?CID=" + _news.ClassId, "Success");
                }

            }

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
          
        }

        private void ShowInfo(int _id)
        {

            Entities mydb = new Entities();
            {

           L_Newss _news = mydb.L_Newss.First(p => p.NID == _id);
            
            txtTitle.Text = _news.Title;
            txtAuthor.Text = _news.Author;
            txtForm.Text = _news.From;
            txtKeyword.Text = _news.Tag;
            txtZhaiyao.Text = _news.ZhaiYao;
            ddlClassId.SelectedValue = _news.ClassId.ToString();
            txtImgUrl.Text = _news.Img;
            txtContent.Value = _news.Content;
            txtUrl.Text = _news.Url;

            if (_news.Click != null)
                txtClick.Text = _news.Click.ToString();

            if (_news.IsTop == true)
            {
                cblItem.Items[1].Selected = true;
            }
            if (_news.IsRed == true)
            {
                cblItem.Items[2].Selected = true;
            }
            if (_news.IsHot == true)
            {
                cblItem.Items[3].Selected = true;
            }
            if (_news.IsSlide == true)
            {
                cblItem.Items[4].Selected = true;
            }
            txtRQ.Text = _news.Time.ToString();
          }
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (Fileword.PostedFile.FileName == "")
            {

                JscriptPrint("请选择要上传的word文件！", "", "Error");
                return;
            }
         
                string fileName = Fileword.PostedFile.FileName;
                int extendNameIndex = fileName.LastIndexOf(".");
                string extendName = fileName.Substring(extendNameIndex);
                  //验证是否为word格式
                if (extendName == ".doc" || extendName == ".docx")
                {
                    word2Html(Fileword);
                }
                else
                {
                    JscriptPrint("请选择正确的word文件(.doc或者.docx)！", "", "Error");
                    return;
                } 
            
        }

        private static string GetUserTag(string html)
        {
            System.Collections.Specialized.StringCollection sc = new System.Collections.Specialized.StringCollection();
            // get rid of unnecessary tag spans (comments and title)
            sc.Add(@"<!--(\w|\W)+?-->");
            sc.Add(@"<title>(\w|\W)+?</title>");
            // Get rid of classes and styles
            sc.Add(@"\s?class=\w+");
            sc.Add(@"\s+style='[^']+'");
            // Get rid of unnecessary tags
            //sc.Add(@"<(meta|link|/?o:|/?style|/?div|/?st\d|/?head|/?html|body|/?body|/?span|!\[)[^>]*?>");
            sc.Add(@"<(meta|link|/?o:|/?style|/?font|/?strong|/?st\d|/?head|/?html|body|/?body|/?span|!\[)[^>]*?>");
            // Get rid of empty paragraph tags
            sc.Add(@"(<[^>]+>)+ (</\w+>)+");
            // remove bizarre v: element attached to <img> tag
            sc.Add(@"\s+v:\w+=""[^""]+""");
            // remove extra lines
            sc.Add(@"(\n\r){2,}");
            sc.Add(@"<p(\w|\W)+?>");
            sc.Add(@"(style=""(\w|\W)+?"")");
            foreach (string s in sc)
            {
                html = Regex.Replace(html, s, "", RegexOptions.IgnoreCase);
            }
            System.Collections.Specialized.StringCollection simg = new System.Collections.Specialized.StringCollection();
            //simg.Add("<img\b[^<>]*?\bsrc=\"(.+?)\"");
            simg.Add(@"<img\b[^<>]*?\bsrc[\s\t\r\n]*=[\s\t\r\n]*[""']?[\s\t\r\n]*(?<imgUrl>[^\s\t\r\n""'<>]*)[^<>]*?/?[\s\t\r\n]*>");
            string _datePath = DateTime.Now.ToString("yyyyMMdd") + "/";
            foreach (string si in simg)
            {
                html = Regex.Replace(html, si, @"<img src='/upload/"+_datePath+"$1'", RegexOptions.IgnoreCase);
            }
            return html;
        }

        public string word2Html(System.Web.UI.HtmlControls.HtmlInputFile wordFilePath)
        {

            string filePath = uploadWord(wordFilePath);
            Stream f = new FileStream(filePath, FileMode.Open);
            Document doc = new Document(f);
            string filename = System.DateTime.Now.Year.ToString() + System.DateTime.Now.Month.ToString() + System.DateTime.Now.Day.ToString() +
          System.DateTime.Now.Hour.ToString() + System.DateTime.Now.Minute.ToString() + System.DateTime.Now.Second.ToString();


            string _datePath = DateTime.Now.ToString("yyyyMMdd") + "/";
            //获得要保存的文件路径
            string serverFileName = _datePath + filename;
            //物理完整路径                    
            string toFileFullPath = HttpContext.Current.Server.MapPath("~/upload/" + _datePath);
            //检查是否有该路径没有就创建
            if (!Directory.Exists(toFileFullPath))            {
                Directory.CreateDirectory(toFileFullPath);
            }


            //被转换的html文档保存的位置
            string ConfigPath = HttpContext.Current.Server.MapPath("~/upload/" + serverFileName + ".htm");

            doc.Save(ConfigPath, SaveFormat.Html);
            Thread.Sleep(3000);//
            f.Dispose();

            this.GetHtmText(ConfigPath);
            File.Delete(filePath);
            File.Delete(ConfigPath);

            return ("/html");
        }
        public string uploadWord(System.Web.UI.HtmlControls.HtmlInputFile uploadFiles)
        {

                string fileName = uploadFiles.PostedFile.FileName;
                int extendNameIndex = fileName.LastIndexOf(".");
                string extendName = fileName.Substring(extendNameIndex);
                string newName = "";
                try
                {
                        DateTime now = DateTime.Now;
                        newName = now.DayOfYear.ToString() + uploadFiles.PostedFile.ContentLength.ToString();
                        //Response.Write(System.Web.HttpContext.Current.Server.MapPath("~/wpic/" + newName + extendName)); 
                        //上传路径 指当前上传页面的同一级的目录下面的wordTmp路径
                        uploadFiles.PostedFile.SaveAs(System.Web.HttpContext.Current.Server.MapPath("~/upload/" + newName + extendName));  
                }
                catch
                {
                    return "0";
                }

                return System.Web.HttpContext.Current.Server.MapPath("~/upload/" + newName + extendName);

          
        }
        private void GetHtmText(string Str)
        {

            StringBuilder Shtml = new StringBuilder(); //创建一个可变字符字符串
            using (StreamReader sr = new StreamReader(Str, Encoding.GetEncoding("GB2312")))
            {
                String line;
                while ((line = sr.ReadLine()) != null)
                {
                    Shtml.Append(line + Environment.NewLine);
                }
                sr.Close();
                sr.Dispose();
                this.txtContent.Value = GetUserTag(Shtml.ToString());
            }

        }




    }


