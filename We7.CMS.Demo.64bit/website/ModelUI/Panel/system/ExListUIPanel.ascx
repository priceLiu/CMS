<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ExListUIPanel.ascx.cs"
    Inherits="We7.Model.UI.Panel.system.ExListUIPanel" %>
<%@ Register Src="../../Container/system/SimpleCommand.ascx" TagName="SimpleCommand"
    TagPrefix="uc6" %>
<asp:Panel ID="plList" runat="server">
    <asp:PlaceHolder ID="phCommand" runat="server"></asp:PlaceHolder>
    <input type="hidden" id="ids" name="ids" />
    <!--操作栏开始-->
    <div class="toolbar2">
        <li class="smallButton4"><a id="add">新增</a></li>
        <li class="smallButton4"><a id="publish">发布</a> </li>
        <li class="smallButton4"><a id="unpublish">取消发布</a> </li>
        <li class="smallButton4"><a id="audit">提交审核</a> </li>
        <!--
        <li runat="server" id="MoveToSpan" class="smallButton4"><a id="moveto">移动到...</a>
            <%--<asp:HyperLink ID="MoveToHyperLink" NavigateUrl="javascript:selectChannels();" runat="server">
           移动到...</asp:HyperLink>
		<asp:LinkButton ID="lnkMoveTo" CommandName="moveTo" CommandArgument="multirow" runat="server"
			Style="display: none" OnClick="lnkMoveTo_Click">移动到辅助按钮</asp:LinkButton>
		<asp:HiddenField ID="hfMoveTo" runat="server" />--%>
        </li>
        <li class="smallButton4" runat="server" id="LinkToSpan"><a id="sendsubject">发到专题...</a>
            <%--<asp:HyperLink ID="HyperLinkCreateRefer" NavigateUrl="javascript:selectChannels('linkto');"
			runat="server">
           发到专题...</asp:HyperLink>
		<asp:LinkButton ID="lnkLinkTo" CommandName="linkTo" CommandArgument="multirow" runat="server"
			Style="display: none" OnClick="lnkLinkTo_Click">发布到专题</asp:LinkButton>
		<asp:HiddenField ID="hfLinkTo" runat="server" />--%>
        </li>
        -->
        <li class="smallButton4"><a id="top">置顶</a> </li>
        <li class="smallButton4"><a id="untop">取消置顶</a> </li>
        <!--
        <li class="smallButton6">
            <%--<div id="button">
			<a href="">添加标签▼</a></div>
		<asp:LinkButton ID="lnkAddTag" CommandName="addTag" CommandArgument="multirow" runat="server"
			Style="display: none" OnClick="lnkAddTag_Click">添加标签辅助按钮</asp:LinkButton>
		<asp:HiddenField ID="hfTag" runat="server" />--%>
        </li>
        -->
        <li class="smallButton4"><a id="delete">删除</a> </li>
        <li class="smallButton4"><a id="refresh">刷新</a> </li>
    </div>
    <!--操作栏结束-->
    <!--查询开始-->
   <div class="toolbar2">
        <div id="con" style="padding-top:5px;">
            <%=ConditionInnerHtml %>
        </div>
         <li class="smallButton4"><a id="bindNow">查询</a> </li>
    </div>

    <ul class="subsubsub" style="cursor:pointer">
        <li >
            <a id="Getall" class="current">全部<span class="count"></span></a>|</li><li>
                    <a id="GetyetPublish">已发布<span class="count"></span></a>|</li><li>
                        <a id="Getdraft">草稿<span class="count"></span></a>|</li><li>
                            <a id="GetAudit">审核中<span class="count"></span></a>|</li><li>
                                <a id="GetPast">过期<span class="count"></span></a></li>           
    </ul>
    <div class="clear"> </div>
    <!--查询结束-->
    <!--列表开始-->
    <div id="list">
        <table id="ModelList" style="display: none">
            <tr>
                <td header='<input id="selectAll" type="checkbox"  onclick="selectAlls(this)" style="margin:6px;">' style='vertical-align: middle; width: 30px;'><input id="chkID" name="chk" type="checkbox" value="${ID}" style="margin: 6px;" onclick="setIds()" /></td> <%=this.TableContent%></tr>
        </table>
    </div>
    <!--列表结束-->    
