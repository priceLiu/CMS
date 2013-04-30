using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ln2012.Models;
using System.Data;

namespace ln2012.Admin.Form
{
    public partial class BmList : AdminBase
    {

        private DataTable dc = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            grdbind();

        }

        public void grdbind()
        {
            using (Entities db = new Entities())
            {
                var Bpl = db.WdBM.OrderByDescending(p => p.BID);
                PagedDataSource pds = new PagedDataSource();
                pds.DataSource = Bpl.ToList();  //这里好像一定要Tolist();不然会有点错误；
                pds.AllowPaging = true;
                AspNetPager1.RecordCount = Bpl.Count(); //记录总数；
                pds.CurrentPageIndex = AspNetPager1.CurrentPageIndex - 1;
                pds.PageSize = AspNetPager1.PageSize;
                this.rptList.DataSource = pds;
                this.rptList.DataBind();
            }
        }

        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {   //当页面页数改变时，执行这个方法；
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            grdbind();
        }


        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(((Label)e.Item.FindControl("lb_id")).Text);


            Entities bll = new Entities();
            WdBM model = bll.WdBM.First(p => p.BID == id);

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

}
