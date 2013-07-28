// JScript 文件

FCKCommands.RegisterCommand('ImportExcel', new FCKDialogCommand('ImportExcel', FCKLang.ImportExcel, FCKPlugins.Items['ImportExcel'].Path + 'ImportExcel.aspx', 400, 300));
var ImportExcelItem = new FCKToolbarButton('ImportExcel', FCKLang.ImportExcel);
ImportExcelItem.IconPath = FCKPlugins.Items['ImportExcel'].Path + 'ImportExcel.gif';
FCKToolbarItems.RegisterItem('ImportExcel', ImportExcelItem);