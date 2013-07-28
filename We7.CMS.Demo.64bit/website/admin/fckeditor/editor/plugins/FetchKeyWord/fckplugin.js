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
*     Plugin for FetchKeyWord background
*
* 
* File Authors:
*         Yogananthar Ananthapavan (rollbond@gmail.com)
*/

// Create the "FetchKeyWord" toolbar button
var oFetchKeyWordItem = new FCKToolbarButton('FetchKeyWord', FCKLang.FetchKeyWord);

//设置按钮的图标路径
oFetchKeyWordItem.IconPath = FCKPlugins.Items['FetchKeyWord'].Path + 'FetchKeyWord.jpg';
//注册按钮项
FCKToolbarItems.RegisterItem('FetchKeyWord', oFetchKeyWordItem);

// The object used for all FetchKeyWord operations.
var FCKFetchKeyWord = new Object();

FCKFetchKeyWord = function (name) {
    this.Name = name;
}

//FCK_TRISTATE_ON为默认是选中状态
//下面的两个方法是实现接口的两个必须的方法，否则会报脚本错误
FCKFetchKeyWord.prototype.GetState = function () {

    return FCK_TRISTATE_OFF;
}

//此方法是点击按钮后要完成的操作
FCKFetchKeyWord.prototype.Execute = function () {
    FetchKeyWord();
}

//以下都是实现功能的方法
function FetchKeyWord() {
   // var fckeditor = FCKeditorAPI.GetInstance("ctl00_MyContentPlaceHolder_ctl00_ContentTextBox");
   // var str = fckeditor.GetHTML(); //这就是内容
  //  var selectstr = FCK.EditorDocument.getSelection();
   // alert(selectstr); editorid
    var editorid = window.parent.document.getElementById("editorid").value;
    var fckeditor = FCKeditorAPI.GetInstance(editorid);
    //获得文章标题
    var titleTextBoxId = window.parent.document.getElementById("titleTextBoxId").value;
    parent.window.$.ajax({
        type: "Post",
        url: "/admin/ajax/KeyWordAjax.aspx?op=fetch&id=" + parent.window.$("#IDHidden").val() + "&name=" + encodeURIComponent(""),
        datatype: "text",
        data: { content: window.parent.document.getElementById(titleTextBoxId).value + fckeditor.GetHTML(), count: 10 },
        success: function (text) {
            //alert(text);
            if (text == "notinstalled") {
                alert("请先安装关键词插件");
                return;
            } else {
                text = text.replace(/,/g, " ");
                var keywordid = window.parent.document.getElementById("keywordinputid").value;
                window.parent.document.getElementById(keywordid).value = text;
                parent.window.we7.info("提取成功!");
            }
           
        },
        error: function () {
            alert("请先安装关键词插件");
        }
    });
}

// Register the related command
FCKCommands.RegisterCommand('FetchKeyWord', new FCKFetchKeyWord('FetchKeyWord'));