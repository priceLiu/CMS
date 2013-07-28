;jQuery.widgetSearchConf = {
    ajaxUrl: "/Admin/DataControlUI/FieldControl/Order/OrdersSelection.ashx",
    version: "1.0.0",
    auther: "wolfweb",
    descript: '部件查询配置jQuery插件',
    defaultVal: {
        TableName: "",                    //表名
        TableDesc: "",                    //表描述  
        Criteria: {},
        maxSize: 100,                     //可用排序的列最大长度
        removed: false,                   //移除某项排序条件 (callback(当前被移除的排序条件))
        inserted: false,                  //插入某项排序条件 (callback(当前最新的排序条件集合))
        preinit: false,                   //开始加载         
        inited: false,                    //加载完成
        container: "",                    //容器选择器
        ajaxfields: this.ajaxUrl,
        selector: "",                     //排序对象json ID选择器
        fieldContainer: "",
        searchForKeydown: ""
    },
    criteriaType: {
        "包含": "Like",
        "大于": "MoreThan",
        "大于或等于": "MoreThanEquals",
        "小于": "LessThan",
        "小于或等于": "LessThanEquals",
        "等于": "Equals",
        "不等于": "NotEquals",
        "不包含": "NotLike",
        "为null": "IsNull",
        "不为null": "IsNotNull"
    },
    keyValue: function (obj) {
        this.key = "";
        this.value = "";

        $.extend(this, obj);
        return this;
    },
    initItem: function (options) {
        $.extend(this.defaultVal, options);

        var _self = this;

        var defaultVal = this.defaultVal;

        var deleteItem = function () {
            var obj = $(this).attr("rel");
            var criterias = JSON.parse(decodeURIComponent($(defaultVal.selector).val()));
            for (var it in criterias.CriteriaJsonObjects) {
                if (criterias.CriteriaJsonObjects[it].Name == obj) {
                    criterias.CriteriaJsonObjects.splice(it, 1);
                    break;
                }
            }
            $(defaultVal.selector).val(encodeURIComponent(JSON.stringify(criterias)));
        };

        var renderCriteriaItem = function (v) {
            var _criteriaType = _self.getCirteriaType(v.CriteriaType);
            var _span = $("<span>").addClass("tag").attr("rel", v.Name)
                .html("查询：" + (v.Description || v.Name) + " " + _criteriaType.key + " '" + v.Value + "'&nbsp;&nbsp;")
                .appendTo($(defaultVal.selector).find(".tagsinput"));
            $("<a>").attr({ "title": "删除查询", "rel": v.Name }).html("x").appendTo(_span).click(deleteItem);
        };

        var renderHtml = function () {
            $(defaultVal.selector).html("");
            if ($(defaultVal.selector).find(".tagsinput").length == 0) {
                $("<div>").addClass("tagsinput").appendTo($(defaultVal.selector));
            }
            for (var it in defaultVal.Criteria) {
                renderCriteriaItem(defaultVal.Criteria[it]);
            }
        };

        var setValue = function () {
            var criteriaObj = JSON.parse(decodeURIComponent($(defaultVal.selector).val()));
            criteriaObj.CriteriaJsonObjects = [];
            for (var it in defaultVal.Criteria) {
                criteriaObj.CriteriaJsonObjects.push(defaultVal.Criteria[it]);
            }

            $(defaultVal.selector).val(encodeURIComponent(JSON.stringify(criteriaObj)));
        };

        renderHtml();
        setValue();

    },
    initSearch: function (options) {
        $.extend(this.defaultVal, options);

        var criteriaMode = { And: "And", Or: "Or" };

        var adorns = {
            None: 0,
            Average: 1,
            Distinct: 2,
            Maximum: 3,
            Minimum: 4,
            Sum: 5,
            Substring: 6,
            Total: 7
        };

        var criteriaJson = function (obj) {
            this.Name = ""; //字段名
            this.Value = ""; //值
            this.ParamsType = 0; //参数类型
            this.ValueType = 0; //值类型
            this.CriteriaType = 0; //查询类型

            $.extend(this, obj);
            return this;
        };

        var criteriaType = this.criteriaType;

        var defaultVal = this.defaultVal;

        var criteriaTypeSelect = function () {
            var select = $("<select>").attr("id", "sreachType").bind("change", function () {
                $(this).parent("li").css("height", 50);
            }).bind("click", function () {
                $(this).parent("li").css("height", 200);
            });

            for (var item in criteriaType) {
                $("<option>").val(criteriaType[item]).html(item).appendTo(select);
            }
            return select;
        };

        var requestType = function () {
            var select = $("<select>").attr("id", "reqType").bind("change", function () {
                $(this).parent("li").css("height", 50);
            }).bind("click", function () {
                $(this).parent("li").css("height", 120);
            });

            $("<option>").val(2).html("常量").appendTo(select);
            $("<option>").val(0).html("来自URL参数").appendTo(select);
            $("<option>").val(1).html("部件属性").appendTo(select);
            return select;
        };

        var notify = function (c, msg) {
            $("<p>").attr("id", "_validateMsg").css({ "background-color": "red", "color": "white", "padding": "3px" }).html(msg).appendTo(c);

            setTimeout(function () {
                $("#_validateMsg").fadeOut().remove();
            }, 1000);
        };

        var submit = function () {
            var _container = $(this).parent("li");
            var reqTypeVal = _container.find("#reqType").val();
            if (reqTypeVal.length > 0) {
                var criteriaObj = defaultVal.Criteria;
                var searchObj = JSON.parse(decodeURIComponent(_container.attr("rel")));
                if (criteriaObj == null)
                    criteriaObj = [];

                searchObj.Value = _container.find("#edtParms").val();
                searchObj.ParamsType = _container.find("#reqType").val();
                searchObj.CriteriaType = _container.find("#sreachType").val();

                var index = checkFiledExist(searchObj);

                if (index > -1)
                    criteriaObj[index] = searchObj;
                else
                    criteriaObj.push(searchObj);

                notify(_container, "添加成功！");
            } else {
                notify(_container, "参数类型必填！");
            }
        };

        var checkFiledExist = function (v) {
            var criterias = defaultVal.Criteria;
            for (var it in criterias) {
                if (criterias[it].Name == v.Name) {
                    return it;
                }
            }
            return -1;
        };

        var renderHtml = function (ajaxUrl) {
            $.ajax({
                type: "get",
                url: ajaxUrl,
                data: "act=searchInfo&criteria=" + encodeURIComponent(JSON.stringify({ TableName: defaultVal.TableName, TableDesc: defaultVal.TableDesc, CriteriaJsonObjects: defaultVal.Criteria })),
                dataType: "json",
                success: function (data) {
                    data = {
                        code: data.code,         //操作代码 200成功,301未登录,500失败
                        message: data.massage,
                        result: data.result
                    };

                    if (data && data.code === 200) {
                        $("<div>").addClass("tagsinput").appendTo($(defaultVal.selector));

                        $(defaultVal.fieldContainer).append('<ul id="searchfieldsinfo" class="mcdropdown_menu">');
                        $.each(data.result, function () {
                            var _criteria = new criteriaJson({ Name: this.Field, ValueType: this.Type, Description: this.Description });

                            var index = checkFiledExist(_criteria);
                            var fieldExist = index > -1;

                            var htmlContainer = $("<li>").attr("rel", this.Field).html(this.Field + ":<b>" + this.Description + "</b>");
                            var ulContainer = $("<ul>").appendTo(htmlContainer).hide();
                            var liContainer = $("<li>").attr("rel", encodeURIComponent(JSON.stringify(_criteria))).appendTo(ulContainer);
                            $("<label>").html("查询类型：").appendTo(liContainer);
                            criteriaTypeSelect().appendTo(liContainer); //查询类型

                            $("<label>").html("请求参数：").appendTo(liContainer);
                            $("<input>").attr("id", "edtParms").css("width", "100px").appendTo(liContainer).val(fieldExist ? defaultVal.Criteria[index].Value : ""); //请求参数
                            liContainer.append("<br />");

                            $("<label>").html("参数类型：").appendTo(liContainer);
                            requestType().appendTo(liContainer); //参数类型


                            $("<input>").attr("type", "button").attr("id", "edtPost").appendTo(liContainer).val("增加此项条件").click(submit);

                            if (fieldExist) {
                                liContainer.find("#sreachType").val(defaultVal.Criteria[index].CriteriaType);
                                liContainer.find("#reqType").get(0).selectedIndex = defaultVal.Criteria[index].ParamsType + 1;
                            }

                            $(defaultVal.fieldContainer).find("#searchfieldsinfo").append(htmlContainer);

                            $(">li", $(defaultVal.fieldContainer).find("#searchfieldsinfo")).hover(function () {
                                $(this).children("ul").show();
                            }, function () {
                                $(this).children("ul").hide();
                            });
                        });
                    } else {
                        alert(data.massage);
                    }
                }
            });
        };

        var searchFiled = function () {
            $(defaultVal.searchForKeydown).bind("keyup", function (e) {
                var value = $(this).val();
                $(defaultVal.fieldContainer).children("ul").children("li").each(function () {
                    var re = new RegExp(value, "gi");
                    if (!re.test($(this).text())) {
                        $(this).css("display", "none");
                    }
                    else {
                        $(this).css("display", "block");
                    }
                });
            });
        };

        renderHtml(this.ajaxUrl);

        searchFiled();
    },
    getCirteriaType: function (v) {
        var count = 1;
        for (var it in this.criteriaType) {
            if (this.criteriaType[it] == v || it == v || count == v) {
                return new this.keyValue({ key: it, value: this.criteriaType[it] });
            }
            count++;
        }
        return null;
    }
};