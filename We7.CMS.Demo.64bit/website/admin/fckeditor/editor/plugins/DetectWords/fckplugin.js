/*
* FCKeditor - The text editor for internet
* Copyright (C) 2003-2006 Frederico Caldeira Knabben
* 
* Licensed under the terms of the GNU Lesser General Public License:
*         http://www.opensource.org/licenses/lgpl-license.php
* 
* For further information visit:
*         http://www.fckeditor.net/
* 
* "Support Open Source software. What about a donation today?"
* 
* File Name: fckplugin.js
*     Plugin for DetectWords background
*
* 
* File Authors:
*         Yogananthar Ananthapavan (rollbond@gmail.com)
*/


// Create the "DetectWords" toolbar button

var oDetectWordsItem = new FCKToolbarButton('DetectWords', FCKLang.DetectWords);


//设置按钮的图标路径

oDetectWordsItem.IconPath = FCKPlugins.Items['DetectWords'].Path + 'DetectWords.jpg';

//注册按钮项

FCKToolbarItems.RegisterItem('DetectWords', oDetectWordsItem);


// The object used for all DetectWords operations.

var FCKDetectWords = new Object();

FCKDetectWords = function (name) {
   
 this.Name = name;

}


//FCK_TRISTATE_ON为默认是选中状态

//下面的两个方法是实现接口的两个必须的方法，否则会报脚本错误

FCKDetectWords.prototype.GetState = function () {
    return FCK_TRISTATE_OFF;
}
//此方法是点击按钮后要完成的操作
FCKDetectWords.prototype.Execute = function () {
     DetectWords();
}
//以下都是实现功能的方法
function DetectWords() {
   
    var fckeditor = FCKeditorAPI.GetInstance("ctl00_MyContentPlaceHolder_ctl00_ContentTextBox");
  
    var str = fckeditor.GetHTML(); //这就是内容
  
    String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {
        
        if (!RegExp.prototype.isPrototypeOf(reallyDo)) 
        {
            return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
        } 
        else 
        {
            return this.replace(reallyDo, replaceWith);
        } 
    }
    //下面是敏感词
    //var words = ["89事件", "222"];
    //  alert(str);
    var words;
    window.parent.$.ajax({
        url: "/plugins/SensitiveWords/ui/getwords.aspx",
        dataType: "text",
        Type: "GET",
        async: false,
        success: function (msg) {
            words = msg.split('，');
            if (words.length == 0) {
                // alert("请安装敏感词插件或者增加敏感词库");
                alert("敏感词库为空");
                return;
            }
            //        if (words[0] == "89事件"&&words.length==1) {
            //        alert("请安装敏感词插件或者增加敏感词库");
            //        return;
            //     }
            for (var i = 0; i < words.length; i++) {

                // if (words[i] != "" || words[i] != " ") {

                // str = str.replace(words[i], "<b style='color:red;'>" + words[i] + "</b>")

                // }

                if (words[i] != "" || words[i] != " ") {
                    str = str.replaceAll(words[i], "<b style='color:red;'>" + words[i] + "</b>", true);
                }
            }

            fckeditor.SetHTML(str);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("敏感词库为空或者请先安装插件！");
        }

    });
   
 }
//alert(str);
// Register the related command
FCKCommands.RegisterCommand('DetectWords', new FCKDetectWords('DetectWords'));
