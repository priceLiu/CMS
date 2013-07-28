﻿using System;
using System.Collections.Generic;
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
    [ControlGroupDescription(Label = "无分页文章列表", Icon = "无分页文章列表", Description = "无分页文章列表", DefaultType = "ArticleList.Default")]
    [ControlDescription(Name = "无分页文章列表控件", Desc = "无分页文章列表控件")]
    public partial class ArticleList_2ColumnWidthImage : ThinkmentDataControl
    {
        private List<Article> articles;
        private Channel channel;
        private Article picArticle;

        /// <summary>
        /// 栏目ID
        /// </summary>
        [Parameter(Title = "栏目", Type = "Channel", Required = true)]
        public string OwnerID = String.Empty;

        /// <summary>
        /// 显示记录条数
        /// </summary>
        [Parameter(Title = "控件每页记录", Type = "Number", DefaultValue = "10")]
        public int PageSize = 10;

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
        [Parameter(Title = "包含子栏目", Type = "Boolean", DefaultValue = "1")]
        public bool IncludeChildren;

        /// <summary>
        /// 上边距10像素
        /// </summary>
        [Parameter(Title = "上边距10像素", Type = "Boolean", DefaultValue = "1")]
        public bool MarginTop10;

        /// <summary>
        /// 下边距10像素
        /// </summary>
        [Parameter(Title = "左边距10像素", Type = "Boolean", DefaultValue = "1")]
        public bool MarginLeft10;

        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "ArticleList_2ColumnWidthImage")]
        public string CssClass;

        /// <summary>
        /// 缩略图标签
        /// </summary>
        [Parameter(Title = "缩略图标签", Type = "KeyValueSelector", Data = "thumbnail", DefaultValue = "flash")]
        public string ThumbnailTag = "flash";

        /// <summary>
        /// 文章描述长度
        /// </summary>
        [Parameter(Title = "文章描述长度", Type = "Number", DefaultValue = "30")]
        public int DescriptionLength = 30;

        /// <summary>
        /// 自定义图标样式
        /// </summary>
        [Parameter(Title = "自定义图标样式", Type = "CustomImage", DefaultValue = "")]
        public string Icon;

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
        /// 图片描述信息长度
        /// </summary>
        [Parameter(Title = "图片描述信息长度", Description = "图片描述信息长度", Type = "Number", DefaultValue = "20")]
        public int PicDescLength;

        /// <summary>
        /// 自定义边框样式
        /// </summary>
        [Parameter(Title = "自定义边框样式", Type = "ColorSelector", DefaultValue = "")]
        public string BorderColor;

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
        /// 文章列表
        /// </summary>
        protected List<Article> Articles
        {
            get
            {
                if (articles == null)
                {
                    Criteria c = new Criteria(CriteriaType.None);
                    if (IncludeChildren)
                    {
                        c.Add(CriteriaType.Like, "ChannelFullUrl", Channel.FullUrl + "%");
                    }
                    else
                    {
                        c.Add(CriteriaType.Equals, "OwnerID", OwnerID);
                    }
                    c.Add(CriteriaType.Equals, "State", 1);
                    if (!String.IsNullOrEmpty(Tags))
                    {
                        c.Add(CriteriaType.Like, "Tags", "%'" + Tags + "'%");
                    }

                    Order[] os = IsShow ? new Order[] { new Order("IsShow", OrderMode.Desc), new Order("Updated", OrderMode.Desc) } : new Order[] { new Order("Updated", OrderMode.Desc) };
                    articles = Assistant.List<Article>(c, os, 0, PageSize,
                                                       new string[] { "ID", "Title", "ChannelFullUrl", "Created", "SN", "Updated" });

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
                                                             "ID", "Title", "ChannelFullUrl", "Created", "SN"
                                                         }) ?? new Channel();
                }
                return channel;
            }
        }

        /// <summary>
        /// 图片新闻
        /// </summary>
        protected Article PicArticle
        {
            get
            {
                if (picArticle == null)
                {
                    Criteria c = new Criteria(CriteriaType.None);
                    if (IncludeChildren)
                    {
                        c.Add(CriteriaType.Like, "ChannelFullUrl", Channel.FullUrl + "%");
                    }
                    else
                    {
                        c.Add(CriteriaType.Equals, "OwnerID", OwnerID);
                    }

                    c.Add(CriteriaType.Equals, "State", 1);
                    c.Add(CriteriaType.Equals, "IsImage", 1);
                    Order[] os = new Order[] { new Order("Updated", OrderMode.Desc) };
                    List<Article> list = Assistant.List<Article>(c, os, 0, 1, new string[]
                                                                                  {
                                                                                      "ID", "Title", "ChannelFullUrl",
                                                                                      "Created", "SN", "Thumbnail","Description"
                                                                                  });
                    if (list != null && list.Count > 0)
                    {
                        picArticle = list[0];
                    }
                }
                return picArticle;
            }
            set { picArticle = value; }
        }

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
        /// 附加的Css样式
        /// </summary>
        protected string MarginCss
        {
            get { return (MarginTop10 ? " mtop10" : "") + (MarginLeft10 ? " mleft10" : ""); }
        }

        /// <summary>
        /// 设计时
        /// </summary>
        protected override void OnDesigning()
        {
            Articles = GetExampleData();
        }

        /// <summary>
        /// 得到例子数据
        /// </summary>
        /// <returns></returns>
        private List<Article> GetExampleData()
        {
            List<Article> lsResult = new List<Article>();
            for (int i = 0; i < PageSize; i++)
            {
                Article temp = new Article();
                temp.ID = We7Helper.CreateNewID();
                temp.Title = "测试新闻" + (i + 1);
                lsResult.Add(temp);
            }
            return lsResult;
        }
    }
}