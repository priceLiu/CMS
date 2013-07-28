﻿using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using We7.CMS.Common;
using We7.CMS.WebControls;
using We7.CMS.WebControls.Core;
using We7.Framework;

namespace We7.CMS.Web.Widgets
{
    [ControlGroupDescription(Label = "两级菜单", Icon = "两级菜单", Description = "两级菜单", DefaultType = "ChannelMenu.TopMenu")]
    [ControlDescription(Desc = "网站顶部菜单显示两级")]
    public partial class ChannelMenu_CurrLocation : ThinkmentDataControl
    {
        private List<Channel> firstLevelChannels, secondLevelChannels, topChannels;
        private Channel currentChannel;

        private ChannelHelper ChannelHelper
        {
            get { return HelperFactory.GetHelper<ChannelHelper>(); }
        }

        protected Channel CurrentChannel
        {
            get
            {
                if (currentChannel == null)
                {
                    string cid = ChannelHelper.GetChannelIDFromURL();
                    currentChannel = ChannelHelper.GetChannel(cid, new string[]
                                                                       {
                                                                           "ID", "Title", "ChannelFullUrl",
                                                                           "Created",
                                                                           "SN"
                                                                       }) ?? new Channel();
                }
                return currentChannel;
            }
        }

        protected bool IsSelected(Channel ch)
        {
            return ch == null && String.IsNullOrEmpty(CurrentChannel.FullUrl) ||
                ch != null && !String.IsNullOrEmpty(CurrentChannel.FullUrl) && CurrentChannel.FullUrl.StartsWith(ch.FullUrl);
        }

        public List<Channel> FirstLevelChannels
        {
            get
            {
                if (firstLevelChannels == null)
                {
                    firstLevelChannels = ChannelHelper.GetChannels(We7Helper.EmptyGUID, true) ?? new List<Channel>();
                }
                return firstLevelChannels;
            }
        }

        public List<Channel> SecondLevelChannels
        {
            get
            {
                if (secondLevelChannels == null)
                {
                    foreach (Channel ch in FirstLevelChannels)
                    {
                        if (IsSelected(ch))
                        {
                            secondLevelChannels = ChannelHelper.GetChannels(ch.ID);
                            break;
                        }
                    }
                    secondLevelChannels = secondLevelChannels ?? new List<Channel>();
                }
                return secondLevelChannels;
            }
        }

        [Parameter(Title = "标签", Type = "String", DefaultValue = "")]
        public string Tag;
        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "ChannelMenu_CurrLocation")]
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
	    
        [Parameter(Title = "自定义图标样式", Type = "CustomImage", DefaultValue = "")]
        public string Icon;

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
	
        /// <summary>
        /// 浮动两级菜单用
        /// </summary>
        public List<Channel> TopChannels
        {
            get
            {
                if (topChannels == null)
                {
                    List<Channel> list = ChannelHelper.GetChannels(We7Helper.EmptyGUID, true) ?? new List<Channel>();
                    foreach (Channel c in list)
                    {
                        if (!string.IsNullOrEmpty(Tag) && c.Tags.Contains(Tag))
                        {
                            if (topChannels == null)
                                topChannels = new List<Channel>();
                            topChannels.Add(c);
                        }
                        else
                        {
                            if (topChannels == null)
                                topChannels = new List<Channel>();
                            if(string.IsNullOrEmpty(Tag))
                                topChannels.Add(c);
                        }
                    }
                    for (int i = 0; i < topChannels.Count; i++)
                    {
                        topChannels[i].SubChannels = ChannelHelper.GetChannels(topChannels[i].ID) ?? new List<Channel>();
                        if (topChannels[i].SubChannels.Count > 0)
                            topChannels[i].HaveSon = true;
                    }
                }
                return topChannels;
            }
        }
    }
}