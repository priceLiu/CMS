/* File Created: 十月 29, 2012 */
//(function () { var style, styleText = '.pager-item{display:block;float:left;}.pager-spinner-prev,.pager-spinner-next{cursor:pointer;height:30px;}.pager-spinner-prev{}.pager-bar{width:400px;height:18px;margin:5px 23px;position:relative;}.pager-spinner-next{}.pager-spliter{display:block;float:left;height:100%;cursor:pointer;}.pager-pointer{width:44px;height:46px;padding-top:2px;font-size:12px;text-align:center;color:#eee;display:block;z-index:100;position:absolute;left:-22px;top:-25px;cursor:pointer;}.pager-pointer-active{background-position:-44px -36px;}'; style = document.createElement('style'); if (style.styleSheet) { style.styleSheet.cssText = styleText; } else { style.appendChild(document.createTextNode(styleText)); } document.getElementsByTagName('head')[0].appendChild(style) })();
// 本文件由文章显示和部件编辑使用，不可删除

function Pager(pelem, total, current, text) {
    if (!pelem || (pelem.jquery && !pelem.length)) {
        throw new ReferenceError('pager element');
    }

    var holder = $($(pelem)[0]), alist = holder.children('a'), aed = !!alist.length, currentPage = current || 1, totalPages = total || 1;
    text = jQuery.extend(true, {
        next: '下一页',
        prev: '上一页',
        page: '第{0}页'
    }, text);

    if (aed) {
        currentPage = total; 	/* 已提供 a 链接，则第二个参数为当前页码，无需‘所有页数’的参数，因为可以从行内获取到 */
        totalPages = alist.length;
    }

    if (total < 0) { throw new Error('invalid total page amout'); }
    if (total > 200) { throw new Error('too much pages'); }

    if (currentPage < 1) { currentPage = 1; }
    if (currentPage > totalPages) { currentPage = totalPages; }

    var j = 0, p = this, events = {
        onpage: [],
        onpaged: [],
        onprepage: [],
        oncancelpre: [],
        fire: function (e, args) {
            var e = this[e], i, r, ret = true, len;
            if (len = e.length) {
                for (i = 0; i < len; i++) {
                    if (ret) {
                        r = e[i].apply(p, args || []);
                        if (typeof r === "boolean") {
                            ret = r;
                        }
                    }
                }
            }
            return ret;
        }
    };
    var es = "onpage,onpaged,onprepage,oncancelpre".split(',');
    for (; j < es.length; j++) {
        this[es[j]] = (function (ev) {
            return function (fn) {
                if (fn === null) {
                    return events[ev] = [];
                }
                if (typeof fn === "undefined") {
                    return events[ev];
                }
                if (typeof fn === "function") {
                    events[ev].push(fn);
                }
                return this;
            }
        })(es[j]);
    }
    this.holder = holder;
    this.page = function (page, silent) {  // silent 静默，而不触发事件
        if (page < 1) { page = 1; };
        if (page > totalPages) { page = totalPages; }
        if (!silent) {
            if (!events.fire('onpage', [page, currentPage])) {
                return;
            }
        }

        var lastPage = currentPage;
        currentPage = page;

        if (!silent) {
            events.fire('onpaged', [page, lastPage]);
        }
    };
    this.totalPages = function () {
        return totalPages;
    },
    this.currentPage = function () {
        return currentPage;
    };

    /* init */
    holder.css({ "display": "block", "clear": "both", "height": "30px", "overflow": "hidden" });
    var a, bar, width, setWidth,innerHTML = '<span class="pager-item pager-spinner-prev"></span><span class="pager-item pager-bar"></span><span class="pager-item pager-spinner-next"></span>';
    $(innerHTML).appendTo(holder);
    bar = $('.pager-bar', holder);
    width = bar.width() / totalPages;
    setWidth = width > 0;
    if (setWidth) {
        aed && bar.append(alist);
        (width < 2) && (width = 2);
        width = Math.floor(width);
        bar.width(width * totalPages);
    }
    j = 1; /* 第一页 */
    // todo:(jijie.chen) 改为 delegate 的方式来处理，以提高效率
    do {
        a = aed ? alist.eq(j - 1) : $('<a>').appendTo(bar);
        if (aed) {
            a.data('href', a.attr('href')).attr('href', 'javascript:void(0);');
            a.data('target', a.attr('target')).attr('target', '');
        }
        a.addClass('pager-spliter').attr("title", text.page.replace(/\{0\}/g, j))
        .data('page', j)
        .text(j)
        .click(function () {
            // 如果预给定 a 列表，并不在这里指定，而采用在 page 事件里处理的方式，那样在外面表现得更加统一，而且，可以在用户事件处理中取消该行为。
            p.page(jQuery(this).data('page'));
        });                                 //.css("background-color", generateColor(j - 1)).attr('title', '第' + j + '页');
        if (setWidth) {
            a.width(width);
        }
    } while (j++ < totalPages);
    if (aed) {
        setTimeout(function () {
            p.onpage(function (page) {	// 此处不能再延时，因为 window.open 在延时时可能被拦截；因此如果使当前页面导航走，则 onpaged 事件无法触发
                var a = $('.pager-bar>a', this.holder).eq(page - 1), href = a.data('href'), target = a.data('target');
                var i, frames, frame, flength;
                a.addClass('pager-current').siblings().removeClass('pager-current');
                if (target) {
                    switch (target.toLowerCase()) {
                        case "_blank":
                            return window.open(href);
                        case "_top":
                        case "_parent":
                            try {
                                window.parent.location = href;
                            } catch (x) {
                                // NOTE: 当无法操作父窗口时，说明跨域，考虑将当前子框架定位到新的页面
                                // window.location = href;
                            }
                            return;
                        case "_self":
                            break;
                        default:
                            // 查找框架
                            frames = $('iframe'); // 忽略 frameset，因为标准不再支持它
                            if (flength = frames.length) {
                                for (i = 0; i < flength; i++) {
                                    frame = frames[i];
                                    if (frame.id == target ||
										frame.name == target) {
                                        frame.src = href;
                                        return;
                                    }
                                }
                            } else {
                                // NOTE: 未找到框架，不执行任何动作
                            }
                            return;
                    }
                }
                window.location = href;
            });
        }, 30);         // 延时 30ms 使得用户代码可在此之前被绑定，使用户可以取消默认行为，如果他需要。
    }
    a = null;


    /* visual effects and handlers */
    $('.pager-spinner-prev', holder).attr('title', text.prev).click(function () {
        p.page(currentPage - 1);
    });
    $('.pager-spinner-next', holder).attr('title', text.next).click(function () {
        p.page(currentPage + 1);
    });

    holder.data("pager", this);

    if (jQuery.browser.mozilla) {
        holder.css('MozUserSelect', 'none');
    } else if (jQuery.browser.msie) {
        holder.bind('selectstart.disableTextSelect', function () { return false; });
    } else {
        holder.bind('mousedown.disableTextSelect', function () { return false; });
    }
}
