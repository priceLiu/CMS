/// <reference path="../jQuery/jquery-1.4.2.js"/>

/*
<link href="/scripts/we7/css/we7.tip.css" rel="Stylesheet" />
<script type="text/javascript" src="/scripts/we7/we7.loader.dev.js" inner="false"></script>
<script type="text/javascript" src="/scripts/we7/we7.tools.js" ></script>
<script type="text/javascript" src="/scripts/we7/we7.form.js" ></script>
<script type="text/javascript" src="/scripts/we7/we7.render.js"></script>
<script type="text/javascript" src="/scripts/we7/we7.tree.js"></script>

<link href="/scripts/jQuery/jQueryUI/css/jquery-ui.css" rel="Stylesheet" />
<link href="/scripts/we7/css/ui.jqgrid.css" rel="Stylesheet" />
<script type="text/javascript" src="/scripts/jquery/jQueryUI/jquery-ui.js"></script>
<script type="text/javascript" src="/scripts/we7/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="/scripts/we7/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="we7/we7.bind.js"></script>
*/


/* we7.core.js 依赖 jQuery */
(function ($, win_we7) {
	var isArray = function (a) { return a && typeof a == "object" && typeof a.length == "number" && typeof a.splice == "function" && !a.propertyIsEnumerable("length") };
	var we7 = function (obj) {
		if (typeof obj === "undefined" || typeof obj === null) {
			return null;
		}
		return new we7.fn.init(obj);
	};
	$.extend(we7, {
		we7: 2011112209,
		isArr: isArray,
		isArray: isArray,
		isUndef: function (a) { return typeof a === "undefined" },
		isNull: function (a) { return typeof a === "object" && !a },
		isN: function (a) { return typeof a === "number" && window.isFinite(a) },
		isFunc: function (a) { return typeof a === "function" },
		isObj: function (a) { var t = typeof a; return a && t === "object" || t === "function" },
		isStr: function (a) { return typeof a === "string" }
	});
	function format(a) { if (!a) return undefined; var b, c, d, e = arguments.length - 1, f = new String(a); for (b = 0; b < e; b++) c = new RegExp("{[" + b + "]}", "g"), f = f.replace(c, arguments[b + 1]); return f }
	String.prototype.trim = function () { var rnotwhite = /\S/, trimLeft = /^\s+/, trimRight = /\s+$/; if (rnotwhite.test("\xA0")) { trimLeft = /^[\s\xA0]+/; trimRight = /[\s\xA0]+$/; } return this.replace(trimLeft, "").replace(trimRight, "") }

	$.extend(we7, {
		indexOfArray: function (arr, elem) {
			if (!arr || !arr.length) { return -1; }
			var fn = we7.isFunc(elem);
			if (fn || (we7.isUndef(Array.prototype.indexOf))) {
				for (var i = 0; i < arr.length; i++) {
					if ((fn && elem.call(arr[i], i) === true) || arr[i] === elem) {
						return i;
					}
				}
				return -1;
			} else {
				return arr.indexOf(elem);
			}
		},
		findInArray: function (arr, fn, i) {
			if (!we7.isFunc(fn) || !arr || !arr.length) return null; var b, c = i || 0; for (; c < arr.length; c++) if (fn.call(arr, b = arr[c])) return b
		}
	});

	var _nu = window.navigator.userAgent;
	var _b = {
		userAgent: _nu,
		msie: false,
		ff: (/firefox/i).test(_nu),
		chrome: (/chrome/i).test(_nu),
		opera: (/opera/i).test(_nu),
		ie: 0
	};
	(function () {
		var a = /msie\s([\d\.]+)/i.exec(_nu);
		_b.msie = (a !== null);
		_b.ie = a === null ? !1 : parseFloat(a[1]);
		_b.firefox = _b.ff;
	})();
	we7.browser = _b;
	we7.log = function log(txt, source) {
		var occurred = new Date();
		txt = occurred.getHours() + ':' + occurred.getMinutes() + ':' + occurred.getSeconds() + '\t' + txt;
		if (window.log) {
			window.log(txt);
		}
		if (window.console && window.console.log) {
			window.console.log(txt);
		}
	};
	we7.formatStr = function (a) { return format.apply(null, arguments) }
	we7.trimStr = function (text) { var s = text; return s.trim() };

	we7.fn = we7.prototype = {
		init: function (o) {
			this.original = o || {};
			if ((we7.isStr(o)) || (!this.jquery && o.nodeType)) {
				this.jquery = $(o);
			} else {    // o is a jQuery object
				this.jquery = we7.isStr(o.jquery) ? o : (o.jquery || null);
			}
		},
		clone: function () {
			var obj = this.original;
			var objClone;
			if (obj.constructor == Object) {
				objClone = new obj.constructor();
			} else {
				objClone = new obj.constructor(obj.valueOf());
			}
			for (var key in obj) {
				if (objClone[key] != obj[key]) {
					if (typeof (obj[key]) == 'object') {
						objClone[key] = we7(obj[key]).clone();
					} else {
						objClone[key] = obj[key];
					}
				}
			}
			objClone.toString = obj.toString;
			objClone.valueOf = obj.valueOf;
			return objClone;
		},
		rename: function (memberName, newMemberName) {
			var self = this, isObj = we7.isUndef(newMemberName) && we7.isObj(memberName);

			function replaceName(n, nn) {
				var o = self.original[n];
				if (o) {
					self.original[newMemberName] = we7(o).clone();
				}
			}

			if (isObj) {
				$.each(memberName, function (name) {
					replaceName(name, this);
				});
			} else {
				replaceName(memberName, newMemberName);
			}
			return self.original;
		}
	};
	we7.fn.init.prototype = we7.fn;
	we7.extend = function (ext) {       // 将成员绑定到实例对象上
		$.extend(we7.prototype, ext);
		return we7;
	};
	we7.extend({
		we7: we7.we7,
		extend: function (ext) {
			$.extend(this, ext);
			return this;
		}
	});
	$.extend(we7, {
		beforeUnload: function (message, func) {
			window.onbeforeunload = function () {
				if (we7.isFunc(func) && func.call() != false)
					return message;
				else if (we7.isStr(func)) 
					return func;
			}
		},
		removeBeforeUnload: function (func) {
			window.onbeforeunload = null;
			if (we7.isFunc(func)) func.call();
		},
		queryString: function (loc, key) {
			if (loc && loc.indexOf('/') === -1) {
				key = loc;
				loc = undefined;
			}
			loc = loc || window.location;
			var p = (function parseQueryParams(location) {
				var search = typeof location.search !== "string" ? (location.indexOf('?') < 0 ? "" : location.substr(location.indexOf('?'))) : location.search;
				var ic = 0, params = {};
				var query = unescape(search.substr(1));
				var vars = query.split("&");
				for (var i = 0; i < vars.length; i++) {
					var pair = vars[i].split("=");
					if (pair[0]) {
						ic++;
						params[pair[0]] = pair[1];
					}
				}
				return ic > 0 ? params : null;
			})(loc);
			return key ? p && p[key] : p;
		}
	});
	$.extend(we7, win_we7);
	window.we7 = we7;
	if (window.we7loader) {
		window.we7.load = window.we7loader;
	}
})(jQuery, window.we7);


