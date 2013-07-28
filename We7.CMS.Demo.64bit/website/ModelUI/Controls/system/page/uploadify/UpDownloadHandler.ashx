<%@ WebHandler Language="C#" Class="UpDownloadHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.IO;
using We7.Framework.Config;
using We7.Model.Core.Data;
using We7.Framework.Util;

public class UpDownloadHandler : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        //通过传来的参数判断执行哪个方法
        if (context.Request["GetFunction"].Equals("UploadFile", StringComparison.InvariantCultureIgnoreCase))
            UploadFile(context);
        if (context.Request["GetFunction"].Equals("ArticleImages", StringComparison.InvariantCultureIgnoreCase))
            ArticleImages(context);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    //上传文章组图
    private void ArticleImages(HttpContext context)
    {
        try
        {
            string relPath = context.Request["folder"] + "/thumbnail/";
            HttpPostedFile filePhotot = context.Request.Files["Filedata"];
            string folderPath = HttpContext.Current.Server.MapPath(relPath);
            //判断路径是否存在
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }
            string ext = Path.GetExtension(filePhotot.FileName);
            string imgName = DateTime.Now.Ticks.ToString();
            string fileName = imgName + ext;
            //上传后图片的路径
            string fn = Path.Combine(folderPath, fileName);
            
            if (GeneralConfigs.GetConfig().Upload_AllowImageType.IndexOf(ext, StringComparison.OrdinalIgnoreCase) < 0)
                throw new Exception("上传文件不合法！");
            //上传

            filePhotot.SaveAs(fn);
            //string thumbnailFilePath = Path.Combine(folderPath, imgName + "_S" + ext);

            //string imageSize = folderAndSize.Split('$')[1].Split(':');

            //for (int i = 0; i < imageSize.Length; i++)
            //{
            //    string[] izeSplit = imageSize[i].Split('*');
            //    int width = int.Parse(izeSplit[0]);
            //    int height = int.Parse(izeSplit[1]);

            //    if (File.Exists(thumbnailFilePath))
            //        File.Delete(thumbnailFilePath);

            //    ImageUtils.MakeThumbnail(fn, Path.Combine(folderPath, imgName + "_" + i + ext), width, height, "HW");
            //}
            relPath = relPath + fileName;

            context.Response.Write(relPath);
        }
        catch (Exception ex)
        {

        }
    }
    //上传文件
    private void UploadFile(HttpContext context)
    {
        string uploadFilePath = string.Format("/_data/Models/{0}/{1}/{2}/", DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
        HttpPostedFile file = context.Request.Files["Filedata"];

        UploadDocumentItem objUploadDocumentItem = new UploadDocumentItem();
        objUploadDocumentItem.DocMuid = Guid.NewGuid().ToString();//生成一个新的MUID，保证文件名称的唯一性
        objUploadDocumentItem.DocName = file.FileName;
        objUploadDocumentItem.UploadDate = DateTime.Now.ToShortDateString();

        ModelDBHelper helper = ModelDBHelper.Create(We7.We7Helper.GetParamValueFromUrl(context.Request.RawUrl, "model"));

        string uploadPath = HttpContext.Current.Server.MapPath(uploadFilePath);

        if (file != null)
        {
            //如果没有该目录则创建该上传目录
            if (!Directory.Exists(uploadPath))
            {
                Directory.CreateDirectory(uploadPath);
            }
            string extension = Path.GetExtension(file.FileName);
            if (GeneralConfigs.GetConfig().Upload_AllowImageType.IndexOf(extension, StringComparison.OrdinalIgnoreCase) < 0)
                throw new Exception("上传文件不合法！");

            string filepath = uploadPath + objUploadDocumentItem.DocMuid + extension;
            file.SaveAs(filepath);
            ImageUtils.MakeThumbnail(filepath, uploadPath + objUploadDocumentItem.DocMuid + "_thumb" + extension, 100, 100, "Cut");
            context.Response.Write(uploadFilePath + objUploadDocumentItem.DocMuid + extension);
            //context.Response.Write(new JavaScriptSerializer().Serialize(objUploadDocumentItem));
        }
    }

}
public class UploadDocumentItem
{
    public UploadDocumentItem()
    { }
    private string docMuid;
    private string docName;
    private string uploadDate;
    public string DocMuid { get { return docMuid; } set { docMuid = value; } }
    public string DocName { get { return docName; } set { docName = value; } }
    public string UploadDate { get { return uploadDate; } set { uploadDate = value; } }
}