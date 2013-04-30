﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;


    public class HomeController : Controller
    {
        public string title = "", content = "", from = "", YX_Addtime = "";
        public int textnum = 0;
        public ActionResult Index()
        {
            TextHandle th = new TextHandle();
            string str = th.GetModText("/index.htm");


            //计数器  需要重写
            //try
            //{
            //    var sysset = new SysSet().loadConfig(Utils.GetMapPath("~/Content/WebSet.config")).FontSize;
            //    //   myhelp = myhelp.getXml("../config/sysparm2.xml");

            //    //赋值给MODEL
            //    SysSet model = new SysSet();
            //    model.FontSize = sysset + 1;
            //    ////修改配置信息
            //    model = new SysSet().saveConifg(model, Server.MapPath("~/Content/WebSet.config"));

            //}
            //catch
            //{

            //}


            ViewData["Message"] = str;

            return View("index");
        }

        public ActionResult read(string ID, string NID)
        {

            int newsid = int.Parse(NID);
            int myid = int.Parse(ID);
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
                        str = str.Replace("<!--Nid-->", NID);
                        str = str.Replace("<!--Id-->", ID);
                        ViewData["Message"] = str; //替换指定索引处的指定字符
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
                        ViewData["Message"] = "没有ID为" + newsid + "的文章，请到后台核对！";
                    }
                }
                else
                {
                    ViewData["Message"] = "没有ID为" + myid + "的栏目，请到后台核对！";
                }
            }

            return View("index");
        }


        public ActionResult list(string ID)
        {
            int myid = int.Parse(ID);
            string type = "";

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
                        string str = "";
                        if (!(_Ncl.CSkin == null || _Ncl.CSkin.ToString() == String.Empty))
                        {
                            str = th.GetModText("/" + _Ncl.CSkin.ToString());
                        }
                        else
                        {
                            str = th.GetModText("/list.htm");
                        }
                        ViewData["Message"] = str; //替换指定索引处的指定字符
                    }
                    if (type == "2")
                    {
                        var listNew = (from n in db.L_Newss where n.ClassId == myid select n);
                        if (listNew.Count() != 0)
                        {
                            var _listNew = listNew.First();
                            string newsid = "pages_" + _listNew.ClassId.ToString() + "_" + _listNew.NID.ToString() + ".aspx";
                            ViewData["Message"] = "";
                            Response.Redirect(newsid);
                        }
                        else
                        {
                            ViewData["Message"] = "单页没有内容，请到后台添加！";
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
                            ViewData["Message"] = "跳转页面没有内容，请到后台添加！";
                        }
                    }
                }
                else
                {
                    ViewData["Message"] = "暂无该栏目请仔细核对！";
                }
            }
            return View("index");

        }

        public ActionResult Search()
        {
            TextHandle th = new TextHandle();
            ViewData["Message"] = th.GetModText("/shlist.htm"); //替换指定索引处的指定字符
            return View("index");
        }

        public ActionResult Form(string ID)
        {
            // string u_id = "1";  
            int myid = int.Parse(ID);
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
            ViewData["Message"] = str;
            return View("index");
        }


        ////////
        //接收表单
        ////////
        public ActionResult myForm(string ID)
        {
            //     u_id = int.Parse(HttpContext.Current.Request.QueryString["id"]);

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

                    ViewData["Message"] = "";
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
                    ViewData["Message"] = "";
                    Utils.ShowMessage2("提交成功！", "/");

                }
            }
            return View("index");
        }
        ///////


        //接收评论
        public ActionResult Feedback(string ID)
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
                ViewData["Message"] = "";
                Utils.ShowMessage2("提交成功！", "/");

            }
            return View("index");
        }
        ///////
        //


        public ActionResult Bm()
        {
            ViewData["Message"] = "dsad";

            return View("Bm");
        }

    }

