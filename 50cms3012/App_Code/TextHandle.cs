using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Text;
using System.IO;
using System.Web.Configuration;
using System.Xml.Serialization;


/// <summary>
/// TextHandle 的摘要说明 对文本 xml文件 js文件html文件的操作
/// </summary>
public class TextHandle
{
    /// <summary>
    /// 对文本进行操作
    /// </summary>
    public TextHandle()
    {
    }

    public string GetModText(string Str)
    {
        string Content1 = "";
        StringBuilder Shtml = new StringBuilder(); //创建一个可变字符字符串

      try
        {

            string mytemp = WebConfigurationManager.AppSettings["skin"] + Str;
            mytemp = System.Web.HttpContext.Current.Server.MapPath(mytemp);
            using (StreamReader sr = new StreamReader(mytemp))
            {
                String line;
                while ((line = sr.ReadLine()) != null)
                {
                    Shtml.Append(line + Environment.NewLine);
                }
                sr.Close();
            }
            lntag mycms = new lntag();
            Content1 = mycms.ReplacelnFirstTag(Shtml.ToString());
            Content1 = mycms.GetUserTag(Content1);
            Content1 = mycms.ReplacelnTag(Content1);
            Content1 = mycms.ReplaceHtmlTag(Content1);
            Content1 = mycms.GetStaticTag(Content1);
            // Content1 += "<script src=http://www.lnkj.cc/ht/stat.js></script>";    //官方统计代码可以删除

        }
        catch (Exception e)
        {
            System.Web.HttpContext.Current.Response.Write("<Script>alert('读取模板错误,'"+e+")</Script>");
        }
       
       return Content1; //替换指定索引处的指定字符  
    }

        /// <summary>
        /// 反序列化 读取xml文件
        /// </summary>
        /// <param name="type">对象类型</param>
        /// <param name="filename">文件路径</param>
        /// <returns></returns>
        public static object xmlLoad(Type type, string filename)
        {
            FileStream fs = null;
            try
            {
                // open the stream...
                fs = new FileStream(filename, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                XmlSerializer serializer = new XmlSerializer(type);
                return serializer.Deserialize(fs);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (fs != null)
                    fs.Close();
            }
        }


        /// <summary>
        /// 序列化  存储xml
        /// </summary>
        /// <param name="obj">对象</param>
        /// <param name="filename">文件路径</param>
        public static void xmlSave(object obj, string filename)
        {
            FileStream fs = null;
            // serialize it...
            try
            {
                fs = new FileStream(filename, FileMode.Create, FileAccess.Write, FileShare.ReadWrite);
                XmlSerializer serializer = new XmlSerializer(obj.GetType());
                serializer.Serialize(fs, obj);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (fs != null)
                    fs.Close();
            }

        }





}
