using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Models;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

   public partial class mydefault : System.Web.UI.Page
	{
        public string title = "", content = "", from = "", YX_Addtime = "";
        public int textnum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "no-cache";


            if (!Page.IsPostBack)
            {


                if (!string.IsNullOrEmpty(Request.Params["type"]))
                {
                    switch (Request.Params["type"])
                    {
                        case "read":
                            { Loadread(); break; }
                        case "search":
                            { LoadSearch(); break; }
                        case "list":
                            { LoadList(); break; }

                        case "myForm":
                            { LoadmyForm(); break; }

                        case "Form":
                            { LoadForm(); break; }
                    }       
                }
                else 
                {

                    LoadData();
                }
               

            }
        }

   //主页的     

        private void LoadData()
        {
            TextHandle th = new TextHandle();
            string str = th.GetModText("/index.htm");

            //计数器  需要重写
            //try
            //{
            //    var sysset = new SysSet().loadConfig(Utils.GetMapPath("~/App_Data/WebSet.config")).FontSize;
            //    //   myhelp = myhelp.getXml("../config/sysparm2.xml");

            //    //赋值给MODEL
            //    SysSet model = new SysSet();
            //    model.FontSize = sysset + 1;
            //    ////修改配置信息
            //    model = new SysSet().saveConifg(model, Server.MapPath("~/App_Data/WebSet.config"));

            //}
            //catch
            //{

            //}
            Response.Write(str);
        }

 // list 页面
        private void LoadList()
        {
  
            int myid = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            string type = "",str="";

            using (Entities db = new Entities())
            {
                //通过栏目id 得到栏目名称和栏目类别 
                //1 文章模型  2 单页模型 3 跳转地址模型

                var datas = from i in db.L_Classs where i.CID == myid select new { i.CType, i.CSkin };
                if (datas.Count() != 0)
                {
                    var _Ncl = datas.First();
                    type = _Ncl.CType.ToString();
                    if (type == "1")
                    {
                        TextHandle th = new TextHandle();
                        if (!(_Ncl.CSkin == null || _Ncl.CSkin.ToString() == String.Empty))
                        {
                            str = th.GetModText("/" + _Ncl.CSkin.ToString());
                        }
                        else
                        {
                            str = th.GetModText("/list.htm");
                        }
                  
                    }
                    if (type == "2")
                    {
                        var listNew = (from n in db.L_Newss where n.ClassId == myid select n);
                        if (listNew.Count() != 0)
                        {
                            var _listNew = listNew.First();
                            string newsid = "pages_" + _listNew.ClassId.ToString() + "_" + _listNew.NID.ToString() + ".aspx";
                            str = "";
                            Response.Redirect(newsid);
                        }
                        else
                        {
                            str = "单页没有内容，请到后台添加！";
                        }
                    }

                    if (type == "3")
                    {
                        var listUrl = (from m in db.L_Newss where m.ClassId == myid select m.Url).First();
                        if (listUrl.Count() != 0 && listUrl != "" && listUrl != "0")
                        {
                            Response.Redirect(listUrl.ToString());
                        }
                        else
                        {
                            str = "跳转页面没有内容，请到后台添加！";
                        }
                    }
                }
                else
                {
                    str = "暂无该栏目请仔细核对！";
                }
            }
            Response.Write(str);
        }
