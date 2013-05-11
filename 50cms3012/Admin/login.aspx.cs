using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models;


    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void loginsubmit_Click(object sender, ImageClickEventArgs e)
        {
            string UserName = txtUserName.Text.Trim();
            string UserPwd = txtUserPwd.Text.Trim();
            if (UserName.Equals("") || UserPwd.Equals("") || TextCode.Equals(""))
            {
                lbMsg.Text = "请输入您要登录用户名,密码,以及验证码";
            }
            else
            {
                if (Session["CheckCode"] == null || Session["CheckCode"].ToString() == String.Empty)
                {
                    lbMsg.Text = "验证码过期，请刷新!";
                    return;
                }

                if (TextCode.Text.ToString().Trim() != Session["CheckCode"].ToString())
                {
                    lbMsg.Text = "用户登入失败，验证码不正确!";
                    new AdminBase().SaveLogs(UserName, "[用户登录]状态：登入失败，验证码不正确！");

                }
                else
                { 
                
          

                if (Session["AdminLoginSun"] == null)
                {
                    Session["AdminLoginSun"] = 1;
                }
                else
                {
                    Session["AdminLoginSun"] = Convert.ToInt32(Session["AdminLoginSun"]) + 1;
                }
                //判断登录
                if (Session["AdminLoginSun"] != null && Convert.ToInt32(Session["AdminLoginSun"]) > 3)
                {
                    lbMsg.Text = "登录错误超过3次，请关闭浏览器重新登录。";
                }

                else if (new AdminBase().bllchkAdminLogin(UserName, DESEncrypt.Encrypt(UserPwd)))
                {
                   
                    //保存日志
                   new AdminBase().SaveLogs(UserName, "[用户登录]状态：登录成功！");

                    Response.Redirect("index.aspx");
                }
                else
                {
                    lbMsg.Text = "您输入的用户名或密码不正确";
                    //保存日志
                    new AdminBase().SaveLogs(UserName, "[用户登录] 状态：登录失败！");
                
                }

                }
            }
        }
    }
