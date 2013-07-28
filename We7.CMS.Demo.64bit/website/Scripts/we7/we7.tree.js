///<reference name="../jQuery/jquery-1.4.2.min.js" assembly="$" />
///<reference path="we7.loader.js" />

$.extend(jQuery.fn, {
	swapClass: function (c1, c2) {
		return this.removeClass(c1).addClass(c2).end();  // .filter(.c1)
	},
	toggleHide: function (animated, callback) {
		animated ?
				this.animate({ height: "toggle" }, animated, callback) :
				this.each(function () {
					$(this)[$(this).is(":hidden") ? "show" : "hide"]();
					if (callback)
						callback.apply(this, arguments);
				});
	}
});

(function ($) {

	/* Tree */
	var cachedNodes = {}, cachedLength = 0,
	defaultNodeOptions = {
		Class_nodeWithChild: 'parentNode',
		Class_asyncNode: 'ajaxNode',
		Class_singleNode: 'singleNode',
		Class_nodeContent: 'nodeContent',
		Class_subTree: 'subTree', 				// 子树（整个树面板样式，可用于添加）
		Class_expandable: 'expandable',
		Class_collapsible: 'collapsible',
		Class_hitarea: 'hitarea',
		Class_current: 'currentNode'
	};

	function addToCache(node) {
		cachedNodes[node.unique] = node;
		cachedLength++
	}

	function removeFromCache(node) {
		try {
			delete cachedNodes[node.unique];
			cachedLength--;
		} catch (x) { }
	}

	function generateRandom() {
		return Math.floor(Math.random() * 100000);
	}

	function decodeId(t) {
		return t ? decodeURIComponent(t).replace('-_-', '{').replace('_-_', '}') : t;
	}

	function encodeId(t) {
		return t ? encodeURIComponent(t.replace('{', '-_-').replace('}', '_-_')) : t;
	}

	function lastIt(node) {/* 为子树的 LI 添加 last 标记（不添加有子节点的或 ajax 节点的 LI） */
		var i, l = node.nodes.length, last;
		if (!l) { return; }
		for (i = 0; i < l; i++) {
			node.nodes[i].dom.removeClass('lastChildNode').removeClass("lastNestedNode");
		}
		last = node.nodes[l - 1];
		if ((!last.nodes.length) && (last.id.substr(0, 10) !== "auto_wait_")) {
			last.dom.addClass('lastChildNode');
		} else if (last.nodes.length) {
			last.dom.addClass('lastNestedNode');
		}
	}

	function TreeNode(text, id, options) {
		options = $.extend({}, defaultNodeOptions, options);
		var auto = 'auto_' + generateRandom();
		if (arguments.length == 2 && typeof id === "object") {
			options = id;
			id = auto;
		}
		!text && (text = '&nbsp;');
		!id && (id = auto);

		var content, self = this, cdom, hitarea = $('<span>').addClass(options.Class_hitarea);
		var async = !!options.ajax, isReady = false, isReqing = false, ajax;
		content = $('<span>').addClass(options.Class_nodeContent).html(text);
		content.mousedown(function () {
			var nodeDom = $(this).parent("li"), node = cachedNodes[nodeDom.attr('tree')];
			node.root().forEach(function (child) {
				child.inactive();
			});
			node.active();
		});
		this.id = id;
		this.parent = null;

		this.unique = (+new Date) + generateRandom() + "_" + cachedLength;
		this.dom = $('<li>').addClass(options.Class_singleNode).attr({ "tree": this.unique, "id": 'tree_' + this.id }).append(hitarea, content);
		this.text = text;
		this.nodes = [];

		this.active = function () {
			this.dom.find("span." + options.Class_nodeContent + ":first").addClass(options.Class_current);
		};
		this.inactive = function () {
			this.dom.find("span." + options.Class_nodeContent + ":first").removeClass(options.Class_current);
		};
		this.root = function () {
			var root = this;
			while (root.parent !== null) {
				root = root.parent;
			}
			return root;
		};
		this.forEach = function (fn, src) {
			var t = src || this;
			fn.apply(t, [this]);
			$.each(this.nodes, function () {
				this.forEach(fn, t);
			});
		};
		this.expand = function () {
			if (cdom) {
				//cdom.show();
				if (cdom.is(":visible")) { return; }
				cdom.toggleHide("fast");
				this.dom.swapClass(options.Class_expandable, options.Class_collapsible);

				if (async && !isReady && !isReqing) {
					launchXHR();
				}
			}
		};
		this.expandAll = function () {
			this.expand();
			$.each(this.nodes, function () {
				this.expandAll();
			});
		};
		this.collapse = function () {
			if (cdom) {
				//cdom.hide();
				if (cdom.is(":hidden")) { return; }
				cdom.toggleHide("fast");
				this.dom.swapClass(options.Class_collapsible, options.Class_expandable);
			}
		};
		this.collapseAll = function () {
			this.collapse();
			$.each(this.nodes, function () {
				this.collapseAll();
			});
		};
		this.add = function (nodes, force) {
			function createSubtree() {
				if (!cdom) {
					cdom = $("<ul>").hide().addClass(options.Class_subTree).appendTo(self.dom);
					return true;
				}
				return false;
			}

			if (async && !isReady) {
				if (createSubtree()) {			// 检查第一个，如果没有添加之
					this.add(new TreeNode('请稍候...', 'auto_wait_' + generateRandom(), { Class_singleNode: options.Class_asyncNode }), true);
				}
				if (!force) return;
			}
			if (!nodes) { return; }

			if (!we7.isArr(nodes)) {
				nodes = [nodes];
			} else if (!nodes[0]) {
				return;
			}

			this.dom.swapClass(options.Class_singleNode, options.Class_nodeWithChild);
			if ((!self.dom.hasClass(options.Class_collapsible)) && (!self.dom.hasClass(options.Class_expandable))) {
				self.dom.addClass(options.Class_expandable);
			}
			$.each(nodes, function () {
				createSubtree();
				// var base, hasChildren = !!this.nodes.length;
				// if(hasChildren){
				// base = cdom.find(">li:has(>ul):last");
				// if(!base.length){				// 目前没有任何复合子节点
				// cdom.prepend( this.dom );
				// }else{
				// this.dom.insertAfter( base );
				// }
				// }else{
				cdom.append(this.dom);
				//}

				this.parent = self;
				base = null;
			});
			this.nodes = this.nodes.concat(nodes);
			lastIt(this);
		};
		this.del = function (node) {
			var index;
			if (node && node.parent) {
				if (this === node.parent) {
					index = we7.indexOfArray(this.nodes, node);
					if (index > -1) {
						this.nodes.splice(index, 1);
						node.del(false); 			// HACK: 利用此 false 值使其到达最后一个执行分支，但用于表示从 parent 处调用回来，而不表示 node 参数的有无 [由于该调用分支含有调用 parent 的代码，因此不应该在此前将该子 node 的 parent 设为 null，实际上也无必要]
					}
					if (!this.nodes.length) {
						this.dom.swapClass(options.Class_nodeWithChild, options.Class_singleNode);
						if (node.id.substr(0, 10) !== "auto_wait_") {	// 排除 ajax 节点对处理过程的干扰
							this.dom.removeClass(options.Class_collapsible).removeClass(options.Class_expandable);
						}
					}
				} else {
					node.parent.del(node);
				}
			} else if (node) {
				node.del();
			} else {
				if (we7.isUndef(node) && this.parent) {
					this.parent.del(this);
				} else {
					if (async && isReqing) {
						ajax.abort();
						ajax = undefined;
					}

					if (this.parent) {
						lastIt(this.parent);
					}
					this.nodes = [];
					cdom = null;
					removeFromCache(this);
					this.dom.remove();
					delete this.dom;
					delete this.parent;
				}
			}
		};
		this.attachMenu = function (menuOptions) {
			if (this.menu) {
				this.menu.destroy();
			}
			this.menu = we7(this.dom).menu(menuOptions, function (e) {
				var src = $(e.target), contentElem = 'span.' + options.Class_nodeContent;
				if (!(src.is(contentElem) || src.parents(contentElem).length > 0)) {
					return false;
				}
			});
		};

		this.refresh = function (bTarget) {		// bTarget 是否立即刷新当前结点（取其子节点 true），还是通过刷新其父节点来间接刷新当前节点（默认，此时 bTarget 作为来源）
			if ((typeof bTarget === "undefined") || (typeof bTarget === "boolean" && !bTarget)) {
				return this.parent ? this.parent.refresh(this) : this.refresh(true);
			}

			if (!async) { return; }
			if (!isReady) {
				this.expand();
				return;
			}
			this.collapse();
			var len;
			var refreshing = this, panel = bTarget === true ? this.dom.parent() : bTarget.dom.parent(), completed = false, isRoot = refreshing === refreshing.root(), oldComplete = options.ajax.complete, srcId = bTarget === true ? false : bTarget.id;
			while (len = this.nodes.length) {
				this.del(this.nodes[len - 1]);
			}
			isReady = false;
			cdom.remove();
			cdom = null;
			this.add();

			options.ajax.complete = function () {
				if (oldComplete) {
					options.ajax.complete = oldComplete;
					oldComplete.apply(this, arguments);
				}
				if (completed) { return; }
				completed = true;
				var ns = refreshing.nodes, nl = ns.length, n, got;
				if (srcId && nl) {
					for (var i = 0; i < nl; i++) {
						n = ns[i];
						if (isRoot) {
							n.attachMenu(options.menu);
						}
						if (n.id === srcId) {
							got = n;
						}
					}
					if (got) {
						setTimeout(function () {
							got.expand();
						}, 10);
					}
				}
				refreshing = undefined;
				oldComplete = undefined;
			};
			this.expand();
		};
		function launchXHR() {
			var xhrOptions = $.extend({
				type: 'get',
				dataType: 'json',
				cache: false,
				data: { _nodeid: self.id, _text: self.text }
			}, options.ajax);
			var oldSuccess = xhrOptions.success;
			xhrOptions.success = function (data, status) {			// {id: text: ajax: nodes:}
				isReqing = false;
				var oldResult;
				if (oldSuccess) {
					oldResult = oldSuccess.apply(this, [].slice.apply(arguments).concat([self]));
				}
				if (oldResult && (typeof oldResult === "object")) {
					data = oldResult;
				}
				var pd, added = false, del = true, preNode = self.nodes[0];
				if (data) {			// 优先取其 tree 属性[以处理无法完美覆盖服务器数据]
					pd = typeof data.length !== "undefined" ? data : [data];
					if(pd.length){
						preNode.del();
						added = TreeNode.initTree(pd, self, options);
					}else{
						self.dom.removeClass(options.Class_expandable);
						if(self.root() === self){
							preNode.dom.removeClass(options.Class_asyncNode).find("span." + options.Class_nodeContent).text("没有数据");
						}else{
							preNode.del();
						}
					}
				}else{
					jQuery("span." + options.Class_nodeContent, preNode.dom).text('读取出错');
				}

				// 加载错误时？恢复为收缩状态，触发错误事件~用户可继续点左边展开来重试 isReqing = false;
				isReady = true;
			};
			isReqing = true;
			ajax = $.ajax(xhrOptions);
		}

		hitarea.click(function () {
			if (self.dom.hasClass(options.Class_expandable)) {
				self.expand();
			} else if (self.dom.hasClass(options.Class_collapsible)) {
				self.collapse();
			}
		});

		if (async) {
			this.add();
		}
		addToCache(this);
		if (options.menu) {
			this.attachMenu(options.menu);
		}
		return this;
	}

	TreeNode.getTree = function (tid) {
		return cachedNodes[tid];
	}

	TreeNode.initTree = function (sd, parent, options) {
		if (!we7.isArr(sd)) { sd = [sd] }
		options = options || {};

		var node, ret = false, set = [];

		function p(a) {
			return typeof a === "string" ? { url: a} : (typeof a === "boolean" ? (a ? {} : undefined) : a);
		}
		options.ajax = p(options && options.ajax) || false;

		$.each(sd, function (i, n) {
			if (typeof n.menu === "undefined") {
				n.menu = false;
			}
			node = new TreeNode(n.text, n.id, $.extend({}, options, { menu: n.menu, ajax: n.ajax ? $.extend({}, options.ajax, p(n.ajax)) : false }));
			parent ? parent.add(node, true) : set.push(node); 		// 强制要求添加节点

			if (n.nodes && n.nodes.length) {
				TreeNode.initTree(n.nodes, node, options);
			}
			ret = true;
		});
		return ret && (parent || set);
	}

	/* Menu */

	var menudefaultOptions = {
		menuClass: 'contextmenu',
		itemClassDisabled: 'disableditem',
		itemClass: 'menuitem',
		inSpeed: 150,
		outSpeed: 75
	};

	function Menu(options) { // {id:'', panel: $(),  inSpeed:0,outSpeed, menuClass   itemClass }

		options = $.extend({}, options, menudefaultOptions);
		!options.items && (options.items = []);
		if (options.inSpeed == 0) options.inSpeed = -1;
		if (options.outSpeed == 0) options.outSpeed = -1;

		function eName(etype) {
			return etype + ".menu";
		}

		var self = this, items = [], globalCallback = options.action, element, actions = {}; 	// options.action 是全局回调
		this.id = options.id || 'menu_' + generateRandom();  // {action:fn, text:'剪切', disabled: false}

		function callback(item, source, sender) {
			var i = self.items(item);
			if (i) {
				i.action.apply(i, [source, sender, self]);
				globalCallback && globalCallback.apply(i, [source, sender, self])
			}
		};
		var menu = $('<ul>').attr({ id: self.id, rel: "we7menu" }).addClass(options.menuClass).hide().appendTo(document.body);
		menu.click(function (e) {
			var source = $(e.target), item = source.is("li[item]") ? source : source.parents("li[item]");

			if (!item.length) {
				return false; 	// 非菜单项
			}

			if (item.hasClass(options.itemClassDisabled)) {
				return false;
			}

			menu.fadeOut(options.outSpeed);
			$(document).unbind(eName('click'));
			setTimeout(function () {
				callback(item.attr('item'), menu.srcElement, item);
			}, 5);
		});
		if ($.browser.mozilla) {
			menu.css('MozUserSelect', 'none');
		} else if ($.browser.msie) {
			menu.bind('selectstart.disableTextSelect', function () { return false; });
		} else {
			menu.bind('mousedown.disableTextSelect', function () { return false; });
		}

		this.items = function (i) {
			switch (typeof i) {
				case "number":
					return items[i];
				case "string":
					return we7.findInArray(items, function (a) { return a.id === i });
				case "function":
					return we7.findInArray(items, function (a) { return i.apply(a) === true; });
				default:
					return items;
			}
		};
		this.add = function (item) {
			item = $.extend({
				action: new Function,
				text: '菜单项 ' + (self.items.length + 1),
				disabled: false,
				id: 'mi_' + generateRandom()
			}, item);


			var act, di = $('<li>').attr('item', item.id).addClass(options.itemClass);
			di.append($('<a>').append(item.text).attr('rel', 'menuitem')).appendTo(menu);
			if (item.disabled) {
				di.addClass(options.itemClassDisabled);
			}
			item.element = di;
			items.push(item);
		};
		this.disable = function (item) {		//禁用一个菜单项
			var i = this.items(item);
			if (i) {
				i.disabled = true;
				menu.find(">li[item='[" + i.id + "']").addClass(options.itemClassDisabled);
			}
		};
		this.enable = function (item) {		//禁用一个菜单项
			var i = this.items(item);
			if (i) {
				i.disabled = true;
				menu.find(">li[item='[" + i.id + "']").removeClass(options.itemClassDisabled);
			}
		};
		this.attachTo = function (el, filter) {
			if (element && el) {
				this.destroy(true);
			}
			$(el).bind(eName('mouseup'), function (e) {
				$("ul[rel=we7menu]").not(menu).fadeOut("fast"); 		// 隐藏其他可能存在的菜单
				if (e.button !== 2) {
					return;
				}
				if (filter && filter.apply($(this), [e]) === false) {
					return;
				}
				// 右击	
				e.preventDefault();
				e.stopPropagation();

				var src = $(e.target), d = {}, x, y;
				if (window.innerHeight) {
					d.pageYOffset = window.pageYOffset;
					d.pageXOffset = window.pageXOffset;
					d.innerHeight = window.innerHeight;
					d.innerWidth = window.innerWidth;
				} else if (document.documentElement && document.documentElement.clientHeight) {
					d.pageYOffset = document.documentElement.scrollTop;
					d.pageXOffset = document.documentElement.scrollLeft;
					d.innerHeight = document.documentElement.clientHeight;
					d.innerWidth = document.documentElement.clientWidth;
				} else if (document.body) {
					d.pageYOffset = document.body.scrollTop;
					d.pageXOffset = document.body.scrollLeft;
					d.innerHeight = document.body.clientHeight;
					d.innerWidth = document.body.clientWidth;
				}
				(e.pageX) ? x = e.pageX : x = e.clientX + d.scrollLeft;
				(e.pageY) ? y = e.pageY : y = e.clientY + d.scrollTop;

				// Show the menu
				$(document).unbind(eName('click'));
				menu.srcElement = src.is("li[tree]") ? src : src.parents('li[tree]');
				menu.css({ top: y, left: x }).fadeIn(options.inSpeed);

				setTimeout(function () {
					$(document).bind(eName('click'), function () {
						$(document).unbind(eName('click'));
						menu.fadeOut(options.outSpeed);
						menu.srcElement = null;
						return false;
					});
				}, 0);
			});

			var cancel = function (e) {
				e.preventDefault();
				e.stopPropagation();
				return false;
			};
			$(el).bind('contextmenu', cancel);
			menu.bind('contextmenu', cancel);
			element = el;
		};
		this.destroy = function (reserve) {
			if (element) {
				element.unbind(eName('mousedown')).unbind(eName('mouseup')).unbind('oncontextmenu');
				menu.unbind('contextmenu', cancel).hide();
			}
			if (!reserve) {
				menu.unbind('selectstart.disableTextSelect').unbind('mousedown.disableTextSelect');
				options = undefined;
				menu = undefined;
				element = undefined;
			}
		};
		var arr = we7.isArr(options.items) && we7.isObj(options.items); 	// 兼容使用对象键对的形式（无需数组）
		$.each(options.items, function (n, v) {
			if (arr) {
				self.add(this);
			} else {
				self.add({
					text: n,
					action: v
				});
			}
		});
	}

	we7.extend({
		"tree": function (json, options) {
			options = options || {};
			var element = this.jquery, tree, nodes, ajaxOK, isAjax = we7.isStr(json) || options.ajax, ajaxed;
			if (isAjax) {
				// ajax tree ?
				options.ajax = $.extend({ url: json }, options.ajax);
				ajaxOK = options.ajax.complete;
				options.ajax.complete = function (data, status) {
					if (ajaxOK) {
						ajaxOK.apply(this, arguments);
					}
					ajaxed = true;
					if (status == "success") {
						element.addClass("we7tree").append(tree.dom.find('ul:first>li'));
					}
				}
				tree = new TreeNode(null, options._we7id, options);
				if (options._we7id) { delete options._we7id; }
				tree.expand();
			} else {
				nodes = TreeNode.initTree(json, null, options);
				element.addClass("we7tree");
				if (nodes.length === 1) {
					tree = nodes[0];
					tree.dom.appendTo(element);
				} else {
					tree = new TreeNode(null, null, options);
					tree.add(nodes);
					element.append(tree.dom.find('ul:first>li'));
				}
			}
			return tree;
		},
		"bindTree": function (bindOption, options) {
			options = options || {};
			var preid = "{00000000-0000-0000-0000-000000000000}", menued = false, self = this, element = this.jquery, title = bindOption.title, parentFieldName = bindOption.parentFieldName, menu = options.menu, ajax = $.extend({}, options.ajax), bo = new we7.BindOption(bindOption);
			!ajax.url && (ajax.url = '/admin/ajax/BusinessSubmit/JsonForCondition.ashx'); //                bindDestination.conditions.push(new we7.BindCondition("ParentID", we7.bindVerb.equals, "{00000000-0000-0000-0000-000000000000}"));
			ajax.type = "post";
			ajax.cache = false;

			var pidCondition = we7.findInArray(bo.conditions, function (i) { return i.source === parentFieldName });
			if (!pidCondition) {
				bo.conditions.push(new we7.BindCondition(parentFieldName, we7.bindVerb.equals, preid));
			}
			var oldBeforeSend = ajax.beforeSend, oldSuccess = ajax.success, orgData = ajax.data, inited;
			ajax.beforeSend = function (xhr, settings) {
				var pid = /_nodeid=([^&]+)(&|$)/.exec(settings.data), pConditionIndex = we7.indexOfArray(bo.conditions, function () { return this.source === parentFieldName }); ;
				inited && (bo.conditions[pConditionIndex] = new we7.BindCondition(parentFieldName, we7.bindVerb.equals, decodeId(pid[1])));
				inited = true;
				settings.data = settings.data.replace(/(?:_c|_f|_tb|_sord|_sort|_text|_nodeid)=[^&]+(&|$)/g, '$1').replace(/&{1,}/g, '&').replace(/(^&|&$)/g, '');
				settings.data = (settings.data ? '&' : '') + ["tree=true", "_pidname=" + parentFieldName, bo.toURI()].join('&');
				if (oldBeforeSend) {
					oldBeforeSend.apply(this, arguments);
				}
			};
			ajax.success = function (data) {
				var d;
				if (oldSuccess) {
					d = oldSuccess.apply(this, arguments);
				}
				if (d && (typeof d === "object")) {
					data = d;
				}

				function doSomething(fn, parent) {
					if (!parent || !parent.length) { return; }
					var i = 0, l = parent.length, node;
					do {
						fn.call(node = parent[i]);
						doSomething(fn, node.nodes);
					}
					while (++i < l)
				}

				doSomething(function () {
					this.text = we7.isStr(title) ? this[title] : title.call(this, this);
					this.id = encodeId(this.ID || this.id);
					this.ajax = this.hasnode ? true : false; 	// hasnode 是固有属性表示是否含有字节点
					if (!menued) {
						this.menu = menu;
					}
				}, we7.isArr(data) ? data : [data]);
				menued = true;
				return data;
			};
			options.ajax = ajax;
			options._we7id = preid;
			return this.tree("", options);
		},
		"menu": function (options, fn) {	// cb 为统一回调
			we7.isArr(options) && (options = { items: options });
			var menu = new Menu(options);
			menu.attachTo(this.jquery, fn);
			return menu;
		}
	});

	we7.tree = function (target, json, options) {
		return we7(target).tree(json, options);
	};
	we7.tree.getTree = function (obj) {		// 获取指定 tree（通过 treeid 或 HTML 节点）
		return TreeNode.getTree(we7.isStr(obj) ? obj : $(obj).attr('tree'));
	};
})(jQuery);