//read页面
        private void Loadread()
        {
            int newsid = int.Parse(HttpContext.Current.Request.QueryString["NID"]); 
            int myid = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            string str = "";
            using (Entities db = new Entities())
            {
                var datas = db.L_Classs.SingleOrDefault(i => i.CID == myid);
                if (datas != null)
                {

                    try
                    {
                        var News = db.L_Newss.Single(i => i.NID == newsid);
                        if (News.Url != "" && News.Url != "0" && News.Url != null)
                        {
                            Response.Redirect(News.Url.ToString());
                        }

                        TextHandle th = new TextHandle();
                        if (!string.IsNullOrEmpty(datas.CSubSkin))
                        {
                            str = th.GetModText("/" + datas.CSubSkin.Trim());
                        }
                        else
                        {
                            str = th.GetModText("/read.htm");
                        }

                        string allpicTAG = "<!--Read_allpic,.*-->";
                        Regex regallpic = new Regex(allpicTAG);
                        MatchCollection mcallpic = regallpic.Matches(str);
                        if (mcallpic.Count > 0)
                        {
                            for (int i = 0; i < mcallpic.Count; i++)
                            {
                                string longtag = mcallpic[i].ToString();
                                string[] longtags = longtag.Split(',');
                                longtag = longtags[1].ToString().Replace("-->", "");


                                string allpic2 = "";
                                string biaoda = @"src=""([\s\S]*?)""";
                                Regex regimg = new Regex(biaoda);
                                MatchCollection mcimg = regimg.Matches(News.Content);
                                if (mcimg.Count > 0)
                                {
                                    for (int ii = 0; ii < mcimg.Count; ii++)
                                    {
                                        allpic2 += longtag.Replace("#pic#", mcimg[ii].ToString().Replace("src=\"", "").Replace("\"", ""));
                                    }

                                }
                                str = str.Replace(mcallpic[i].ToString(), allpic2);

                            }
                        }

                        str = str.Replace("<!--Read_title-->", News.Title);
                        str = str.Replace("<!--Read_content-->", News.Content);
                        str = str.Replace("<!--Read_key-->", News.Tag);
                        str = str.Replace("<!--Read_img-->", News.Img);
                        str = str.Replace("<!--Read_desc-->", News.ZhaiYao);
                        str = str.Replace("<!--Read_auth-->", News.Author);
                        str = str.Replace("<!--Read_from-->", News.From);
                        str = str.Replace("<!--Read_click-->", News.Click);
                        str = str.Replace("<!--Read_time-->", News.Time.ToString());
                        str = str.Replace("<!--Nid-->", newsid.ToString());
                        str = str.Replace("<!--Id-->", ID);
                       
                        try
                        {
                            News.Click = (Convert.ToInt32(News.Click) + 1).ToString();

                            db.SaveChanges();
                        }
                        catch
                        {
                        }

                    }
                    catch
                    {
                        str = "没有ID为" + newsid + "的文章，请到后台核对！";
                    }
                }
                else
                {
                    str = "没有ID为" + myid + "的栏目，请到后台核对！";
                }
            }

            Response.Write(str);
        }

        private void LoadSearch()
        {
            TextHandle th = new TextHandle();
            Response.Write(th.GetModText("/shlist.htm")); //替换指定索引处的指定字符

        }

       private void LoadForm()
        {
            // string u_id = "1";  
            int myid = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            //    adduc(myid);
            using (Entities db = new Entities())
            {
                var fm = db.L_Form.SingleOrDefault(p => p.FID == myid);
                Table newtable = new Table();
                int textnum = 0;
                this.title = fm.FNmae;
                content = "<table><form name=Form2 action=myform" + myid + ".aspx method=post>";
                string a = fm.F1;
                if (a.Length > 0)
                {
                    a = a.Substring(0, a.Length - 1);
                    string[] sArray = a.Split(new char[] { '|' });
                    foreach (string myStr in sArray)
                    {
                        textnum++;
                        content += "<tr><td>" + myStr + "</td>";
                        content += "<td><input name='ln" + textnum.ToString() + "'/></td></tr>";
                    }

                }

            }
            content += "<tr><td><input type='submit' name='Submit' value='提交' /><td><td></td><tr></from></table>";
            TextHandle th = new TextHandle();
            string str = th.GetModText("/read.htm");
            str = str.Replace("<!--Read_title-->", title);
            str = str.Replace("<!--Read_content-->", content);
            // ViewState["adduc"] = 1;
            Response.Write(str);
        }


        ////////
        //接收表单
        ////////
        private void LoadmyForm()
        {
            //     u_id = int.Parse(HttpContext.Current.Request.QueryString["id"]);
           string ID = HttpContext.Current.Request.QueryString["ID"];
            if (ID == "F")
            {
                using (Entities mydb = new Entities())
                {

                    L_Feedback fdb = new L_Feedback();
                    fdb.FTime = DateTime.Now.ToString();
                    fdb.FName = Request.Form["Fname"];
                    fdb.NID = Convert.ToInt16(Request.Form["NID"]);
                    fdb.FContent = Request.Form["FContent"];
                    fdb.FQQ = Request.Form["FQQ"];
                    fdb.FLock = "0";
                    mydb.L_Feedback.AddObject(fdb);
                    mydb.SaveChanges();
                    Utils.ShowMessage2("提交成功！", "/");

                }

            }

            else
            {
                int mid = int.Parse(ID);
                Table newtable = new Table();
                using (Entities db = new Entities())
                {
                    var fm = db.L_Form.SingleOrDefault(p => p.FID == mid);
                    this.title = fm.FNmae;

                    string a = fm.F1;
                    // ty_1 = a;

                    if (a.Length > 0)
                    {
                        a = a.Substring(0, a.Length - 1);
                        string[] sArray = a.Split(new char[] { '|' });
                        textnum = sArray.Length;
                    }

                    //if (!(Page.Request.Form["id"] == null || Page.Request.Form["id"].ToString() == String.Empty))
                    //{
                    L_RForm fmRe = new L_RForm();
                    fmRe.FrReTime = DateTime.Now;
                    for (int i = 1; i <= textnum; i++)
                    {
                        string TXname = "ln" + i.ToString();
                        fmRe.Fr2 += Request.Form[TXname] + "|";
                    }

                    fmRe.Fr1 = a;
                    fmRe.FID = mid;
                    fmRe.FrRepaly = "";
                    db.L_RForm.AddObject(fmRe);
                    db.SaveChanges();
                   
                    Utils.ShowMessage2("提交成功！", "/");

                }
            }
     
        }
        ///////


        //接收评论
       private void LoadFeedback(string ID)
        {
            //      u_id = int.Parse(HttpContext.Current.Request.QueryString["id"]);
            int mid = int.Parse(ID);
            Table newtable = new Table();
            using (Entities db = new Entities())
            {
                var fm = db.L_Form.SingleOrDefault(p => p.FID == mid);
                this.title = fm.FNmae;

                string a = fm.F1;
                // ty_1 = a;

                if (a.Length > 0)
                {
                    a = a.Substring(0, a.Length - 1);
                    string[] sArray = a.Split(new char[] { '|' });
                    textnum = sArray.Length;
                }

                //if (!(Page.Request.Form["id"] == null || Page.Request.Form["id"].ToString() == String.Empty))
                //{
                L_RForm fmRe = new L_RForm();
                fmRe.FrReTime = DateTime.Now;
                for (int i = 1; i <= textnum; i++)
                {
                    string TXname = "ln" + i.ToString();
                    fmRe.Fr2 += Request.Form[TXname] + "|";
                }

                fmRe.Fr1 = a;
                fmRe.FID = mid;
                fmRe.FrRepaly = "";
                db.L_RForm.AddObject(fmRe);
                db.SaveChanges();        
                Utils.ShowMessage2("提交成功！", "/");
            }

        }

	}

