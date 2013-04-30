using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Web;

   /// <summary>
    /// 功能菜单
    /// </summary>
    public class LeftMenu
    {
        private string title;

        private string code;
        private string href;
        private string img;

        private List<MenuLink> links = new List<MenuLink>();

        public string Title
        {
            set { title = value; }
            get { return title; }
        }

        public string Code
        {
            set { code = value; }
            get { return code; }
        }

        public string Href
        {
            set { href = value; }
            get { return href; }
        }
        public string Img
        {
            set { img = value; }
            get { return img; }
        }
        public List<MenuLink> Links
        {
            set { links = value; }
            get { return links; }
        }

        public static List<LeftMenu> Load()
        {
            XmlDocument xml = new XmlDocument();
            xml.Load(HttpContext.Current.Request.PhysicalApplicationPath + "/Content/Menu.config");
            List<LeftMenu> menus = new List<LeftMenu>();
            XmlNodeList menuNodes = xml.SelectNodes("Menus/Menu");
            foreach (XmlNode menuNode in menuNodes)
            {
                LeftMenu menu = new LeftMenu();
                menu.Code = menuNode.Attributes["code"].Value;
                menu.Title = menuNode.Attributes["title"].Value;
                menu.Href = menuNode.Attributes["href"].Value;
                menu.Img = menuNode.Attributes["img"].Value;

                foreach (XmlNode linkNode in menuNode.ChildNodes)
                {
                    MenuLink link = new MenuLink();
                    link.Code = linkNode.Attributes["code"].Value;
                    link.Title = linkNode.Attributes["title"].Value;
                    link.Href = linkNode.Attributes["href"].Value;
                    menu.Links.Add(link);
                }
                menus.Add(menu);
            }
            return menus;
        }
    }
