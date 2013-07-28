﻿using System;
using System.ComponentModel;
using System.Web.UI.WebControls;
using We7.CMS.WebControls;
using We7.CMS.WebControls.Core;

namespace We7.CMS.Web.Widgets
{
    [ControlGroupDescription(Label = "网页尾部", Icon = "网页尾部", Description = "网页尾部", DefaultType = "Footer.Default")]
    [ControlDescription(Desc = "尾部", Author = "系统")]
    public partial class Footer_Default : BaseControl
    {
        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "Footer_Default")]
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
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}