/****************************************************/


/*
we7 loader
Intergrated with we7.core[always the newest version]
*/
(function () {
	var version = (we7 && we7.we7) || 2011112209, basePath = '/scripts/', jsConfigUrl = '/scripts/we7/_ResourceSets.js',
    preventCache = true, scriptRel = 'ref', scriptConfig = 'config', debugMode = false;

	var log = function log(txt, source) {
		if (!debugMode) { return; }
		var occurred = new Date();
		txt = occurred.getHours() + ':' + occurred.getMinutes() + ':' + occurred.getSeconds() + '\t' + txt;
		if (window.console && window.console.log) {
			window.console.log(txt);
		}
	}
    , innerResource = {
		jQueryUI:[
				{ name: 'jqueryui', src: '/scripts/jquery/jQueryUI/jquery-ui.js'},
                { name: '_jquicss', src: '/scripts/jQuery/jQueryUI/css/jquery-ui.css' }
		]
    	,we7tip: [
                { name: 'jqtools', src: basePath + 'we7/jquery.tools.min.js'},
                { name: 'we7tools', src: basePath + 'we7/we7.tools.js', need: 'jqtools' },
				{ name: '_tip_css', src: basePath + 'we7/css/we7.tip.css' }
            //, { name: 'jquery', src: basePath + 'jquery/jquery-1.4.2.min.js'} // basePath + jquery.js     // 永远把 jQuery 置于最后一个，程序会自动判断是否已载入
         ]
        , we7form: [
                { name: 'we7form', src: basePath + 'we7/we7.form.js', need: "jqueryui" }
        ]
        , we7bind: [		/* 需要在已入的文件中作此更改（添加） */
			{ name: 'jgrid_css', src: '/scripts/we7/css/ui.jqgrid.css' },
            { name: 'jgrid_lang', src: '/scripts/we7/i18n/grid.locale-cn.js' },
			{ name: 'jgrid', src: '/scripts/we7/jquery.jqGrid.min.js', need: 'jgrid_lang' },
			{ name: 'we7bind', src: basePath + 'we7/we7.bind.js', need: "jgrid" }
        ]
    };

	// { name: 'we7', src: basePath + 'we7/we7.core.js', need: 'jquery' }, // we7.core 已整合到当前脚本文件中
	/*
	<script type="text/javascript" src="/scripts/we7/jquery.tools.min.js"></script>
	<script type="text/javascript" src="/scripts/we7/we7.loader.js"></script>
	<script type="text/javascript" src="/scripts/we7/we7.tools.js"></script>
	<script type="text/javascript" src="/scripts/we7/we7.form.js"></script>
	*/


//	var jQuery_Loaded = false;          // TODO: add some fondation methods to check if one resource has been loaded already
//	if (jQuery && jQuery.prototype.jquery && typeof (jQuery.prototype.selector) !== "undefined") {
//		jQuery_Loaded = true;           // jQuery 文档已引用jQuery
//		innerResource.we7tip.splice(innerResource.we7tip.length - 1, 1);
//		log("jQuery has already been imported to this document");
//	}

	if (jQuery && typeof jQuery.ui !== "undefined") {  // jQuery UI has been loaded
		delete innerResource.jQueryUI;
		log("jQuery UI has already been imported to this document");
	}

	var loadInner, scriptHref = (function () {		// 获取当前脚本文件的引用 URL（在页面中的 SRC），用于在页面上寻找定位到当前脚本块
		var scripts = document.getElementsByTagName('SCRIPT');
		var script = scripts[scripts.length - 1];
		loadInner = script.getAttribute("inner");
		return script.src;
	})();

	function ajaxCreate() {
		var xhrObj = false;
		try {
			xhrObj = new XMLHttpRequest();
		} catch (e) {
			var aTypes = ["Msxml2.XMLHTTP.6.0",
            			  "Msxml2.XMLHTTP.3.0",
						  "Msxml2.XMLHTTP",
						  "Microsoft.XMLHTTP"];
			var len = aTypes.length;
			for (var i = 0; i < len; i++) {
				try {
					xhrObj = new ActiveXObject(aTypes[i]);
				}
				catch (e) {
					continue;
				}
				break;
			}
		}
		finally {
			if (!xhrObj) {
				var e = 'Error: this browser does not support XmlHttpRequest';
				log(e);
				throw new Error(e);
			}
			return xhrObj;
		}
	}
	function addParam(url, name, value) {
		name = ((url.indexOf('?') > -1) ? '&' : '?') + encodeURIComponent(name) + '=' + encodeURIComponent(value);
		var index = url.indexOf('#');
		index = (index === -1) ? url.length : index;
		url = url.substr(0, index) + name + url.substr(index);
		return url;
	}
	function injectDom(txt, bKeep) {
		var se = document.createElement('SCRIPT'), head = document.getElementsByTagName('head')[0];
		se.setAttribute("type", "text/javascript");
		se.setAttribute("injected", Number(new Date));
		head.appendChild(se);
		se.text = txt;
		if (!bKeep) {
			setTimeout(function () {                        // NOTE: 一段时间之后在 DOM 中去除这个 Script 标记有利于提高之后 DOM 检索的效率，减少浏览器内存占用
				head.removeChild(se);
			}, 1500);
		}
	}
	function addStyle(style) {
		var fileref = document.createElement("link");       // NOTE: CSS载入并未考虑依赖关系，而仅只是动态添加到页面 Head 中
		fileref.setAttribute("rel", "stylesheet");
		fileref.setAttribute("type", "text/css");
		fileref.setAttribute("href", style);
		document.getElementsByTagName('head')[0].appendChild(fileref);
	}
	function addEvent(ev, e, bTrigger, bDelete) {
		if (!e) { return; }
		if (ev) {
			ev.push(e);
		} else {
			ev = [e];
		}
		if (bTrigger) {
			return triggerEvent(ev, bDelete);
		}
		return ev;
	}
	function triggerEvent(ev, bDelete) {
		if (!ev) { return; }
		var len = ev.length, e;
		for (var i = 0; i < len; i++) {
			e = ev[i];
			if (typeof e === "string") {
				injectDom(e, true);
			} else if (e) {
				e.call(window);
			}
			if (bDelete) {
				ev[i] = undefined;
			}
		}
		if (bDelete) {
			ev.splice(0, ev.length);
		}
	}

	function Context() {
		this.q = [];
		this.injectScripts = function () {
			var len = this.q.length;
			log('Injecting scripts with ' + len + ' length of queue');
			for (var i = 0; i < len; i++) {
				var qScript = this.q[i];
				if (!qScript.scriptText) {
					// 等待其他请求完成
					log('Script ' + qScript.name + ' is not ready yet when injecting scripts queue');
					break;
				}
				else if (qScript.status < 2) {
					qScript.status = 2;
					injectDom(qScript.scriptText);

					log(qScript.name + ' is now loaded by queue');
					if (qScript.onComplete) {
						qScript.onComplete.call(qScript);
					}
				}
			}
		}
	}
	function Script(name, src, need, context, onComplete, onError) {
		name = name || 'script_' + (new Number(new Date()));
		var tNeed = (typeof need);
		switch (tNeed) {
			case "string":
				need = need.replace(' ', '').split(',');
				break;
			case "object":
				if (!need) {
					need = [];
				}
				break;
			default:
				need = [];
		}

		this.name = name;
		this.src = src;
		this.need = need || [];
		this.index = -1;
		this.context = context;
		this.onComplete = onComplete;
		this.onError = onError;
		this.scriptText = null;

		this.status = 0;        // -1： 发生错误     0: 初始化   1: 正在载入    2: 载入完成

		if (this.src && preventCache) {
			this.src = addParam(this.src, '_we7ver', version);
		}

		this.load = function (onC, onE) {
			if (onC) {
				this.onComplete = onC;
			}
			if (onE) {
				this.onError = onE;
			}
			var script = this, xhrObj = ajaxCreate();

			if (this.context) {
				this.index = this.context.q.length;
				this.context.q.push(this);
			}

			this.status = 1;
			xhrObj.onreadystatechange = function () {
				if (xhrObj.readyState === 4) {
					if (xhrObj.status < 200 || xhrObj.status >= 400) {
						log('Error when loading script ' + script.name + ', server returned a bad status code: ' + xhrObj.status);
						script.status = -1;
						if (script.context) {
							script.context.q[script.index].status = -1;
						}
						if (script.onError) {
							script.onError.call(script);
						}
					} else {
						if (script.context) {
							script.context.q[script.index].scriptText = xhrObj.responseText;
							script.context.injectScripts();
						}
						else {
							script.status = 2;
							injectDom(xhrObj.responseText);
							log(script.name + ' is now loaded');
							if (script.onComplete) {
								script.onComplete.call(script);
							}
						}
					}
				}
			};
			xhrObj.open('GET', this.src, true);
			xhrObj.send(null);
		};
	};
	var Manager = {
		had: [],
		add: function (script) {
			Manager.had.push(script);
		},
		get: function (script) {
			var name = typeof script === 'string' ? script : script.name;
			var hadL = Manager.had.length;
			for (var i = 0; i < hadL; i++) {
				if (Manager.had[i].name == name)
					return Manager.had[i];
			}
			return null;
		}
	}
//	if (jQuery_Loaded) {
//		jQuery_Loaded = new Script("jquery", "jquery.js");
//		jQuery_Loaded.status = 2;
//		Manager.add(jQuery_Loaded);
//	}
	function loadResourceSets(task) {
		var sets = task.tasks, result = [];

		function resoureceSetReady() {
			var ts, go = true, suc = true;

			function getScriptIndexOf(scr) {
				for (var i = 0; i < result.length; i++) {
					if (result[i].name === scr.name) {
						return i;
					}
				}
				return -1;
			}

			var index = getScriptIndexOf(this);
			if (index > -1) {
				result[index].status = this.status;
			}

			for (var i = 0; i < result.length; i++) {
				ts = result[i];
				if (ts.status > -1 && ts.status < 2) {
					go = false;
					break;
				} else if (ts.status === -1) {
					suc = false;
				}
			}
			if (go) {
				task.isReady = true;
				for (var i = 0; i < result.length; i++) {
					Manager.add(result[i]);
				}
				log('All scripts are now loaded');
				if (suc) {
					task.successed = true;
					log('All scripts are now loaded successfully');
				}
				triggerEvent(task.onReady, true);
				if (suc) {
					triggerEvent(task.onSuccess, true);
				}
				if (typeof this.index !== "undefined") {
					try { delete this.context; } catch (err) { }
				}
				delete result;
			}
		}
		function findScript(script, index) {
			if (typeof script === 'object') {
				return script;
			}
			if (!index) {
				index = sets.length;
			}

			for (var i = 0; i < index; i++) {
				if (sets[i].name === script)
					return sets[i];
			}
			return false;
		}
		function needNotContained(needs) {
			var need, notContained = [];
			for (var i = 0; i < needs.length; i++) {
				need = needs[i];
				if (!findScript(need) && !Manager.get(need)) {
					needs.splice(i, 1);
					notContained.push(need);
				}
			}
			return notContained.length ? notContained : true;       // true 表示无遗漏
		}
		function isNeeded(left, right, nested) {
			var notRight = false;
			if (result.length === 1) {
				return false;
			}
			left = findScript(left);
			if (!right) {
				notRight = true;
				right = new Script('_Global' + Math.random(), '', result);
			} else {
				right = findScript(right);
			}

			if (left.name === right.name) {
				return false;
			}

			var l = right.need ? right.need.length : 0, needNow;

			for (var ni = 0; ni < l; ni++) {
				needNow = right.need[ni];
				if (needNow.name === left.name) {       // need left<如果右边是此过程创造的，则不允许直接相等，仅允许其子集相等>
					if (!notRight) {
						return true;
					}
				} else if (!nested) {
					if (isNeeded(left, needNow, notRight ? true : false)) {                 // need's need need left
						return true;
					}
				}
			}
			return false;
		}
		function contrast(left, right) {
			var sR = 0, li = left.need.length, ri = right.need.length;
			if (!li && !ri) {
				return 0;
			} else {
				var L_R = false, R_L = false;       // 左边依赖右边；右边依赖左边
				L_R = isNeeded(left, right);
				R_L = isNeeded(right, left);

				if (L_R && R_L) {
					throw new Error('Can not load scripts which require each other');
				}

				if (L_R) {
					sR = -1;            // 右边依赖左边，则 L < R <
				} else if (R_L) {
					sR = 1;             // 左边依赖右边，则 R < L <
				} else if (!li) {
					sR = -1;            // 左边没有依赖，则左边提前 L < R <
				} else if (!ri) {
					sR = 1;             // 右边没有依赖，则右边提前 R < L <
				} else {                //  都没有依赖
					return 0;
				}
			}

			return sR;
		}

		var script, need, nl, needInResult, bStyle;
		for (var i = 0; i < sets.length; i++) {
			script = sets[i];
			var needLack, li = script.src.lastIndexOf('.');
			bStyle = (li > -1) ? script.src.substr(li).substr(0,4) === '.css' : false;
			if (!bStyle) {
				script = (typeof script.scriptText !== "undefined") ? script : new Script(script.name, script.src, script.need);
				if (!Manager.get(script)) {
					need = script.need;
					if (need.length) {
						needLack = needNotContained(need);
						if (needLack !== true) {
							log('Some required scripts (' + needLack.join(',') + ') can not be found for script "' + script.name + '", it may not work properly');
						}
					}
					for (var _n = 0; _n < need.length; _n++) {
						script.need[_n] = findScript(need[_n]) || Manager.get(need[_n]);
					}

					result.push(script);
				}
			}
			else {
				addStyle(script.src);
			}
		}
		if (!result.length) {
			resoureceSetReady.call(null);
			return;
		}
		result.sort(contrast);

		var resultNow, context = new Context();

		for (var i = 0; i < result.length; i++) {
			resultNow = result[i];
			if (resultNow.need.length || isNeeded(resultNow)) {
				resultNow.context = context;
			}
		}

		for (var i = 0; i < result.length; i++) {
			resultNow = result[i];
			resultNow.load(resoureceSetReady, function () {
				triggerEvent(task.onError, true);
			});
		}
	}
	var jsConfigUrlLoaded = false;
	function LoadTask(script, onReady, onError, resConfig) {
		if(!script){return null;}
		var  httpUrl = /^(https?:\/\/.+)?\/.*\.js(\?.*)?/;
		var viaRes = false, task = this;
		
		function boxScript(s){
			if(typeof s.context === "undefined"){
				try{
					s = new Script(s.name, s.src, s.need);
				}catch(x){}
			}
			return s;
		}

		if (typeof script === "string" ){
			if(httpUrl.test(script)){
				script = new Script('we7_script_' + Number(new Date()), script);
			}else{
				viaRes = true;
			}
		}else if(typeof script === "object"){
			if(typeof script.length === "undefined"){	// 不要是数组
				script = boxScript(script);
			}else{
				 for(var _i=0;_i<script.length;_i++){
					script[_i] = boxScript(script[_i]);
				 }
			}
		}
	
		this.isReady = false;
		this.successed = false;
		this.onReady = addEvent(null, onReady); 		// 		当完成时（而不管是否均已成功）
		this.onSuccess = null; 							//		当成功时 （要求所有的均已成功）
		this.onError = addEvent(null, onError); 		//		每次发生错误时
		this.resConfig = resConfig;

		this.tasks = viaRes ? null : ((typeof script.length !== "undefined") ? script : [script]);
		this.load = function () {
			if (viaRes) {
				if (task.tasks = loaderProxy.resoureSets[script]) {     // 已注册过此资源集
					loadResourceSets(task);
				} else {                                                // 未注册过（试图加载资源集文件）
					if (resConfig === jsConfigUrl && jsConfigUrlLoaded) {  //  已读取过配置
						var t = 'No such resource set found: ' + script; log(t); throw new Error(t);
					}
					var resScript = new Script('_Res_' + resConfig.substr(resConfig.lastIndexOf('/') + 1).replace('.', ''), resConfig, null);
					var resTask = new LoadTask(resScript, function () {
						jsConfigUrlLoaded = true;
						if (!(loaderProxy.resoureSets[script])) {
							var t = 'No such resource set found: ' + script; log(t); throw new Error(t);
						}
						// 开始排序并发动载入
						task.tasks = loaderProxy.resoureSets[script];
						loadResourceSets(task);
					}, function () {
						var t = 'Failed to load resource configuration'; log(t); throw new Error(t);
					});
					resTask.load();
				}
			} else {
				var exsits = Manager.get(script);
				if (exsits) {
					this.isReady = exsits.status === 2 || exsits.status === -1;
					this.successed = exsits.status === 2;

					if (this.isReady && this.onReady) {
						triggerEvent(this.onReady, true);
					}
					if (this.successed && this.onSuccess) {
						triggerEvent(this.onSuccess, true);
					}
				} else {
					loadResourceSets(this);
				}
			}
			return this;
		}
		this.ready = function (func) {
			this.onReady = addEvent(this.onReady, func);
			if (this.isReady) {
					triggerEvent(this.onReady, true);
			}
			return this;
		};
		this.success = function (func) {
			this.onSuccess = addEvent(this.onSuccess, func);
			if (this.successed) {
				triggerEvent(this.onSuccess, true);
			}
			return this;
		};
		this.error = function (func) {
			this.onError = addEvent(this.onError, func);
			return this;
		};
	}
	function loaderProxy() {
		var loader = new LoadTask(arguments[0], arguments[1], arguments[2], arguments[3] || jsConfigUrl);
		loader.load();
		return loader;
	}
	loaderProxy._readyFunc = null;      // Ready 事件
	loaderProxy.ready = function (func, donotTigger) {
		loaderProxy._readyFunc = addEvent(loaderProxy._readyFunc, func);
		if (!donotTigger && loaderProxy._ready) {
			triggerReady();
		}
	}
	function triggerReady() {
		triggerEvent(loaderProxy._readyFunc, true);
	}
	loaderProxy.resoureSets = {};
	loaderProxy.addResource = function (obj) {
		for (var a in obj) {
			if (obj.hasOwnProperty(a)) {
				if (loaderProxy.resoureSets[a]) {
					log('Original resource ' + a + ' has been overwrite');
				}
				loaderProxy.resoureSets[a] = obj[a];
			}
		}
	};
	
	if (!window.we7) {
		window.we7 = {};
	}
	window.we7.load = loaderProxy;
	function init() {
		if (loaderProxy._ready) {
			return; // 防止重复提交
		}
		loaderProxy._ready = true;

		log('Initializing loader callbacks, typeof we7 is:' + (typeof we7));

		var loads = [];
		// 遍历脚本并执行其中代码
		var scripts = [], docScripts = document.getElementsByTagName('SCRIPT'), len = docScripts.length;
		for (var _si = 0; _si < len; _si++) { //当此时向 DOM 中注入 script 时，get.byTagName 的结果会被修改，因此需要复制出来
			scripts.push(docScripts[_si]);
		}
		var script, loaderCommand, loadRef, task, config, injed = 'injected', inj;

		for (var i = 0; i < len; i++) {
			script = scripts[i];
			inj = script.getAttribute(injed);
			if (inj) {
				continue;
			}
			loadRef = script.getAttribute(scriptRel);
			config = script.getAttribute(scriptConfig);
			if (script.src && ((script.src.indexOf(scriptHref) > -1) || loadRef)) {
				if (config) {                           //NOTE: 仅 loader.js 脚本上的 config 会更改全局（其他的对应各自）
					jsConfigUrl = config;
				}
				loaderCommand = script.innerHTML.replace(/^\s+/, '').replace(/\s+$/, '');
			}
			if (loadRef) {
				loads.push({
					name: loadRef,
					callback: loaderCommand ? loaderCommand : null,
					config: config ? config : jsConfigUrl
				});
			} else {
				if (script.src && loaderCommand) {
					loaderProxy.ready(loaderCommand, true);             //没有载入任务时为 window；有载入任务时为 LoadTask 本身
				}
			}
			loaderCommand = undefined;
		}
		triggerReady();
		for (var i = 0; i < loads.length; i++) {
			task = loaderProxy(loads[i].name, loads[i].callback, null, loads[i].config);
		}
	}
	var irCount = 0, irdCount = 0, readyRun = false;
	if (loadInner !== "false") {
		function checkReady() {
			irdCount++;
			if (irdCount >= irCount && !readyRun) {
				readyRun = true;
				init();
			}
		}
		for (var p in innerResource) {
			if (innerResource.hasOwnProperty(p)) {
				irCount++;
				(function (index) {
					setTimeout(function () {
						(new LoadTask(innerResource[index], checkReady)).load();
					}, 1);
				})(p);
			}
		}
	} else {
		init();
	}

})();


