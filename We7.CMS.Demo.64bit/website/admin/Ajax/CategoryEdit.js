function checkKey(name, el) {
    jQuery.get("/Admin/Ajax/CategoryRepeatCheck.aspx?key=" + encodeURI(name) + "&type=1&r=" + new Date().getTime(), function(result) {
        el.style.display = "none";
        if(typeof result=="string") result = eval("(" + result + ")");
        if (result.responseText == "true") {
            el.style.display = "";
        } else {
            el.style.display = "检测出错" + result.message;
        }
    });
//        {
//        method: "get",
//        parameters: "key=" + encodeURI(name) + "&type=1&r=" + new Date().getTime(),
//        onSuccess: function(result) {
//            el.style.display = "none";
//            if (result.responseText == "true") {
//                el.style.display = "";
//            }
//        },
//        onFailure: function(result) {
//            alert("检测出错" + result.message);
//        }
//    });
}

function checkName(name, el) {
    jQuery.get("/Admin/Ajax/CategoryRepeatCheck.aspx?key=" + encodeURI(name) + "&type=0&r=" + new Date().getTime(), function(result) {
        el.style.display = "none";
        if (typeof result == "string") result = eval("(" + result + ")");
        if (result.responseText == "true") {
            el.style.display = "";
        } else {
            el.style.display = "检测出错" + result.message;
        }
    });
//    {
//        method: "get",
//        parameters: "key=" + encodeURI(name) + "&type=0&r=" + new Date().getTime(),
//        onSuccess: function(result) {
//            el.style.display = "none";
//            if (result.responseText == "true") {
//                el.style.display = "";
//            }
//        },
//        onFailure: function(result) {
//            alert("检测出错" + result.message);
//        }
//    });
}

function checkKey2(name, el) {
    var flag = { result: false };
    jQuery.get("/Admin/Ajax/CategoryRepeatCheck.aspx?key=" + encodeURI(name) + "&type=1&r=" + new Date().getTime(), function(result) {
        el.style.display = "none";
        if (typeof result == "string") result = eval("(" + result + ")");
        if (result.responseText == "true") {
            el.style.display = "";
            flag.result = true;
        } else {
            alert("检测出错" + result.message);
        }
    });
//    {
//        method: "get",
//        asynchronous: false,
//        parameters: "key=" + encodeURI(name) + "&type=1&r=" + new Date().getTime(),
//        onSuccess: function(result) {

//            el.style.display = "none";
//            if (result.responseText == "true") {
//                el.style.display = "";
//                flag = true;
//            }
//        },
//        onFailure: function(result) {
//            alert("检测出错" + result.message);
//        }
//    });
    return flag.result;
}

function checkName2(name, el) {
    var flag = { result: false };
    jQuery.get("/Admin/Ajax/CategoryRepeatCheck.aspx?key=" + encodeURI(name) + "&type=0&r=" + new Date().getTime(), function(result) {
        el.style.display = "none";
        if (typeof result == "string") result = eval("(" + result + ")");
        if (result.responseText == "true") {
            el.style.display = "";
            flag.result = true;
        } else {
            alert("检测出错" + result.message);
        }
    });
    //    {
    //        method: "get",
    //        asynchronous: false,
    //        parameters: "key=" + encodeURI(name) + "&type=0&r=" + new Date().getTime(),
    //        onSuccess: function(result) {
    //            el.style.display = "none";
    //            if (result.responseText == "true") {
    //                el.style.display = "";
    //                flag = true;
    //            }
    //        },
    //        onFailure: function(result) {
    //            alert("检测出错" + result.message);
    //        }
    //    });
    return flag.result;
}