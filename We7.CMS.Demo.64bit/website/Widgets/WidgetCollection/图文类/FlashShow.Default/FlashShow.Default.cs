using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;
using Thinkment.Data;
using We7.CMS.Common;
using We7.CMS.WebControls;
using We7.CMS.WebControls.Core;
using We7.Framework;

namespace We7.CMS.Web.Widgets
{
    /// <summary>
    /// 文章列表数据提供者
    /// </summary>
    [ControlGroupDescription(Label = "翻转图片", Icon = "翻转图片", Description = "翻转图片", DefaultType = "ArticleView.Default")]
    [ControlDescription(Name = "翻转图片", Desc = "翻转图片")]
    public partial class FlashShow_Default : ThinkmentDataControl
    {

        private List<Article> articles;
        private Channel channel;
        protected StringBuilder sbThumb = new StringBuilder();
        protected StringBuilder sbUrl = new StringBuilder();
        protected StringBuilder sbTitle = new StringBuilder();

        [Parameter(Title = "缩略图标签", Type = "KeyValueSelector",Data="thumbnail",DefaultValue = "flash")]
        public string ThumbnailTag = "flash";

        [Parameter(Title = "查询标签", Type = "String", DefaultValue = "")]
        public string Tag;

        [Parameter(Title = "宽度", Type = "Number", DefaultValue = "290")]
        public int FrameWidth=290;

        [Parameter(Title = "高度", Type = "Number", DefaultValue = "160")]
        public int FrameHeight=160;

        [Parameter(Title = "栏目", Type = "Channel", Required = true)]
        public string OwnerID = String.Empty;

        [Parameter(Title = "控件每页记录", Type = "Number", DefaultValue = "4")]
        public int PageSize = 10;

        [Parameter(Title = "包含子栏目", Type = "Boolean", DefaultValue = "1")]
        public bool IncludeChildren;

        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "FlashShow_Default")]
        public string CssClass;

        /// <summary>
        /// 自定义的css样式
        /// </summary>
        protected virtual string Css
        {
            get
            {
                return CssClass;
            }
        }


        protected void BuildAttributeString()
        {
            foreach (Article article in Articles)
            {
                sbTitle.AppendFormat("{0}|", article.Title);
                sbUrl.AppendFormat("{0}|", article.Url);
                sbThumb.AppendFormat("{0}|", article.GetTagThumbnail(ThumbnailTag));
            }
            if (sbTitle.Length > 0)
            {
                sbTitle.Remove(sbTitle.Length - 1, 1);
                sbUrl.Remove(sbUrl.Length - 1, 1);
                sbThumb.Remove(sbThumb.Length - 1, 1);
            }
        }

        protected override void OnInitData()
        {
            BuildAttributeString();
        }

        /// <summary>
        /// 文章列表
        /// </summary>
        protected List<Article> Articles
        {
            get
            {
                if (articles == null)
                {
                    Criteria c = new Criteria(CriteriaType.None);

                    c.Add(CriteriaType.Equals, "ModelName", "System.Article");
                    
                    if (!String.IsNullOrEmpty(OwnerID))
                    {
                        if (IncludeChildren)
                        {
                            c.Add(CriteriaType.Like, "ChannelFullUrl", Channel.FullUrl + "%");
                        }
                        else
                        {
                            c.Add(CriteriaType.Equals, "OwnerID", OwnerID);
                        }
                    }
                    c.Add(CriteriaType.Equals, "State", 1);
                    c.Add(CriteriaType.Equals, "IsImage", 1);

                    if (!String.IsNullOrEmpty(Tag))
                    {
                        c.Add(CriteriaType.Like, "Tags", "%" + Tag + "%");
                    }

                    Order[] os = new Order[] { new Order("Updated", OrderMode.Desc) };
                    articles = Assistant.List<Article>(c, os, 0, PageSize, new string[]
                                                                               {
                                                                                   "ID", "Title", "ChannelFullUrl",
                                                                                   "Created",
                                                                                   "SN", "Thumbnail"
                                                                               });

                }
                return articles;
            }
            set { articles = value; }
        }

        /// <summary>
        /// 当前栏目信息
        /// </summary>
        protected Channel Channel
        {
            get
            {
                if (channel == null)
                {
                    ChannelHelper helper = HelperFactory.GetHelper<ChannelHelper>();
                    channel = helper.GetChannel(OwnerID, new string[]
                                                             {
                                                                 "ID", "Title", "ChannelFullUrl",
                                                                 "Created",
                                                                 "SN"
                                                             }) ?? new Channel();
                }
                return channel;
            }
        }
    }
}