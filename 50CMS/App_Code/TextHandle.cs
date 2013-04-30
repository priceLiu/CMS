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
using ln2012.Models;

/// <summary>
/// TextHandle 的摘要说明
/// </summary>
public class TextHandle
{
    /// <summary>
    /// 对文本进行操作
    /// </summary>
    public TextHandle()
    {
    }
    #region 过滤字符串
    /// <summary>
    /// 过滤SQL字符串
    /// </summary>
    /// <param name="Str">要过滤的字符串</param>
    /// <returns></returns>
    public string GetPastText(string Str)
    {
        char[] Temp = Str.ToCharArray();
        Str = null;
        foreach (char i in Temp)
            if (i.ToString() != ";" && i.ToString() != " ")
                Str += i.ToString();
        Temp = Str.ToCharArray();
        Str = null;
        for (int i = 0; i < Temp.Length; i++)
        {
            if (i != Temp.Length - 1)
            {
                if ((Temp[i].ToString() == "-" && Temp[i + 1].ToString() != "-") || Temp[i].ToString() != "-")
                    Str += Temp[i].ToString();
            }
            else
                Str += Temp[i].ToString();
        }
        return Str;
    }
    /// <summary>
    /// 过滤SQL字符串
    /// </summary>
    /// <param name="Str">要过滤的字符串</param>
    /// <param name="Str">要过滤的字符</param>
    /// <param name="Str">要替换为的字符</param>
    /// <returns></returns>
    public string GetPastText(string Str, string Originality, string Swap)
    {
        Str = Str.Trim();
        char[] Temp = Str.ToCharArray();
        Str = null;
        foreach (char i in Temp)
            if (i.ToString() != Originality)
                Str += i.ToString();
            else
                Str += Swap;
        return Str;
    }
    #endregion
    #region 文本加密
    /// <summary>
    /// 文本加密
    /// </summary>
    /// <param name="Str">要加密的文本（128位）</param>
    /// <returns></returns>
    public string AddThickness(string Str)
    {
        Str = FormsAuthentication.HashPasswordForStoringInConfigFile(Str, "md5");
        Str = FormsAuthentication.HashPasswordForStoringInConfigFile(Str, "sha1");
        Str += FormsAuthentication.HashPasswordForStoringInConfigFile(Str.Substring(12, 6).ToLower(), "md5");
        Str += FormsAuthentication.HashPasswordForStoringInConfigFile(Str.Substring(8, 20), "sha1");
        Str += FormsAuthentication.HashPasswordForStoringInConfigFile(Str.Substring(5, 16), "md5");
        Str += FormsAuthentication.HashPasswordForStoringInConfigFile(Str.Substring(8, 16).ToUpper(), "sha1");
        Str = Str.Substring(0, 16) + Str.Substring(18, 16) + Str.Substring(25, 16) + Str.Substring(50, 16) + Str.Substring(67, 16) +
            Str.Substring(90, 16) + Str.Substring(100, 16) + Str.Substring(117, 16);
        return Str;
    }
    #endregion
    #region 替换文本
    /// <summary>
    /// 替换文本
    /// </summary>
    /// <param name="HandleText">要操作的字符串</param>
    /// <param name="OriginalityText">原始字符串</param>
    /// <param name="NewText">要替换为的字符串</param>
    /// <returns></returns>
    public string DisplaceText(string HandleText, string OriginalityText, string NewText)
    {
        string ReturnText = "";
        while (true)
        {
            if (HandleText.IndexOf(OriginalityText) != -1)
            {
                ReturnText += HandleText.Substring(0, HandleText.IndexOf(OriginalityText)) + NewText;
                HandleText = HandleText.Substring(HandleText.IndexOf(OriginalityText) + OriginalityText.Length, HandleText.Length -
                    HandleText.IndexOf(OriginalityText) - OriginalityText.Length);
            }
            else
                break;
        }
        ReturnText += HandleText;
        return ReturnText;
    }
    #endregion
    #region 转换UBB代码
    /// <summary>
    /// 转换UBB代码
    /// </summary>
    /// <param name="Text">要转换的代码</param>
    /// <returns></returns>
    public string UBB(string Text)
    {
        Text = DisplaceText(Text, "[img]", "<img src='");
        Text = DisplaceText(Text, "[/img]", "' />");
        Text = DisplaceText(Text, "[url", "<a href");
        Text = DisplaceText(Text, "[/url]", "</a>");
        Text = DisplaceText(Text, "[upload", "<a href");
        Text = DisplaceText(Text, "[/upload]", "</a>");
        Text = DisplaceText(Text, "[color", "<font color");
        Text = DisplaceText(Text, "[/color]", "</font>");
        Text = DisplaceText(Text, "[b]", "<b>");
        Text = DisplaceText(Text, "[/b]", "</b>");
        Text = DisplaceText(Text, "[size", "<font size");
        Text = DisplaceText(Text, "[/size]", "</font>");
        Text = DisplaceText(Text, "[rm]", "<OBJECT classid='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' class='OBJECT'" +
            " id='RAOCX' width='400' height='360'>" +
            " <PARAM NAME=SRC VALUE=");
        Text = DisplaceText(Text, "[/rm]", "><PARAM NAME='CONSOLE' VALUE='Clip1'> " +
            " <PARAM NAME='CONTROLS' VALUE='imagewindow'><PARAM NAME=AUTOSTART VALUE='true'></OBJECT>");
        Text = DisplaceText(Text, "[wma]", "<embed name='MediaPlayer1' pluginspage='http://www.microsoft.com/Windows/MediaPlayer'" +
            "src=");
        Text = DisplaceText(Text, "[/wma]",
            " width='400' height='360' hidden='false' type='application/x-mplayer2' showcontrols='1' autostart='1'></embed>");
        Text = DisplaceText(Text, "[wmv]", "<embed name='MediaPlayer1' pluginspage='http://www.microsoft.com/Windows/MediaPlayer'" +
         "src=");
        Text = DisplaceText(Text, "[/wmv]",
            " width='400' height='360' hidden='false' type='application/x-mplayer2' showcontrols='1' autostart='1'></embed>");
        Text = DisplaceText(Text, "[mp3]", "<embed name='MediaPlayer1' pluginspage='http://www.microsoft.com/Windows/MediaPlayer'" +
         "src=");
        Text = DisplaceText(Text, "[/mp3]",
            " width='400' height='360' hidden='false' type='application/x-mplayer2' showcontrols='1' autostart='1'></embed>");
        Text = DisplaceText(Text, "]", ">");
        return Text;
    }
    #endregion

    public string GetModText(string Str)
    {
        string Content1 = "";
        StringBuilder Shtml = new StringBuilder(); //创建一个可变字符字符串

      //  y.accDAL.help h = new y.accDAL.help();


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
        catch
        {
            System.Web.HttpContext.Current.Response.Write("<Script>alert('读取模板错误')</Script>");
        }
       
       return Content1; //替换指定索引处的指定字符  
    }




        /// <summary>
        /// 反序列化
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
        /// 序列化
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
