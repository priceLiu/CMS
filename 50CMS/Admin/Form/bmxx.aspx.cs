using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ln2012.Models;
namespace ln2012.Admin.Form
{
    public partial class bmxx : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

          int  _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            Entities db = new Entities();
            WdBM Bm = db.WdBM.First(p => p.BID == _Id);

            TBname.Text = Bm.Bname;
             TBtel.Text=Bm.Btel;
            TBid.Text=Bm.Biden;
            TBcom.Text=Bm.Bcom;
            TBmail.Text=Bm.Bmail;
            Image1.ImageUrl = "/up/small/"+Bm.Bimg;

            TBname2.Text=Bm.Bname2;
            TBtel2.Text=Bm.Btel2;
            TBid2.Text=Bm.Biden2;
            TBcom2.Text=Bm.Bcom2;
            TBmail2.Text= Bm.Bmail2;
            Image2.ImageUrl = "/up/small/" + Bm.Bimg2;
        }
    }
}