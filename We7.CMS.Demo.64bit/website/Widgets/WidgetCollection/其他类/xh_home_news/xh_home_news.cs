using System;
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
    [ControlGroupDescription(Label = "无分页文章列表", Icon = "无分页文章列表", Description = "无分页文章列表", DefaultType = "xh_home_news")]
    [ControlDescription(Name = "西湖首页之西湖要闻", Desc = "西湖首页之西湖要闻")]
    public partial class xh_home_news : ThinkmentDataControl
    {
        private List<Article> articles;
        private Channel channel;
        private Article picArticle;




        #region 栏目
        /// <summary>
        /// 栏目ID1
        /// </summary>
        [Parameter(Title = "栏目1", Type = "Channel", Required = true, Weight = 30)]
        public string OwnerID = String.Empty;

        /// <summary>
        /// 栏目ID2
        /// </summary>
        [Parameter(Title = "栏目2", Type = "Channel", Required = true, Weight = 29)]
        public string OwnerID2 = String.Empty;

        /// <summary>
        /// 栏目ID3
        /// </summary>
        [Parameter(Title = "栏目3", Type = "Channel", Required = true, Weight = 28)]
        public string OwnerID3 = String.Empty;

        /// <summary>
        /// 栏目ID4
        /// </summary>
        [Parameter(Title = "栏目4", Type = "Channel", Required = false, Weight = 27)]
        public string OwnerID4 = String.Empty;

        /// <summary>
        /// 栏目ID5
        /// </summary>
        [Parameter(Title = "栏目5", Type = "Channel", Required = false, Weight = 26)]
        public string OwnerID5 = String.Empty;

        /// <summary>
        /// 栏目ID6
        /// </summary>
        [Parameter(Title = "栏目6", Type = "Channel", Required = false, Weight = 25)]
        public string OwnerID6 = String.Empty;

        /// <summary>
        /// 栏目ID7
        /// </summary>
        [Parameter(Title = "栏目7", Type = "Channel", Required = false, Weight = 24)]
        public string OwnerID7 = String.Empty;

        /// <summary>
        /// 栏目ID8
        /// </summary>
        [Parameter(Title = "栏目8", Type = "Channel", Required = false, Weight = 23)]
        public string OwnerID8 = String.Empty;

        /// <summary>
        /// 栏目ID9
        /// </summary>
        [Parameter(Title = "栏目9", Type = "Channel", Required = false, Weight = 22)]
        public string OwnerID9 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目10", Type = "Channel", Required = false, Weight = 21)]
        public string OwnerID10 = String.Empty;

        #endregion


        #region 栏目
        /// <summary>
        /// 栏目ID1
        /// </summary>
        [Parameter(Title = "栏目11", Type = "Channel", Required = true, Weight = 20)]
        public string OwnerID11 = String.Empty;

        /// <summary>
        /// 栏目ID2
        /// </summary>
        [Parameter(Title = "栏目12", Type = "Channel", Required = true, Weight = 19)]
        public string OwnerID12 = String.Empty;

        /// <summary>
        /// 栏目ID3
        /// </summary>
        [Parameter(Title = "栏目13", Type = "Channel", Required = true, Weight = 18)]
        public string OwnerID13 = String.Empty;

        /// <summary>
        /// 栏目ID4
        /// </summary>
        [Parameter(Title = "栏目14", Type = "Channel", Required = false, Weight = 17)]
        public string OwnerID14 = String.Empty;

        /// <summary>
        /// 栏目ID15
        /// </summary>
        [Parameter(Title = "栏目15", Type = "Channel", Required = false, Weight = 16)]
        public string OwnerID15 = String.Empty;

        /// <summary>
        /// 栏目ID16
        /// </summary>
        [Parameter(Title = "栏目16", Type = "Channel", Required = false, Weight = 15)]
        public string OwnerID16 = String.Empty;

        /// <summary>
        /// 栏目ID17
        /// </summary>
        [Parameter(Title = "栏目17", Type = "Channel", Required = false, Weight = 14)]
        public string OwnerID17 = String.Empty;

        /// <summary>
        /// 栏目ID18
        /// </summary>
        [Parameter(Title = "栏目18", Type = "Channel", Required = false, Weight = 13)]
        public string OwnerID18 = String.Empty;

        /// <summary>
        /// 栏目ID19
        /// </summary>
        [Parameter(Title = "栏目19", Type = "Channel", Required = false, Weight = 12)]
        public string OwnerID19 = String.Empty;

        /// <summary>
        /// 栏目ID19
        /// </summary>
        [Parameter(Title = "栏目20", Type = "Channel", Required = false, Weight = 11)]
        public string OwnerID20 = String.Empty;

        #endregion



        #region 栏目
        /// <summary>
        /// 栏目ID1
        /// </summary>
        [Parameter(Title = "栏目21", Type = "Channel", Required = true, Weight = 10)]
        public string OwnerID21 = String.Empty;

        /// <summary>
        /// 栏目ID2
        /// </summary>
        [Parameter(Title = "栏目22", Type = "Channel", Required = true, Weight = 9)]
        public string OwnerID22 = String.Empty;

        /// <summary>
        /// 栏目ID3
        /// </summary>
        [Parameter(Title = "栏目23", Type = "Channel", Required = true, Weight = 8)]
        public string OwnerID23 = String.Empty;

        /// <summary>
        /// 栏目ID4
        /// </summary>
        [Parameter(Title = "栏目24", Type = "Channel", Required = false, Weight = 7)]
        public string OwnerID24 = String.Empty;

        /// <summary>
        /// 栏目ID5
        /// </summary>
        [Parameter(Title = "栏目25", Type = "Channel", Required = false, Weight = 6)]
        public string OwnerID25 = String.Empty;

        /// <summary>
        /// 栏目ID6
        /// </summary>
        [Parameter(Title = "栏目26", Type = "Channel", Required = false, Weight = 5)]
        public string OwnerID26 = String.Empty;

        /// <summary>
        /// 栏目ID7
        /// </summary>
        [Parameter(Title = "栏目27", Type = "Channel", Required = false, Weight = 4)]
        public string OwnerID27 = String.Empty;

        /// <summary>
        /// 栏目ID8
        /// </summary>
        [Parameter(Title = "栏目28", Type = "Channel", Required = false, Weight = 3)]
        public string OwnerID28 = String.Empty;

        /// <summary>
        /// 栏目ID9
        /// </summary>
        [Parameter(Title = "栏目29", Type = "Channel", Required = false, Weight = 2)]
        public string OwnerID29 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目30", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID30 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目31", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID31 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目32", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID32 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目33", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID33 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目34", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID34 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目35", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID35 = String.Empty;

        /// <summary>
        /// 栏目ID10
        /// </summary>
        [Parameter(Title = "栏目36", Type = "Channel", Required = false, Weight = 1)]
        public string OwnerID36 = String.Empty;
        #endregion


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
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "xh_home_news")]
        public string CssClass;

        /// <summary>
        /// 自定义图标样式
        /// </summary>
        [Parameter(Title = "自定义图标样式", Type = "CustomImage", DefaultValue = "")]
        public string Icon;

        /// <summary>
        /// Tags标签
        /// </summary>
        [Parameter(Title = "Tags标签", Type = "Tags", DefaultValue = "")]
        public string Tags;

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
            get
            {
                return BorderColor;
            }
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

                    Criteria ownerIdsConditions = new Criteria(CriteriaType.None);
                    ownerIdsConditions.Mode = CriteriaMode.Or;

                    string[] ownerIds = new string[] { OwnerID, OwnerID2, OwnerID3, OwnerID4, OwnerID5, OwnerID6, OwnerID7, OwnerID8, OwnerID9, OwnerID10, OwnerID11, OwnerID12, OwnerID13, OwnerID14, OwnerID15, OwnerID16, OwnerID17, OwnerID18, OwnerID19, OwnerID20, OwnerID21, OwnerID22, OwnerID23, OwnerID24, OwnerID25, OwnerID26, OwnerID27, OwnerID28, OwnerID29, OwnerID30, OwnerID31, OwnerID32, OwnerID33, OwnerID34, OwnerID35, OwnerID36};
                    foreach (string item in ownerIds)
                    {
                        if (!string.IsNullOrEmpty(item))
                        {
                            ownerIdsConditions.AddOr(CriteriaType.Equals, "OwnerID", item);
                        }
                    }
                    c.Criterias.Add(ownerIdsConditions);

                    c.Add(CriteriaType.Equals, "State", 1);
                    if (!String.IsNullOrEmpty(Tags))
                    {
                        c.Add(CriteriaType.Like, "Tags", "%'" + Tags + "'%");
                    }

                    Order[] os = new Order[] { new Order("Index", OrderMode.Desc), new Order("Updated", OrderMode.Desc) };
                    articles = Assistant.List<Article>(c, os, 0, PageSize, new string[]
                                                                           {
                                                                            "ID", "Title", "ChannelFullUrl", "Created", "SN"
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
