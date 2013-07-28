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
*     Plugin for KeyWords background
*
* 
* File Authors:
*         Yogananthar Ananthapavan (rollbond@gmail.com)
*/

// Create the "KeyWords" toolbar button
var oKeyWordsItem = new FCKToolbarButton('KeyWords', FCKLang.KeyWords);

//设置按钮的图标路径
oKeyWordsItem.IconPath = FCKPlugins.Items['KeyWords'].Path + 'KeyWords.jpg';
//注册按钮项
FCKToolbarItems.RegisterItem('KeyWords', oKeyWordsItem);

// The object used for all KeyWords operations.
var FCKKeyWords = new Object();

FCKKeyWords = function (name) {
    this.Name = name;
}

//FCK_TRISTATE_ON为默认是选中状态
//下面的两个方法是实现接口的两个必须的方法，否则会报脚本错误
FCKKeyWords.prototype.GetState = function () {

    return FCK_TRISTATE_OFF;
}

//此方法是点击按钮后要完成的操作
FCKKeyWords.prototype.Execute = function () {
    KeyWords();
}

//以下都是实现功能的方法
function KeyWords() {
   // var fckeditor = FCKeditorAPI.GetInstance("ctl00_MyContentPlaceHolder_ctl00_ContentTextBox");
   // var str = fckeditor.GetHTML(); //这就是内容
    var selectstr = FCK.EditorDocument.getSelection();
    //alert(selectstr);
    var keywordid = window.parent.document.getElementById("keywordinputid").value;
    var keywords = window.parent.document.getElementById(keywordid).value;
    var array = keywords.split(' ');
    for (var i = 0; i < array.length; i++) {
        //alert(array[i]);
        if (array[i] == "") {
            continue;
        }
        if (selectstr==array[i]) {
            // alert("已经添加");
            parent.window.we7.info("已经添加!");
            return;
        }
    }
    window.parent.document.getElementById(keywordid).value = keywords + " " + selectstr;
    parent.window.we7.info("添加成功!");
    //addkeyword1(selectstr);
}


// Register the related command
FCKCommands.RegisterCommand('KeyWords', new FCKKeyWords('KeyWords'));