using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ln2012.Models;

public partial class admin_imgcode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DESEncrypt.DrawImage(4);
    }
}