<link href="/scripts/we7/css/we7.tip.css" rel="Stylesheet" />
<script type="text/javascript" src="/scripts/we7/we7.loader.js"></script>
    <script type="text/javascript">
        var Commond={} , form ;
        Commond.AjaxSend=function(bind,conn){
            if (conn.id) {
                var op=bind.options();
                var url=op.url;
	            var value = {
	            "_tb" : op.postData._tb,
	            "_oper": conn.type,
	            "_id" : conn.id,
                "_xml":"ModelXml",
                "_c":conn.updata,
                "_model":"<%=HttpContext.Current.Request.QueryString["model"]%>"
	            };
	            $.ajax({
		            type:'POST',
		            url: url,
		            data: value,
                    beforeSend:function(){we7.loading('我正在努力的干活儿...!')},
		            success:function(data,status){
                        var json =eval("("+data+")");
			            we7.info(json.message);
			            bind.refresh();
                        $("#selectAll").attr("checked",false);
		            }
	            });
            }
            else we7.info('抱歉，您没有选择任何项。');
        };
            
        Commond.AjaxSend.Expand=function(bind,id){
            var op=bind.options();
            var url="/admin/Ajax/BusinessSubmit/ExpandHandle/ContentModel/SubmitAudit.ashx";
	        var value = {
            "_tb" : op.postData._tb,
		    "_id" : id,
            "_model":"<%=HttpContext.Current.Request.QueryString["model"]%>"
	        };
	        $.ajax({
		        type:'POST',
		        url: url,
		        data: value,
                beforeSend:function(){we7.loading('我正在努力的干活儿...!')},
		        success:function(data,status){
                    var json =eval("("+data+")");
			        we7.info(json.message);
			        bind.refresh();
                    $("#selectAll").attr("checked",false);
		        }
	        })
        };
        Commond.AjaxSend.GetModelCount=function(bind){
         var op=bind.options();
            var url="/admin/Ajax/BusinessSubmit/ExpandHandle/ContentModel/GetModelCount.ashx";
	        var value = {
            "_tb" : op.postData._tb
	        };
	        $.ajax({
		        type:'POST',
		        url: url,
		        data: value,
		        success:function(data,status){
                    var json = eval("("+data+")");
			        $("#GetyetPublish").find("span:first").text("("+json.yetPublish+")");
                    $("#Getdraft").find("span:first").text("("+json.draft+")");
                    $("#GetAudit").find("span:first").text("("+json.Checking+")");
                    $("#GetPast").find("span:first").text("("+json.Overdued+")");
                    $("#Getall").find("span:first").text("("+json.total+")");
		        }
	        })
        };
        Commond.AjaxSend.Operate=function(bind,bindDestination,state){
         var cond=[];cond.push(new we7.BindCondition("state", we7.bindVerb.equals, state));
            var condition=$.extend({},bindDestination,{conditions:cond});
            bind.options("postData",$.extend({},bind.options("postData"),condition.toParam()));
            bind.refresh();
        }

        Commond.Add=function(){
            window.top.location.href="/admin/AddIns/ModelEditor.aspx?notiframe=<%=HttpContext.Current.Request.QueryString["notiframe"]%>&model=<%=HttpContext.Current.Request.QueryString["model"]%>&panel=edit&ID=<%=We7Helper.CreateNewID() %>";
        };
        Commond.Publish=function(bind,id){
            var conn={};
            conn.id=id;conn.updata="state@6@1";
            conn.type=3;
            Commond.AjaxSend(bind,conn);
        };	
        Commond.Unpublish=function(bind,id){
            var conn={};
            conn.id=id;conn.updata="state@6@0";
            conn.type=3;
            Commond.AjaxSend(bind,conn);
        };
        Commond.Audit=function(bind,id){
            Commond.AjaxSend.Expand(bind,id);
        };
        Commond.Moveto=function(id){
        if(!form){
          form = we7.form('/admin/ChannelList.aspx',{
                iframe:true,
                size:{
                    width:700,
                    height:500
                }
                ,title:"选择栏目"
                ,scrolling:true
                ,position:"center"
            });
            }
            form.show();
            var iframe = $("iframe[rel=we7form_iframe]");
                iframe.bind("load",function(){
                    iframe[0].contentWindow.onSelectHyperLinkClick=function(id,fullpath){
                        //todo:处理逻辑

                        form.close();
                    }
	                iframe[0].contentWindow.onCancelHyperLinkClick=function(){
                        form.close();
                    }
            });
    
            
        }; //暂无,待添加
        Commond.Sendsubject=function(id){
        alert("sendsubject");
        };
        Commond.Top=function(bind,id){
            var conn={};
            conn.id=id;conn.updata="IsShow@6@1";
             conn.type=3;
            Commond.AjaxSend(bind,conn);
        };
        Commond.Untop=function(bind,id){
            var conn={};
            conn.id=id;conn.updata="IsShow@6@0";
            conn.type=3;
            Commond.AjaxSend(bind,conn);
        };
        Commond.Delete=function(bind,id){
            var conn={};
            conn.id=id;
            conn.type=1;
            Commond.AjaxSend(bind,conn);
        };
        Commond.Refresh=function(bind){
            bind.refresh();
        };

        function setIds(){
	        var val = [];
	        $("[name=chk]").each(function(){
		        if(this.checked){
			        val.push($(this).val());
		        }
	        });
	        $('#ids').val(val.join(','));
        }

        function selectAlls(a){
           $("#ModelList input[type=checkbox]").attr("checked",a.checked);
           setIds();
        }

        we7.load.ready(function () {
            // 定义条件
            var condition=[];

            // 定义要绑定的资源的目标
            var bindDestination = new we7.BindOption({
                tableName: "<%=TableName %>"
		        , fields: { <%=Fields %>
		        }
			    , sortField: "<%=SortField %>"
			    , sortOrder: "<%=SortOrder %>"
                , rows: 10
            });
            bindDestination.conditions=condition;

            var binder;

            //绑定过程
            function bindData() {
                var options = {
                    caption: "<%=Caption %>",
                    height: 220,
                    rowNum: 10,
                    autowidth: true,
                    deletableRow: false,
                    postData:{"_xml":"ModelXml","_model":"<%=HttpContext.Current.Request.QueryString["model"]%>","_join":"<%=Join %>"},
                    onLoad:function(e,data){
                        Commond.AjaxSend.GetModelCount(binder);
                    }
                };
               binder= we7("#ModelList").bind(bindDestination, options);

               
            }
            
            $("#bindNow").bind("click",function(){
                <%if (mp.EnableSingleTable) {%>
                condition=[];
                $("#con input").each(function(){
                if ($(this).val()) {
                    condition.push(new we7.BindCondition($(this).attr("field"),$(this).attr("queryType"),$(this).attr("queryType")==1?"%"+$(this).val()+"%":$(this).val()));
                }
                });
                bindDestination.conditions=condition;

                binder.options("postData",$.extend({},binder.options("postData"),bindDestination.toParam()));
                binder.refresh();
                <%} else{%>
                we7.info('查询功能需要在设置常规中启用“单表存储”并存储数据哦。');
                <%} %>
            });

            $("#add").bind("click",function(){
               Commond.Add();
            });
            $("#publish").bind("click",function(){
               Commond.Publish(binder,$("#ids").val());
            });
            $("#unpublish").bind("click",function(){
               Commond.Unpublish(binder,$("#ids").val());
            });
            $("#audit").bind("click",function(){
               Commond.Audit(binder,$("#ids").val());
            });
            $("#moveto").bind("click",function(){
               Commond.Moveto($("#ids").val());
            });
            $("#sendsubject").bind("click",function(){
               Commond.Sendsubject($("#ids").val());
            });
            $("#top").bind("click",function(){
               Commond.Top(binder,$("#ids").val());
            });
            $("#untop").bind("click",function(){
               Commond.Untop(binder,$("#ids").val());
            });
            $("#delete").bind("click",function(){
               Commond.Delete(binder,$("#ids").val());
                 Commond.Refresh(binder);
            });
            $("#refresh").bind("click",function(){
               Commond.Refresh(binder);
            });

            //选项过滤事件
             $("#Getall").bind("click",function(){
                binder.options("postData",bindDestination.toParam());
                binder.refresh();
            });
             $("#GetyetPublish").bind("click",function(){
                //todo:一种更加好的方式?
               Commond.AjaxSend.Operate(binder,bindDestination,"1");
               
            });
             $("#Getdraft").bind("click",function(){
                Commond.AjaxSend.Operate(binder,bindDestination,"0");
            });
             $("#GetAudit").bind("click",function(){
              Commond.AjaxSend.Operate(binder,bindDestination,"2");
            });
             $("#GetPast").bind("click",function(){
                Commond.AjaxSend.Operate(binder,bindDestination,"3");
            });

            $(document).ready(function () {
            
                bindData();
                $(".toolbar2").css("padding-bottom","30px");
               
//                var views=$("#ModelList a[type='view']");   //暂时不特殊处理。管理列
//                $(views).live("click",function(){
//                    var forms = we7.form($(this).attr('location'),{
//                    iframe:true,
//                    size:{
//                        width:700,
//                        height:500,
//                    }
//                    ,title:"<%=TableName %>"
//                    ,scrolling:true
//                    ,position:"center"
//                    });
//                    forms.show();
//                });
//                var edits=$("#ModelList a[type='edit']");
//                $(edits).live("click",function(){
//                    alert('edits');
//                });
            });
        });

    </script>
</asp:Panel>
