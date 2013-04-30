<%@ Application Language="C#" %>
<script RunAt="server">
	//for MVC
	public static void RegisterRoutes(RouteCollection routes) {

        routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
        routes.MapRoute(
  "list", // 路由名称
  "list{ID}.aspx", // 带有参数的 URL
  new { controller = "Home", action = "list", ID = @"(\d)+\,(\d)+" } // 参数默认值
    );

        routes.MapRoute(
 "Form", // 路由名称
 "Form{ID}.aspx", // 带有参数的 URL
 new { controller = "Home", action = "Form", ID = @"(\d)+\,(\d)+" } // 参数默认值
   );
        routes.MapRoute(
"myForm", // 路由名称
"myform{ID}.aspx", // 带有参数的 URL
new { controller = "Home", action = "myForm", ID = @"(\d)+\,(\d)+" } // 参数默认值
);

        routes.MapRoute(
          "Search", // 路由名称
          "shlist.aspx", // 带有参数的 URL
          new { controller = "Home", action = "Search", ID = UrlParameter.Optional } // 参数默认值
      );


        routes.MapRoute(
          "Pages", // 路由名称
          "Pages_{ID}_{NID}.aspx", // 带有参数的 URL
          new { controller = "Home", action = "read", ID = @"(\d)+\,(\d)+", NID = @"(\d)+\,(\d)+" } // 参数默认值
      );
        routes.MapRoute(
            "Default", // 路由名称
            "{controller}/{action}/{ID}", // 带有参数的 URL
            new { controller = "Home", action = "Index", ID = UrlParameter.Optional } // 参数默认值
        );

        
        
	}

	void Application_Start(object sender, EventArgs e) {
		RegisterRoutes(RouteTable.Routes);
	}

	void Application_End(object sender, EventArgs e) {
		//在应用程序关闭时运行的代码

	}

	void Application_Error(object sender, EventArgs e) {
		//在出现未处理的错误时运行的代码

	}

	void Session_Start(object sender, EventArgs e) {
		//在新会话启动时运行的代码

	}

	void Session_End(object sender, EventArgs e) {
		//在会话结束时运行的代码。 
		// 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
		// InProc 时，才会引发 Session_End 事件。如果会话模式 
		//设置为 StateServer 或 SQLServer，则不会引发该事件。

	}
       
</script>
