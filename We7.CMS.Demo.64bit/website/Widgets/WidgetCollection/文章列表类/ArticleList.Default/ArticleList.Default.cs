using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Thinkment.Data;
using We7.CMS.Common;
using We7.CMS.WebControls;
using We7.CMS.WebControls.Core;
using We7.Framework;
using We7.Framework.Orders;

namespace We7.CMS.Web.Widgets {
    /// <summary>
    /// 文章列表数据提供者
    /// </summary>
    [ControlGroupDescription(Label = "无分页文章列表", Icon = "无分页文章列表", Description = "无分页文章列表",
        DefaultType = "ArticleList.Default")]
    [ControlDescription(Name = "无分页文章列表控件", Desc = "无分页文章列表控件")]
    public partial class ArticleList_Default : ThinkmentDataControl {
        private List<Article> articles;
        private Channel channel;
        private Article picArticle;

        /// <summary>
        /// 栏目ID
        /// </summary>
        [Parameter(Title = "栏目", Type = "Channel", Required = true)] public string OwnerID = String.Empty;

        /// <summary>
        /// 显示记录条数
        /// </summary>
        [Parameter(Title = "控件每页记录", Type = "Number", DefaultValue = "10")] public int PageSize = 10;

        /// <summary>
        /// 标题长度
        /// </summary>
        [Parameter(Title = "标题长度", Type = "Number", DefaultValue = "30")] public int TitleLength = 30;

        /// <summary>
        /// 日期格式
        /// </summary>
        [Parameter(Title = "日期格式", Type = "String", DefaultValue = "[MM-dd]")] public string DateFormat = "[MM-dd]";

        /// <summary>
        /// 是否包含子栏目
        /// </summary>
        [Parameter(Title = "包含子栏目", Type = "Boolean", DefaultValue = "1")] public bool IncludeChildren;

        /// <summary>
        /// 上边距10像素
        /// </summary>
        [Parameter(Title = "上边距10像素", Type = "Boolean", DefaultValue = "1")] public bool MarginTop10;

        /// <summary>
        /// 下边距10像素
        /// </summary>
        [Parameter(Title = "左边距10像素", Type = "Boolean", DefaultValue = "1")] public bool MarginLeft10;

        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "ArticleList_Default")] public string CssClass;

        /// <summary>
        /// 自定义图标样式
        /// </summary>
        [Parameter(Title = "自定义图标样式", Type = "CustomImage", DefaultValue = "")] public string Icon;

        /// <summary>
        /// Tags标签
        /// </summary>
        [Parameter(Title = "Tags标签", Type = "Tags", DefaultValue = "")] public string Tags;

        /// <summary>
        /// 自定义边框样式
        /// </summary>
        [Parameter(Title = "自定义边框样式", Type = "ColorSelector", DefaultValue = "")] public string BorderColor;

        [DefaultFieldValue] [Parameter(Title = "排序信息", Type = "OrderSelector", Required = true)] public string OrderInfo
            = getDefaultOrder();

        private string _criteriaInfo;

        [DefaultFieldValue]
        [Parameter(Name = "ArticleCriteria", Title = "查询配置选项", Type = "SearchFactory", Required = true)]
        public string CriteriaInfo
        {
            get
            {
                if (string.IsNullOrEmpty(_criteriaInfo))
                {
                    _criteriaInfo =
                        WidgetFiledAssist<CriteriaDescription>.CreateJson(
                            CriteriaDescription.Create(new CriteriaJsonObject[] {}, "Article", "文章"));
                }
                return _criteriaInfo;
            }
            set { _criteriaInfo = value; }
        }

        /// <summary>
        /// 获取
        /// </summary>
        /// <returns></returns>
        private static string getDefaultOrder()
        {
            Order isShow = new Order("IsShow", OrderMode.Desc);
            isShow.AliasName = "是否置顶";
            Order updated = new Order("Updated", OrderMode.Desc);
            updated.AliasName = "更新时间";
            Order[] os = new Order[] {isShow, updated};
            return WidgetFiledAssist<OrderDescription>.CreateJson(OrderDescription.Create(os, "Article", "文章"));
        }

        /// <summary>
        /// 自定义图标
        /// </summary>
        protected virtual string CustomIcon
        {
            get { return Icon; }
        }

        /// <summary>
        /// 背景图标
        /// </summary>
        /// <returns></returns>
        protected string BackgroundIcon()
        {
            if (!string.IsNullOrEmpty(CustomIcon))
            {
                return string.Format("style=\"background:url({0}) no-repeat;\"", CustomIcon);
            }
            return string.Empty;
        }

        /// <summary>
        /// 边框颜色
        /// </summary>
        protected virtual string BoxBorderColor
        {
            get { return BorderColor; }
        }

        /// <summary>
        /// 设置边框颜色
        /// </summary>
        /// <returns></returns>
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

                    if (!string.IsNullOrEmpty(CriteriaInfo))
                    {
                        Criteria child = WidgetFiledAssist<CriteriaDescription>.DeJson(CriteriaInfo).Criteria(this);
                        if (child.Criterias.Count > 0)
                        {
                            c.Criterias.AddRange(child.Criterias);
                        }
                    }

                    articles = Assistant.List<Article>(c,
                                                       WidgetFiledAssist<OrderDescription>.DeJson(OrderInfo).Orders,
                                                       0, PageSize, new string[]
                                                                        {
                                                                            "ID", "Title", "ChannelFullUrl", "Created",
                                                                            "SN", "ContentType", "ContentUrl"
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
                                                                 "ID", "Title", "ChannelFullUrl", "Created", "SN"
                                                             }) ?? new Channel();
                }
                return channel;
            }
        }

        /// <summary>
        /// 自定义的css样式
        /// </summary>
        protected virtual string Css
        {
            get { return CssClass; }
        }

        /// <summary>
        /// 附加的Css样式
        /// </summary>
        protected string MarginCss
        {
            get { return (MarginTop10 ? " mtop10" : "") + (MarginLeft10 ? " mleft10" : ""); }
        }

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