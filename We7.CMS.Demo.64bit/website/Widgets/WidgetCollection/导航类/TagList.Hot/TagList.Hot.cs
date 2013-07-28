using System.Web.UI.WebControls;
using We7.CMS.WebControls;
using We7.CMS.WebControls.Core;

namespace We7.CMS.Web.Widgets
{
    [ControlGroupDescription(Label = "热门标签", Icon = "热门标签", Description = "热门标签", DefaultType = "TagList.Hot")]
    [ControlDescription(Desc = "热门标签")]
    public partial class TagList_Hot : ThinkmentDataControl
    {
        /// <summary>
        /// 自定义Css类名称
        /// </summary>
        [Parameter(Title = "自定义Css类名称", Type = "String", DefaultValue = "TagList_Hot")]
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
    }
}