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
using Models;
using System.Collections.Generic;
using System.Linq;


    public partial class index : AdminBase
    {
        public string mynewlist = "";
        public string admin_power = "",admin_Role="";
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
                        admin_power = ""; admin_Role = "";
                        int _Id = int.Parse(Session["AdminID"].ToString());
                        using (Entities db = new Entities())
                        {
                            admin_Role = db.Manages.SingleOrDefault(p => p.MID == _Id).MRole; //
                            admin_power = db.Manages.SingleOrDefault(p => p.MID == _Id).MPower;
                        }

                        grdbind();
                        webname.Text = sysset.WebName.ToString();
                        GetMenuString();
                    }
                  

                }
                catch
                {
                }
             
            }
        }

        protected void GetMenuString()
        {

            List<LeftMenu> menus = LeftMenu.Load();
       
            int i = 1;


            foreach (LeftMenu menu in menus)
            {
                if (admin_power.IndexOf("," + menu.Code + ",") > -1)                    
                navmenu.Text += string.Format("<li onclick='tabs({0});'><a href='{1}' target='sysMain'>{3}</a></li>\r\n", i-1, menu.Href, menu.Img, menu.Title);

              
                if (menu.Code != "100")
                {            
                    Label2.Text+="<div class='left_menu'><ul>";  
                    foreach (MenuLink link in menu.Links)
                    {
                        if (admin_power.IndexOf("," + link.Code + ",") > -1)
                            Label2.Text += string.Format("<li><a href='{0}' target='sysMain'>{1}</a></li>\r\n", link.Href, link.Title);
                    }
                  Label2.Text+="</ul></div>\r\n";
                
                }
              i++;
            }

        }

        protected void lbtnExit_Click(object sender, EventArgs e)
        {
            Session["AdminNo"] = null;
            Session["AdminName"] = null;
            Session["AdminType"] = null;
            Session["AdminLevel"] = null;
            Utils.WriteCookie("AdminName", "lncms", -1440);
            Utils.WriteCookie("AdminPwd", "lncms", -1440);
            Response.Redirect("login.aspx");
        }


    

        public void grdbind()
        {
            using (Entities newlx = new Entities())
            {
                DataTable dc = new DataTable();
                dc.Columns.Add("Classid", typeof(int));
                dc.Columns.Add("CpareID", typeof(int));
                dc.Columns.Add("ClassName", typeof(string));
                dc.Columns.Add("lb", typeof(string));
                var m = from n in newlx.L_Classs select n;
                foreach (var n in m)
                {
                    if (chkpow(n.CID))
                    {
                        DataRow row = dc.NewRow();
                        row["Classid"] = int.Parse(n.CID.ToString());
                        row["CpareID"] = int.Parse(n.CpareID.ToString());
                        row["lb"] = "栏目模型为：" + TypeName(n.CType.ToString());
                        row["ClassName"] = n.CNmae.ToString();
                        dc.Rows.Add(row);
                    }
                
                }
                
                DataView dv = new DataView(dc);
                dv.RowFilter = "CpareID=0";
                foreach (DataRowView drv in dv)
                {
                    TreeNode node = new TreeNode();
                    node.Text = drv["ClassName"].ToString();
                    node.Value = drv["Classid"].ToString();
                    node.ImageUrl = "images/tree_folder.gif";
                    node.NavigateUrl = "News/List.aspx?CID=" + drv["Classid"].ToString();
                    node.ToolTip = drv["lb"].ToString();
                    node.Target = "sysMain";
                    node.Expanded = false;
                    TreeView1.Nodes.Add(node);
                    AddReplies(dc, node);
                }


            }
           
        }


        private void AddReplies(DataTable dt, TreeNode node)
        {

            DataView dv = new DataView(dt);
            dv.RowFilter = "CpareID='" + node.Value + "'";
            foreach (DataRowView row in dv)
            {
                if (chkpow(Convert.ToInt16(row.Row["Classid"])))
                    {
                TreeNode replyNode = new TreeNode();
                replyNode.Text = row["ClassName"].ToString();
                replyNode.Value = row["Classid"].ToString();
                replyNode.NavigateUrl = "News/List.aspx?CID=" + row["Classid"].ToString();
                replyNode.Target="sysMain";
                replyNode.ToolTip = row["lb"].ToString();
                //replyNode.Expanded = false;
                node.ChildNodes.Add(replyNode);
                AddReplies(dt, replyNode);
                  }
            }
        }


        private bool chkpow(long claid)
        {
            if (sysset.NewsRule)
            { return true; }
            else
            {
                if (admin_Role.IndexOf("," + claid + ",") > -1)
                    return true;
                else
                    return false;
            }
        }
        //public void grdbind()
        //{
        //    using (Entities newlx = new Entities())
        //    {
                
        //        var m = from n in newlx.L_Classs where n.CpareID == 0 select n;
        //        foreach (var n in m)
        //        {

        //            mynewlist += string.Format("<tr><td><a href='add.aspx?id={0}'>{1}</a>\r\n", int.Parse(n.CID.ToString()), "<img src='images/tree_minusmiddle.gif' align='absmiddle' border='0' /><img src='images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString() + "</tr></td>");

        //            int leng = 1;
        //            dpbinder(int.Parse(n.CID.ToString()), leng);
        //        }
               
        //    }
        //}

        //public void dpbinder( int cID, int leng)//根据父ID查询子项
        //{

        //    using (Entities newlx = new Entities())
        //    {

        //        int a;
        //        int.TryParse(cID.ToString(), out a);

        //        var mm = from nn in newlx.L_Classs where nn.CpareID == a select nn;
        //        leng++;
        //        foreach (var n in mm)
        //        {
        //            string tr = addtab(leng);
        //            if (n.CID.ToString() == mm.ToList().Last().CID.ToString())
        //            {
        //                mynewlist += string.Format("<tr><td><a href='add.aspx?id={0}'>{1}</a>\r\n", int.Parse(n.CID.ToString()), tr + "<img src='images/tree_minusbottom.gif' align='absmiddle' border='0' /><img src='images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString() + "</tr></td>");

                
        //            }
        //            else
        //            {
        //                mynewlist += string.Format("<tr><td><a href='add.aspx?id={0}'>{1}</a>\r\n", int.Parse(n.CID.ToString()), tr + "<img src='images/tree_minusmiddle.gif' align='absmiddle' border='0' /><img src='images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString() + "</tr></td>");
                    

        //            }

        //            dpbinder(int.Parse(n.CID.ToString()), leng);

        //        }
        //    }
        //}
        //private string addtab(int i)
        //{
        //    string aa = "";
        //    for (int j = 1; j < i; j++)
        //    {
        //        aa += "<img src='images/tree_line.gif' align='absmiddle' border='0' />";
        //    }
        //    return aa;
        //}


    }

