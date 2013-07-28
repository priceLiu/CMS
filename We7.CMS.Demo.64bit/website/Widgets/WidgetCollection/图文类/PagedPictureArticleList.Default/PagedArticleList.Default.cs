﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Thinkment.Data;
using We7.CMS.Common;
using We7.CMS.WebControls;
using We7.CMS.WebControls.Core;
using We7.Framework;
using We7.Framework.Util;

namespace We7.CMS.Web.Widgets
{
    /// <summary>
    /// 文章分页控件列表
    /// </summary>
    [ControlGroupDescription(Label = "分页图片列表", Icon = "分页图片列表", Description = "分页图片列表", DefaultType = "Pager.ArticleList")]
    [ControlDescription(Desc = "图片分页控件列表")]
    public partial class PagedArticleListDefault : ThinkmentDataControl
    {
        private List<Article> articles;
        private Channel channel;
        private Criteria criteria;

        /// <summary>
        /// 分页器
        /// </summary>
        [Children]
        public ControlPager Pager = new ControlPager();

        /// <summary>
        /// 栏目ID
        /// </summary>
        [Parameter(Title = "栏目", Type = "Channel", Required = true)]
        public string OwnerID = String.Empty;

        /// <summary>
        /// 标题长度
        /// </summary>
        [Parameter(Title = "标题长度", Type = "Number", DefaultValue = "30")]
        public int TitleLength = 30;

        /// <summary>
        /// 日期格式
        /// </summary>
        [Parameter(Title = "日期格式", Type = "String", DefaultValue = "[MM-dd]")]
        public string DateFormat = "[MM-dd]";

        /// <summary>
        /// 是否包含子栏目
        /// </summary>
        [Parameter(Title = "包含子栏目", Type = "Boolean", DefaultValue = "true")]
        public bool IncludeChildren;

