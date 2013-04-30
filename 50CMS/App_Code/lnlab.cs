using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Data.Common;
using System.IO;
using System.Data.Objects;


   public class lnlab
   {

       /// <summary>
       /// 获取flash
       /// </summary>
       /// <param name="ClassID">栏目id,如为整站,则使用"N"</param>
       /// <param name="Num">条数</param>
       /// <param name="WordsNum">字数</param>
       /// <param name="Width">宽度</param>
       /// <param name="Height">高度</param>
       /// <returns></returns>
       public static string LnFlash(string ClassID, string Num, string WordsNum, string Width, string Height)
       {
           string result = "";
           string AllText = "";
           string AllPic = "";
           string AllLink = "";
           int _classID = Convert.ToInt32(ClassID);
           int _num = Convert.ToInt32(Num);

           Entities mydb = new Entities();
           var q = from p in mydb.L_Newss
                   where p.Content.Contains("src=")
                   select p;
           if (ClassID != "N")
           {
               
               q = q.Where(p => p.ClassId ==_classID).OrderByDescending(p => p.NID).Take(_num);

           }
           else
           {
               q = q.Take(_num).OrderByDescending(p => p.NID);
           }
           foreach (var p in q)
           {
               AllLink += "Pages_" + p.ClassId + "_" + p.NID + ".aspx|";
               AllText += TrimString(p.Title, WordsNum) + "|";
               string biaoda = @"src=""([\s\S]*?)""";
               Regex regimg = new Regex(biaoda);
               MatchCollection mcimg = regimg.Matches(p.Content.ToString());
               if (mcimg.Count > 0)
               {
                   AllPic += mcimg[0].ToString().Replace("src=", "").Replace("\"", "") + "|";
               }
               else
               {
                   AllPic += "|";
               }


           }
           result = string.Format("<script type=\"text/javascript\">var Flash_Width = {0};var Flash_Height = {1};var Txt_Height = 30;var Swf_Height = parseInt(Flash_Height + Txt_Height);var Pics_ = \'{2}\';var Links_ = \'{3}\';var Texts_ = \'{4}\';document.write(\'<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0\" width=\"\' + Flash_Width + \'\" height=\"\' + Swf_Height + \'\">\');document.write(\'<param name=\"allowScriptAccess\" value=\"sameDomain\"><param name=\"movie\" value=\"Flash.swf\"><param name=\"quality\" value=\"high\"><param name=\"bgcolor\" value=\"#ffffff\">\');document.write(\'<param name=\"menu\" value=\"false\"><param name=\"wmode\" value=\"opaque\">\');document.write(\'<param name=\"FlashVars\" value=\"pics=\' + Pics_ + \'&links=\' + Links_ + \'&texts=\' + Texts_ + \'&borderwidth=\' + Flash_Width + \'&borderheight=\' + Flash_Height + \'&textheight=\' + Txt_Height + \'\">\');document.write(\'<embed src=\"Flash.swf\" wmode=\"opaque\" FlashVars=\"pics=\' + Pics_ + \'&links=\' + Links_ + \'&texts=\' + Texts_ + \'&borderwidth=\' + Flash_Width + \'&borderheight=\' + Flash_Height + \'&textheight=\' + Txt_Height + \'\" menu=\"false\" bgcolor=\"#ffffff\" quality=\"high\" width=\"\' + Flash_Width + \'\" height=\"\' + Swf_Height + \'\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />\');document.write(\'</object>\');</script>", Width, Height, AllPic.Remove(AllPic.Length - 1), AllLink.Remove(AllLink.Length - 1), AllText.Remove(AllText.Length - 1));
           mydb.Dispose();
           return result;
       }


  /// <summary>
       /// 获取单个视频
       /// </summary>
       /// <param name="ClassID"></param>
       /// <param name="Width"></param>
       /// <param name="Height"></param>
       /// <returns></returns>
       public static string LnVideo(string ClassID, string Width, string Height)
       {
           string result = "";
           string vpath="";
           int _cLassid = Convert.ToInt32(ClassID);
           Entities mydb = new Entities();
                L_Newss ln = mydb.L_Newss.Where(p=>p.ClassId==_cLassid).OrderByDescending(p=>p.NID).First();
               string biaoda = @"value=""([\s\S]*?.wmv)""";
               Regex regimg = new Regex(biaoda);
               MatchCollection mcimg = regimg.Matches(ln.Content.ToString());
               if (mcimg.Count > 0)
               {
                   //AllPic += mcimg[0].ToString().Replace("src=", "").Replace("\"", "") + "|";
                   vpath=mcimg[0].ToString().Replace("value=", "").Replace("\"", "");
               }
           result = string.Format("<object style='width:{0}px; height: {1}px' codebase='http://activex.microsoft.com/activex/ controls/mplayer/en/nsmp2inf.cab#Version=6,0,02,902' type='application/x-oleobject' height='{1}' standby='Loading Microsoft Windows Media Player components...' width='{0}' classid='CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95'><param name='FileName' value='{2}'   /><param name='autoStart' value='1'   /><param name='showControls' value='1'   /><param name='showstatusbar' value='0'   /><param name='windowlessvideo' value='false'   /><embed name='MediaPlayer1' src='{2}' autostart='1' showcontrols='1' showstatusbar='0' windowlessvideo='false' width='{0}' height='{1}' type='application/x-mplayer2' pluginspage='http://www.microsoft.com/Windows/MediaPlayer'   ></embed> </object>",Width,Height,vpath);
           mydb.Dispose();
           return result;
       }

       ///搜索 
       /// <param name="col">每页条数 </param>
       /// <returns></returns>
       public static string LnSh(string KEY, string col)
       {
           string result = "";
           int startRecord = 0;
           if (HttpContext.Current.Request.QueryString["startnum"] != null)
           {
               startRecord = Convert.ToInt32(HttpContext.Current.Request.QueryString["startnum"].ToString());
           }
           int maxRecords = int.Parse(col);
           using (Entities db = new Entities())
           {
               var myNote = (from mydata in db.L_Newss orderby mydata.NID descending where mydata.Title.Contains(KEY)  select mydata);


               if (myNote.Count() == 0)
               {
                   return "没有找到你要搜索的内容";
               }

               int count = myNote.Count();
               myNote = myNote.Skip(startRecord).Take(maxRecords);
               foreach (var nt in myNote)
               {
                   result += "<div class=lnsh><h2><a href=Pages_" + nt.ClassId + "_" + nt.NID + ".aspx>" + nt.Title + "</a></h2><h3>" + Convert.ToDateTime(nt.Time).ToLongDateString() + "</h3></div>\n";

               }
               if (startRecord > (count - 1))
               {
                   startRecord = (count - maxRecords) - 1;
               }
               if ((startRecord - maxRecords) < 0)
               {
                   startRecord = 0;
               }
               result = result + "<div class='page' id='mypage'>" + Pager(startRecord, count, maxRecords, "KEY") + "</div>";
               return result;
           }
       }



       /// <summary>
       /// 获取评论列表
       /// </summary>

       /// <param name="Num">留言条数all为全部 </param>
       /// <returns></returns>
       public static string LnFeedBack(string PageID, string Num, string col)
       {
           string result = "";
           int startRecord = 0;
           if (HttpContext.Current.Request.QueryString["startnum"] != null)
           {
               startRecord = Convert.ToInt32(HttpContext.Current.Request.QueryString["startnum"].ToString());
           }
           int maxRecords = int.Parse(col);

           using (Entities db = new Entities())
           {
               int _PageID = int.Parse(PageID);
               var myNote = (from mydata in db.L_Feedback orderby mydata.FID descending where mydata.NID == _PageID where mydata.FLock == "1" select mydata);

         
               if (Num != "all")
               {
                   int _num = int.Parse(Num);
                   myNote = myNote.Take(_num);
               }
               var count = myNote.Count();
               if (count == 0)
                   return "内容暂空";

               myNote = myNote.Skip(startRecord).Take(maxRecords);

       

               foreach (var nt in myNote)
               {
                   result += "<li ><h1>" + nt.FName + "</h1>";
                   result += "<h2>" + nt.FContent + "</h2>";

                   result += "<h3>" + nt.FReContent + "</h3> </li><br>\n";
               }

               if (startRecord > (count - 1))
                   startRecord = (count - maxRecords) - 1;

               if ((startRecord - maxRecords) < 0)
                   startRecord = 0;

               result = result + "<div id=fbpage><table align=center width=100%><tr><td align=center>" + Pager(startRecord, count, maxRecords, "class") + "</td></tr></table></div>";
               return result;
           }
       }

       /// <summary>
       /// 获取留言列表
       /// </summary>

       /// <param name="Num">留言条数all为全部 </param>
       /// <returns></returns>
       //////public static string LnNote(string ClassID, string Num, string col)
       //////{
       //////    string result = "";
       //////    string sql = "";
       //////    int startRecord = 0;
       //////    if (HttpContext.Current.Request.QueryString["startnum"] != null)
       //////    {
       //////        startRecord = Convert.ToInt32(HttpContext.Current.Request.QueryString["startnum"].ToString());
       //////    }


       //////    int maxRecords = int.Parse(col);
           //sql = "select * From yuserform where f_id=" + ClassID + " order by y_id DESC";

           //DataSet dataSet = new DataSet();

           //try
           //{
           //    OleDbDataAdapter adapter = new OleDbDataAdapter(sql, AccHelp.ConnectionString);
           //    adapter.SelectCommand.CommandType = CommandType.Text;

           //    adapter.Fill(dataSet, startRecord, maxRecords, "table");
           //}
           //catch
           //{
           //}
           //foreach (DataRow row2 in dataSet.Tables["table"].Rows)
           //{

           //    string a = row2["y_1v"].ToString();


           //    if (a.Length > 0)
           //    {
           //        a = a.Substring(0, a.Length - 1);
           //        string[] sArray = a.Split(new char[] { '|' });
           //        result += "姓名：" + sArray[0] + "   时间：" + row2["y_date"].ToString() + "<br>留言内容" + sArray[1] + "<br>回复：" + row2["y_replay"].ToString() + "<br><br>";
           //    }
           //}

       //////////    using (Entities db = new Entities())
       //////////    {
       //////////        var myNote = (from mydata in db.LN_FormRe orderby mydata.fr_id descending where mydata.f_id == int.Parse(ClassID) where mydata.fr_reok==1  select mydata);
       //////////        if (Num!="all")
       //////////        {
       //////////         myNote = myNote.Take(int.Parse(Num));
            
       //////////        }
			   
       //////////        if (myNote.Count() == 0)
       //////////        {
       //////////            return "内容暂空";
       //////////        }
			
       //////////       int count =myNote.Count();
       //////////      myNote = myNote.Skip(startRecord).Take(maxRecords);
       //////////        foreach (var nt in myNote)
       //////////        {
       //////////            string a = nt.fr_2;
       //////////            a = a.Substring(0, a.Length - 1);
       //////////            string[] sArray = a.Split(new char[] { '|' });
       //////////            result += "姓名：" + sArray[0];
       //////////            result += "  时间：" + nt.fr_date;
       //////////            result += "<br>FAQ内容：" + sArray[2];
       //////////            result += "<br>回复：" + nt.fr_repaly + "<br><hr />";             
       //////////        }

          

       //////////    if (startRecord > (count - 1))
       //////////    {
       //////////        startRecord = (count - maxRecords) - 1;
       //////////    }
       //////////    if ((startRecord - maxRecords) < 0)
       //////////    {
       //////////        startRecord = 0;
       //////////    }




       //////////    result = result + "<table align=center><tr><td align=center>" + Pager(startRecord, count, maxRecords, "class") + "</td></tr></table>";

       //////////    return result;
       //////////}
     //////////  }

       /// <summary>
       /// 获取标题
       /// </summary>
       /// <param name="ClassID"></param>
       /// <param name="Num"></param>
       /// <param name="WordsNum"></param>
       /// <returns></returns>
        public static string LnSNL(string ClassID, string Num,string WordsNum)
        {
            return LnNL(ClassID, "<li><a href='#link#'>#title#</a></li>", Num, WordsNum, "20", "0", "0");
        }

        public static string LnNL(string ClassID, string Style, string Num, string WordsNum, string InfoNum, string Page, string PageNum)
        {
            return LnNLT(ClassID,"", Style, Num, WordsNum, InfoNum, Page, PageNum);
        }
        

        /// <summary>
        /// 获取标题列表
        /// </summary>
        /// <param name="ClassID">文章所属栏目</param>
        /// <param name="NType">文章属性</param>
        /// <param name="Style">样式,$link$=链接,$title$=标题,$info$=摘要,$pic$=图片地址</param>
        /// <param name="Num">新闻条数</param>
        /// <param name="WordsNum">标题字数</param>
        /// <param name="InfoNum">摘要字数</param>
        /// <param name="page">是否分页,1为分页,0不分</param>
        /// <returns></returns>
        /// 

        public static string LnNLT(string ClassID, string NType,string Style, string Num, string WordsNum, string InfoNum, string Page, string PageNum)
        {
            #region 如果不为N
            if (ClassID != "N")
               {
                   using (Entities mydb = new Entities()) {               
                   string result = "";                     
         
                       string[] allclassid = ClassID.Split('|');
                       #region 
                       var myNew = PredicateBuilder.False<L_Newss>();
                       if (allclassid.Length > 1)
                       {                        
                           foreach (string oneclass in allclassid)
                           {                        
                              int temp = int.Parse(oneclass);
                              myNew = myNew.Or(p => p.ClassId == temp);
                           }                 
                       }
                    
                       else
                       {
                           myNew = myNew.Or(p => p.ClassId.ToString()==ClassID);
                       }

                       myNew = myNew.And(p => p.IsLock != "1");
                       if (NType.Length>2) 
                       {

                
                          //热点
                         if (NType.IndexOf("hot") >= 0)
                         {
                             myNew = myNew.And(p => p.IsHot == "1");
                         }
                         //推荐
                         else if (NType.IndexOf("red") >= 0)
                         {
                             myNew = myNew.And(p => p.IsRed == "1");
                         }
                          //图片
                         if (NType.IndexOf("img") >= 0)
                         {
                             myNew = myNew.And(p => p.IsSlide == "1");
                         }
                           //置顶
                         if (NType.IndexOf("top") >= 0)
                         {
                             myNew = myNew.And(p => p.IsTop == "1");
                         }
                       }
                       //是否锁定
                     

                       #endregion
     
                   if (Page == "0")
                   {
                       int _Num = int.Parse(Num);
                       List<L_Newss> _myNew = mydb.L_Newss.Where(myNew.Compile()).OrderByDescending(p => p.NID).OrderByDescending(p => p.IsTop).Take(_Num).ToList();
                       result = myresult(Style, WordsNum, InfoNum,_myNew);                 
                   }

                   else
                   {
                       string nowpage = "1";
                       string totalnum = "";
                       List<L_Newss> _myNewpage = mydb.L_Newss.Where(myNew.Compile()).OrderByDescending(p => p.NID).OrderByDescending(p => p.IsTop).Take(999999).ToList();
                       totalnum = _myNewpage.Count().ToString();

                       if (HttpContext.Current.Request["page"] != null)
                       {
                           nowpage = HttpContext.Current.Request["page"].ToString();
                       }
                       if (nowpage == "1")
                       {
                           _myNewpage = _myNewpage.Take(int.Parse(PageNum)).ToList();
                         }
                          else
                         {
                             _myNewpage = _myNewpage.Skip(int.Parse(PageNum) * (Convert.ToInt32(nowpage) - 1)).Take(int.Parse(PageNum)).ToList();  
                      }

                       result = myresult(Style, WordsNum, InfoNum, _myNewpage);   

                       string firsturl = "";
                       string fonturl = "";
                       string nexturl = "";
                       string lasturl = "";
                       string tatalpage = "";
                       if (Convert.ToInt32(totalnum) < Convert.ToInt32(PageNum))
                       {
                           tatalpage = "1";
                       }
                       else
                       {
                           tatalpage = ((Convert.ToInt32(totalnum) / Convert.ToInt32(PageNum)) + 1).ToString();
                       }

                       if (nowpage == "1")
                       {
                           firsturl = "?page=1";
                           fonturl = "javascript:void(0);";
                           nexturl = "?page=2";
                           lasturl = "?page=" + tatalpage;
                       }
                       else if (nowpage == tatalpage)
                       {
                           firsturl = "?page=1";
                           fonturl = "?page=" + (Convert.ToInt32(nowpage) - 1).ToString();
                           nexturl = "javascript:void(0)";
                           lasturl = "javascript:void(0);";
                       }
                       else
                       {
                           firsturl = "?page=1";
                           fonturl = "?page=" + (Convert.ToInt32(nowpage) - 1).ToString();
                           nexturl = "?page=" + (Convert.ToInt32(nowpage) + 1).ToString();
                           lasturl = "?page=" + tatalpage;
                       }
                       result += string.Format("<div class='page' id='mypage'><a href='{0}'>首页</a>&nbsp;&nbsp;<a href='{1}'>前一页</a>&nbsp;当前是:第[{4}]页 共[{5}]页&nbsp;<a href='{2}'>后一页</a><a href='{3}'>&nbsp;&nbsp;尾页</a></div>", firsturl, fonturl, nexturl, lasturl, nowpage, tatalpage);
                   }
                   return result;
                }
               }
           #endregion
            #region 如果为N
            else
            {
                string result = "";
                 using (Entities db = new Entities()) {
                     var myNew = PredicateBuilder.True<L_Newss>();
                     myNew = myNew.And(p => p.IsLock != "1");

                     if (NType.Length > 2)
                     {
                         //热点
                         if (NType.IndexOf("hot") >= 0)
                         {
                             myNew = myNew.And(p => p.IsHot == "1");
                         }
                         //推荐
                         else if (NType.IndexOf("red") >= 0)
                         {
                             myNew = myNew.And(p => p.IsRed == "1");
                         }
                         //图片
                         if (NType.IndexOf("img") >= 0)
                         {
                             myNew = myNew.And(p => p.IsSlide == "1");
                         }
                         //置顶
                         if (NType.IndexOf("top") >= 0)
                         {
                             myNew = myNew.And(p => p.IsTop == "1");
                         }
                     }
                     //是否锁定
                  

                if (Page == "0")
                {
                 
                    int _Num = int.Parse(Num);
                    var mm = db.L_Newss.Where(myNew.Compile());

                   // var _myNew = db.L_Newss.Where(myNew.Compile()).OrderByDescending(p => p.NID).OrderByDescending(p => p.IsTop).Take(_Num);
                   var _news = (from nn in mm orderby nn.NID descending orderby nn.IsTop select nn).Take(_Num);
                  // string sql = ((ObjectQuery)_news).ToTraceString();
                   List<L_Newss> _mynews = _news.ToList();
                  
                     result = myresult(Style, WordsNum, InfoNum, _mynews);   
                }
             
                else
                {
                    string nowpage = "1";
                    string totalnum = "";
                    List<L_Newss> _myNew = db.L_Newss.Where(myNew.Compile()).OrderByDescending(p => p.NID).OrderByDescending(p => p.IsTop).Take(999999).ToList();
                       
                    totalnum = _myNew.Count().ToString();
                    if (HttpContext.Current.Request["page"] != null)
                    {
                        nowpage = HttpContext.Current.Request["page"].ToString();
                    }
                    if (nowpage == "1")
                    {
                        _myNew = _myNew.Take(int.Parse(PageNum)).ToList();  
                    
                    }
                    else
                    {
                        _myNew = _myNew.Skip(int.Parse(PageNum) * (Convert.ToInt32(nowpage) - 1)).Take(int.Parse(PageNum)).ToList();  
                    
                    }
                    result = myresult(Style, WordsNum, InfoNum, _myNew);   

                    string firsturl = "";
                    string fonturl = "";
                    string nexturl = "";
                    string lasturl = "";
                    string tatalpage = "";
                    if (Convert.ToInt32(totalnum) < Convert.ToInt32(PageNum))
                    {
                        tatalpage = "1";
                    }
                    else
                    {
                        tatalpage = ((Convert.ToInt32(totalnum) / Convert.ToInt32(PageNum)) + 1).ToString();
                    }

                    if (nowpage == "1")
                    {
                        firsturl = "?page=1";
                        fonturl = "javascript:void(0);";
                        nexturl = "?page=2";
                        lasturl = "?page=" + tatalpage;
                    }
                    else if (nowpage == tatalpage)
                    {
                        firsturl = "?page=1";
                        fonturl = "?page=" + (Convert.ToInt32(nowpage) - 1).ToString();
                        nexturl = "javascript:void(0)";
                        lasturl = "javascript:void(0);";
                    }
                    else
                    {
                        firsturl = "?page=1";
                        fonturl = "?page=" + (Convert.ToInt32(nowpage) - 1).ToString();
                        nexturl = "?page=" + (Convert.ToInt32(nowpage) + 1).ToString();
                        lasturl = "?page=" + tatalpage;
                    }
                    result += string.Format("<div class='page' id='mypage'><a href='{0}'>第一页</a><a href='{1}'>上一页</a><a href='{2}'>下一页</a><a href='{3}'>最后一页</a>&nbsp;当前是:第[{4}]页 共[{5}]页</div>", firsturl, fonturl, nexturl, lasturl, nowpage, tatalpage);


                   }

                 }
                return result;
            }
            #endregion

        }

         //
        //分类名字 (id, 类别1为带链接其他为不带链接)
        public static string Dex_ClassName(string id,string type)
        {

           string str="";
           int _id = Convert.ToInt16(id);
            using (Entities db= new Entities())
            {
                var listName = db.L_Classs.SingleOrDefault(p => p.CID == _id).CNmae;
                if(type=="1")
                str = "<A href=\"{$Dex_SitUrl$}/list" + id + ".aspx\">" + listName.ToString() + "</A> ";  
                else
                str = listName.ToString();  
        
            }
            return str;
        }

        //导航标签 (id, 类别1为带链接其他为不带链接)
        public static string Dex_ClassNav(string id, string type)
        {
           string str = "";
            using (Entities lnnews = new Entities())
            {
                int _id = int.Parse(id);
                string _mystr;
                var listPid = (from p in lnnews.L_Classs where p.CID == _id select new{p.CpareID,p.CNmae}).First();
               
                if (type == "1")
                    _mystr = "<A href=\"{$Dex_SitUrl$}/list" + id + ".aspx\">" + listPid.CNmae.ToString() + "</A> ";
                else
                    _mystr = listPid.CNmae.ToString();

                str = dpbnc(_mystr, int.Parse(listPid.CpareID.ToString()), type);
            
            }

            return str;
        }

        public static string dpbnc(string mystr, int cID, string type)//根据子项ID查询父
        {
            using (Entities lnnews = new Entities())
            {
                if (cID == 0)
                    return mystr;

                var listPid = (from p in lnnews.L_Classs where p.CID == cID select new { p.CpareID, p.CNmae }).First();

                if (type == "1")
                    mystr = "<A href=\"{$Dex_SitUrl$}/list" + cID + ".aspx\">" + listPid.CNmae.ToString() + "</A> "+ "&nbsp;&nbsp;>&nbsp;>&nbsp;&nbsp;" + mystr;
                else                
                mystr = listPid.CNmae.ToString() + "&nbsp;&nbsp;>&nbsp;>&nbsp;&nbsp;" + mystr;

                dpbnc(mystr, int.Parse(listPid.CpareID.ToString()),type);
            
            } 
            return mystr;

        }
        

        //截取字符串
        public static string TrimString(object sdr, string Num)
        {
            string result = "";
            if (sdr == null && sdr.ToString() == "")
            {
                result = "";
            }
            else
            {
                if (Html2Text(sdr.ToString(), false).Length > Convert.ToInt32(Num))
                {
                    result = Html2Text(sdr.ToString(), false).Remove(Convert.ToInt32(Num));
                }
                else
                {
                    result = Html2Text(sdr.ToString(), false);
                }
            }
            return result;

        }
        public static string Html2Text(string html, bool keepFormat)
        {
            string pattern = html2TextPattern;
            if (!keepFormat) pattern += "|(?<control>[\r\n\\s])"; // 换行字符 

            RegexOptions options = RegexOptions.IgnoreCase | RegexOptions.Singleline | RegexOptions.Compiled;
            string txt = Regex.Replace(html, pattern, new MatchEvaluator(Html2Text_Match), options);

            if (!keepFormat)
                return Regex.Replace(txt.Trim(), "[\u0020]+", "\u0020", options); // 替换多个连续空格 
            else
                return txt;
        }

        private static string html2TextPattern =
               @"(?<script><script[^>]*?>.*?</script>)|(?<style><style>.*?</style>)|(?<comment><!--.*?-->)" +
               @"|(?<html><[^>]+>)" + // HTML标记 
               @"|(?<quot>&(quot|#34);)" + // 符号: " 
               @"|(?<amp>&(amp|#38);)" + // 符号: & 
               @"|(?<lt>&(lt|#60);)" + // 符号: < 
               @"|(?<gt>&(gt|#62);)" + // 符号: > 
               @"|(?<iexcl>&(iexcl|#161);)" + // 符号: (char)161 
               @"|(?<cent>&(cent|#162);)" + // 符号: (char)162 
               @"|(?<pound>&(pound|#163);)" + // 符号: (char)163 
               @"|(?<copy>&(copy|#169);)" + // 符号: (char)169 
               @"|(?<others>&(\d+);)" + // 符号: 其他 
               @"|(?<space>&nbsp;|&#160;)"; // 空格 

        private static string Html2Text_Match(Match m)
        {
            if (m.Groups["quot"].Value != string.Empty)
                return "\"";
            else if (m.Groups["amp"].Value != string.Empty)
                return "&";
            else if (m.Groups["lt"].Value != string.Empty)
                return "<";
            else if (m.Groups["gt"].Value != string.Empty)
                return ">";
            else if (m.Groups["iexcl"].Value != string.Empty)
                return "\xa1";
            else if (m.Groups["cent"].Value != string.Empty)
                return "\xa2";
            else if (m.Groups["pound"].Value != string.Empty)
                return "\xa3";
            else if (m.Groups["copy"].Value != string.Empty)
                return "(c)";
            else if (m.Groups["space"].Value != string.Empty)
                return "\u0020";
            else if (m.Groups["control"].Value != string.Empty)
                return "\u0020";
            else
                return string.Empty;
        }

       /// <summary>
       /// 分页
       /// </summary>
       /// <param name="startnum"></param>
       /// <param name="count"></param>
       /// <param name="pernum"></param>
       /// <param name="Wname"></param>
       /// <returns></returns>
        public static string Pager(int startnum, int count, int pernum, string Wname)
        {
            string str = "";
            if ((HttpContext.Current.Request[Wname] == null) || (HttpContext.Current.Request[Wname] == ""))
            {
                str = "0";
            }
            else
            {
                str = HttpContext.Current.Request[Wname];
            }
            int num = 0;
            if ((count % pernum) == 0)
            {
                num = count / pernum;
            }
            else
            {
                num = (count / pernum) + 1;
            }
            int num2 = (startnum + pernum) / pernum;
            if ((count - pernum) == startnum)
            {
                num2 = num;
            }
            string str2 = "<br><br><br>";
            string str3 = str2;



            object obj2 = str3 + "\n<script>function gono(str){window.location.href='?btn=sk&SearchText=" + Wname + "&startnum='+str ;}</script>\n";
            str2 = string.Concat(new object[] { obj2, "<tr><td>共", count, "条", "&nbsp;当前第", num2, "页&nbsp&nbsp;共有", num, "页" });

            //   str2 = string.Concat(new object[] { obj2, "<tr><td colspan=10>共有", count, "件&nbsp;&nbsp;ページ" });
            if (count > 0)
            {
                string str4 = str2;
                str2 = str4 + "&nbsp;&nbsp;<a href='?startnum=0&" + Wname + "=" + str + "'>首页</a>&nbsp;&nbsp;";
            }
            else
            {
                str2 = str2 + "&nbsp;&nbsp;第一页&nbsp;&nbsp;";
            }
            if ((startnum - pernum) >= 0)
            {
                object obj3 = str2;
                str2 = string.Concat(new object[] { obj3, "<a href='?startnum=", startnum - pernum, "&", Wname, "=", str, "'>前一页</a>&nbsp;&nbsp;" });
            }
            else
            {
                str2 = str2 + "前一页&nbsp;&nbsp;";
            }
            if ((startnum + pernum) <= (count - 1))
            {
                object obj4 = str2;
                object obj5 = string.Concat(new object[] { obj4, "<a href='?startnum=", startnum + pernum, "&", Wname, "=", str, "'>下一页</a>&nbsp;&nbsp;" });
                str2 = string.Concat(new object[] { obj5, "<a href='?startnum=", pernum * (num - 1), "&", Wname, "=", str, "'>最后一页</a>&nbsp;&nbsp;" });
            }
            else
            {
                str2 = str2 + "下一页&nbsp;&nbsp;";
            }

            return str2;
        }

        public static string Dex_Tag(string id,string nu)
        {

            string myTag = "";
            int _id=int.Parse(id);
            using (Entities db = new Entities())
            {
                var bq = db.L_Classs.SingleOrDefault(p => p.CID == _id);
                if (nu == "1")
                {
                  myTag = bq.CTag.ToString();
                }
                if (nu == "2")
                {
                   myTag = bq.CTag2.ToString();
                }
                if (nu == "3")
                {
                    myTag = bq.CTag3.ToString();
                }
               
            }

            string str2 = myTag;
            return str2;
        }


        //list分类列表 ( 2为同级所有 ,3下级)
        public static string Dex_ClassList(string id, int col)
        {
            string str2 = "";
            string str3 = "";
            int num = col;
            int _id = int.Parse(id);
            var cla = new List<L_Classs> {};
                using (Entities db = new Entities())
                {  
                   if (col == 2)
                   {
                    var bq = db.L_Classs.SingleOrDefault(p => p.CID == _id);
                    cla = db.L_Classs.Where(p => p.CpareID == bq.CpareID).ToList();
                   }
                   if (col == 3)
                   {
                       cla = db.L_Classs.Where(p => p.CID == _id).ToList();   
                   }
                    str2 = "<ul>";
                    foreach (var _cla in cla)
                    {
                        str2 = str2 + "<li><A title=\"" + _cla.CNmae + "\"  ";
                        str2 = str2 + " href=\"{$Dex_SitUrl$}/List" + _cla.CID + ".aspx \"" + ">";
                        if (col == 3)
                        {
                            if (_cla.CID == int.Parse(id))
                            {
                                str2 += "";
                            }
                        }
                        str2 = str2 + _cla.CNmae + str3 + "</A></li>";
                    }
                    str2 += "</ul>";
                }
                return str2;      
        }

       ///// <summary>
       ///// 测试用
       ///// </summary>
       ///// <param name="myNew"></param>
       ///// <returns></returns>

       //public static string rpln(string[] myNew)

        public static string myresult(string Style, string WordsNum, string InfoNum , List<L_Newss> myNew)
        
       {
           string result = "";
           if (myNew.Count() == 0)
           {
               return "内容暂空";
           }
           foreach (var nw in myNew)
           {
               result += Style;
               Regex reg = new Regex(@"#\w*#");
               MatchCollection mc = reg.Matches(Style);

               foreach (Match m in mc)
               {
                   if (m.Value == "#link#")
                   {
                       result = result.Replace(m.Value, "Pages_" + nw.ClassId + "_" + nw.NID + ".aspx");
                   }
                   else if (m.Value == "#title#")
                   {
                       if (nw.Title!=null)
                       result = result.Replace(m.Value, TrimString(nw.Title, WordsNum));
                   }
                   else if (m.Value == "#fulltitle#")
                   {
                       if (nw.Title != null)
                           result = result.Replace(m.Value, nw.Title);
                   }
                   else if (m.Value == "#time#")
                   {
                       if (nw.Time != null)
                       result = result.Replace(m.Value, Convert.ToDateTime(nw.Time).ToLongDateString());
                   }
                   else if (m.Value == "#key#")
                   {
                       result = result.Replace(m.Value,nw.Tag);
                   }

                   else if (m.Value == "#From#")
                   {
                       result = result.Replace(m.Value, nw.From);
                   }
                   else if (m.Value == "#info#")
                   {
                       result = result.Replace(m.Value, TrimString(nw.ZhaiYao, InfoNum));
                   }
                   else if (m.Value == "#fullinfo#")
                   {
                       result = (result.Replace(m.Value, nw.ZhaiYao)).Remove(Convert.ToInt32(InfoNum));
                   }
                   else if (m.Value == "#pic#")
                   {
                       string biaoda = @"src=""([\s\S]*?)""";
                       Regex regimg = new Regex(biaoda);
                       MatchCollection mcimg = regimg.Matches(nw.Content.ToString());
                       if (mcimg.Count > 0)
                       {
                           result = result.Replace(m.Value, mcimg[0].ToString());
                       }
                       else
                       {
                           result = result.Replace(m.Value, "src=\"/logo/img.gif\"");
                       }

                   }

                   else if (m.Value == "#picNsrc#")
                   {
                       string biaoda = @"src=""([\s\S]*?)""";
                       Regex regimg = new Regex(biaoda);
                       MatchCollection mcimg = regimg.Matches(nw.Content.ToString());
                       if (mcimg.Count > 0)
                       {
                           result = result.Replace(m.Value,mcimg[0].ToString().Substring(4));
                       }
                       else
                       {
                           result = result.Replace(m.Value, "src=\"/logo/img.gif\"");
                       }

                   }

                   else if (m.Value == "#img#")
                   {

                       if (nw.Img != null)
                       {
                           result = result.Replace(m.Value, nw.Img);
                       }
                       else
                       {
                           result = result.Replace(m.Value, "src=\"/logo/img.gif\"");
                       }

                   }

         
                   else if (m.Value == "#classname#")
                   {

                       if (nw.ClassId != null)
                       {
                           using (Entities db = new Entities())
                           {
                                 var use = db.L_Classs.FirstOrDefault(p => p.CID==nw.ClassId).CNmae;
                                 result = result.Replace(m.Value, use);
                           }
          
                       }
                       else
                       {
                           result = result.Replace(m.Value, "src=\"/logo/img.gif\"");
                       }

                   }

                   else if (m.Value == "#class#")
                   {

                       if (nw.ClassId != null)
                       {
                           using (Entities db = new Entities())
                           {
                               var use = db.L_Classs.FirstOrDefault(p => p.CID == nw.ClassId);
                               result = result.Replace(m.Value, "<a href=List"+use.CID+".aspx>"+use.CNmae+"</a>");
                           }

                       }
                       else
                       {
                           result = result.Replace(m.Value, "src=\"/logo/img.gif\"");
                       }

                   }
				


               }
           }

           return result;
       }

       


       


    }

