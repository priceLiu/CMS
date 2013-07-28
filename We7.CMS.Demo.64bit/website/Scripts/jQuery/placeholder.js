/// <reference path="jquery-1.4.2.min.js" />
/* File Created: 十一月 7, 2012 
   example : <input type="text" placeholder="电子邮件" />
   notice : 需要Jquery支持
*/
function supports_input_placeholder() {
    var i = document.createElement("input");
    return "placeholder" in i;
}

// 让不支持placeholder的浏览器实现此属性
(function ($) {
    var inputPlaceholder = $("input[placeholder],textarea[placeholder]");

    if (inputPlaceholder.length !== 0 && !supports_input_placeholder()) {
        var colorPlace = "#A9A9A9";
        $.each(inputPlaceholder, function (i) {
            var isUserEnter = 0; // 是否为用户输入内容,placeholder允许用户的输入和默认内容一样  
            var ph = $(this).attr("placeholder");
            var curColor = $(this).css("color");

            $(this).val(ph).css("color", colorPlace);
            
            $(this).focus(function () {
                if ($(this).val() == ph && !isUserEnter) $(this).val("").css("color", curColor);
            }).blur(function () {
                if ($(this).val() == "") {
                    $(this).val(ph).css("color", colorPlace);
                    isUserEnter = 0;
                }}).keyup(function () {
                            if ($(this).val() !== ph) isUserEnter = 1;
                    });
        });
    }
})(jQuery);