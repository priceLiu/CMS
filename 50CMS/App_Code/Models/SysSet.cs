using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Caching;



    public class SysSet
    {
        
        private string _webname = "";
        private string _weburl = "";
        private string _webtel = "";
        private string _webemail = "";
        private string _webcrod = "";
        private string _webkeywords = "";
        private string _webdescription = "";

        private string _webpath = "/";
        private string _webfilepath = "upload";

        private string _webfiletype = "GIF|JPG|PNG|BMP|RAR|DOC|XLS|TXT|SWF";
        private int _webfilesize = 9024;
        private int _iswatermark = 0;
        private int _watermarkstatus = 0;
        private int _imgquality = 0;
        private string _imgwaterpath = "";
        private int _imgwatertransparency =0;
        private string _watertext = "";
        private string _waterfont = "";
        private int _fontsize = 0;

        private bool _weblog;
        private bool _newsrule;

        /// <summary>
        ///  网站名称
        /// </summary>
        public string WebName
        {
            set { _webname = value; }
            get { return _webname; }
        }

        /// <summary>
        ///  网站地址
        /// </summary>
        public string WebUrl
        {
            set { _weburl = value; }
            get { return _weburl; }
        }

        /// <summary>
        ///  联系电话
        /// </summary>
        public string WebTel
        {
            set { _webtel = value; }
            get { return _webtel; }
        }

   

        /// <summary>
        ///  联系邮箱
        /// </summary>
        public string WebEmail
        {
            set { _webemail = value; }
            get { return _webemail; }
        }

        /// <summary>
        ///  ICP备案
        /// </summary>
        public string WebCrod
        {
            set { _webcrod = value; }
            get { return _webcrod; }
        }

        /// <summary>
        /// 网站关健字
        /// </summary>
        public string WebKeywords
        {
            set { _webkeywords = value; }
            get { return _webkeywords; }
        }

        /// <summary>
        ///  网站描述
        /// </summary>
        public string WebDescription
        {
            set { _webdescription = value; }
            get { return _webdescription; }
        }


        /// <summary>
        ///  网站路径
        /// </summary>
        public string WebPath
        {
            set { _webpath = value; }
            get { return _webpath; }
        }


        /// <summary>
        ///  上传文件路径
        /// </summary>
        public string WebFilePath
        {
            set { _webfilepath = value; }
            get { return _webfilepath; }
        }

   
        /// <summary>
        ///  图片限制类型
        /// </summary>
        public string WebFileType
        {
            set { _webfiletype = value; }
            get { return _webfiletype; }
        }
        /// <summary>
        ///  图片限制大小
        /// </summary>
        public int WebFileSize
        {
            set { _webfilesize = value; }
            get { return _webfilesize; }
        }
        /// <summary>
        ///  图片水印
        /// </summary>
        public int IsWatermark
        {
            set { _iswatermark = value; }
            get { return _iswatermark; }
        }
        /// <summary>
        ///  图片水印状态
        /// </summary>
        public int WatermarkStatus
        {
            set { _watermarkstatus = value; }
            get { return _watermarkstatus; }
        }
        /// <summary>
        ///  图片质量
        /// </summary>
        public int ImgQuality
        {
            set { _imgquality = value; }
            get { return _imgquality; }
        }
        /// <summary>
        ///  图片水印图片路径
        /// </summary>
        public string ImgWaterPath
        {
            set { _imgwaterpath = value; }
            get { return _imgwaterpath; }
        }
        /// <summary>
        ///  图片水印图片透明度
        /// </summary>
        public int ImgWaterTransparency
        {
            set { _imgwatertransparency = value; }
            get { return _imgwatertransparency; }
        }
        /// <summary>
        ///  图片水印文字
        /// </summary>
        public string WaterText
        {
            set { _watertext = value; }
            get { return _watertext; }
        }

            /// <summary>
        ///  图片水印文字字体
        /// </summary>
        public string WaterFont
        {
            set { _waterfont = value; }
            get { return _waterfont; }
        }
        


        /// <summary>
        ///  图片水印文字大小
        /// </summary>
        public int FontSize
        {
            set { _fontsize = value; }
            get { return _fontsize; }
        }

        /// <summary>
        ///  网站日志
        /// </summary>
        public bool WebLog
        {
            set { _weblog = value; }
            get { return _weblog; }
        }

          /// <summary>
        ///  新闻栏目权限
        /// </summary>
        public bool NewsRule
        {
            set { _newsrule = value; }
            get { return _newsrule; }
        }

        


        private static object lockHelper = new object();

        public SysSet loadConfig(string configFilePath)
        {
           return (SysSet)TextHandle.xmlLoad(typeof(SysSet), configFilePath);
        }

        public SysSet loadCacheConfig(string configFilePath)
        {
          

            SysSet Cache_SysSet = HttpContext.Current.Cache["Cache_SysSet"] as SysSet;
            if (Cache_SysSet == null)
            {
                //创建缓存依赖项
                CacheDependency dependency = new CacheDependency(configFilePath);
                //创建缓存
                HttpContext.Current.Cache.Add("Cache_SysSet", loadConfig(configFilePath), dependency, Cache.NoAbsoluteExpiration, new TimeSpan(0, 30, 0), CacheItemPriority.Default, null);
                Cache_SysSet = HttpContext.Current.Cache["Cache_Webset"] as SysSet;
            }

            return Cache_SysSet;

        }

        public SysSet saveConifg(SysSet mode, string configFilePath)
        {
            lock (lockHelper)
            {
                TextHandle.xmlSave(mode, configFilePath);
            }
            return mode;
        }

    }

