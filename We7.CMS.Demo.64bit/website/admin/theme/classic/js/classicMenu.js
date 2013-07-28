; jQuery.classicMenu = {
    menuContainer: "#mainMenu",
    Name: "默认菜单",
    createMenu: function (options) {
        var defaultVal = {
            Text: '默认菜单',
            Data: adminMenu.getMenuData(),
            ContainerElement: "#mainMenu",
            DisMenuSwitch: false
        };
        $.extend(defaultVal, options);

        var container = $("<ul>").attr("id", "adminmenu");
        var boolean = { result: false };

        var createMenu = function (obj, counter, container) {
            var htmlTmp = "<li class='" + getClsByCurrentMenu(obj, counter) + "' id='" + getIdByIcon(obj.Icon) + "'><div class=\"we7-menu-image\"><br></div>"
                + "<div class=\"we7-menu-toggle\"><br></div><a  class='" + getClsByCurrentMenu(obj, counter) + "' tabindex=\"1\">" + obj.Title + "</a>"
                    + "<div class=\"we7-submenu\"><div class=\"we7-submenu-head\">" + obj.Title + "</div><ul>" + createSubMenu(obj) + "</ul></div>";

            container.append(htmlTmp);

            if (boolean.result) {
                container.append("<li class=\"we7-menu-separator\"><br></li>");
            }
        };

        var createSubMenu = function (currentMenu) {
            var htmlElement = "<li class=\"{0}\" id=\"{4}\">{5}. <a href=\"javascript:menuClick('{1}','{4}');\" class=\"{2}\" tabindex=\"1\"> {3}</a></li>";
            var result = new String();
            var tmp;
            for (var menu in currentMenu.Items) {
                if (typeof currentMenu.Items[menu] == "object") {
                    if (menu == 0)
                        tmp = htmlElement.replace("{0}", "we7-first-item");
                    else
                        tmp = htmlElement.replace("{0}", "");

                    result += tmp.replace("{0}", "we7-first-item")
                        .replace(/\{1\}/gi, currentMenu.Items[menu].Href)
                        .replace(/\{2\}/gi, "we7-first-item")
                        .replace(/\{3\}/gi, currentMenu.Items[menu].Title + createSubMenuOption(currentMenu, currentMenu.Items[menu]))
                        .replace(/\{4\}/gi, getIdByIcon(currentMenu.Icon) + "_" + (parseInt(menu) + 1))
                        .replace(/\{5\}/gi, parseInt(menu) + 1);
                }
            }
            return result;
        };

        var createSubMenuOption = function (parentMenu, currentMenu) {
            var menuStr = new String();
            if (currentMenu.Items && currentMenu.Items.length) {
                for (var menu in currentMenu.Items) {
                    if (typeof currentMenu.Items[menu] == "object") {
                        menuStr += "| <a href=\"javascript:menuClick('" + currentMenu.Items[menu].Href + "','" + getIdByIcon(parentMenu.Icon) + "_" + (parseInt(menu) + 1) + "');\">" + currentMenu.Items[menu].Title + "</a>";
                    }
                }
            }
            return menuStr;
        };

        var getClsByCurrentMenu = function (objMenu, counter) {
            var cls = "menu-top";
            if (counter == 0 || boolean.result) {
                cls += " menu-top-first we7-first-item";
                boolean.result = false;
            }

            if (defaultVal.Data[parseInt(counter) + 1] == undefined || defaultVal.Data[parseInt(counter) + 1].Group == objMenu.Group + 1) {
                cls += " menu-top-last";

                if (defaultVal.Data[parseInt(counter) + 1])
                    boolean.result = true;
            }

            if (objMenu.Items && objMenu.Items.length > 0)
                cls += " we7-has-submenu";

            return cls;
        };

        var getIdByIcon = function (icon) {
            if (icon == null || icon == "")
                return "";
            else
                return icon.substring(0, icon.indexOf('.'));
        };

        var initMenuState = function () {
            $("#we7head").slideDown("fast");
        };

        var execute = function (data) {
            defaultVal.Data = data;
            if (defaultVal.DisMenuSwitch) {
                if (typeof defaultVal.Data == "string") {
                    $(defaultVal.ContainerElement).html(defaultVal.Data);
                    $("#switchMenu").hide();
                    adminMenu.init();
                }
                return;
            }
            defaultVal.Data = eval(defaultVal.Data);

            if (defaultVal.Data != "") {
                var selObject = $(defaultVal.ContainerElement);

                selObject.html("");
                for (var item in defaultVal.Data) {
                    if (typeof defaultVal.Data[item] == "object")
                        createMenu(defaultVal.Data[item], item, container);
                }
                container.appendTo(selObject);
                adminMenu.init();
                selObject.fadeIn();

                initMenuState();
            }
        };

        if (typeof defaultVal.Data == "function") {
            defaultVal.Data = defaultVal.DisMenuSwitch ? defaultVal.Data.apply(this) : defaultVal.Data.apply(this, [defaultVal.ContainerElement]);
        }

        if (typeof defaultVal.Data == "string") {

            if (defaultVal.Data == "") {
                defaultVal.Data = adminMenu.getMenuData(defaultVal.DisMenuSwitch ? defaultVal.ContainerElement : undefined, execute);
                return;
            }
        }

        execute(defaultVal.Data);

    },
    closeMenu: function () {
        var selObject = $(this.menuContainer);
        $("#we7head").slideUp("fast");
        selObject.animate({ scrollLeft: 175 }, 500).html("");
    }
};