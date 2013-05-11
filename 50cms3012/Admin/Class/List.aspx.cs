using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models;
using System.Data;


    public partial class List : AdminBase
    {

        private DataTable dc = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            grdbind();

        }

        public void grdbind()
        {
            using (Entities newlx = new Entities())
            {
                dc.Columns.Add("Classid", typeof(int));
                dc.Columns.Add("CpareID", typeof(int));
                dc.Columns.Add("ClassName", typeof(string));
                dc.Columns.Add("lb", typeof(string));
                var m = from n in newlx.L_Classs where n.CpareID == 0 select n;
                foreach (var n in m)
                {
                    DataRow row = this.dc.NewRow();
                    row["Classid"] = int.Parse(n.CID.ToString());
                    row["CpareID"] = int.Parse(n.CpareID.ToString());
                    row["lb"] = TypeName(n.CType.ToString());
                    //if (n.CID.ToString() == m.ToList().Last().CID.ToString())
                    //{
                    //row["ClassName"] = "<img src='../images/tree_minusbottom.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString();
                    //}
                    //else
                    //{
                    row["ClassName"] = "<img src='../images/tree_minusmiddle.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString();

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
                    row["lb"] = TypeName(n.CType.ToString());
                    if (n.CID.ToString() == mm.ToList().Last().CID.ToString())
                    {

                        row["ClassName"] = tr + "<img src='../images/tree_minusbottom.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString();
                    }
                    else
                    {
                        row["ClassName"] = tr + "<img src='../images/tree_minusmiddle.gif' align='absmiddle' border='0' /><img src='../images/tree_folder.gif' align='absmiddle' border='0' />" + n.CNmae.ToString();

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




        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(((Label)e.Item.FindControl("lb_id")).Text);


            Entities bll = new Entities();
            L_Classs model = bll.L_Classs.First(p => p.CID == id);

            switch (e.CommandName.ToLower())
            {

                case "del":
                    bll.DeleteObject(model);

                    break;

            }

            bll.SaveChanges();
            grdbind();

        }
    }