/*
<script type="text/javascript" ref="aspnet" config="/scripts/we7/_ResourceSets.js" src="/scripts/loader.js">
alert('done')           // 保证所有核心组件都可用？
</script>
*/

/* 不需要压缩的部分（已压缩） */
(function($){$.tools=$.tools||{version:'v1.2.5'};$.tools.tooltip={conf:{effect:'toggle',fadeOutSpeed:"fast",predelay:0,delay:30,opacity:1,tip:0,rePosition:true,position:['top','center'],offset:[0,0],relative:false,cancelDefault:true,autoHide:true,events:{def:"mouseenter,mouseleave",input:"focus,blur",widget:"focus mouseenter,blur mouseleave",tooltip:"mouseenter,mouseleave"},layout:'<div rel="tipcontent"/>',tipClass:'tooltip'},addEffect:function(name,loadFn,hideFn){effects[name]=[loadFn,hideFn];}};var effects={toggle:[function(done){var conf=this.getConf(),tip=this.getTip(),o=conf.opacity;if(o<1){tip.css({opacity:o});} tip.show();done.call();},function(done){this.getTip().hide();done.call();}],fade:[function(done){var conf=this.getConf();this.getTip().fadeTo(conf.fadeInSpeed,conf.opacity,done);},function(done){this.getTip().fadeOut(this.getConf().fadeOutSpeed,done);}]};function getPosition(trigger,tip,conf){var top=conf.relative?trigger.position().top:trigger.offset().top,left=conf.relative?trigger.position().left:trigger.offset().left,pos=conf.position[0];top-=tip.outerHeight()-conf.offset[0];left+=trigger.outerWidth()+conf.offset[1];if(/iPad/i.test(navigator.userAgent)){top-=$(window).scrollTop();} var height=tip.outerHeight()+trigger.outerHeight();if(pos=='center'){top+=height/2;} if(pos=='bottom'){top+=height;} pos=conf.position[1];var width=tip.outerWidth()+trigger.outerWidth();if(pos=='center'){left-=width/2;} if(pos=='left'){left-=width;} return{top:top,left:left};} function getContentPanel(tip){var panel=tip.find("[rel='tipcontent']");return panel.length?panel:tip;} function Tooltip(trigger,conf){var self=this,fire=trigger.add(self),tip,timer=0,pretimer=0,title=trigger.attr("title"),tipAttr=trigger.attr("data-tooltip"),effect=effects[conf.effect],shown,isInput=trigger.is(":input"),isWidget=isInput&&trigger.is(":checkbox, :radio, select, :button, :submit"),type=trigger.attr("type"),evt=conf.events[type]||conf.events[isInput?(isWidget?'widget':'input'):'def'];if(!effect){throw"Nonexistent effect \""+conf.effect+"\"";} evt=evt.split(/,\s*/);if(evt.length!=2){throw"Tooltip: bad events configuration for "+type;} $.each(evt,function(i,ev){var evs=ev.split(' ');$.each(evs,function(j,e){if(e.indexOf('.')<0){evs[j]=e+'.T';}});evt[i]=evs.join(' ');});trigger.bind(evt[0],function(e){clearTimeout(timer);if(conf.predelay){pretimer=setTimeout(function(){self.show(e);},conf.predelay);}else{self.show(e);} e.stopPropagation();}).bind(evt[1],function(e){clearTimeout(pretimer);if(conf.delay){timer=setTimeout(function(){self.hide(e);},conf.delay);}else{self.hide(e);}});if(title&&conf.cancelDefault){trigger.removeAttr("title");trigger.data("title",title);} $.extend(self,{show:function(e){var customedTip=tip&&tip.data("_custom"),customTip=e&&(typeof e==="string"&&e);if(customTip){e=undefined;}else{tip&&tip.removeData("_custom");} if(customTip||customedTip){if(tip)tip.remove();tip=undefined;} if(!tip){if(tipAttr){tip=$(tipAttr);}else if(conf.tip){tip=$(conf.tip).eq(0);}else if(title){tip=$(conf.layout).addClass(conf.tipClass).appendTo(document.body).hide();}else{tip=trigger.next();if(!tip.length){tip=trigger.parent().next();}} if(!tip.length){throw"Cannot find tooltip for "+trigger;} getContentPanel(tip).empty().append(title);} if(conf.tip){getContentPanel(tip).html(trigger.data("title"));} if(customTip){getContentPanel(tip).empty().append(customTip);tip.data("_custom",true);} if(!customTip&&self.isShown()){return self;} tip.stop(true,true);var pos=getPosition(trigger,tip,conf);e=e||$.Event();e.type="onBeforeShow";fire.trigger(e,[pos]);if(e.isDefaultPrevented()){return self;} pos=getPosition(trigger,tip,conf);if(conf.rePosition){tip.css({position:'absolute',top:pos.top,left:pos.left});} shown=true;effect[0].call(self,function(){e.type="onShow";shown='full';fire.trigger(e);});var event=conf.events.tooltip.split(/,\s*/);if(!tip.data("__set")){tip.bind(event[0],function(){clearTimeout(timer);clearTimeout(pretimer);});if(event[1]&&!trigger.is("input:not(:checkbox, :radio), textarea")){tip.bind(event[1],function(e){if(e.relatedTarget!=trigger[0]){trigger.trigger(evt[1].split(" ")[0]);}});} tip.data("__set",true);} return self;},hide:function(e){if(!tip||!self.isShown()){return self;} if(!conf.autoHide){return self;} e=e||$.Event();e.type="onBeforeHide";fire.trigger(e);if(e.isDefaultPrevented()){return;} shown=false;effects[conf.effect][1].call(self,function(){e.type="onHide";fire.trigger(e);});return self;},destroy:function(){if(tip){tip.stop(true,true).hide(function(){$(this).remove()});} trigger.unbind(evt[0]).unbind(evt[1]);trigger.removeData("tooltip");},isShown:function(fully){return fully?shown=='full':shown;},getConf:function(){return conf;},getTip:function(){return tip;},getTrigger:function(){return trigger;}});$.each("onHide,onBeforeShow,onShow,onBeforeHide".split(","),function(i,name){if($.isFunction(conf[name])){$(self).bind(name,conf[name]);} self[name]=function(fn){if(fn){$(self).bind(name,fn);} return self;};});} $.fn.tooltip=function(conf){var api=this.data("tooltip");if(api){return api;} conf=$.extend(true,{},$.tools.tooltip.conf,conf);if(typeof conf.position=='string'){conf.position=conf.position.split(/,?\s/);} this.each(function(){api=new Tooltip($(this),conf);$(this).data("tooltip",api);});return conf.api?api:this;};})(jQuery);
(function(a){var b=a.tools.tooltip;a.extend(b.conf,{direction:"up",bounce:!1,slideOffset:10,slideInSpeed:300,slideOutSpeed:200,slideFade:!a.browser.msie});var c={up:["-","top"],down:["+","top"],left:["-","left"],right:["+","left"]};b.addEffect("slide",function(a){var b=this.getConf(),d=this.getTip(),e=b.slideFade?{opacity:b.opacity}:{},f=c[b.direction]||c.up;e[f[1]]=f[0]+"="+b.slideOffset,b.slideFade&&d.css({opacity:0}),d.show().animate(e,b.slideInSpeed,a)},function(b){var d=this.getConf(),e=d.slideOffset,f=d.slideFade?{opacity:0}:{},g=c[d.direction]||c.up,h=""+g[0];d.bounce&&(h=h=="+"?"-":"+"),f[g[1]]=h+"="+e,this.getTip().animate(f,d.slideOutSpeed,function(){a(this).hide(),b.call()})})})(jQuery);
(function(a){var b=a.tools.tooltip;b.dynamic={conf:{classNames:"top right bottom left"}};function c(b){var c=a(window),d=c.width()+c.scrollLeft(),e=c.height()+c.scrollTop();return[b.offset().top<=c.scrollTop(),d<=b.offset().left+b.width(),e<=b.offset().top+b.height(),c.scrollLeft()>=b.offset().left]}function d(a){var b=a.length;while(b--)if(a[b])return!1;return!0}a.fn.dynamic=function(e){typeof e=="number"&&(e={speed:e}),e=a.extend({},b.dynamic.conf,e);var f=a.extend(!0,{},e),g=e.classNames.split(/\s/),h;this.each(function(){var b=a(this).tooltip().onBeforeShow(function(b,e){var i=this.getTip(),j=this.getConf();h||(h=[j.position[0],j.position[1],j.offset[0],j.offset[1],a.extend({},j)]),a.extend(j,h[4]),j.position=[h[0],h[1]],j.offset=[h[2],h[3]],i.css({visibility:"hidden",position:"absolute",top:e.top,left:e.left}).show();var k=a.extend(!0,{},f),l=c(i);if(!d(l)){l[2]&&(a.extend(j,k.top),j.position[0]="top",i.addClass(g[0])),l[3]&&(a.extend(j,k.right),j.position[1]="right",i.addClass(g[1])),l[0]&&(a.extend(j,k.bottom),j.position[0]="bottom",i.addClass(g[2])),l[1]&&(a.extend(j,k.left),j.position[1]="left",i.addClass(g[3]));if(l[0]||l[2])j.offset[0]*=-1;if(l[1]||l[3])j.offset[1]*=-1}i.css({visibility:"visible"}).hide()});b.onBeforeShow(function(){var a=this.getConf(),b=this.getTip();setTimeout(function(){a.position=[h[0],h[1]],a.offset=[h[2],h[3]]},0)}),b.onHide(function(){var a=this.getTip();a.removeClass(e.classNames)}),ret=b});return e.api?ret:this}})(jQuery);
(function(a){function ioa(arr,elem){if(!arr||!arr.length){return-1}for(var i=0;i<arr.length;i++){if(arr[i]===elem){return i}}return-1}function r(d,e,f){function n(b,c,d){if(!f.grouped&&b.length){return}var e;if(d===false||a.isArray(d)){e=i.messages[c.key||c]||i.messages["*"];e=e[f.lang]||i.messages["*"].en;var g=e.match(/\$\d/g);if(g&&a.isArray(d)){a.each(g,function(a){e=e.replace(this,d[a])})}}else{e=d[f.lang]||d}b.push(e)}var g=this,h=e.add(g),k=false;d=d.not(":button, :image, :reset, :submit");var o={_get:function(a){return a.data("valCache")},isValid:function(a,c){var d=o._get(a);return d&&b(d.valid,c)>-1},push:function(a,b,c){var d=o._get(a)||{valid:[],invalid:[]};if(c){d.invalid.push({val:b,msgs:c})}else{d.valid.push(b)}a.data("valCache",d)},isInvalid:function(b,c){var d=o._get(b);return d&&function(){var b=false;a.each(d.invalid,function(a,d){if(d.val===c){b=d.msgs;return false}});return b}()}};a.extend(g,{getConf:function(){return f},getForm:function(){return e},getInputs:function(){return d},reflow:function(){d.each(function(){var b=a(this),c=b.data("msg.el");if(c){var d=j(b,c,f);c.css({top:d.top,left:d.left})}});return g},invalidate:function(b,c,e){e=!!e;if(!c){var i=[];a.each(b,function(a,b){var c=d.filter("[name='"+a+"']");if(c.length){c.trigger("OI",[b]);i.push({input:c,messages:[b]})}});b=i;c=a.Event()}c.type="onFail";h.trigger(c,[b,e]);if(f.focusOnError){try{b[0].input[0].focus()}catch(j){}}return g},reset:function(b){b=b?b.not(":button, :image, :reset, :submit"):d;b.removeClass(f.errClass).removeClass(f.okClass).each(function(){var b=a(this).data("msg.el");if(b){b.remove();a(this).data("msg.el",null)}});if(f.errorInputEvent){b.unbind(f.errorInputEvent+".VE"||"")}return g},destroy:function(){e.unbind(f.formEvent+".V").unbind("reset.V");d.unbind(f.inputEvent+".V").unbind("change.V");if(f.errorInputEvent){d.unbind(f.errorInputEvent+".VE"||"")}return g.reset()},isCompleted:function(){return!k},checkValidity:function(e,i,j){function u(){if(r.length){g.invalidate(r,i,j);return false}else{if(f.errorInputEvent){e.unbind(f.errorInputEvent+".VE")}i.type="onSuccess";if(!j){h.trigger(i,[e,j])}}return true}function s(b){if(!f.custom){return true}var c=b.data("validator-custom"),d=[];if(c){if(c.length){a.each(c,function(a,c){var e=c.call(b,g,j);if(e!==true){d.push(e)}})}else{d=c.call(b,g,j);if(d!==true){d=[d]}}return d.length?d:true}return true}var p=m[f.effect];if(!p){throw'Validator: cannot find effect "'+f.effect+'"'}j=!!j;e=e||d;e=e.not(":disabled").filter(function(b){return q(a(this))});if(!e.length){return true}i=i||a.Event();i.type="onBeforeValidate";h.trigger(i,[e,j]);if(i.isDefaultPrevented()){return i.result}var r=[];var t=[];e.not(":radio:not(:checked)").not(":hidden").each(function(){function u(){if(b.length){var a={input:d,messages:b};r.push(a);d.trigger("OI",[b]);if(f.errorInputEvent){d.bind(k,function(a){g.checkValidity(d,a,true)})}i.type="onInputFail";h.trigger(i,[d,b,j]);if(!i.isDefaultPrevented()){p[0].call(g,[a])}}else if(!q){i.type="onInputSuccess";h.trigger(i,[d,j]);if(!i.isDefaultPrevented()){p[1].call(g,d)}}if(r.length&&f.singleError){t=[];return false}return true}var b=[],d=a(this).data("messages",b),e=d.val(),k=c(d)?"onHide.v":f.errorInputEvent+".VE",m,q;d.unbind(k);if(o.isValid(d,e)){return u()}else if(m=o.isInvalid(d,e)){b=m;return u()}var v=s(d);if(v!==true){var w=d.attr(f.errMsgAttr);if(w){b=[w];return false}else{a.each(v,function(a,c){n(b,"*",c)})}}a.each(l,function(){var a=this,c=a[0];if(d.filter(c).length){var h=a[1].call(g,d,e,j);if(h!==true){var i=d.attr(f.errMsgAttr);if(i){b=[i];return false}else{n(b,c,h)}}}});if(!b.length){if(d.data("validator-ajax")){q=true;t.push(d)}else{o.push(d,e,null)}}else{o.push(d,e,b)}return u()});if((!j||f.ajaxOnSoft)&&t.length){k=true;i.type="onAjaxStart";h.trigger(i,[t,j]);if(i.isDefaultPrevented()){t=[];k=false;return u()}function v(a,c){var d=b(t,a);if(d>-1){t.splice(d,1);if(c!=="canceled"){i.type="onAjaxResponse";h.trigger(i,[a,c,j]);if(c===null){o.push(a,a.val(),null);i.type="onInputSuccess";h.trigger(i,[a,j]);if(!i.isDefaultPrevented()){p[1].call(g,a)}}else{o.push(a,a.val(),c.messages);i.type="onInputFail";h.trigger(i,[a,c.messages,j,"ajax"]);if(!i.isDefaultPrevented()){p[0].call(g,r)}}}}if(t.length===0){k=false;i.type="onAjaxDone";h.trigger(i,[t,r,j]);return u()}}function w(){if(g._ajaxTimer){delete g._ajaxTimer}a.each(t,function(a,b){i.type="onAjaxRequest";h.trigger(i,[b,j]);if(i.isDefaultPrevented()){v(b,"canceled")}else{var c=b.data("validator-ajax");c.call(b,g,function(a,b){var c=null;if(a!==true){c={input:this,messages:[a]};r.push(c)}v(this,c)})}})}if(j){if(g._ajaxTimer){try{clearTimeout(g._ajaxTimer)}catch(x){}}g._ajaxTimer=setTimeout(w,750)}else{w()}return false}else{return u()}}});g.validate=g.checkValidity;a.each("onBeforeValidate,onInputSuccess,onInputFail,onFail,onSuccess,onAjaxStart,onAjaxRequest,onAjaxResponse,onAjaxDone".split(","),function(b,c){if(a.isFunction(f[c])){a(g).bind(c,f[c])}g[c]=function(b){if(b){a(g).bind(c,b)}return g}});if(f.formEvent){e.bind(f.formEvent+".V",function(a){if(!g.checkValidity(null,a)){return a.preventDefault()}})}e.bind("reset.V",function(){g.reset()});if(d[0]&&d[0].validity){d.each(function(){this.oninvalid=function(a){if(a){a.preventDefault()}return false}})}if(e[0]){e[0].checkValidity=g.checkValidity}if(f.inputEvent){d.bind(f.inputEvent+".V",function(b){g.checkValidity(a(this),b,true)})}d.filter(":checkbox, select").filter("[required]").bind("change.V",function(b){var c=a(this);if(this.checked||c.is("select")&&a(this).val()){var d=a.Event();d.type="onInputSuccess";h.trigger(d,[c,true]);if(!d.isDefaultPrevented()){m[f.effect][1].call(g,c,b)}}});var p=d.filter(":radio").change(function(a){g.checkValidity(p,a,true)});a(window).resize(function(){g.reflow()})}function q(a){function c(a){if(typeof a==="undefined")return false;if(a==="")return false;return true}var b=a.attr("we7-validate");if(c(b)){return true}var d=a.attr("required"),e=a.attr("max"),f=a.attr("min"),g=a.attr("maxlength"),h=a.attr("pattern"),i=a.attr("data-type"),j=a.attr("type"),k=j==="url",l=j==="email",m=j==="number";if(k||l||m||c(i)||c(d)&&d||c(e)||c(f)||c(g)&&g>0&&g<524288||c(h)&&h){a.attr("we7-validate","validate");return true}return false}function k(a){function b(){return this.getAttribute("type")==a}b.key="[type="+a+"]";return b}function j(b,c,d){var e=b.offset().top,f=b.offset().left,g=d.position.split(/,?\s+/),h=g[0],i=g[1];e-=c.outerHeight()-d.offset[0];f+=b.outerWidth()+d.offset[1];if(/iPad/i.test(navigator.userAgent)){e-=a(window).scrollTop()}var j=c.outerHeight()+b.outerHeight();if(h=="center"){e+=j/2}if(h=="bottom"){e+=j}var k=b.outerWidth();if(i=="center"){f-=(k+c.outerWidth())/2}if(i=="left"){f-=k}return{top:e,left:f}}function c(b){return!!(a.tools.dateinput&&a(b).attr("we7date"))}var b=ioa;a.tools=a.tools||{version:"v1.2.5"};var d=/\[type=([a-z]+)\]/,e=/^-?[0-9]*(\.[0-9]+)?$/,f=a.tools.dateinput,g=/^([a-z0-9_\.\-\+]+)@([\da-z\.\-]+)\.([a-z\.]{2,6})$/i,h=/^(https?:\/\/)?[\da-z\.\-]+\.[a-z\.]{2,6}[#&+_\?\/\w \.\-=]*$/i,i;i=a.tools.validator={conf:{grouped:false,effect:"default",errClass:"invalid",okClass:"nice",inputEvent:null,errorInputEvent:"keyup",formEvent:"submit",custom:true,focusOnError:false,showTips:true,ajaxOnSoft:false,lang:"en",message:"<div/>",errMsgAttr:"msg-error",okMsgAttr:"msg-ok",errMsgClass:"error",okMsgClass:"ok",offset:[0,0],position:"center right",singleError:false,speed:"normal"},messages:{"*":{en:"请输入正确的值"}},localize:function(b,c){a.each(c,function(a,c){i.messages[a]=i.messages[a]||{};i.messages[a][b]=c})},localizeFn:function(b,c){i.messages[b]=i.messages[b]||{};a.extend(i.messages[b],c)},fn:function(b,c,e){if(a.isFunction(c)){e=c}else{if(typeof c=="string"){c={en:c}}this.messages[b.key||b]=c}var f=d.exec(b);if(f){b=k(f[1])}l.push([b,e])},addEffect:function(a,b,c){m[a]=[b,c]}};var l=[],m={"default":[function(b){var c=this.getConf();if(!c.showTips){return}a.each(b,function(b,d){var e=d.input;e.removeClass(c.okClass).addClass(c.errClass);var f=e.data("msg.el");if(!f){f=a(c.message).appendTo(document.body);e.data("msg.el",f)}f.removeClass(c.okMsgClass).addClass(c.errMsgClass);f.css({visibility:"hidden"}).find("p").remove();a.each(d.messages,function(b,c){a("<p/>").html(c).appendTo(f)});if(f.outerWidth()==f.parent().width()){f.add(f.find("p")).css({display:"inline"})}var g=j(e,f,c);f.css({visibility:"visible",position:"absolute",top:g.top,left:g.left}).fadeIn(c.speed)})},function(b){var c=this.getConf();if(!c.showTips){return}b.removeClass(c.errClass).removeClass(c.okClass).each(function(){var b=a(this).data("msg.el");if(b){b.css({visibility:"hidden"})}})}],we7:[null,function(b){var c=this.getConf();if(!c.showTips){return}b.removeClass(c.errClass).addClass(c.okClass).each(function(){var b=a(this);var d=b.data("msg.el");if(!d){d=a(c.message).appendTo(document.body);b.data("msg.el",d)}d.removeClass(c.errMsgClass).addClass(c.okMsgClass);d.css({visibility:"hidden"}).find("p").remove();var e=b.attr(c.okMsgAttr)||"填写正确";if(!e){return}a("<p/>").html(e).appendTo(d);if(d.outerWidth()==d.parent().width()){d.add(d.find("p")).css({display:"inline"})}var f=j(b,d,c);d.css({visibility:"visible",position:"absolute",top:f.top,left:f.left}).fadeIn(c.speed)})}]};m.we7[0]=m["default"][0];a.each("email,url,number".split(","),function(b,c){a.expr[":"][c]=function(a){return a.getAttribute("type")===c}});a.fn.oninvalid=function(a){return this[a?"bind":"trigger"]("OI",a)};var n="请输入正确的 Email 地址",o="请输入正确的网址",p="请输入数字";i.fn(":email",n,function(a,b){return!b||g.test(b)});i.fn(":url",o,function(a,b){return!b||h.test(b)});i.fn(":number",p,function(a,b){return e.test(b)});i.fn("[data-type=email]",n,function(a,b){return!b||g.test(b)});i.fn("[data-type=url]",o,function(a,b){return!b||h.test(b)});i.fn("[data-type=number]",p,function(a,b){return e.test(b)});i.fn("[max]","请输入小于 $1 的数值",function(a,b){if(b===""||c(a)){return true}var d=a.attr("max");return parseFloat(b)<=parseFloat(d)?true:[d]});i.fn("[min]","请输入大于 $1 的数值",function(a,b){if(b===""||c(a)){return true}var d=a.attr("min");return parseFloat(b)>=parseFloat(d)?true:[d]});i.fn("[maxlength]","请按要求输入不超过 $1 个字符",function(a,b){var c=parseInt(a.attr("maxlength"));if(b&&b.length&&b.length>c){return[c]}return true});i.fn("[minlength]","请按要求输入不少于 $1 个字符",function(a,b){var c=parseInt(a.attr("minlength"));if(b&&b.length&&b.length<c){return[c]}return true});i.fn("[required]","此项是必须填写的",function(a,b){if(a.is(":checkbox")){return a.is(":checked")}return!!b});i.fn("[pattern]",function(a){var v,b=new RegExp("^"+a.attr("pattern")+"$");return !(v=a.val())||b.test(v)});a.fn.validator=function(b){var c=this.data("we7_validator");if(c){c.destroy();this.removeData("we7_validator")}b=a.extend(true,{},i.conf,b);if(this.is(":input")){c=new r(this,this.parent(),b);return this.data("we7_validator",c)}else{return this.attr("novalidate","novalidate").each(function(){var d=a(this);c=new r(d.find(":input"),d,b);d.data("we7_validator",c)})}}})(jQuery);
