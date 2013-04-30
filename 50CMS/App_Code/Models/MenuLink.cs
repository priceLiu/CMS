using System;
using System.Collections.Generic;
using System.Text;

    public class MenuLink
    {
        private string title;

        private string code;

        private string href;
      

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
    }

