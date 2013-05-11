<%@ WebHandler Language="C#" Class="wordUpload" %>
using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.SessionState;
using System.IO;


    /// <summary>
    /// AJAX单文件上传页
    /// </summary>
    public class wordUpload : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //检查是否登录后上传操作
            if (!new AdminBase().IsAdminLogin())
            {
                context.Response.Write("{msg: 0, msbox: \"请登录后再进行上传文件！\"}");
                return;
            }

            string _refilepath = context.Request.QueryString["ReFilePath"]; //取得返回的对象名称
            string _upfilepath = context.Request.QueryString["UpFilePath"]; //取得上传的对象名称
     
            HttpPostedFile _upfile = context.Request.Files[_upfilepath];
            string _delfile = context.Request.Params[_refilepath];
            
            if (_upfile == null)
            {
                context.Response.Write("{msg: 0, msbox: \"请选择要上传文件！\"}");
                return;
            }
            UpLoad upFiles = new UpLoad();
            string msg = upFiles.fileSaveAs(_upfile, 1);
        
            //返回成功信息
            context.Response.Write(msg);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

