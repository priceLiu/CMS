using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Text;
using System.Collections.Generic;


    public partial class AdminAdd : AdminBase
    {
        public int _Id = 0;
        private DataTable dc = new DataTable();
        public string admin_power = "";
        public string admin_role = "";


        protected void Page_Load(object sender, EventArgs e)
        {

            Response.CacheControl = "no-cache";

            if (!string.IsNullOrEmpty(Request.Params["ID"]))
            {
                _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);

            }

            if (!Page.IsPostBack)
            {

                if (_Id != 0)
                {
                    ShowInfo(_Id);
                    this.Panel2.Visible = true;
                    Literal1.Text = Convert.ToString(_Id);
                    using (Entities db = new Entities())
                    {
                        admin_role = db.Manages.SingleOrDefault(p => p.MID == _Id).MRole;
                        admin_power = db.Manages.SingleOrDefault(p => p.MID == _Id).MPower;
                    }
                }
                else
                {
                    this.Panel1.Visible = true;
                }
                GetMenuString();
                grdbind();

            }


        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Entities mydb = new Entities();
            {
                Manages Lt = new Manages();
                if (_Id != 0)
                    Lt = mydb.Manages.First(p => p.MID == _Id);

                Lt.MName = txtName.Text.Trim();

                Lt.MRole = "";
                string admin_power = ",";
                if (Request.Form["admin_power"] != null)
                    admin_power = "," + Request.Form["admin_power"].ToString() + ",";
                Lt.MPower = admin_power;

                string admin_Role = ",";
                if (Request.Form["admin_Role"] != null)
                    admin_Role = "," + Request.Form["admin_Role"].ToString() + ",";
                Lt.MRole = admin_Role;


                if (_Id == 0)
                {
                    Lt.MPWD = DESEncrypt.Encrypt(this.txtTag.Text.ToString().Trim());
                    mydb.Manages.AddObject(Lt);
                    mydb.SaveChanges();
                    JscriptPrint("用户添加成功啦！", "AdminList.aspx", "Success");
                }
                else
                {
                    mydb.SaveChanges();
                    JscriptPrint("用户修改成功啦！", "AdminList.aspx", "Success");
                }
            }


            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }

        private void ShowInfo(int _id)
        {

            Entities mydb = new Entities();
            {

                Manages _mg = mydb.Manages.First(p => p.MID == _id);
                txtName.Text = _mg.MName;


            }
        }





        protected void GetMenuString()
        {
            List<LeftMenu> menus = LeftMenu.Load();
            StringBuilder sb = new StringBuilder();
            foreach (LeftMenu menu in menus)
            {
                sb.Append("<table cellpadding=0 cellspacing=0 width=98%><tr>\r\n");

                sb.Append("<td  align=left class=\"menu_title\" ><input type=checkbox  name=\"admin_power\" class=\"checkall\" value=\"");
                sb.Append(menu.Code + "\"");
                if (_Id != 0)
                {
                    if (admin_power.IndexOf("," + menu.Code + ",") > -1)
                        sb.Append(" checked");
                }
                sb.Append("/>");

                sb.AppendFormat("{0}</td></tr>\r\n", menu.Title);

                sb.AppendFormat("<tr><td  align=left><ul class=\"sec_menu\" menuid=\"{0}\">\r\n", menu.Code);
                foreach (MenuLink link in menu.Links)
                {
                    sb.Append("<li  class=\"li_menu\"><input type=checkbox  name=\"admin_power\" class=\"checkall\"  value=\"");
                    sb.Append(link.Code + "\"");
                    if (_Id != 0)
                    {
                        if (admin_power.IndexOf("," + link.Code + ",") > -1)
                            sb.Append(" checked");
                    }
                    sb.Append("/>");
                    sb.AppendFormat(" {1} <a href=\"{0}\" target=\"fmain\"> {2} </a> </li>\r\n", link.Href, link.Code, link.Title);
                }
                sb.Append("</ul></td></tr></table><br>\r\n");
            }
            ltMasterSetting.Text = sb.ToString();
        }

        protected void btnSaveSetting_Click(object sender, EventArgs e)
        {
            string admin_power = ",";
            if (Request.Form["admin_power"] != null)
                admin_power = "," + Request.Form["admin_power"].ToString() + ",";
            using (Entities db = new Entities())
            {
                var upadmin = db.Manages.Single(p => p.MID == int.Parse(Request.QueryString["ID"].ToString()));
                upadmin.MPower = admin_power;
                db.SaveChanges();
            }
            GetMenuString();


        }
        protected string[,] leftMenu()
        {

            //doh.SqlCmd = "select id,title,pId,[Type],ItemName from [xk_Channel] where Enabled=1 and isOut=0 order by pId";
            //DataTable dt = doh.GetDataTable();
            //下面的'$'后面的'0'表示系统
            //string[,] menu = new string[3 + dt.Rows.Count, 12];

            string[,] menu = new string[3, 12];
            menu[0, 0] = "系统管理$0";
            menu[0, 1] = "<li><a href='AdminUser.aspx' id='A7'>·管理员管理</a></li>";
            menu[0, 2] = "<li><a href='AdminUserRole.aspx?id=12' id='A9'>·管理员权限</a></li>";


            menu[1, 0] = "标签管理$0";
            menu[1, 1] = "<li><a href='Tag.aspx' id='A15'>·自定义标签</a></li>";
            menu[1, 2] = "<li><a href='Templates.aspx' id='A14'>·模板管理</a></li>";


            menu[2, 0] = "内容采集$0";
            menu[2, 1] = "<a href='CollItem.aspx' target='fmain'>采集管理</a> | <a href='CollItem.aspx?action=add' target='fmain'>添加</a>";
            menu[2, 2] = "<a href='CollHistory.aspx' target='fmain'>数据处理</a>";

            return menu;
        }

        //  新闻类别
        public void grdbind()
        {
            using (Entities newlx = new Entities())
            {
                dc.Columns.Add("Classid", typeof(int));
                dc.Columns.Add("ClassName", typeof(string));
                dc.Columns.Add("lb", typeof(int));


                var m = from n in newlx.L_Classs where n.CpareID == 0 select n;
                foreach (var n in m)
                {
                    DataRow row = this.dc.NewRow();
                    row["Classid"] = int.Parse(n.CID.ToString());
                    row["lb"] = int.Parse(n.CType.ToString());
                    //if (n.CID.ToString() == m.ToList().Last().CID.ToString())
                    //{
                    //row["ClassName"] = "<img src='../images/tree_minusbottom.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString();
                    //}
                    //else
                    //{



                    row["ClassName"] = "<img src='../images/tree_minusmiddle.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + addchk(n.CID) + n.CNmae.ToString();



                    //}
                    dc.Rows.Add(row);
                    int leng = 1;
                    dpbinder(dc, int.Parse(n.CID.ToString()), leng);
                }
                this.rptList.DataSource = dc.DefaultView;
                rptList.DataBind();
            }
        }

        public void dpbinder(DataTable dp, int cID, int leng)//根据父ID查询子项
        {

            using (Entities newlx = new Entities())
            {

                int a;
                int.TryParse(cID.ToString(), out a);

                var mm = from nn in newlx.L_Classs where nn.CpareID == a select nn;
                leng++;
                foreach (var n in mm)
                {
                    string tr = addtab(leng);
                    DataRow row = this.dc.NewRow();
                    row["Classid"] = int.Parse(n.CID.ToString());
                    row["lb"] = int.Parse(n.CType.ToString());
                    if (n.CID.ToString() == mm.ToList().Last().CID.ToString())
                    {

                        row["ClassName"] = tr + "<img src='../images/tree_minusbottom.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + addchk(n.CID) + n.CNmae.ToString();
                    }
                    else
                    {
                        row["ClassName"] = tr + "<img src='../images/tree_minusmiddle.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + addchk(n.CID) + n.CNmae.ToString();

                    }

                    dp.Rows.Add(row);
                    dpbinder(dp, int.Parse(n.CID.ToString()), leng);



                }
            }
        }
        private string addtab(int i)
        {
            string aa = "";
            for (int j = 1; j < i; j++)
            {
                aa += "<img src='../images/tree_line.gif' align='absmiddle' border='0' />";
            }
            return aa;
        }

        private string addchk(long claid)
        {

            string _claid = claid.ToString();

            StringBuilder _mycn = new StringBuilder();
            _mycn.Append("<input type=checkbox  name=\"admin_Role\" class=\"checkall\" value=\"");
            _mycn.Append(_claid + "\"");
            if (_Id != 0)
            {
                if (admin_role.IndexOf("," + _claid + ",") > -1)
                    _mycn.Append(" checked");
            }
            else
            {
                _mycn.Append(" checked");
            }
            _mycn.Append("/>");
            return _mycn.ToString();

        }



    }



