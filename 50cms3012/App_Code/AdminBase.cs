using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Configuration;
using System.Text.RegularExpressions;
using Models;


    public class AdminBase : System.Web.UI.Page
    {
        protected internal SysSet sysset;
        public AdminBase()
        {
            this.Load += new EventHandler(AdminBase_Load);
            sysset = new SysSet().loadCacheConfig(Utils.GetMapPath("~/App_Data/WebSet.config"));

        }

        void AdminBase_Load(object sender, EventArgs e)
        {
            if (!IsAdminLogin())
            {
                Response.Write("<script>window.open('/Admin/login.aspx','_top');</script>");
                Response.End();
            }
        }

        /// <summary>
        /// 判断管理员是否已经登录(解决Session超时问题)
        /// </summary>
        public bool IsAdminLogin()
        {
            //如果Session为Null
            if (Session["adminID"] != null && Session["adminID"].ToString() != String.Empty)
            {
                return true;
            }
            else
            {
                //检查Cookies
                string adminname = Utils.GetCookie("AdminName", "lncms"); //解密用户名
                string adminpwd = Utils.GetCookie("AdminPwd", "lncms");
                if (adminname != "" && adminpwd != "")
                {
                    adminname = DESEncrypt.Decrypt(adminname); //解密用户名

                    if (bllchkAdminLogin(adminname, adminpwd))
                        return true;

                }
            }
            return false;
        }


        /// <summary>
        /// 检查登录用户
        /// </summary>
        /// <param name="UserName"></param>
        /// <param name="UserPwd"></param>
        /// <returns></returns>
        public bool bllchkAdminLogin(string UserName, string UserPwd)
        {
            using (Entities db = new Entities())
            {

                var mydd = db.Manages.SingleOrDefault(p => p.MName == UserName);
                if (mydd == null)
                {
                    //  JscriptPrint("类别修改成功啦！", "list.aspx", "Success");
                    //  HttpContext.Current.Response.Write("<script>alert('用户名错误，请确认你的身份!!!');</script>");
                    return false;
                }
                else
                {
                    string Md5_userpassword = UserPwd;
                    //判断密码的正确性
                    if (Md5_userpassword != mydd.MPWD)
                    {
                        //HttpContext.Current.Response.Write("<script>alert('用户密码错误，请确认你的身份!!!');</script>");
                        return false;
                    }
                    else
                    {
                        Session["AdminID"] = mydd.MID;
                        Session["AdminName"] = mydd.MName;
                        Session["AdminType"] = mydd.MRole;

                        //设置超时时间
                        Session.Timeout = 45;
                        Session["AdminLoginSun"] = null;
                        //写入Cookies
                        Utils.WriteCookie("AdminName", "lncms", DESEncrypt.Encrypt(mydd.MName));
                        Utils.WriteCookie("AdminPwd", "lncms", mydd.MPWD);
                        return true;

                    }

                }
            }


        }





        public bool chkAdminLogin(string UserName, string UserPwd)
        {
            //对用户输入的密码进行Md5加密	      
            UserName = UserName.Trim();
            UserPwd = UserPwd.Trim();
            using (Entities mydb = new Entities())
            {
                //////var mydd = mydb.L_Admin.SingleOrDefault(p => p.adminname == Text2.Value);
                //////if (mydd == null)
                //////{
                //////    Response.Write("<script>alert('用户名错误，请确认你的身份!!!');</script>");
                //////    return;
                //////}
                //////else
                //////{
                //////    string Md5_userpassword = Th.md10(this.pass.Text);
                //////    //判断密码的正确性
                //////    if (Md5_userpassword != mydd.adminpwd)
                //////    {
                //////        Response.Write("<script>alert('用户登入失败，请确认你的身份!!!');</script>");
                //////        return;
                //////    }
                //////    else
                //////    {
                //////        string LoginIP = Request.UserHostAddress.ToString();
                //////        //把用户名、密码、权限存入Session值中，以备使用
                //////        Session["adminID"] = mydd.adminid.ToString();
                //////        Session["adminName"] = mydd.adminname;
                //////        Response.Redirect("maint.aspx");
                //////    }

                //////}

                return true;

            }
        }



        /// <summary>
        /// 绑定类别DropDownList控制
        /// </summary>
        /// /// <param name="firstItemTxt">第一项显示的文字</param>
        /// <param name="ddl">要绑定的DropDownList控件</param>

        public void ClassTreeBind(string firstItemTxt, DropDownList dp)
        {
            string tepmValue="0";
            ClassTreeBindFV(tepmValue, firstItemTxt, dp);
           
        }
        public void ClassTreeBindFV(string firstItemValue, string firstItemTxt, DropDownList dp)
        {
            dp.Items.Clear();
            ListItem list = new ListItem(firstItemTxt, firstItemValue);
            dp.Items.Add(list);

            using (Entities _class = new Entities())
            {
                int a;
                int.TryParse(list.Value, out a);

                var m = from n in _class.L_Classs where n.CpareID == a select n;
                foreach (var n in m)
                {
                    string typename = TypeName(n.CType.ToString());
                    if (chkpow(n.CID))
                    {
                        dp.Items.Add(new ListItem(n.CNmae.ToString() + "    【" + typename + "】", n.CID.ToString()));
                        int leng = 1;

                        dpbinder(dp, int.Parse(n.CID.ToString()), leng);
                    }
                }
            }
        }

        private bool chkpow(long claid)
        {
            if (sysset.NewsRule) 
            { return true; }
            else { 
            string admin_power = "";
            int _Id = int.Parse(Session["AdminID"].ToString());
            using (Entities db = new Entities())
            {
                admin_power = db.Manages.SingleOrDefault(p => p.MID == _Id).MRole;
            }

            if (admin_power.IndexOf("," + claid + ",") > -1)
                return true;
            else
                return false;
            }
        }





        public void dpbinder(DropDownList dp, int cID, int leng)//根据父ID查询子项
        {
            //DataTable ds = SelectProClass("select productClassID,productClassName from tab_productClass where productClassParentID=" + cID.ToString());
            using (Entities _class = new Entities())
            {
                int b;
                int.TryParse(cID.ToString(), out b);

                var mm = from nn in _class.L_Classs where nn.CpareID == b select nn;
                leng++;
                foreach (var n in mm)
                {
                    string tr = addtab(leng);

                    if (chkpow(n.CID))
                    {
                        string typename = TypeName(n.CType.ToString());
                        dp.Items.Add(new ListItem(tr + "├─" + n.CNmae.ToString() + "    【" + typename + "】", n.CID.ToString()));
                        dpbinder(dp, int.Parse(n.CID.ToString()), leng);
                    }
                }
            }
        }
        private string addtab(int i)
        {
            string aa = "";
            for (int j = 0; j < i; j++)
            {
                aa += "　";
            }
            return aa;
        }


        /// <summary>
        /// 遮罩提示窗口
        /// </summary>
        /// <param name="w">宽度</param>
        /// <param name="h">高度</param>
        /// <param name="msgtitle">窗口标题</param>
        /// <param name="msgbox">提示文字</param>
        /// <param name="url">返回地址</param>
        /// <param name="msgcss">CSS样式</param>
        protected void JscriptMsg(int w, int h, string msgtitle, string msgbox, string url, string msgcss)
        {
            string msbox = "";
            msbox += "<script type=\"text/javascript\">\n";
            msbox += "parent.jsmsg(" + w + "," + h + ",\"" + msgtitle + "\",\"" + msgbox + "\",\"" + url + "\",\"" + msgcss + "\")\n";
            msbox += "</script>\n";
            ClientScript.RegisterClientScriptBlock(Page.GetType(), "JsMsg", msbox);
        }


        /// <summary>
        /// js的添加编辑删除提示
        /// </summary>
        /// <param name="msgtitle">提示文字</param>
        /// <param name="url">返回地址</param>
        /// <param name="msgcss">CSS样式</param>
        protected void JscriptPrint(string msgtitle, string url, string msgcss)
        {
            string msbox = "";
            msbox += "<script type=\"text/javascript\">\n";
            msbox += "parent.jsprint(\"" + msgtitle + "\",\"" + url + "\",\"" + msgcss + "\")\n";
            msbox += "</script>\n";
            ClientScript.RegisterClientScriptBlock(Page.GetType(), "JsPrint", msbox);
        }


        /// <summary>
        /// 日志写入
        /// </summary>
        /// <param name="str"></param>
        protected void SaveLogs(string str)
        {

            if (Session["AdminName"] != null)
            {
                 SaveLogs(Session["AdminName"].ToString(),str);
            }
           

        }

        /// <summary>
        /// 日志写入
        /// </summary>
        /// <param name="str"></param>
        public void SaveLogs(string username, string str)
        {

            if (!sysset.WebLog)
            {
                return;
            }
            Entities mydb = new Entities();
            {
                L_Log Lg = new L_Log();

                Lg.L_TiTLE = str;
                Lg.L_Time = DateTime.Now.ToString();
                Lg.L_IP = GetIP();
                Lg.L_UID = username;
                mydb.L_Log.AddObject(Lg);
                mydb.SaveChanges();

            }
        }



        public static string GetIP()
        {
            string result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
         
            if (string.IsNullOrEmpty(result))
                result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (string.IsNullOrEmpty(result))
                result = HttpContext.Current.Request.UserHostAddress;

            if (string.IsNullOrEmpty(result) || ! IsIP(result))
                return "127.0.0.1";

            return result;
        }

        #region 检查是否为IP地址
        /// <summary>
        /// 是否为ip
        /// </summary>
        /// <param name="ip"></param>
        /// <returns></returns>
        public static bool IsIP(string ip)
        {
            return Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
        }
        #endregion


        public string TypeName(string CType)
        {
            string _typeName = "";
            switch (CType)
            {
                case ("1"):
                    _typeName = "文章";
                    break;
                case ("2"):
                    _typeName = "单页";
                    break;
                case ("3"):
                    _typeName = "跳转";
                    break;
            }
            return _typeName;
        }
    }
