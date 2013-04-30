using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using ln2012.Models;
using System.Collections.Generic;
using System.Linq;

namespace ln2012.Admin
{
    public partial class index : AdminBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ////lblAdminName.Text = Session["AdminName"].ToString();
                    ////switch (int.Parse(Session["AdminType"].ToString()))
                    ////{
                    ////    case 1:
                    ////        lblAdminName.Text += "（超级管理员）";
                    ////        break;
                    ////    case 2:
                    ////        lblAdminName.Text += "（系统管理员）";
                    ////        break;
                    ////    case 3:
                    ////        lblAdminName.Text += "（内容管理员）";
                    ////        break;
                    ////}
                    if (Session["AdminName"] != null && Session["AdminName"].ToString() != String.Empty)
                    {
                        lblAdminName.Text = Session["AdminName"].ToString();
                    }
                  

                }
                catch
                {
                }
                GetMenuString();
            }
        }

        protected void GetMenuString()
        {

            List<LeftMenu> menus = LeftMenu.Load();
       
            int i = 1;
            string admin_power = "";
            using (Entities db = new Entities())
            {
               int _adminID = Convert.ToInt32(Session["adminID"]);
               admin_power = db.Manages.SingleOrDefault(p => p.MID == _adminID ).MPower;

            }

            foreach (LeftMenu menu in menus)
            {
                if (admin_power.IndexOf("," + menu.Code + ",") > -1)                    
                navmenu.Text += string.Format("<li onclick='tabs({0});'><a href='{1}' target='sysMain'><span><img src='{2}' /><br/>{3}</span></a></li>\r\n", i-1, menu.Href, menu.Img, menu.Title);

                Label2.Text+="<div class='left_menu'><ul>";
                foreach (MenuLink link in menu.Links)
                {
                        if (admin_power.IndexOf("," + link.Code + ",") > -1)
                        Label2.Text+=string.Format("<li><a href='{0}' target='sysMain'>{1}</a></li>\r\n", link.Href, link.Title);
                }
                Label2.Text+="</ul></div>\r\n";
                i++;
            }

        }

        protected void lbtnExit_Click(object sender, EventArgs e)
        {
            Session["AdminNo"] = null;
            Session["AdminName"] = null;
            Session["AdminType"] = null;
            Session["AdminLevel"] = null;
            Utils.WriteCookie("AdminName", "DtCms", -1440);
            Utils.WriteCookie("AdminPwd", "DtCms", -1440);
            Response.Redirect("login.aspx");
        }
    }
}
