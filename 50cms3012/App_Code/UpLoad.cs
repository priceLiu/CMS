using System;
using System.Web;
using System.IO;
using System.Drawing;
using System.Net;
using System.Configuration;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;


    public class UpLoad
    {

        private SysSet sysset;
        private string filePath; //上传目录名
        private readonly string fileType; //文件类型
        private readonly int fileSize; //文件大小0为不限制
        private readonly int isWatermark; //0为不加水印，1为文字水印，2为图片水印
        private readonly int waterStatus; //水印位置
        private readonly int waterQuality; //水印图片质量
        private readonly string imgWaterPath; //水印图片地址
        private readonly int waterTransparency; //水印图片透时度
        private readonly string textWater; //水印文字
        private readonly string textWaterFont; //文字水印字体
        private readonly int textFontSize; //文字大小

        public static string SaveCutPic(string pPath, string pSavedPath, int pPartStartPointX, int pPartStartPointY, int pPartWidth, int pPartHeight, int pOrigStartPointX, int pOrigStartPointY, int imageWidth, int imageHeight)
        {
            using (Image originalImg = Image.FromFile(pPath))
            {
                if (originalImg.Width == imageWidth && originalImg.Height == imageHeight)
                {
                    return SaveCutPic(pPath, pSavedPath, pPartStartPointX, pPartStartPointY, pPartWidth, pPartHeight,
                            pOrigStartPointX, pOrigStartPointY);

                }
                string filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg";
                string filePath = pSavedPath + "\\" + filename;

                Bitmap thumimg = MakeThumbnail(originalImg, imageWidth, imageHeight);

                Bitmap partImg = new Bitmap(pPartWidth, pPartHeight);

                Graphics graphics = Graphics.FromImage(partImg);
                Rectangle destRect = new Rectangle(new Point(pPartStartPointX, pPartStartPointY), new Size(pPartWidth, pPartHeight));//目标位置
                Rectangle origRect = new Rectangle(new Point(pOrigStartPointX, pOrigStartPointY), new Size(pPartWidth, pPartHeight));//原图位置（默认从原图中截取的图片大小等于目标图片的大小）

                ///文字水印  
                Graphics G = Graphics.FromImage(partImg);
                //Font f = new Font("Lucida Grande", 6);
                //Brush b = new SolidBrush(Color.Gray);
                G.Clear(Color.White);
                // 指定高质量的双三次插值法。执行预筛选以确保高质量的收缩。此模式可产生质量最高的转换图像。 
                G.InterpolationMode = InterpolationMode.HighQualityBicubic;
                // 指定高质量、低速度呈现。 
                G.SmoothingMode = SmoothingMode.HighQuality;

                graphics.DrawImage(thumimg, destRect, origRect, GraphicsUnit.Pixel);
                //G.DrawString("Xuanye", f, b, 0, 0);
                G.Dispose();

                originalImg.Dispose();
                if (File.Exists(filePath))
                {
                    File.SetAttributes(filePath, FileAttributes.Normal);
                    File.Delete(filePath);
                }
                partImg.Save(filePath, ImageFormat.Jpeg);

                partImg.Dispose();
                thumimg.Dispose();
                return filename;
            }
        }

        public static Bitmap MakeThumbnail(Image fromImg, int width, int height)
        {
            Bitmap bmp = new Bitmap(width, height);
            int ow = fromImg.Width;
            int oh = fromImg.Height;

            //新建一个画板
            Graphics g = Graphics.FromImage(bmp);

            //设置高质量插值法
            g.InterpolationMode = InterpolationMode.High;
            //设置高质量,低速度呈现平滑程度
            g.SmoothingMode = SmoothingMode.HighQuality;
            //清空画布并以透明背景色填充
            g.Clear(Color.Transparent);

            g.DrawImage(fromImg, new Rectangle(0, 0, width, height),
                new Rectangle(0, 0, ow, oh),
                GraphicsUnit.Pixel);

            return bmp;

        }

        public static string SaveCutPic(string pPath, string pSavedPath, int pPartStartPointX, int pPartStartPointY, int pPartWidth, int pPartHeight, int pOrigStartPointX, int pOrigStartPointY)
        {
            string filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg";
            string filePath = pSavedPath + "\\" + filename;

            using (Image originalImg = Image.FromFile(pPath))
            {
                Bitmap partImg = new Bitmap(pPartWidth, pPartHeight);
                Graphics graphics = Graphics.FromImage(partImg);
                Rectangle destRect = new Rectangle(new Point(pPartStartPointX, pPartStartPointY), new Size(pPartWidth, pPartHeight));//目标位置
                Rectangle origRect = new Rectangle(new Point(pOrigStartPointX, pOrigStartPointY), new Size(pPartWidth, pPartHeight));//原图位置（默认从原图中截取的图片大小等于目标图片的大小）

                ///注释 文字水印  
                Graphics G = Graphics.FromImage(partImg);
                //Font f = new Font("Lucida Grande", 6);
                //Brush b = new SolidBrush(Color.Gray);
                G.Clear(Color.White);
                // 指定高质量的双三次插值法。执行预筛选以确保高质量的收缩。此模式可产生质量最高的转换图像。 
                G.InterpolationMode = InterpolationMode.HighQualityBicubic;
                // 指定高质量、低速度呈现。 
                G.SmoothingMode = SmoothingMode.HighQuality;

                graphics.DrawImage(originalImg, destRect, origRect, GraphicsUnit.Pixel);
                //G.DrawString("Xuanye", f, b, 0, 0);
                G.Dispose();

                originalImg.Dispose();
                if (File.Exists(filePath))
                {
                    File.SetAttributes(filePath, FileAttributes.Normal);
                    File.Delete(filePath);
                }
                partImg.Save(filePath, ImageFormat.Jpeg);
                partImg.Dispose();
            }
            return filename;
        }




        public UpLoad()
        {
            sysset = new SysSet().loadCacheConfig(Utils.GetMapPath("~/App_Data/WebSet.config"));

            filePath = sysset.WebPath + sysset.WebFilePath;
            fileType = sysset.WebFileType;
            fileSize = sysset.WebFileSize;
            isWatermark = sysset.IsWatermark;
            waterStatus = sysset.WatermarkStatus;
            waterQuality = sysset.ImgQuality;
            imgWaterPath = sysset.WebPath + sysset.ImgWaterPath;
            waterTransparency = sysset.ImgWaterTransparency;
            textWater = sysset.WaterText;
            textWaterFont = sysset.WaterFont;
            textFontSize = sysset.FontSize;
        }

        ///<summary>
        /// 文件上传方法
        /// </summary>
        public string fileSaveAs(HttpPostedFile _postedFile, int _isWater)
        {
            try
            {
                string _fileExt = _postedFile.FileName.Substring(_postedFile.FileName.LastIndexOf(".") + 1);
                //验证合法的文件
                if (!CheckFileExt(this.fileType, _fileExt))
                {
                    return "{\"msg\": 1, \"msbox\": \"不允许上传" + _fileExt + "类型的文件！\"}";
                }
                if (this.fileSize > 0 && _postedFile.ContentLength > fileSize * 1024)
                {
                    return "{\"msg\": 1, \"msbox\": \"文件超过限制的大小啦！\"}";
                }
                string _fileName = DateTime.Now.ToString("yyyyMMddHHmmssff") + "." + _fileExt; //随机文件名
                //检查保存的路径 是否有/开头结尾
                if (this.filePath.StartsWith("/") == false) this.filePath = "/" + this.filePath;
                if (this.filePath.EndsWith("/") == false) this.filePath = this.filePath + "/";
                //按日期归类保存
                string _datePath = DateTime.Now.ToString("yyyyMMdd") + "/";
                this.filePath += _datePath;
                //获得要保存的文件路径
                string serverFileName = this.filePath + _fileName;
                //物理完整路径                    
                string toFileFullPath = HttpContext.Current.Server.MapPath(this.filePath);
                //检查是否有该路径没有就创建
                if (!Directory.Exists(toFileFullPath))
                {
                    Directory.CreateDirectory(toFileFullPath);
                }
                //将要保存的完整文件名                
                string toFile = toFileFullPath + _fileName;
                //保存文件
                _postedFile.SaveAs(toFile);

                //是否打图片水印
                if (isWatermark > 0 && _isWater == 1 && CheckFileExt("BMP|JPEG|JPG|GIF|PNG|TIFF", _fileExt))
                {
                    switch (isWatermark)
                    {
                        case 1:
                            ImageWaterMark.AddImageSignText(serverFileName, this.filePath + _fileName, this.textWater, waterStatus, waterQuality, textWaterFont, textFontSize);
                            break;
                        case 2:
                            ImageWaterMark.AddImageSignPic(serverFileName, this.filePath + _fileName, this.imgWaterPath, waterStatus, waterQuality, waterTransparency);
                            break;
                    }
                }
                return "{\"msg\": 1, \"msbox\": \"" + serverFileName + "\"}";
            }
            catch
            {
                return "{\"msg\": 1, \"msbox\": \"上传过程中发生意外错误！\"}";
            }
        }

        /// <summary>
        /// 检查是否为合法的上传文件
        /// </summary>
        /// <returns></returns>
        private bool CheckFileExt(string _fileType, string _fileExt)
        {
            string[] allowExt = _fileType.Split('|');
            for (int i = 0; i < allowExt.Length; i++)
            {
                if (allowExt[i].ToLower() == _fileExt.ToLower()) { return true; }
            }
            return false;
        }


    }
