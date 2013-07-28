(function () {
    var ie = 8, ua = navigator.userAgent;
    if (window.ActiveXObject) {
        ie = ua.match( /msie\s([\d]+)\./i )[1];
        ie = parseInt(ie);
        if (ie < 8) {
            alert("您即将访问 We7 模板编辑器，但您的浏览器版本太旧了。\n如要体验我们全新的拖拽技术，建议您下载以下浏览器的任一款：Firefox、Chrome 或升级至 IE 8 或以上版本，谢谢您对互联网新技术的支持！\n如果您开启了 IE 的兼容性视图功能，请关闭它。");
            try {
                document.execCommand("stop");
            } catch(x) {
            }
            history.go(-1);
        }
    }
})();
