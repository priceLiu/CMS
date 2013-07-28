///<reference path="../jQuery/jquery-1.4.2.min.js" />
///<reference path="we7.loader.dev.js" />

(function ($) {
	var templateEngine,cache = {};

	function templateEngine(elem) {
			var tokens = {start:'<?', end:'?>'}, code;
			function buildFn() {
				return function(data){			
					var key, keys=[], values = [];
					
					function isIlegal(name){
							if(/^[\d]/.test(name)){
								return false;
							}
							if(!(/^[\$a-z_][a-z\$0-9_]*/i).test(name)){
								return false;
							}
							if ((/^(break|case|catch|continue|debugger|default|delete|do|else|finally|for|function|if|in|instanceof|new|return|switch|this|throw|try|typeof|var|void|while|with)$/)
								.test(name)){
									return false;
							}
							return true;
					}
					
					for(key in data){
						if( isIlegal(key) ){
							keys.push(key);
							values.push(data[key]);
						}
					}
					
					return new Function(keys, arguments.callee.code).apply(data,values);
				};
			}
			
			var tmplAttr = "rendertmpl", id, fn, html, rand = (+ new Date), vname = '__p' + rand;  // use a random variable name,  http://www.planeart.cn/?p=1594
			fn = we7.isStr(elem) ? (html = elem, buildFn()) : (elem = $(elem), id = elem.attr(tmplAttr)) && cache[id] ? cache[id] : elem.attr(tmplAttr, id = 'tmpl_' + rand) && (html = elem.html(), cache[id] = buildFn());
			fn.code = (!we7.isStr(elem) && cache[id].code) || "var " + vname + "=[],echo=function(){"+ vname +".push.apply("+ vname +",arguments);};"+vname+".push('" +					// modified 'object' to 'this'
				html.replace(/(\\)/g,"\\\\")			// #BUG fixed: can not process slashes
					  .replace(/(\<\s*\/[^>]+\>)[\n\r\t\s]+(?=\<[^>]+\>)/g, "$1")			// 注意，将所有换行、TAB替换，会对HTML格式产生不可控的影响？且要求模板 Javascript 没有注释、分号齐全
					  .replace(/[\r\n\t]/g,"")
					  .split(tokens.start).join("\t")
					  .replace(new RegExp("((^|\\" + tokens.end + ")[^\t]*)'", 'g'), function (a) { return a.replace(/(')/g, "\r") }) // #BUG fixed: can not process multi qoutes
					  .replace(new RegExp("\t=(.*?)\\" + tokens.end,'g'), "',$1,'")
					  .split("\t").join("');")
					  .split(tokens.end).join( vname +".push('")
					  .split("\r").join("\\'")
				+ "');return "+ vname +".join('');";
			return fn;
	}
	
	var renderMode = {
		"array": 0					// 数组、集合，循环模板呈现
		, "arrayLike": 1			// 类似 array 的对象（之后会将其构建为真正的 array）
		, "arguments": 2			// arguments 或类似结构的对象，内部使用 slice 使其变成 array
		, "object": -1				// 将对象直接呈现（即使是集合，也不循环）
	};
	function repeat(opts, data, mode) {
		mode = we7.isUndef(mode) ? opts.mode : mode, tmpl = opts.tmplEngine || templateEngine(opts.template);
		if (we7.isUndef(mode)) { mode = 0 } else if (we7.isStr(mode)) { mode = we7.isUndef(renderMode[mode]) ? 0 : renderMode[mode]; }

		!opts.tmplEngine && (opts.tmplEngine = tmpl);
		(mode == 1 && (data = $.makeArray(data))) || (mode == 2 && (data = [].slice.apply(data)));
		return mode < 0 ? tmpl(data) : (function () {
			var i, html = [];
			for (i = 0; i < data.length; i++) {
				html.push(tmpl(data[i]));
			}
			return html.join('');
		})();
	}
	function renderProxy(elem, data, options) {
		var el = elem, self = this, fire = $(this);
		this.data = data;
		options = $.extend({ mode: 0, autoRender: true }, options);
		options.ajax = we7.isStr(data) ? true : false;
		options.tmplEngine = null;

		$.each("onBeforeLoad,onBeforeRender,onLoad,onRender,onError,onRender".split(','), function (i, event) {
			self[event] = function (fn) {
				fire.bind(event, fn);
			};
			if (we7.isFunc(options[event])) {
				fire.bind(event, options[event]);
			}
		});
		function trigger(type, args) {
			var e = $.Event(type), ret;
			ret = fire.trigger(e, args);
			return e.isDefaultPrevented() ? false : we7.isUndef(e.result) ? true : e.result;
		}
		this.render = function (data, mode) {
			var ret, dMode;
			if (we7.isN(data) && we7.isUndef(mode)){
				mode = data; 
				data = this.data;
			}else{
				data = data || this.data;
				if(!this.data){
					this.data = data;
				}
			}
			
			dMode = typeof data === "object" ? (we7.isArray(data) ? 0 : -1) : 0;
			function prep(m){
				return we7.isN(m) ? m : ((!we7.isUndef(renderMode[m]) && renderMode[m]) ||  dMode);
			}				
			we7.isUndef(mode) ? (mode = options.mode) : (we7.isUndef(options.mode) && (options.mode = mode));
			mode = prep(mode);
			options.mode = prep(options.mode);
			(mode === 1 && (data = $.makeArray(data))) || (mode === 2 && (data = [].slice.apply(data)));
			
			try {
				ret = repeat(options, data, mode);
			} catch (x) { trigger("onError", [{ source: x, message: "Render Error", code: -100 }, data, options, mode]); return; }
			if (trigger("onBeforeRender", [ret, data, options, mode])) {
				el.html(ret);
				trigger("onRender", [ret, data, options, mode]);
			}
			return ret;
		};
		var ajaxOpts, oldSuccess;
		if (options.ajax) {
			options.url = this.data;
			if (trigger("onBeforeLoad", [this.data, options])) {
				ajaxOpts = $.extend({
					url: options.url,
					type: 'GET',
					cache: false,
					dataType: "json",
					error: function (xhr, status, err) {
						trigger("onError", [{ source: err, message: "Load Error", code: 110 }, options, xhr])
					}
				}, options.ajaxOptions);
				ajaxOpts.success && (oldSuccess = ajaxOpts.success);
				ajaxOpts.success = function (d) {
					var _d = trigger("onLoad", [d, options]);
					self.data = (typeof _d === "boolean") ? d : _d;
					if (oldSuccess) { oldSuccess.apply(this, arguments); }
					options.autoRender && self.render();
				};
				$.ajax(ajaxOpts);
			}
		} else {
			options.autoRender && this.render();
		}
		return this;
	}
	we7.extend({ "render": function (data, template, options) {
			var isTmpl = we7.isStr(template) || !we7.isUndef(template.jquery) || !we7.isUndef(template.nodeType); 	// 如果为 字符串[模板字面值] 或者 jQuery 或者为 DOM [取模板来源DOM]，认为是模板
			options = options || {};
			if (we7.isN(options)) { options = { mode: options} }
			isTmpl ? (options.template = template) : (options = $.extend(template, options));

			return new renderProxy(this.jquery, data, options);
		}
	});
	we7.renderMode = renderMode;
	we7.render = function (json, tmpl, options) {
		return we7("<div>").render(json, tmpl, options);
	};
	we7.render.tmplFromObsolete = function (str) {
		return str
			.replace(/\$\{([^\}]*)\}/g, "{{html $1}}")
			.replace(/\{\{\/if\}\}/g, "<?}?>")
			.replace(/\{\{if\s+(?:\(?((?:[^\}]|\}(?!\}))*?)\)?)\s*\}\}/g, "<?if($1){?>")
			.replace(/\{\{else\s*\}\}/g, "<?}else{?>")
			.replace(/\{\{else\s+(?:\(?((?:[^\}]|\}(?!\}))*?)\)?)\s*\}\}/g, "<?}else if($1){?>")
			.replace(/\{\{(?:html|=)\s+(?:\(?((?:[^\}]|\}(?!\}))*)\)?)\s*\}\}/g, "<?=$1?>");
	};
})(jQuery);