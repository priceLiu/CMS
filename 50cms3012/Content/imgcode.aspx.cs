using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.UI;

public partial class admin_imgcode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DESEncrypt.DrawImage(4);
    }
}
