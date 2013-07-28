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
    [ControlGroupDescription(Label = "搜索工具条", Icon = "搜索工具条", Description = "搜索工具条", DefaultType = "Search.SearchUI")]
    [ControlDescription("搜索文章")]
    public partial class Search_SearchUI : ThinkmentDataControl
    {
        private Channel channel;
        private List<Channel> listChildren;

        /// <summary>
        /// 栏目ID
        /// </summary>
        [Parameter(Title = "栏目", Type = "Channel", Required = true)]
        public string OwnerID = String.Empty;

        /// <summary>
        /// 上边距10像素
        /// </summary>
        [Parameter(Title = "上边距10像素", Type = "Boolean",DefaultValue="1")]
        public bool MarginTop10 = true;

        /// <summary>
        /// 搜索结果页面URL
        /// </summary>
        [Parameter(Title = "搜索结果页面URL", Type = "String", DefaultValue = "/search.aspx")]
        public string PageUrl = "/search.aspx";

        /// <summary>
        /// 栏目Request参数名称
        /// </summary>
        [Parameter(Title = "栏目Request参数名称", Type = "String", DefaultValue = "channel")]
        public string ParamChannel = "channel";

        /// <summary>
        /// 文章标题Request参数名称
        /// </summary>
        [Parameter(Title = "文章标题Request参数名称", Type = "String", DefaultValue = "title")]
        public string ParamTitle = "title";

        /// <summary>
        /// 文章内容Request参数名称
        /// </summary>
        [Parameter(Title = "文章内容Request参数名称", Type = "String", DefaultValue = "content")]
        public string ParamContent = "content";

        /// <summary>
        /// 文章作者Request参数名称
        /// </summary>
        [Parameter(Title = "文章作者Request参数名称", Type = "String", DefaultValue = "author")]
        public string ParamAuthor = "author";

        /// <summary>
        /// 文章录入者Request参数名称
        /// </summary>
        [Parameter(Title = "文章录入者Request参数名称", Type = "String", DefaultValue = "inputer")]
        public string ParamInputer = "inputer";

        /// <summary>
        /// 文章关键词Request参数名称
        /// </summary>
        [Parameter(Title = "文章关键词Request参数名称", Type = "String", DefaultValue = "tag")]
        public string ParamTag = "tag";

        /// <summary>
        /// 当前栏目信息
        /// </summary>
        protected Channel Channel
        {
            get
            {
                if (channel == null)
                {
                    ChannelHelper helper = HelperFactory.Instance.GetHelper<ChannelHelper>();
                    if (string.IsNullOrEmpty(OwnerID))
                    {
                        OwnerID = helper.GetChannelIDFromURL();
                    }
                    channel = helper.GetChannel(OwnerID, null);
                    if (channel != null)
                        listChildren = GetChildren();
                    else
                        channel = new Channel();
                }
                return channel;
            }
        }

        /// <summary>
        /// 子栏目
        /// </summary>
        protected List<Channel> ChannelChildren
        {
            get
            {
                return listChildren;
            }
        }


           /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "Search_SearchUI")]
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

        private List<Channel> GetChildren()
        {
            Criteria c = new Criteria(CriteriaType.Like, "FullUrl", Channel.FullUrl + "%");
            c.Add(CriteriaType.Equals, "State", 1);
            c.Add(CriteriaType.NotEquals, "ID", Channel.ID);
            return Assistant.List<Channel>(c, new Order[] { new Order("ID") });        
        }
    }
}