        /// <summary>
        /// 上边距10像素
        /// </summary>
        [Parameter(Title = "上边距10像素", Type = "Boolean", DefaultValue = "true")]
        public bool MarginTop10;
        /// <summary>
        /// 缩略图标签
        /// </summary>
        [Parameter(Title = "缩略图标签", Type = "KeyValueSelector", Data = "thumbnail", DefaultValue = "flash")]
        public string ThumbnailTag = "flash";
        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "PagedArticleList_Default")]
        public string CssClass;

        /// <summary>
        /// 是否按置顶排序
        /// </summary>
        [Parameter(Title = "是否显示置顶", Type = "Boolean", DefaultValue = "0", Required = true)]
        public bool IsShow;

        /// <summary>
        /// Tags标签
        /// </summary>
        [Parameter(Title = "Tags标签", Type = "Tags", DefaultValue = "")]
        public string Tags;

        /// <summary>
        /// 只显示图片
        /// </summary>
        [Parameter(Title = "只显示图片", Type = "Boolean", DefaultValue = "true")]
        public bool ImageOnly;

        /// <summary>
        /// 自定义图标样式
        /// </summary>
        [Parameter(Title = "自定义图标样式", Type = "CustomImage", DefaultValue = "")]
        public string Icon;

        /// <summary>
        /// 自定义边框样式
        /// </summary>
        [Parameter(Title = "自定义边框样式", Type = "ColorSelector", DefaultValue = "")]
        public string BorderColor;

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

        /// <summary>
        /// 通过Url获取查询关键字
        /// </summary>
        public string KeyWord
        {
            get
            {
                if (Request["keywords"] == null || Request["keywords"].ToString().Trim().Length < 1)
                    return null;

                return We7Helper.RemoveHtml(System.Web.HttpUtility.UrlDecode(Request["keywords"].ToString()));
            }
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
                    if (string.IsNullOrEmpty(OwnerID))
                    {
                        OwnerID = helper.GetChannelIDFromURL();
                    }
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

        /// <summary>
        /// 文章列表
        /// </summary>
        protected List<Article> Articles
        {
            get
            {
                int pageIndex = Pager.PageIndex, startIndex, pageItemsCount;
                Utils.BuidlPagerParam(Pager.RecordCount, Pager.PageSize, ref pageIndex, out startIndex,
                                      out pageItemsCount);
                Order[] os = IsShow
                                 ? new Order[]
                                       {
                                           new Order("IsShow", OrderMode.Desc), new Order("Updated", OrderMode.Desc),
                                           new Order("ID", OrderMode.Desc)
                                       }
                                 : new Order[] {new Order("Updated", OrderMode.Desc), new Order("ID", OrderMode.Desc)};
                articles = Assistant.List<Article>(criteria, os, startIndex, pageItemsCount, new string[]
                                                                                                 {
                                                                                                     "ID", "Title",
                                                                                                     "ChannelFullUrl",
                                                                                                     "Created",
                                                                                                     "SN", "Thumbnail","Updated"
                                                                                                 });
                if (ImageOnly)
                {
                    List<Article> tmp = new List<Article>();
                    foreach (Article it in articles)
                    {
                        if (!string.IsNullOrEmpty(it.GetTagThumbnail(ThumbnailTag)))
                        {
                            tmp.Add(it);
                        }
                    }
                    articles = tmp;
                }
                return articles;
            }
        }

        /// <summary>
        /// 自定义图标
        /// </summary>
        protected virtual string CustomIcon
        {
            get
            {
                return Icon;
            }
        }
        protected string BackgroundIcon()
        {
            if (!string.IsNullOrEmpty(CustomIcon))
            {
                return string.Format("style=\"background:url({0}) no-repeat;\"", CustomIcon);
            }
            return string.Empty;
        }
      

        protected virtual string BoxBorderColor
        {
            get
            {
                return BorderColor;
            }
        }
        protected string SetBoxBorderColor()
        {
            if (!string.IsNullOrEmpty(BoxBorderColor))
            {
                return string.Format("style=\"border-color:{0};\"", BoxBorderColor);
            }
            return string.Empty;
        }
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitCriteria();
                //计算出总记录数
                Pager.RecordCount = Assistant.Count<Article>(criteria);
            }
        }

        private void InitCriteria()
        {
            criteria = new Criteria(CriteriaType.None);
            if (string.IsNullOrEmpty(KeyWord))
            {
                if (IncludeChildren && Channel != null)
                {
                    criteria.Add(CriteriaType.Like, "ChannelFullUrl", Channel.FullUrl + "%");
                }
                else
                {
                    criteria.Add(CriteriaType.Equals, "OwnerID", Channel.ID);
                }
            }
            string tag = We7Helper.RemoveHtml(System.Web.HttpUtility.UrlDecode(Request["tag"]));
            if (!String.IsNullOrEmpty(tag))
            {
                criteria.Add(CriteriaType.Like, "Tags", "%" + HttpUtility.UrlDecode(tag) + "%");
            }

            string title = We7Helper.RemoveHtml(System.Web.HttpUtility.UrlDecode(Request["title"]));
            if (!String.IsNullOrEmpty(title))
            {
                criteria.Add(CriteriaType.Like, "Title", "%" + title + "%");
            }

            string channel = We7Helper.RemoveHtml(System.Web.HttpUtility.UrlDecode(Request["channel"]));
            if (!String.IsNullOrEmpty(channel))
            {
                Channel ch = HelperFactory.Instance.GetHelper<ChannelHelper>().GetChannel(channel, null);
                if (ch != null)
                {
                    criteria.Add(CriteriaType.Like, "ChannelFullUrl", ch.FullUrl + "%");
                }
            }

            string author = We7Helper.RemoveHtml(System.Web.HttpUtility.UrlDecode(Request["author"]));
            if (!String.IsNullOrEmpty(author))
            {
                criteria.Add(CriteriaType.Equals, "Author", author);
            }

            if (!string.IsNullOrEmpty(KeyWord))
            {
                Criteria keyCriteria = new Criteria(CriteriaType.None);
                keyCriteria.Mode = CriteriaMode.Or;
                keyCriteria.AddOr(CriteriaType.Like, "Title", "%" + KeyWord + "%");
                keyCriteria.AddOr(CriteriaType.Like, "Description", "%" + KeyWord + "%");
                criteria.Criterias.Add(keyCriteria);
            }

            criteria.Add(CriteriaType.Equals, "State", 1);
        }


    }
}