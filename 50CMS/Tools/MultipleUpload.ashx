<%@ WebHandler Language="C#"  Class="MultipleUpload" %>
using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.SessionState;
using System.IO;
using System.Text.RegularExpressions;




    /// <summary>
    /// AJAX多文件上传页
    /// </summary>
    public class MultipleUpload : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //检查是否登录后上传操作
            //if (!new ManagePage().IsAdminLogin())
            //{
            //    context.Response.Write("{msg: 0, msbox: \"请登录后再进行上传文件！\"}");
            //    return;
            //}
            HttpPostedFile _upfile = context.Request.Files["FileUpload"];
            string _delfile = context.Request.Params["txtImgUrl"];
            if (_upfile == null)
            {
                context.Response.Write("{msg: 0, msbox: \"请选择要上传文件！\"}");
                return;
            }
            UpLoad upFiles = new UpLoad();
            string remsg = upFiles.fileSaveAs(_upfile, 1);

            string pattern = @"^{\s*msg:\s*(.*)\s*,\s*msbox:\s*\""(.*)\""\s*}$"; //键名前和键值前后都允许出现空白字符
            Regex r = new Regex(pattern, RegexOptions.IgnoreCase); //正则表达式实例，不区分大小写
            Match m = r.Match(remsg); //搜索匹配项
            string msg = m.Groups[1].Value; //msg的值，正则表达式中第1个圆括号捕获的值
            string msbox = m.Groups[2].Value; //msbox的值，正则表达式中第2个圆括号捕获的值

            //如果是修改，则上传文件后同时写进数据库
            //string _pid = context.Request.Params["album_parent_id"];
            //if (!string.IsNullOrEmpty(_pid) && msg == "1")
            //{
            //    BLL.PicturesAlbum bll = new DtCms.BLL.PicturesAlbum();
            //    PicturesAlbum model = new DtCms.Model.PicturesAlbum();
            //    model.PictureId = int.Parse(_pid);
            //    model.ImgUrl = msbox;
            //    int _reid = bll.Add(model);
            //    context.Response.Write("{msg: 1, msgid: \"" + _reid + "\", msbox: \"" + msbox + "\"}");
            //    return;
            //}
            //返回成功信息
            context.Response.Write(remsg);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

