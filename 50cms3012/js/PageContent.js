
$(function () {
    //内容分页
    
    var pagecontent = $("#pagecontent").html();
    var strs = new Array();
    //正则

    //var regstr = /<hr .* class="ke-pagebreak">/i;
    
    var regstr = new RegExp('<HR .*ke-pagebreak.*>','i');
    strs = pagecontent.split(regstr);
    if (strs.length > 1) {
        var pageText = "<div id='nrpg' style='clear:both;width:720px; float:left; margin-top:10px;'>";
        //alert(strs.length);
        for (var i = 0; i < strs.length; i++) {
            pageText += "<a href='javascript:showpage(" + i + ")' style='border:solid 1px #d4dbf4; margin-left:10px; width:15px; height:20px; float:left; display:block; line-height:20px; text-align:center;'>" + (i + 1) + "</a>";
        }
		$("#pagecontent").html(strs[0]);
        $("#pagecontent").after(pageText+"</div>");
		$("#nrpg a").eq(0).css({background:"#2d68b0",color:"#FFF"});
}
$(".ke-pagebreak").hide();
    $.fn.showpage = function (pageno) {
        $("#pagecontent").html(strs[pageno]);
		$("#nrpg a").css({background:"#FFF",color:"#666666"});
		$("#nrpg a").eq(pageno).css({background:"#2d68b0",color:"#FFF"});
        //alert(pageno);

    }
})
function showpage(pageno) {
    $().showpage(pageno);	
   }