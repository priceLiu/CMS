<%@ WebHandler Language="C#" Class="Upload" %>


/**
 * KindEditor ASP.NET
 *
 * 本ASP.NET程序是演示程序，建议不要直接在实际项目中使用。
 * 如果您确定直接使用本程序，使用之前请仔细确认相关安全设置。
 * 一些事情修改过
 */

using System;
using System.Collections;
using System.Web;
using System.IO;
using System.Globalization;
using System.Text.RegularExpressions;
using LitJson;

    public class Upload : IHttpHandler
    {

        
        public void ProcessRequest(HttpContext context)
        {
            //检查是否登录后上传操作
            if (!new AdminBase().IsAdminLogin())
            {
                context.Response.Write("{msg: 0, msbox: \"请登录后再进行上传文件！\"}");
                return;
            }
            
            HttpPostedFile imgFile = context.Request.Files["imgFile"];
            if (imgFile == null)
            {
                showError("请选择要上传文件！", context);
                return;
            }
            UpLoad upFiles = new UpLoad();
            string remsg = upFiles.fileSaveAs(imgFile, 1);

            string pattern = @"^{\s*\""msg\"":\s*(.*)\s*,\s*\""msbox\"":\s*\""(.*)\""\s*}$"; //键名前和键值前后都允许出现空白字符
            Regex r = new Regex(pattern, RegexOptions.IgnoreCase); //正则表达式实例，不区分大小写
            Match m = r.Match(remsg); //搜索匹配项
            string msg = m.Groups[1].Value; //msg的值，正则表达式中第1个圆括号捕获的值
            string msbox = m.Groups[2].Value; //msbox的值，正则表达式中第2个圆括号捕获的值 
            if (msg == "0")
            {
                showError(msbox, context);
            }
            String fileUrl = msbox;

            Hashtable hash = new Hashtable();
            hash["error"] = 0;
            hash["url"] = fileUrl;
            context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            context.Response.Write(JsonMapper.ToJson(hash));
            context.Response.End();
        }

        private void showError(string message, HttpContext context)
        {
            Hashtable hash = new Hashtable();
            hash["error"] = 1;
            hash["message"] = message;
            context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            context.Response.Write(JsonMapper.ToJson(hash));
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return true;
            }
        }
    }
