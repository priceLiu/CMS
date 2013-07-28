<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidatorManage.aspx.cs"
    MasterPageFile="~/Admin/theme/classic/content.Master" Inherits="We7.CMS.Web.Admin.ContentModel.ValidatorManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyContentPlaceHolder" runat="server">
    <style>
        .ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button
        {
            font-family: Verdana,Arial,sans-serif;
            font-size: 1em;
        }
        .delete-rul
        {
            width: 20px;
        }
    </style>
    <script type="text/javascript">
        //验证规则
        var rules = [];
        var currentRules = [];
        function Init() {
            rules = { operator: [{ operate: "AND" }, { operate: "OR"}], rules: [
            { rule: "min", type: "min", readonly: false, val: "", txt: "最小值" },
            { rule: "max", type: "max", readonly: false, val: "", txt: "最大值" },
            { rule: "minlength", type: "minlength", readonly: false, val: "", txt: "最小长度" },
            { rule: "maxlength", type: "maxlength", readonly: false, val: "", txt: "最大长度" },
            { rule: "required", type: "required", readonly: true, val: "required", txt: "必填" },
            { rule: "data-type", type: "Email", readonly: true, val: "email", txt: "Email" },
            { rule: "data-type", type: "Number", readonly: true, val: "number", txt: "数字" },
            { rule: "data-type", type: "Url", readonly: true, val: "url", txt: "Url" },
            { rule: "pattern", type: "Pattern", readonly: false, val: "", txt: "正则", params: [{ key: "", val: ""}]}]
            };
            $(".add-rule").live("click", function () {

                createTable({ op: $("select.opsel").val(), rule: "required", type: "required", readonly: true, val: "required", txt: "必填" });

            });
            var rule = we7.queryString("rule");
            if (!we7.isUndef(rule) && rule.length > 0) {
                currentRules = JSON.parse(rule);
                $.each(currentRules, function (i) {
                    createTable(currentRules[i]);
                });
            }
            else {
                createTable({ op: $("select.opsel").val(), rule: "required", type: "required", readonly: true, val: "required", txt: "必填" });
            }

            $("#save").live("click", function () {
                currentRules = [];
                $("tr.columns").each(function (i) {
                    if ($(this).find("input[name=rule-op]").length == 1)
                    //GTODO:插入前判断是否有重复值

                        currentRules.push({ op: $(this).find("input[name=rule-op]").val(), rule: $(this).find("select[name=select-rule]").val(), val: $(this).find("input[name=rule-val]").val(), type: $(this).find("input[name=rule-type]").val() });
                });

                window.parent.getValidator(currentRules.length > 0 ? currentRules : "");
            });
            $("#reset").live("click", function () {
                currentRules = [];
                $("tr.columns").each(function () { $(this).remove(); });
            });

        }
        function Selector(text) {
            var p;
            $.each(rules.rules, function (e) {
                p = rules.rules[e];
                if (p.txt === text) {
                    return false;
                }
            });
            return p;
        }

        function SelectChange(select) {
            var currentRule = Selector(select.find("option:selected").text());
            if (currentRule) {
                var t = select.parent().parent().find("input[name=rule-val]");
                if (t) {
                    t.val(currentRule.val);
                    t.attr("disabled", currentRule.readonly);
                }
                select.parent().parent().find("input[name=rule-type]").val(currentRule.type);
            }
        }

        function createTable(obj) {
            var b = $("<tr class='columns' ></tr>");
            var l = "";
            var p;
            var n;
            var op;
            b.append("<td class='first'></td>");
            l = $("<td ></td>");
            b.append(l);
            op = $("<input type='hidden' value='" + (obj.op) + "' name='rule-op' >");
            l.append(op);
            op = $("<input type='hidden' value='" + (obj.type) + "' name='rule-type' >");
            l.append(op);
            op = $("<select name='select-rule'></select>");
            op.bind("change", function () {
                SelectChange($(this));
            });
            l.append(op);

            $.each(rules.rules, function (e) {
                p = rules.rules[e];

                var isThis = obj.type == p.type ? true : false;
                if (isThis)
                    obj.readonly = p.readonly;
                //判断是否已经选择
                l += "<option  value='" + p.rule + "'" + (isThis ? "selected='selected'" : "") + ">" + p.txt + "</option>";
            });
            op.append(l);

            l = $("<td class='operators'></td>");
            b.append(l);
            l = $("<td></td>");
            b.append(l);


            l = $("<td class='data'></td>");
            b.append(l);
            l.append('<input type="text" name="rule-val"  ' + (obj.readonly ? 'disabled="disabled"' : '') + ' value="' + (obj.val ? obj.val : '') + '" />');

            n = $("　<input type='button' value='-' title='删除' class='fm-button delete-rule ui-del'/>");
            l.append(n);
            n.bind("click", function () {
                b.remove();
                return false;
            });
            $(".group", "#fbox_jqgridlist").append(b);
        }
        
    </script>
    <div id="mainContent">
        <div class="ui-jqdialog-content ui-widget-content" id="searchcntfbox_jqgridlist">
            <span>
                <div id="fbox_jqgridlist" class="searchFilter" style="overflow: auto">
                    <table class="group ui-widget ui-widget-content" style="border: 0px none;">
                        <tbody>
                            <tr class="error" style="display: none;">
                                <th colspan="5" class="ui-state-error" align="left">
                                </th>
                            </tr>
                            <tr>
                                <th colspan="5" align="left">
                                    <select class="opsel" style="display:none">
                                        <option value="AND" selected="selected">AND</option>
                                        <!--GTODO:可以支持or这种验证规则-->
                                        <!--<option value="OR">OR</option>-->
                                    </select><span style="padding-left:10px"><input type="button" value="添加" title="Add rule" class="add-rule ui-add fm-button"></span>
                                </th>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <table class="EditTable" style="border: 0px none; margin-top: 5px" id="fbox_jqgridlist_2">
                    <tbody>
                        <tr>
                            <td colspan="2">
                                <hr class="ui-widget-content" style="margin: 1px">
                            </td>
                        </tr>
                        <tr>
                            <td class="EditButton" style="text-align: left">
                                <a href="javascript:void(0)" id="reset" class="fm-button ui-state-default ui-corner-all fm-button-icon-left ui-search">
                                    <span class="ui-icon ui-icon-arrowreturnthick-1-w"></span>重置</a>
                            </td>
                            <td class="EditButton">
                                <a href="javascript:void(0)" id="save" class="fm-button ui-state-default ui-corner-all fm-button-icon-right ui-reset">
                                    <span class="ui-icon ui-icon-check"></span>保存</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </span>
        </div>
    </div>
    <script type="text/javascript" src="/scripts/we7/we7.loader.dev.js">
    </script>
    <script type="text/javascript">
        Init();
    </script>
</asp:Content>
