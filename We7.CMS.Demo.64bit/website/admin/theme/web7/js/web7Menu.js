; jQuery.web7Menu = {
    menuContainer: "#topCustomMenu",
    Name: "顶部菜单",
    createMenu: function (options) {
        var defaultVal = {
            Text: '顶部菜单',
            Data: adminMenu.getMenuData(),
            activeClass: "activeMenu",
            normalClass: "normalMenu",
            subActiveClass: "subActiveMenu",
            subNormalClass: "subnormalMenu",
            menuContainer: "#topCustomMenu"
        };
        var boolean = { result: true };
        $.extend(defaultVal, options);

        var Render = function (menuData, container, valOption) {
            var ul = $("<ul>");

            if (container.attr("class") == valOption.activeClass) {
                ul.attr("class", valOption.subActiveClass).attr("id", container.attr("rel"));
            }
            if (container.attr("class") == valOption.normalClass) {
                ul.attr("class", valOption.subNormalClass).attr("id", container.attr("rel"));
            }

            if (boolean.result) ul.attr("class", "mainMenu");

            ul.css("width", menuWidth(menuData, ul));

            for (var it in menuData) {
                if (typeof menuData[it] == "object") {
                    var currentMenu = $("<li>").attr("rel", formatID(menuData[it].ID));
                    var tmpMenu;
                    var tmpWidth;

                    if (menuData[it].ParentID == "{00000000-0000-0000-0000-000000000000}") {
                        var href = $("<a>").attr("href", "#").html(menuData[it].Title);
                        href.attr("class", getIdByIcon(menuData[it].Icon)).appendTo(currentMenu);
                        currentMenu.attr("class", /*boolean.result ? valOption.activeClass : */valOption.normalClass).appendTo(ul);
                        ul.appendTo(container);
                    }
                    else {
                        tmpMenu = findMenuById(menuData[it].ParentID, defaultVal.Data);
                        if (tmpMenu.ParentID != "{00000000-0000-0000-0000-000000000000}") {
                            tmpWidth = parseInt(currentMenu.width()) + 17 * menuData[it].Title.length;
                            currentMenu = $("li[rel='" + formatID(menuData[it].ParentID) + "']");
                            currentMenu.append("|<a href=\"" + menuData[it].Href + "\">" + menuData[it].Title + "</a>");
                            currentMenu.css("width", parseInt(currentMenu.css("width")) + tmpWidth);
                            currentMenu.parent().css("width", parseInt(currentMenu.parent().css("width")) + tmpWidth);
                        }
                        else {
                            currentMenu.html("<a href=\"" + menuData[it].Href + "\">" + menuData[it].Title + "</a>");
                            currentMenu.css("width", 12 * menuData[it].Title.length).appendTo(ul);
                            ul.appendTo(container);
                        }
                        if (tmpMenu.ParentID == "{00000000-0000-0000-0000-000000000000}") {
                            if (it == 0)
                                currentMenu.css("border-radius", "2px 0 0 2px").css("margin-left", "-4px");

                            if (it > 0 && it != menuData.length)
                                currentMenu.css("margin-left", 0);

                            if (it == menuData.length - 1)
                                currentMenu.css("border-radius", "0 2px 2px 0");

                            if (menuData.length == 1) {
                                currentMenu.css("border-radius", "2px").css("width", "72px").css("margin-left", "-10px");
                            }
                        }
                    }
                    boolean.result = false;

                    if (menuData[it].Items.length) {
                        Render(menuData[it].Items, currentMenu, valOption);
                    }
                }
            }
        };

        var getIdByIcon = function (icon) {
            if (icon == null || icon == "")
                return "";
            else
                return icon.substring(0, icon.indexOf('.'));
        };

        var menuWidth = function (menuData, container) {
            var it = 17;
            var result = 0;
            var width = parseInt(container.css("width")) || container.width();
            for (var i in menuData) {
                if (typeof menuData[i] == "object")
                    result += it * menuData[i].Title.length;
            }
            return result + width;
        };

        var findMenuById = function (id, menus) {
            for (var menu in menus) {
                if (menus[menu].ID == id)
                    return menus[menu];

                if (menus[menu].Items && menus[menu].Items.length) {
                    findMenuById(id, menus[menu].Items);
                }
            }
            return "";
        };

        var bindEvent = function (container, options) {
            container.find("ul:first>li").each(function () {
                $(this).hover(function (e) {

                    $(this).addClass(options.activeClass).removeClass(options.normalClass);

                    $("#" + $(this).attr("rel")).show();

                    var tmpWidth = $(this).children("ul").offset().left + $(this).children("ul").width();
                    if (tmpWidth > $(window).width() - 100)
                        $(this).children("ul").css("left", -tmpWidth + $(window).width() - 100);

                    if (Storage.support()) {
                        Storage.set('menuID', $(this).attr("rel"));
                    }
                }, function () {
                    $(this).addClass(options.normalClass).removeClass(options.activeClass);
                    $("#" + $(this).attr("rel")).hide();
                });
            });
        };

        var formatID = function (id) {
            return id.replace("{", "").replace("}", "").replace(/-/gi, "_");
        };

        var initMenuState = function () {
            $("#we7body-content").addClass("web7body-content").css({ width: "90%", float: "none", margin: "0 auto" });
            $("#we7footer").css("background-color", "#D7D7D7");

            $(defaultVal.menuContainer).append("<div class=\"usr-info\"><ul><li class=\"usr-info-data\"><span class=\"site-name\"><a href=\"/\" title=\"点击浏览 Web7.Dev 首页\" target=\"_blank\">站点首页</a></span><span><a href=\"/Admin/\">管理员</a></span></li><li class=\"usr-info-logout\"><a href=\"/Admin/Signin.aspx?action=logout\">退出</a></li></ul></div>");

            if (Storage.support()) {
                var id = Storage.get("menuID");
                $("li[rel='" + id + "']").click();
            }
        };

        var execute = function (data) {
            defaultVal.Data = data;
            defaultVal.Data = eval(defaultVal.Data);
            if (defaultVal.Data != "") {
                $("<a>").attr("class", "site-logo").attr({ target: "dashboard", href: "#" }).html("Web7").appendTo($("<hgroup>").appendTo($(defaultVal.menuContainer)));

                Render(defaultVal.Data, $(defaultVal.menuContainer), defaultVal);
                $(defaultVal.menuContainer).fadeIn();
                bindEvent($(defaultVal.menuContainer), defaultVal);

                initMenuState();
            }
        };

        if (typeof defaultVal.Data == "function") {
            defaultVal.Data = defaultVal.Data.apply(this);
        }

        if (typeof defaultVal.Data == "string") {
            if (defaultVal.Data == "") {
                defaultVal.Data = adminMenu.getMenuData(undefined, execute);
                return;
            }

            defaultVal.Data = eval(defaultVal.Data);
        }

        execute(defaultVal.Data);

    },
    closeMenu: function () {
        var selObject = $(this.menuContainer);
        selObject.slideUp("fast").html("");
        $("body").css({ background: "none" });
        $("#we7footer").css("background-color", "#464646");
    }
};