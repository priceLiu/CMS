using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Text;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Linq;
using Models;
using System.Web.Routing;
using System.IO;
using System.Net;


public class lntag
{

    public string Dex_SitUrl;
    public string Dex_Skin;
    public string Dex_Key, Dex_Desc;
    //cms标签

    public string ReplacelnFirstTag(string temp)
    {
        string pattern = "{--(.*?)--}";
        StringBuilder builder = new StringBuilder();
        builder.Append(temp);
        foreach (Match match in Regex.Matches(builder.ToString(), pattern))
        {
            string str2 = "";
            str2 = match.Value;

            int startIndex = str2.ToString().IndexOf("{--") + 3;
            int index = str2.ToString().IndexOf("--}");
            if (str2.ToString().Substring(startIndex, index - startIndex).ToString() != null)
            {

                string[] strArray = str2.ToString().Substring(startIndex, index - startIndex).Split(new char[] { '*' });
                string str3 = strArray[0].ToString();
                string stemp = strArray[1].ToString();
                string[] tagID = GetTagID(stemp);
                try
                {
                    switch (str3)
                    {
                        case "LnTag":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.Dex_Tag(System.Web.HttpContext.Current.Request["ID"].ToString(), tagID[0]));
                                continue;
                            }
                    }
                }
                catch (Exception exception)
                {
                    builder.Append(str3 + "可能是你优先标签的参数个数不对或者个数不对，请仔细检查" + exception.Message);
                }
                continue;
            }
        }
        return builder.ToString();
    }


    public string ReplacelnTag(string temp)
    {
        string pattern = "{--(.*?)--}";
        StringBuilder builder = new StringBuilder();
        builder.Append(temp);
        foreach (Match match in Regex.Matches(builder.ToString(), pattern))
        {
            string str2 = "";
            str2 = match.Value;

            int startIndex = str2.ToString().IndexOf("{--") + 3;
            int index = str2.ToString().IndexOf("--}");
            if (str2.ToString().Substring(startIndex, index - startIndex).ToString() != null)
            {

                string[] strArray = str2.ToString().Substring(startIndex, index - startIndex).Split(new char[] { '*' });
                string str3 = strArray[0].ToString();
                string stemp = strArray[1].ToString();
                string[] tagID = GetTagID(stemp);
                try
                {
                    switch (str3)
                    {


                        case "LnFeedBack":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnFeedBack(System.Web.HttpContext.Current.Request["NID"].ToString(), tagID[1], tagID[2]));
                                continue;
                            }

                        case "LnSNL":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnSNL(tagID[0], tagID[1], tagID[2]));
                                continue;
                            }

                        case "LnVideo":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnVideo(tagID[0], tagID[1], tagID[2]));
                                continue;
                            }
                        case "LnFlash":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnFlash(tagID[0], tagID[1], tagID[2], tagID[3], tagID[4]));
                                continue;
                            }
                        case "LnNL":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnNL(tagID[0], tagID[1], tagID[2], tagID[3], tagID[4], tagID[5], tagID[6]));
                                continue;
                            }

                        case "LnNLT":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnNLT(tagID[0], tagID[1], tagID[2], tagID[3], tagID[4], tagID[5], tagID[6], tagID[7]));
                                continue;
                            }
                        case "LnLNLT":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnNLT(System.Web.HttpContext.Current.Request["ID"].ToString(), tagID[1], tagID[2], tagID[3], tagID[4], tagID[5], tagID[6], tagID[7]));
                                continue;
                            }

   
                        case "LnALNL":
                            {

                                string _ClassID = System.Web.HttpContext.Current.Request.RequestContext.RouteData.Values["ID"].ToString();
                                string _myClass = _ClassID + "|";
                                _myClass += dpbinder(int.Parse(_ClassID));
                                _myClass = _myClass.Substring(0, _myClass.Length - 1);
                                builder = builder.Replace(str2.Trim(), lnlab.LnNL(_myClass, tagID[1], tagID[2], tagID[3], tagID[4], tagID[5], tagID[6]));
                                continue;
                            }


                        //case "LnNL2":
                        //    {
                        //        builder = builder.Replace(str2.Trim(), lnlab.LnNL2(tagID[0], tagID[1], tagID[2], tagID[3], tagID[4], tagID[5], tagID[6]));
                        //        continue;
                        //    }
                        case "LnLNL":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.LnNL(System.Web.HttpContext.Current.Request["ID"].ToString(), tagID[1], tagID[2], tagID[3], tagID[4], tagID[5], tagID[6]));
                                continue;
                            }
                        //case "LnContent":
                        //    {
                        //        builder = builder.Replace(str2.Trim(), lnlab.GetContent(tagID[0]));
                        //        continue;
                        //    }

                        //返回当前栏目带链接的名称
                        case "LnClassName":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.Dex_ClassName(System.Web.HttpContext.Current.Request["ID"].ToString(), tagID[0]));
                              continue;
                            }
                        case "LnClassNav":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.Dex_ClassNav(System.Web.HttpContext.Current.Request["ID"].ToString(), tagID[0]));
                                continue;
                            }


                        case "LnClassList":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.Dex_ClassList(System.Web.HttpContext.Current.Request["ID"].ToString(), Convert.ToInt16(tagID[0])));
                                continue;
                            }




                        //搜索
                        case "LnSh":
                            {
                                if (!(string.IsNullOrEmpty(System.Web.HttpContext.Current.Request["KEY"])))
                                {
                                    builder = builder.Replace(str2.Trim(), lnlab.LnSh(System.Web.HttpContext.Current.Request["KEY"], tagID[0]));
                                }
                                else
                                {
                                    builder = builder.Replace(str2.Trim(), "请输入要搜索的内容！");
                                }
                                continue;
                            }

                        case "LnFWL":
                            {
                                string _fwl = (new SysSet().loadConfig(Utils.GetMapPath("~/App_Data/WebSet.config")).FontSize).ToString();
                                builder = builder.Replace(str2.Trim(), _fwl);
                                continue;
                            }

                        //分类标题 

                        case "Dex_ClassName":
                            {

                                builder = builder.Replace(str2.Trim(), lnlab.Dex_ClassName(System.Web.HttpContext.Current.Request["ID"].ToString(), "0"));
                                continue;


                            }


                    }
                }
                catch (Exception exception)
                {
                    builder.Append(str3 + "可能是你标签的参数个数不对或者个数不对，请仔细检查" + exception.Message);
                }
                continue;
            }
        }
        return builder.ToString();

    }


    public static string dpbinder(int cID)//根据父ID查询子项
    {
        using (Entities _class = new Entities())
        {
            string _temp = "";
            var mm = from nn in _class.L_Classs where nn.CpareID == cID select nn;
            foreach (var n in mm)
            {
                _temp += n.CID.ToString() + "|";
                _temp += dpbinder(int.Parse(n.CID.ToString()));
            }
            return _temp;
        }
    }

    public string ReplaceHtmlTag(string temp)
    {

        this.Dex_SitUrl = WebConfigurationManager.AppSettings["wwwroot"];
        this.Dex_Skin = WebConfigurationManager.AppSettings["skin"];
        SysSet sysset = new SysSet().loadCacheConfig(Utils.GetMapPath("~/App_Data/WebSet.config"));
        this.Dex_Key = sysset.WebKeywords;
        this.Dex_Desc = sysset.WebDescription;

        string pattern = "<!--#(.*?)#-->";


        StringBuilder builder = new StringBuilder();
        builder.Append(temp);
        foreach (Match match in Regex.Matches(builder.ToString(), pattern))
        {

            string str2 = "";
            str2 = match.ToString();

            int startIndex = str2.ToString().IndexOf("<!--#") + 5;
            int index = str2.ToString().IndexOf("#-->");
            if (str2.ToString().Substring(startIndex, index - startIndex).ToString() != null)
            {


                string[] strArray = str2.ToString().Substring(startIndex, index - startIndex).Split(new char[] { '*' });
                string str3 = strArray[0].ToString();
                string stemp = strArray[1].ToString();
                string[] tagID = GetTagID(stemp);
                try
                {
                    switch (str3)
                    {
                        // case "Dex_News":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_News(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1]),Convert.ToInt16(tagID[2])));
                        //         continue;
                        //     }

                        //     //list 页面分类列表
                        case "Dex_ClassList":
                            {
                                builder = builder.Replace(str2.Trim(), lnlab.Dex_ClassList(System.Web.HttpContext.Current.Request["ID"].ToString(), Convert.ToInt16(tagID[0])));
                                continue;
                            }




                        // //page 页面分类列表

                        // case "Dex_PageClassList":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_PageClassList(System.Web.HttpContext.Current.Request["NID"], Convert.ToInt16(tagID[0])));
                        //         continue;
                        //     }


                        ////图片 列表
                        // case "Dex_ImgNews":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_ImgNews(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1]), Convert.ToInt16(tagID[2])));
                        //         continue;
                        //     }
                        ////图片 列表详细
                        // case "Dex_ImgNews2":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_ImgNews2(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1]), Convert.ToInt16(tagID[2])));
                        //         continue;
                        //     }
                        // //list页面
                        // case "Dex_NewsList":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_NewsList(System.Web.HttpContext.Current.Request["ID"], Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1])));
                        //         continue;

                        //     }





                        //   //分类图片

                        //   case "Dex_ClassImg":
                        //     {

                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_ClassImg(System.Web.HttpContext.Current.Request["ID"]));
                        //         continue;


                        //     }


                        //   //留言本
                        // case "Dex_Note":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_Note(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1])));
                        //         continue;
                        //     }




                        // case "Dex_Info":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_Info(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1]), Convert.ToInt16(tagID[2]), Convert.ToInt16(tagID[3]), Convert.ToInt16(tagID[4]), Convert.ToInt16(tagID[5])));
                        //         continue;
                        //     }




                        // case "Dex_InfoList":
                        //     {


                        //             builder = builder.Replace(str2.Trim(), lnlab.Dex_Info(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1]), Convert.ToInt16(tagID[2]), Convert.ToInt16(tagID[3]), Convert.ToInt16(tagID[4]),int.Parse(System.Web.HttpContext.Current.Request["ID"])));
                        //             continue;

                        //     }

                        //          case "Dex_PageInfo":
                        //     {
                        //         builder = builder.Replace(str2.Trim(), lnlab.Dex_PageInfo(Convert.ToInt16(tagID[0]), Convert.ToInt16(tagID[1]), Convert.ToInt16(tagID[2]), Convert.ToInt16(tagID[3]), Convert.ToInt16(tagID[4]), Convert.ToInt16(tagID[5])));
                        //         continue;
                        //     }     


                    }
                }
                catch (Exception exception)
                {
                    builder.Append("可能是你标签的参数个数不对或者个数不对，请仔细检查" + exception.Message);
                }
                continue;
            }
        }
        return builder.ToString();

    }

    //用户标签

    public string GetUserTag(string Content1)
    {

        string pattern = @"{\$use_+(.*?)\$}";
        string oldValue = "";
        //int num = this.TemplateID();
        //this.Exsql.Open();
        //string sql = "select * from YX_CMS where YX_TemplateType=" + num;


        StringBuilder builder = new StringBuilder();
        builder.Append(Content1);
        MatchCollection matchs = Regex.Matches(builder.ToString(), pattern);
        try
        {
            try
            {
                foreach (Match match in matchs)
                {
                    oldValue = match.ToString();
                    int startIndex = oldValue.ToString().IndexOf("{$use_") + 6;
                    int index = oldValue.ToString().IndexOf("$}");
                    string taghead = oldValue.Substring(startIndex, index - startIndex).ToString();


                    // SqlDataReader reader = this.Exsql.Re_dr(sql);
                    //y.accDAL.help myPage = new y.accDAL.help();
                    //DataRow[] dr = myPage.getLable(taghead, "config/lable.xml");
                    //DataRow mydr = dr[0]; 
                   using (Entities db = new Entities())
                    {
                        var lx = db.L_Tags.FirstOrDefault(p => p.TName == taghead);
                        if (lx != null) { 
                        new StringBuilder();
                        builder = builder.Replace(oldValue, lx.TContent.ToString());
                        }

                    }



                }
            }
            catch
            {
            }
        }
        finally
        {

        }
        return builder.ToString();
    }


    //静态标签

    public string GetStaticTag(string htmls)
    {

        //y.accDAL.xmlHelp myhelp = new y.accDAL.xmlHelp();
        //myhelp = myhelp.getXml("config/sysparm2.xml");
        //string  Dex_siteName = myhelp.n1.ToString();
        //string newValue = myhelp.n1.ToString();
        //string str2 = myhelp.n4.ToString();
        //string str3 = myhelp.n5.ToString();

        //string Message = myhelp.n4.ToString();
        htmls = htmls.Replace("name=\"movie\" value=\"", "name=\"movie\" value=\"" + this.Dex_SitUrl + "/" + this.Dex_Skin + "/");
        htmls = htmls.Replace("link href=\"", "link href=\"" + this.Dex_SitUrl + "/" + this.Dex_Skin + "/");
        htmls = htmls.Replace("img src=\"", "img src=\"" + this.Dex_SitUrl + "/" + this.Dex_Skin + "/");
        htmls = htmls.Replace("script src=\"", "script src=\"" + this.Dex_SitUrl + "/" + this.Dex_Skin + "/");
        htmls = htmls.Replace("type=\"text/javascript\" src=\"", "type=\"text/javascript\" src=\"" + this.Dex_SitUrl + "/" + this.Dex_Skin + "/");
        htmls = htmls.Replace("src=\"images", "src=\"" + this.Dex_SitUrl + "/" + this.Dex_Skin + "/images");
        htmls = htmls.Replace("{$Dex_Skin$}", this.Dex_Skin).Replace("{$Dex_SitUrl$}", this.Dex_SitUrl);
        htmls = htmls.Replace("{$Ln_Key$}", Dex_Key).Replace("{$Ln_Desc$}", this.Dex_Desc);

        //  htmls = htmls.Replace("{$Ln_css$}", getURL("http://www.ynicity.cn/ecity-web/pages/common/css.jsp"));



        //  htmls = htmls.Replace("{$Dex_Copright$}", str3);
        return htmls;

    }


    private string getURL(string _Url)
    {
        WebClient client = new WebClient();
        client.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
        client.Credentials = CredentialCache.DefaultCredentials;
        byte[] bResult = client.DownloadData(_Url);
        return Encoding.UTF8.GetString(bResult);




    }





    public string[] GetTagID(string stemp)
    {
        string[] strArray = null;
        try
        {
            if (stemp != "")
            {
                strArray = stemp.Split(new char[] { ',' });
            }
        }
        catch
        {
        }
        return strArray;
    }








}

