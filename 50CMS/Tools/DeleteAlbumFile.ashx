<%@ WebHandler Language="C#" Class="DeleteAlbumFile" %>
using System;
using System.Web;
using System.Web.SessionState;
using System.IO;

    /// <summary>
    /// 删除PicturesAlbum记录及图片
    /// </summary>
    public class DeleteAlbumFile : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //检查是否登录后上传操作
            //if (!new ManagePage().IsAdminLogin())
            //{
            //    context.Response.Write("{msg: 0, msbox: \"请登录后再进行上传文件！\"}");
            //    return;
            //}
         //   int _fileid;
            string _delfile = context.Request.Params["delfile"];

            //删除数据库记录
            //if (int.TryParse(context.Request.Params["fileid"] as string, out _fileid))
            //{
            //    DtCms.BLL.PicturesAlbum bll = new DtCms.BLL.PicturesAlbum();
            //    bll.Delete(_fileid);
            //}
            //删除已存在的文件
            if (!string.IsNullOrEmpty(_delfile))
            {
                string _filename = Utils.GetMapPath(_delfile);
                if (!File.Exists(_filename))
                {
                    context.Response.Write("{msg: 0, msbox: \"要删除" + _delfile + "的文件不存在！\"}");
                    return;
                }
                File.Delete(_filename);
            }
            //返回成功信息
            context.Response.Write("{msg: 1, msbox: \"" + _delfile + "\"}");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
