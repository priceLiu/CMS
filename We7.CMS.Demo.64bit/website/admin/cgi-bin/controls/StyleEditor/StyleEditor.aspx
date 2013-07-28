<%@ Page Language="C#" AutoEventWireup="true" Codebehind="StyleEditor.aspx.cs" Inherits="We7.CMS.Web.Admin.StyleEditor" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>��ʽ�༭��</title>
    <link rel="stylesheet" type="text/css" href="styleeditor.css" media="screen" />

    <script src="<%=AppPath%>/cgi-bin/DialogHelper.js" type="text/javascript" charset="gb2312"></script>

    <style type="text/css">
  
    .Active { BORDER-RIGHT: lightcyan thin ; BORDER-TOP: lightcyan thin inset; BORDER-LEFT: lightcyan thin inset; CURSOR: hand; BORDER-BOTTOM: lightcyan thin ; BACKGROUND-COLOR: lightcyan }
	.InActive { BORDER-RIGHT: medium none ; BORDER-TOP: powderblue thin solid ; BORDER-LEFT: powderblue thin solid ; CURSOR: hand; BORDER-BOTTOM: powderblue thin ; BACKGROUND-COLOR: powderblue }
	.Highlight { BORDER-RIGHT: medium none ; BORDER-TOP: lightcyan thin outset ; BORDER-LEFT: lightcyan thin outset ; CURSOR: hand; BORDER-BOTTOM: lightcyan thin ; BACKGROUND-COLOR: lightcyan }
		</style>

    <script src="StyleEditor.js" type="text/javascript" charset="gb2312"></script>

    <script type="text/javascript">
function selectColor(obj) {
    var s = window.showModalDialog("ColorList.aspx", window,"dialogWidth:640px;dialogHeight:480px");
    if(s != null) {
        var o = document.all[obj];
        if( o )
            o.value = s;
    }
}

function onBodyLoad() {
    var p = null;
    var s;
    
    if(window.parent != null ) {
       p = window.parent;
    }
    else if(window.opener != null) {
        p = window.opener;
    }
    if(p && p.getParameter != null)    {
        s = p.getParameter();    
    }
    else {
        s = "";
    }   
    
    LoadStyle(s);
}    

function onBodyKeyPress() {
    if(event.keyCode == 13) {
        SubmitMe();
    }
    else if(event.keyCode == 27) {
        CancelMe();
    }
}

function SubmitMe() {
    var s = GetStyleText();
    closeDialog(s, "");
}

function CancelMe() {
     closeDialog(null, null);
}
    </script>

</head>
<body onkeypress="onBodyKeyPress()" onload="onBodyLoad();">
    <form id="HexConvert" runat="server">
        <div id="wrap">
            <div id="header">
                <div id="site-name">
                    </div>
            </div>
            <div id="content-wrap">
                <div id="content">
                    <div id="breadcrumb">
                        <div class="toolbar">
                            <asp:HyperLink ID="SelectHyperLink" runat="server" NavigateUrl="javascript:SubmitMe();">
                                <asp:Image ID="SelectImage" runat="server" ImageUrl="~/admin/Images/icon_ok.gif" />
                                ѡ��</asp:HyperLink>
                            <span>| </span>
                            <asp:HyperLink ID="CancelHyperLink" runat="server" NavigateUrl="javascript:CancelMe();">
                                <asp:Image ID="CancelImage" runat="server" ImageUrl="~/admin/Images/icon_cancel.gif" />
                                ȡ��</asp:HyperLink>
                            <span>| </span>
                        </div>
                        <div id="plContainer" style="z-index: 102; left: 0px; width: 720px; position: relative;
                            top: 0px; height: 500px; background-color: Gray">
                            <table id="tblTab" style="border-right: lightcyan thin; border-top: thin; font-size: 12px;
                                z-index: 102; left: 8px; border-left: thin; width: 55px; border-bottom: thin;
                                position: absolute; top: 8px; height: 272px; text-align: center" cellspacing="0"
                                cellpadding="0" border="0">
                                <tr>
                                    <td id="tabFont" onmouseover="HighlightTab(this.id);" style="height: 29px" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" valign="middle" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_font.gif"></td>
                                                <td>
                                                    &nbsp;����</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabBg" onmouseover="HighlightTab(this.id);" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_bk.gif" /></td>
                                                <td>
                                                    &nbsp;����</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabText" onmouseover="HighlightTab(this.id);" style="height: 25px" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_text.gif" /></td>
                                                <td>
                                                    &nbsp;�ı�</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabPos" onmouseover="HighlightTab(this.id);" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_pos.gif"></td>
                                                <td>
                                                    &nbsp;λ��</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabLayout" onmouseover="HighlightTab(this.id);" style="height: 29px" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_page.gif"></td>
                                                <td>
                                                    &nbsp;����</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabEdge" onmouseover="HighlightTab(this.id);" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_border.gif"></td>
                                                <td>
                                                    &nbsp;��Ե</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabList" onmouseover="HighlightTab(this.id);" style="height: 24px" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_list.gif"></td>
                                                <td>
                                                    &nbsp;�б�</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabFilter" onmouseover="HighlightTab(this.id);" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_filter.gif"></td>
                                                <td>
                                                    &nbsp;�˾�</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tabOther" onmouseover="HighlightTab(this.id);" onclick="SwitchTab(this.id);"
                                        onmouseout="UnHighlightTab(this.id);" align="center">
                                        <table style="font-size: 12px" cellspacing="0" cellpadding="0" border="0">
                                            <tr>
                                                <td>
                                                    <img alt="" src="images/ico_other.gif"></td>
                                                <td>
                                                    ����</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblContent" style="border-right: lightcyan thin inset; border-top: lightcyan thin inset;
                                font-size: 12px; z-index: 101; left: 65px; border-left: lightcyan thin inset;
                                width: 642px; border-bottom: lightcyan thin inset; position: absolute; top: 8px;
                                height: 456px; background-color: lightcyan" cellspacing="1" cellpadding="1" width="642"
                                border="1">
                                <tr>
                                    <td>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  ���� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="plExampleContainer" style="border-right: thin solid; border-top: thin solid;
                                            z-index: 500; left: 0px; overflow: auto; border-left: thin solid; width: 632px;
                                            border-bottom: thin solid; position: absolute; top: 368px; height: 80px">
                                            <table id="tblExample" style="z-index: 500; left: 0px; overflow: scroll; width: 100%;
                                                position: absolute; top: 0px; height: 100%" cellspacing="1" cellpadding="1" border="0">
                                                <tr>
                                                    <td id="tdExample" style="overflow: auto" valign="middle" align="center">
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="tabFontContent" style="width: 634px; position: absolute; top: 8px; height: 448px">
                                            <div style="display: inline; z-index: 101; left: 16px; width: 56px; position: absolute;
                                                top: 8px; height: 14px">
                                                ��������</div>
                                            <hr style="z-index: 102; left: 80px; width: 526px; position: absolute; top: 16px;
                                                height: 1px" width="526" size="1">
                                            <input id="font_tbFontFamily" style="font-size: 12px; z-index: 103; left: 32px; width: 264px;
                                                position: absolute; top: 24px; height: 22px" readonly type="text" size="38">
                                            <input id="font_btnfont_OpenSelectFontWindow" style="font-size: 12px; z-index: 104;
                                                left: 304px; width: 24px; position: absolute; top: 24px; height: 20px" onclick="font_OpenSelectFontWindow();"
                                                type="button" value="...">
                                            <div style="display: inline; z-index: 105; left: 16px; width: 56px; position: absolute;
                                                top: 56px; height: 15px">
                                                ��������</div>
                                            <hr style="z-index: 106; left: 80px; width: 524px; position: absolute; top: 64px;
                                                height: 1px" width="524" size="1">
                                            <div style="display: inline; z-index: 107; left: 32px; width: 32px; position: absolute;
                                                top: 80px; height: 15px">
                                                ��ɫ</div>
                                            <input language="javascript" id="font_tbColor" style="font-size: 12px; z-index: 108;
                                                left: 72px; width: 88px; position: absolute; top: 73px; height: 23px" type="text"
                                                onchange="ShowTextExample();" size="9">
                                            <input id="font_ColorSelect" style="z-index: 109; left: 168px; width: 24px; position: absolute;
                                                top: 72px; height: 24px" onclick="selectColor('font_tbColor');" type="button"
                                                value="...">
                                            <div style="display: inline; z-index: 110; left: 208px; width: 32px; position: absolute;
                                                top: 80px; height: 15px">
                                                б��</div>
                                            <select id="font_ddlFontStyle" style="font-size: 12px; z-index: 111; left: 248px;
                                                width: 144px; position: absolute; top: 75px" onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="normal">����</option>
                                                <option value="italic">б��</option>
                                            </select>
                                            <div style="display: none; z-index: 112; left: 408px; width: 56px; position: absolute;
                                                top: 80px; height: 15px">
                                                <p>
                                                    Сд��ĸ</p>
                                            </div>
                                            <select id="font_ddlFontVariant" style="display: none; font-size: 12px; z-index: 113;
                                                left: 472px; width: 144px; position: absolute; top: 76px" onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="normal">����</option>
                                                <option value="small-caps">Сд��ĸ</option>
                                            </select>
                                            <div style="display: inline; z-index: 114; left: 32px; width: 29px; position: absolute;
                                                top: 104px; height: 15px">
                                                ��С</div>
                                            <hr style="z-index: 115; left: 64px; width: 28%; position: absolute; top: 112px;
                                                height: 1px" width="28.06%" size="1">
                                            <table id="Table2" style="font-size: 12px; z-index: 116; left: 304px; width: 208px;
                                                position: absolute; top: 126px; height: 103px" cellspacing="1" cellpadding="1"
                                                width="208" border="0">
                                                <tr valign="bottom">
                                                    <td style="width: 22px">
                                                        <input language="javascript" id="font_cbTxtDec_None" onclick="font_cbTxtDec_None_onclick(this.checked);"
                                                            type="checkbox" value="none"></td>
                                                    <td>
                                                        <label for="font_cbTxtDec_None">
                                                            ��</label>
                                                    </td>
                                                </tr>
                                                <tr valign="bottom">
                                                    <td style="width: 22px">
                                                        <input id="font_cbTxtDec_Underline" onclick="ShowTextExample();" type="checkbox"
                                                            value="underline"></td>
                                                    <td>
                                                        <label for="font_cbTxtDec_Underline">
                                                            �»���</label>
                                                    </td>
                                                </tr>
                                                <tr valign="bottom">
                                                    <td style="width: 22px">
                                                        <input id="font_cbTxtDec_LineThrough" onclick="ShowTextExample();" type="checkbox"
                                                            value="line-through"></td>
                                                    <td>
                                                        <label for="font_cbTxtDec_LineThrough">
                                                            ɾ����</label>
                                                    </td>
                                                </tr>
                                                <tr valign="bottom">
                                                    <td style="width: 22px">
                                                        <input id="font_cbTxtDec_Overline" onclick="ShowTextExample();" type="checkbox" value="overline"></td>
                                                    <td>
                                                        <label for="font_cbTxtDec_Overline">
                                                            �ϻ���</label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <hr style="z-index: 117; left: 336px; width: 36.42%; position: absolute; top: 112px;
                                                height: 1px" width="36.42%" size="1">
                                            <div style="display: inline; z-index: 118; left: 304px; width: 29px; position: absolute;
                                                top: 104px; height: 15px">
                                                Ч��</div>
                                            <hr style="z-index: 119; left: 72px; width: 28%; position: absolute; top: 248px;
                                                height: 1px" width="24.03%" size="1">
                                            <div style="display: inline; z-index: 120; left: 32px; width: 29px; position: absolute;
                                                top: 240px; height: 15px">
                                                ����</div>
                                            <table id="Table3" style="font-size: 12px; z-index: 121; left: 32px; width: 216px;
                                                position: absolute; top: 256px; height: 45px" cellspacing="1" cellpadding="0"
                                                width="216" align="left" border="0">
                                                <tr valign="bottom">
                                                    <td style="width: 20px">
                                                        <input id="font_rbFontWeight0" onclick="font_ChangeFontWeightType(0);" type="radio"
                                                            checked name="font_rblFontWeight"></td>
                                                    <td style="width: 80px">
                                                        <label for="font_rbFontWeight0">
                                                            ����</label></td>
                                                    <td colspan="2">
                                                        <select id="font_ddlAbsFontWeight" style="font-size: 12px; width: 100%" onchange="ShowTextExample();">
                                                            <option value="" selected>&lt;δ����&gt;</option>
                                                            <option value="normal">����</option>
                                                            <option value="bold">����</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr valign="bottom">
                                                    <td style="width: 20px">
                                                        <input id="font_rbFontWeight1" onclick="font_ChangeFontWeightType(1);" type="radio"
                                                            name="font_rblFontWeight"></td>
                                                    <td style="width: 80px">
                                                        <label for="font_rbFontWeight1">
                                                            ���</label></td>
                                                    <td colspan="2">
                                                        <select id="font_ddlRevFontWeight" style="font-size: 12px; width: 100%" onchange="ShowTextExample();">
                                                            <option value="">&lt;δ����&gt;</option>
                                                            <option value="lighter" selected>�ϵ�</option>
                                                            <option value="bolder">����</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div style="display: none; z-index: 122; left: 304px; width: 29px; position: absolute;
                                                top: 240px; height: 15px">
                                                ��д</div>
                                            <select id="font_ddlTxtTrans" style="display: none; font-size: 12px; z-index: 123;
                                                left: 304px; width: 208px; position: absolute; top: 256px" onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="none">��</option>
                                                <option value="capitalize">����ĸ��д</option>
                                                <option value="lowercase">Сд</option>
                                                <option value="uppercase">��д</option>
                                            </select>
                                            <input language="javascript" id="font_rbFontSize0" style="z-index: 124; left: 32px;
                                                position: absolute; top: 128px" onclick="font_ChangeSizeType(0);" type="radio"
                                                checked name="font_rblFontSize">
                                            <input id="font_tbFontSize" style="z-index: 125; left: 120px; width: 72px; position: absolute;
                                                top: 128px; height: 22px" type="text" onchange="ShowTextExample();" size="6">
                                            <select id="font_ddlFontUnit" style="font-size: 12px; z-index: 126; left: 200px;
                                                position: absolute; top: 128px" onchange="ShowTextExample();" size="1">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <input language="javascript" id="font_rbFontSize1" style="z-index: 127; left: 32px;
                                                position: absolute; top: 160px" onclick="font_ChangeSizeType(1);" type="radio"
                                                name="font_rblFontSize">
                                            <select id="font_ddlAbsFontSize" style="font-size: 12px; z-index: 128; left: 120px;
                                                width: 128px; position: absolute; top: 160px" onchange="ShowTextExample();" size="1">
                                                <option value="">&lt;δ����&gt;</option>
                                                <option value="xx-small" selected>XX-Small</option>
                                                <option value="x-small">X-Small</option>
                                                <option value="small">Small</option>
                                                <option value="medium">Medium</option>
                                                <option value="large">Large</option>
                                                <option value="x-large">X-Large</option>
                                                <option value="xx-large">XX-Large</option>
                                            </select>
                                            <input id="font_rbFontSize2" style="z-index: 129; left: 32px; position: absolute;
                                                top: 192px" onclick="font_ChangeSizeType(2);" type="radio" name="font_rblFontSize">
                                            <select id="font_ddlRevFontSize" style="font-size: 12px; z-index: 130; left: 120px;
                                                width: 128px; position: absolute; top: 192px" onchange="ShowTextExample();" size="1">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="smaller">��С</option>
                                                <option value="larger">�ϴ�</option>
                                            </select>
                                            <div style="display: inline; z-index: 131; left: 64px; width: 32px; position: absolute;
                                                top: 132px; height: 15px">
                                                �ض�</div>
                                            <div style="display: inline; z-index: 132; left: 64px; width: 32px; position: absolute;
                                                top: 164px; height: 15px">
                                                ����</div>
                                            <div style="display: inline; z-index: 133; left: 64px; width: 32px; position: absolute;
                                                top: 196px; height: 15px">
                                                ���</div>
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  ���� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabBgContent" style="width: 634px; position: absolute; top: 500px; height: 440px">
                                            <div style="display: inline; z-index: 100; left: 16px; width: 56px; position: absolute;
                                                top: 8px; height: 14px">
                                                ����ɫ</div>
                                            <hr style="z-index: 101; left: 80px; width: 526px; position: absolute; top: 16px;
                                                height: 1px" width="595" size="1">
                                            <input id="bg_tbBgColor" style="font-size: 12px; z-index: 102; left: 80px; width: 176px;
                                                position: absolute; top: 32px; height: 22px" type="text" onchange="ShowTextExample();"
                                                size="24">
                                            <input id="bg_btnSelectColor" style="font-size: 12px; z-index: 104; left: 264px;
                                                width: 24px; position: absolute; top: 32px; height: 24px" onclick="selectColor('bg_tbBgColor');"
                                                type="button" value="...">
                                            <div style="display: inline; z-index: 105; left: 32px; width: 48px; position: absolute;
                                                top: 36px; height: 10px">
                                                ��ɫ</div>
                                            <input id="bg_cbBgTrans" style="z-index: 106; left: 344px; position: absolute; top: 32px"
                                                onclick="bg_BgTrans_change();ShowTextExample();" type="checkbox">
                                            <div style="display: inline; z-index: 107; left: 368px; width: 32px; position: absolute;
                                                top: 35px; height: 15px">
                                                <label for="bg_cbBgTrans">
                                                    ͸��</label>
                                            </div>
                                            <div style="display: inline; z-index: 108; left: 16px; width: 56px; position: absolute;
                                                top: 72px; height: 14px">
                                                ����ͼ��</div>
                                            <hr style="z-index: 109; left: 80px; width: 526px; position: absolute; top: 80px;
                                                height: 1px" width="595" size="1">
                                            <div style="display: inline; z-index: 110; left: 32px; width: 32px; position: absolute;
                                                top: 92px; height: 15px">
                                                ͼ��</div>
                                            <input language="javascript" id="bg_tbBgImage" style="font-size: 12px; z-index: 111;
                                                left: 72px; width: 432px; position: absolute; top: 88px; height: 22px" type="text"
                                                onchange="return bg_tbBgImage_onchange()" size="66">
                                            <div style="display: inline; z-index: 112; left: 48px; width: 32px; position: absolute;
                                                top: 116px; height: 15px">
                                                ƽ��</div>
                                            <select id="bg_ddlRepeat" style="font-size: 12px; z-index: 113; left: 88px; width: 168px;
                                                position: absolute; top: 112px" disabled onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="repeat-x">ˮƽƽ��</option>
                                                <option value="repeat-y">��ֱƽ��</option>
                                                <option value="repeat">ˮƽ�ʹ�ֱƽ��</option>
                                                <option value="no-repeat">��ƽ��</option>
                                            </select>
                                            <div style="display: inline; z-index: 114; left: 272px; width: 32px; position: absolute;
                                                top: 116px; height: 15px">
                                                ����</div>
                                            <select id="bg_ddlAttach" style="font-size: 12px; z-index: 115; left: 312px; width: 192px;
                                                position: absolute; top: 112px" disabled onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="scroll">��������</option>
                                                <option value="fixed">�̶�����</option>
                                            </select>
                                            <div style="display: inline; z-index: 116; left: 48px; width: 32px; position: absolute;
                                                top: 152px; height: 15px">
                                                λ��</div>
                                            <hr style="z-index: 117; left: 88px; width: 52.33%; position: absolute; top: 160px;
                                                height: 1px" width="52.33%" size="1">
                                            <div style="display: inline; z-index: 118; left: 72px; width: 32px; position: absolute;
                                                top: 180px; height: 15px">
                                                ˮƽ</div>
                                            <select id="bg_ddlPosX" style="font-size: 12px; z-index: 119; left: 112px; width: 152px;
                                                position: absolute; top: 176px" disabled onchange="bg_ddlPosX_onchange();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="left">��</option>
                                                <option value="center">����</option>
                                                <option value="right">��</option>
                                                <option value="custom">�Զ���</option>
                                            </select>
                                            <input id="bg_tbPosX" style="font-size: 12px; z-index: 120; left: 288px; width: 48px;
                                                position: absolute; top: 176px; height: 22px" disabled type="text" onchange="ShowTextExample();"
                                                size="2">
                                            <select id="bg_ddlPosXUnit" style="font-size: 12px; z-index: 121; left: 344px; width: 80px;
                                                position: absolute; top: 176px" disabled onchange="ShowTextExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 122; left: 72px; width: 32px; position: absolute;
                                                top: 210px; height: 15px">
                                                ��ֱ</div>
                                            <select id="bg_ddlPosY" style="font-size: 12px; z-index: 123; left: 112px; width: 152px;
                                                position: absolute; top: 208px" disabled onchange="bg_ddlPosY_onchange();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="top">��</option>
                                                <option value="center">����</option>
                                                <option value="bottom">��</option>
                                                <option value="custom">�Զ���</option>
                                            </select>
                                            <input id="bg_tbPosY" style="font-size: 12px; z-index: 124; left: 288px; width: 48px;
                                                position: absolute; top: 208px; height: 22px" disabled type="text" onchange="ShowTextExample();"
                                                size="2">
                                            <select id="bg_ddlPosYUnit" style="font-size: 12px; z-index: 125; left: 344px; width: 80px;
                                                position: absolute; top: 208px" disabled onchange="ShowTextExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <input language="javascript" id="bg_cbNoneImage" style="z-index: 126; left: 32px;
                                                position: absolute; top: 240px" onclick="return bg_cbNoneImage_onclick()" type="checkbox">
                                            <div style="display: inline; z-index: 127; left: 56px; width: 88px; position: absolute;
                                                top: 243px; height: 16px">
                                                <label for="bg_cbNoneImage">
                                                    ��ʹ�ñ���ͼ��</label></div>
                                            <input id="bg_btnSelectImg" style="font-size: 12px; z-index: 128; left: 512px; width: 24px;
                                                position: absolute; top: 88px; height: 24px" onclick="javascript:document.all['bg_tbBgImage'].value=window.showModalDialog('../ftp/default.aspx?obj=0','','dialogHeight:525px;dialogWidth:730px;center:yes;resizable:no;scroll:yes;status:no');"
                                                type="button" value="..." name="Button1">
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  �ı� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabTextContent" style="width: 634px; position: absolute; top: 1000px; height: 440px">
                                            <div style="display: inline; z-index: 100; left: 16px; width: 56px; position: absolute;
                                                top: 8px; height: 14px">
                                                ���뷽ʽ</div>
                                            <hr style="z-index: 101; left: 80px; width: 526px; position: absolute; top: 16px;
                                                height: 1px" width="595" size="1">
                                            <div style="display: inline; z-index: 103; left: 16px; width: 40px; position: absolute;
                                                top: 36px; height: 12px">
                                                ˮƽ��</div>
                                            <select language="javascript" id="txt_ddlAlign" style="font-size: 12px; z-index: 104;
                                                left: 64px; width: 120px; position: absolute; top: 32px" onchange="return txt_ddlAlign_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="left">��</option>
                                                <option value="center">����</option>
                                                <option value="right">��</option>
                                                <option value="justify">���˶���</option>
                                            </select>
                                            <select id="txt_ddlVAlign" style="font-size: 12px; z-index: 105; left: 432px; width: 120px;
                                                position: absolute; top: 32px" onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="sub">�±�</option>
                                                <option value="super">�ϱ�</option>
                                                <option value="baseline">����</option>
                                            </select>
                                            <div style="display: inline; z-index: 106; left: 384px; width: 40px; position: absolute;
                                                top: 36px; height: 12px">
                                                ��ֱ��</div>
                                            <div style="display: inline; z-index: 107; left: 200px; width: 40px; position: absolute;
                                                top: 36px; height: 12px">
                                                ������</div>
                                            <select id="txt_ddlJustify" style="font-size: 12px; z-index: 108; left: 248px; width: 120px;
                                                position: absolute; top: 32px" onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="auto">�Զ�</option>
                                                <option value="inter-word">�����־�</option>
                                                <option value="newspaper">��ֽ��ʽ</option>
                                                <option value="distribute">�ֲ����</option>
                                                <option value="distribute-all-lines">�ֲ�������</option>
                                            </select>
                                            <div style="display: inline; z-index: 109; left: 16px; width: 32px; position: absolute;
                                                top: 64px; height: 14px">
                                                ���</div>
                                            <div style="display: inline; z-index: 110; left: 32px; width: 32px; position: absolute;
                                                top: 84px; height: 14px">
                                                ��ĸ</div>
                                            <select language="javascript" id="txt_ddlLetSpa" style="font-size: 12px; z-index: 111;
                                                left: 64px; width: 120px; position: absolute; top: 80px" onchange="return txt_ddlLetSpa_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="normal">����</option>
                                                <option value="custom">�Զ���</option>
                                            </select>
                                            <input id="txt_tbLetSpa" style="font-size: 12px; z-index: 112; left: 200px; width: 56px;
                                                position: absolute; top: 80px; height: 22px" disabled type="text" onchange="ShowTextExample();"
                                                size="4">
                                            <select id="txt_ddlLetSpaUnit" style="font-size: 12px; z-index: 113; left: 264px;
                                                width: 56px; position: absolute; top: 80px" disabled onchange="ShowTextExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 114; left: 32px; width: 16px; position: absolute;
                                                top: 116px; height: 14px">
                                                ��</div>
                                            <select language="javascript" id="txt_ddlLineHeight" style="font-size: 12px; z-index: 115;
                                                left: 64px; width: 120px; position: absolute; top: 112px" onchange="return txt_ddlLineHeight_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="normal">����</option>
                                                <option value="custom">�Զ���</option>
                                            </select>
                                            <input id="txt_tbLineHeight" style="font-size: 12px; z-index: 121; left: 200px; width: 56px;
                                                position: absolute; top: 112px; height: 22px" disabled type="text" onchange="ShowTextExample();"
                                                size="4">
                                            <select id="txt_ddlLineHeightUnit" style="font-size: 12px; z-index: 130; left: 264px;
                                                width: 56px; position: absolute; top: 112px" disabled onchange="ShowTextExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 131; left: 360px; width: 48px; position: absolute;
                                                top: 64px; height: 12px">
                                                �ı���</div>
                                            <div style="display: inline; z-index: 132; left: 376px; width: 32px; position: absolute;
                                                top: 84px; height: 14px">
                                                ����</div>
                                            <hr style="z-index: 133; left: 56px; width: 41.37%; position: absolute; top: 72px;
                                                height: 1px" width="41.37%" size="1">
                                            <hr style="z-index: 134; left: 416px; width: 30%; position: absolute; top: 72px;
                                                height: 1px" width="30.66%" size="1">
                                            <input id="txt_tbIndent" style="font-size: 12px; z-index: 135; left: 432px; width: 56px;
                                                position: absolute; top: 80px; height: 22px" type="text" onchange="ShowTextExample();"
                                                size="4">
                                            <select id="txt_ddlIndentUnit" style="font-size: 12px; z-index: 136; left: 496px;
                                                width: 56px; position: absolute; top: 80px" onchange="ShowTextExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 137; left: 376px; width: 56px; position: absolute;
                                                top: 116px; height: 6px">
                                                �ı�����</div>
                                            <select id="txt_ddlDirection" style="font-size: 12px; z-index: 138; left: 432px;
                                                width: 120px; position: absolute; top: 112px" onchange="ShowTextExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="ltr">������</option>
                                                <option value="rtl">���ҵ���</option>
                                            </select>
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  λ�� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabPosContent" style="width: 634px; position: absolute; top: 1500px; height: 440px">
                                            &nbsp;
                                            <img id="pos_imgPos" style="z-index: 100; left: 24px; position: absolute; top: 16px"
                                                alt="" src="images/pos_notset.gif">
                                            <div style="display: inline; z-index: 101; left: 64px; width: 56px; position: absolute;
                                                top: 16px; height: 15px">
                                                λ��ģʽ</div>
                                            <select language="javascript" id="pos_ddlPos" style="font-size: 12px; z-index: 102;
                                                left: 64px; width: 176px; position: absolute; top: 32px" onchange="return pos_ddlPos_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="static">�������е�λ��</option>
                                                <option value="relative">��������ƫ����</option>
                                                <option value="absolute">����λ��</option>
                                            </select>
                                            <div style="display: inline; z-index: 103; left: 64px; width: 16px; position: absolute;
                                                top: 68px; height: 15px">
                                                ��</div>
                                            <input id="pos_tbTop" style="font-size: 12px; z-index: 104; left: 88px; width: 48px;
                                                position: absolute; top: 64px; height: 22px" type="text" size="2">
                                            <select id="pos_ddlTopUnit" style="font-size: 12px; z-index: 105; left: 144px; width: 56px;
                                                position: absolute; top: 64px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 106; left: 64px; width: 16px; position: absolute;
                                                top: 100px; height: 15px">
                                                ��</div>
                                            <input id="pos_tbLeft" style="font-size: 12px; z-index: 107; left: 88px; width: 48px;
                                                position: absolute; top: 96px; height: 22px" type="text" size="2">
                                            <select id="pos_ddlLeftUnit" style="font-size: 12px; z-index: 108; left: 144px; width: 56px;
                                                position: absolute; top: 96px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 109; left: 232px; width: 32px; position: absolute;
                                                top: 68px; height: 12px">
                                                �߶�</div>
                                            <input id="pos_tbHeight" style="font-size: 12px; z-index: 110; left: 272px; width: 48px;
                                                position: absolute; top: 64px; height: 22px" type="text" size="2">
                                            <select id="pos_ddlHeightUnit" style="font-size: 12px; z-index: 111; left: 328px;
                                                width: 56px; position: absolute; top: 64px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 112; left: 232px; width: 32px; position: absolute;
                                                top: 100px; height: 12px">
                                                ���</div>
                                            <input id="pos_tbWidth" style="font-size: 12px; z-index: 114; left: 272px; width: 48px;
                                                position: absolute; top: 96px; height: 22px" type="text" size="2">
                                            <select id="pos_ddlWidthUnit" style="font-size: 12px; z-index: 115; left: 328px;
                                                width: 56px; position: absolute; top: 96px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 113; left: 64px; width: 40px; position: absolute;
                                                top: 132px; height: 15px">
                                                Z ����</div>
                                            <input id="pos_tbZIndex" style="font-size: 12px; z-index: 116; left: 112px; width: 72px;
                                                position: absolute; top: 128px; height: 22px" type="text" size="6">
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  ���� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabLayoutContent" style="width: 634px; position: absolute; top: 2000px;
                                            height: 440px">
                                            <div style="display: inline; z-index: 100; left: 16px; width: 56px; position: absolute;
                                                top: 8px; height: 12px">
                                                ������&nbsp;
                                            </div>
                                            <hr style="z-index: 101; left: 72px; width: 500px; position: absolute; top: 16px;
                                                height: 1px" width="561" size="1">
                                            <img id="lay_imgVisibility" style="z-index: 107; left: 24px; position: absolute;
                                                top: 32px" alt="" src="images/layout_visibility_notset.gif">
                                            <div style="display: inline; z-index: 102; left: 72px; width: 56px; position: absolute;
                                                top: 32px; height: 14px">
                                                �ɼ��ԣ�</div>
                                            <select language="javascript" id="lay_ddlVisibility" style="font-size: 12px; z-index: 104;
                                                left: 72px; width: 144px; position: absolute; top: 48px" onchange="return lay_ddlVisibility_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="hidden">����</option>
                                                <option value="visible">�ɼ�</option>
                                            </select>
                                            <img id="lay_imgDisplay" style="z-index: 111; left: 24px; position: absolute; top: 80px"
                                                alt="" src="images/layout_display_notset.gif">
                                            <div style="display: inline; z-index: 106; left: 72px; width: 40px; position: absolute;
                                                top: 80px; height: 12px">
                                                ��ʾ��</div>
                                            <select language="javascript" id="lay_ddlDisplay" style="font-size: 12px; z-index: 112;
                                                left: 72px; width: 144px; position: absolute; top: 96px" onchange="return lay_ddlDisplay_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="none">����ʾ</option>
                                                <option value="block">��Ϊ��Ԫ��</option>
                                                <option value="inline">��Ϊ����Ԫ��</option>
                                            </select>
                                            <div style="display: inline; z-index: 109; left: 304px; width: 88px; position: absolute;
                                                top: 32px; height: 14px">
                                                �����ı�������</div>
                                            <img id="lay_imgFloat" style="z-index: 108; left: 256px; position: absolute; top: 32px"
                                                alt="" src="images/layout_float_notset.gif">
                                            <select language="javascript" id="lay_ddlFloat" style="font-size: 12px; z-index: 110;
                                                left: 304px; width: 144px; position: absolute; top: 48px" onchange="return lay_ddlFloat_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="none">���ϲ������ı�</option>
                                                <option value="right">����</option>
                                                <option value="left">����</option>
                                            </select>
                                            <img id="lay_imgClear" style="z-index: 113; left: 256px; position: absolute; top: 80px"
                                                alt="" src="images/layout_clear_notset.gif">
                                            <div style="display: inline; z-index: 114; left: 304px; width: 88px; position: absolute;
                                                top: 80px; height: 14px">
                                                ����������</div>
                                            <select language="javascript" id="lay_ddlClear" style="font-size: 12px; z-index: 115;
                                                left: 304px; width: 144px; position: absolute; top: 96px" onchange="return lay_ddlClear_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="both">�κ�һ��</option>
                                                <option value="right">���ұ�</option>
                                                <option value="left">�����</option>
                                                <option value="none">������</option>
                                            </select>
                                            <div style="display: inline; z-index: 117; left: 24px; width: 32px; position: absolute;
                                                top: 128px; height: 14px">
                                                ����&nbsp;</div>
                                            <hr style="z-index: 122; left: 64px; width: 508px; position: absolute; top: 136px;
                                                height: 1px" width="504" size="1">
                                            <div style="display: inline; z-index: 125; left: 40px; width: 32px; position: absolute;
                                                top: 152px; height: 14px">
                                                ���&nbsp;</div>
                                            <select id="lay_ddlOverflow" style="font-size: 12px; z-index: 128; left: 104px; width: 200px;
                                                position: absolute; top: 152px">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="auto">��Ҫʱʹ�ù�����</option>
                                                <option value="scroll">ʼ��ʹ�ù�����</option>
                                                <option value="visible">����������</option>
                                                <option value="hidden">��������</option>
                                            </select>
                                            <div style="display: inline; z-index: 132; left: 24px; width: 32px; position: absolute;
                                                top: 184px; height: 14px">
                                                ����</div>
                                            <hr style="z-index: 133; left: 64px; width: 508px; position: absolute; top: 192px;
                                                height: 1px" width="506" size="1">
                                            <div style="display: inline; z-index: 134; left: 56px; width: 16px; position: absolute;
                                                top: 212px; height: 15px">
                                                ��</div>
                                            <input id="lay_tbClipTop" style="font-size: 12px; z-index: 135; left: 80px; width: 48px;
                                                position: absolute; top: 208px; height: 22px" type="text" size="2">
                                            <select id="lay_ddlClipTopUnit" style="font-size: 12px; z-index: 136; left: 136px;
                                                width: 56px; position: absolute; top: 208px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 137; left: 56px; width: 16px; position: absolute;
                                                top: 244px; height: 15px">
                                                ��</div>
                                            <input id="lay_tbClipLeft" style="font-size: 12px; z-index: 138; left: 80px; width: 48px;
                                                position: absolute; top: 240px; height: 22px" type="text" size="2">
                                            <select id="lay_ddlClipLeftUnit" style="font-size: 12px; z-index: 139; left: 136px;
                                                width: 56px; position: absolute; top: 240px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 140; left: 224px; width: 32px; position: absolute;
                                                top: 212px; height: 12px">
                                                ��</div>
                                            <input id="lay_tbClipBottom" style="font-size: 12px; z-index: 141; left: 264px; width: 48px;
                                                position: absolute; top: 208px; height: 22px" type="text" size="2">
                                            <select id="lay_ddlClipBottomUnit" style="font-size: 12px; z-index: 142; left: 320px;
                                                width: 56px; position: absolute; top: 208px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 143; left: 224px; width: 32px; position: absolute;
                                                top: 244px; height: 12px">
                                                ��</div>
                                            <input id="lay_tbClipRight" style="font-size: 12px; z-index: 144; left: 264px; width: 48px;
                                                position: absolute; top: 240px; height: 22px" type="text" size="2">
                                            <select id="lay_ddlClipRightUnit" style="font-size: 12px; z-index: 145; left: 320px;
                                                width: 56px; position: absolute; top: 240px">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 146; left: 24px; width: 64px; position: absolute;
                                                top: 272px; height: 14px">
                                                ��ӡ��ҳ��</div>
                                            <hr style="z-index: 147; left: 88px; width: 487px; position: absolute; top: 282px;
                                                height: 1px" width="489" size="1">
                                            <div style="display: inline; z-index: 148; left: 48px; width: 32px; position: absolute;
                                                top: 300px; height: 15px">
                                                ��ǰ</div>
                                            <select id="lay_ddlPbb" style="font-size: 12px; z-index: 149; left: 88px; width: 176px;
                                                position: absolute; top: 296px">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="auto">�Զ�</option>
                                                <option value="always">ǿ�Ʒ�ҳ</option>
                                            </select>
                                            <div style="display: inline; z-index: 150; left: 288px; width: 32px; position: absolute;
                                                top: 300px">
                                                �κ�</div>
                                            <select id="lay_ddlPba" style="font-size: 12px; z-index: 151; left: 328px; width: 176px;
                                                position: absolute; top: 296px">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="auto">�Զ�</option>
                                                <option value="always">ǿ�Ʒ�ҳ</option>
                                            </select>
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  ��Ե ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabEdgeContent" style="width: 634px; position: absolute; top: 2500px; height: 440px">
                                            <div style="display: inline; z-index: 101; left: 16px; width: 32px; position: absolute;
                                                top: 8px; height: 14px">
                                                �߾�&nbsp;
                                            </div>
                                            <hr style="z-index: 102; left: 56px; width: 129px; position: absolute; top: 16px;
                                                height: 1px" width="129" size="1">
                                            <div style="display: inline; z-index: 103; left: 40px; width: 24px; position: absolute;
                                                top: 36px; height: 14px">
                                                ����</div>
                                            <select id="edg_ddlMarginTopUnit" style="font-size: 12px; z-index: 104; left: 128px;
                                                width: 56px; position: absolute; top: 32px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <input id="edg_tbMarginTop" style="font-size: 12px; z-index: 105; left: 72px; width: 48px;
                                                position: absolute; top: 32px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <div style="display: inline; z-index: 106; left: 40px; width: 24px; position: absolute;
                                                top: 60px; height: 14px">
                                                �ף�</div>
                                            <input id="edg_tbMarginBottom" style="font-size: 12px; z-index: 107; left: 72px;
                                                width: 48px; position: absolute; top: 56px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <select id="edg_ddlMarginBottomUnit" style="font-size: 12px; z-index: 108; left: 128px;
                                                width: 56px; position: absolute; top: 56px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 109; left: 40px; width: 24px; position: absolute;
                                                top: 84px; height: 14px">
                                                ��</div>
                                            <input id="edg_tbMarginLeft" style="font-size: 12px; z-index: 110; left: 72px; width: 48px;
                                                position: absolute; top: 80px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <select id="edg_ddlMarginLeftUnit" style="font-size: 12px; z-index: 111; left: 128px;
                                                width: 56px; position: absolute; top: 80px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 112; left: 40px; width: 24px; position: absolute;
                                                top: 108px; height: 14px">
                                                �ң�</div>
                                            <input id="edg_tbMarginRight" style="font-size: 12px; z-index: 113; left: 72px; width: 48px;
                                                position: absolute; top: 104px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <select id="edg_ddlMarginRightUnit" style="font-size: 12px; z-index: 114; left: 128px;
                                                width: 56px; position: absolute; top: 104px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 116; left: 224px; width: 32px; position: absolute;
                                                top: 8px; height: 14px">
                                                �հ�&nbsp;</div>
                                            <hr style="z-index: 118; left: 264px; width: 129px; position: absolute; top: 16px;
                                                height: 1px" width="129" size="1">
                                            <div style="display: inline; z-index: 122; left: 248px; width: 24px; position: absolute;
                                                top: 36px; height: 14px">
                                                ����</div>
                                            <select id="edg_ddlPadTopUnit" style="font-size: 12px; z-index: 120; left: 336px;
                                                width: 56px; position: absolute; top: 32px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <input id="edg_tbPadTop" style="font-size: 12px; z-index: 123; left: 280px; width: 48px;
                                                position: absolute; top: 32px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <div style="display: inline; z-index: 128; left: 248px; width: 24px; position: absolute;
                                                top: 60px; height: 14px">
                                                �ף�</div>
                                            <input id="edg_tbPadBottom" style="font-size: 12px; z-index: 124; left: 280px; width: 48px;
                                                position: absolute; top: 56px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <select id="edg_ddlPadBottomUnit" style="font-size: 12px; z-index: 117; left: 336px;
                                                width: 56px; position: absolute; top: 56px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 119; left: 248px; width: 24px; position: absolute;
                                                top: 84px; height: 14px">
                                                ��</div>
                                            <input id="edg_tbPadLeft" style="font-size: 12px; z-index: 121; left: 280px; width: 48px;
                                                position: absolute; top: 80px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <select id="edg_ddlPadLeftUnit" style="font-size: 12px; z-index: 125; left: 336px;
                                                width: 56px; position: absolute; top: 80px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 126; left: 248px; width: 24px; position: absolute;
                                                top: 108px; height: 14px">
                                                �ң�</div>
                                            <input id="edg_tbPadRight" style="font-size: 12px; z-index: 127; left: 280px; width: 48px;
                                                position: absolute; top: 104px; height: 22px" type="text" onchange="edg_ShowExample();"
                                                size="2">
                                            <select id="edg_ddlPadRightUnit" style="font-size: 12px; z-index: 115; left: 336px;
                                                width: 56px; position: absolute; top: 104px" onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <div style="display: inline; z-index: 129; left: 16px; width: 32px; position: absolute;
                                                top: 136px; height: 15px">
                                                �߿�</div>
                                            <hr style="z-index: 130; left: 48px; width: 67.4%; position: absolute; top: 144px;
                                                height: 1px" width="67.4%" size="1">
                                            <img id="edg_imgBorder" style="z-index: 131; left: 40px; position: absolute; top: 160px"
                                                height="32" alt="" src="images/edg_border_all.gif" width="32">
                                            <div style="display: inline; z-index: 132; left: 80px; width: 104px; position: absolute;
                                                top: 160px; height: 16px">
                                                ѡ��Ҫ���ĵı�Ե</div>
                                            <select language="javascript" id="edg_ddlBorder" style="font-size: 12px; z-index: 133;
                                                left: 80px; width: 112px; position: absolute; top: 176px" onchange="return edg_ddlBorder_onchange()">
                                                <option value="top">��</option>
                                                <option value="bottom">��</option>
                                                <option value="left">��</option>
                                                <option value="right">��</option>
                                                <option value="all" selected>ȫ��</option>
                                            </select>
                                            <div style="display: inline; z-index: 134; left: 72px; width: 32px; position: absolute;
                                                top: 210px; height: 15px">
                                                ��ʽ</div>
                                            <select language="javascript" id="edg_ddlBorderStyle" style="font-size: 12px; z-index: 135;
                                                left: 112px; width: 136px; position: absolute; top: 208px" onchange="return edg_ddlBorderStyle_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="none">��</option>
                                                <option value="solid">ʵ��</option>
                                                <option value="double">˫��</option>
                                                <option value="groove">����</option>
                                                <option value="ridge">͹��</option>
                                                <option value="inset">��Ƕ</option>
                                                <option value="outset">��Ƕ</option>
                                            </select>
                                            <div style="display: inline; z-index: 136; left: 72px; width: 32px; position: absolute;
                                                top: 244px; height: 15px">
                                                ���</div>
                                            <select language="javascript" id="edg_ddlBorderWidth" style="font-size: 12px; z-index: 137;
                                                left: 112px; width: 136px; position: absolute; top: 240px" onchange="return edg_ddlBorderWidth_onchange()">
                                                <option value="notset" selected>&lt;δ����&gt;</option>
                                                <option value="thin">ϸ</option>
                                                <option value="">��</option>
                                                <option value="thick">��</option>
                                                <option value="custom">�Զ���</option>
                                            </select>
                                            <select id="edg_ddlBorderWidthUnit" style="font-size: 12px; z-index: 138; left: 312px;
                                                width: 56px; position: absolute; top: 240px" disabled onchange="edg_ShowExample();">
                                                <option value="px" selected>px</option>
                                                <option value="pt">pt</option>
                                                <option value="pc">pc</option>
                                                <option value="mm">mm</option>
                                                <option value="cm">cm</option>
                                                <option value="in">in</option>
                                                <option value="em">em</option>
                                                <option value="ex">ex</option>
                                                <option>%</option>
                                            </select>
                                            <input id="edg_tbBorderWidth" style="font-size: 12px; z-index: 139; left: 256px;
                                                width: 48px; position: absolute; top: 240px; height: 22px" disabled type="text"
                                                onchange="edg_ShowExample();" size="2">
                                            <div style="display: inline; z-index: 140; left: 72px; width: 32px; position: absolute;
                                                top: 276px; height: 15px">
                                                ��ɫ</div>
                                            <input language="javascript" id="edg_tbBorderColor" style="font-size: 12px; z-index: 141;
                                                left: 112px; width: 88px; position: absolute; top: 272px; height: 22px" type="text"
                                                onchange="edg_ShowExample();" size="9">
                                            <input id="edg_btnBorderColor" style="font-size: 12px; z-index: 142; left: 208px;
                                                position: absolute; top: 272px" onclick="selectColor('edg_tbBorderColor');" type="button"
                                                value="...">
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  �б� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabListContent" style="width: 634px; position: absolute; top: 3000px; height: 440px">
                                            <div style="display: inline; z-index: 101; left: 16px; width: 56px; position: absolute;
                                                top: 40px; height: 12px">
                                                ��Ŀ����
                                            </div>
                                            <hr style="z-index: 102; left: 72px; width: 500px; position: absolute; top: 48px;
                                                height: 1px" width="561" size="1">
                                            <div style="display: inline; z-index: 103; left: 16px; width: 40px; position: absolute;
                                                top: 12px; height: 12px">
                                                �б�</div>
                                            <select language="javascript" id="lst_ddlStyle" style="font-size: 12px; z-index: 104;
                                                left: 64px; width: 160px; position: absolute; top: 8px" onchange="return lst_ddlStyle_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="display">��ʾ��Ŀ����</option>
                                                <option value="none">ȡ����Ŀ����</option>
                                            </select>
                                            <select id="lst_ddlStyleType" style="font-size: 12px; z-index: 105; left: 88px; width: 208px;
                                                position: absolute; top: 64px" disabled onchange="lst_ShowExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="circle">Բ��</option>
                                                <option value="disk">Բ��</option>
                                                <option value="square">������</option>
                                                <option value="decimal">���֣�1 2 3 4...��</option>
                                                <option value="lower-roman">Сд�������֣�i ii iii iv...��</option>
                                                <option value="upper-roman">��д�������֣�I II III IV...��</option>
                                                <option value="lower-alpha">Сд��ĸ��a b c d...��</option>
                                                <option value="upper-alpha">��д��ĸ��A B C D...��</option>
                                            </select>
                                            <div style="display: inline; z-index: 106; left: 40px; width: 40px; position: absolute;
                                                top: 68px; height: 12px">
                                                ��ʽ��</div>
                                            <div style="display: inline; z-index: 107; left: 40px; width: 40px; position: absolute;
                                                top: 100px; height: 14px">
                                                λ�ã�</div>
                                            <select id="lst_ddlStylePos" style="font-size: 12px; z-index: 108; left: 88px; width: 208px;
                                                position: absolute; top: 96px" disabled onchange="lst_ShowExample();">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="outside">��ࣨ�ı�������</option>
                                                <option value="inside">�ڲࣨ�ı���������</option>
                                            </select>
                                            <input language="javascript" id="lst_cbCustomImage" style="z-index: 109; left: 40px;
                                                position: absolute; top: 128px" disabled onclick="return lst_cbCustomImage_onclick()"
                                                type="checkbox">
                                            <div style="display: inline; z-index: 110; left: 64px; width: 88px; position: absolute;
                                                top: 132px; height: 14px">
                                                <label for="lst_cbCustomImage">
                                                    �Զ�����Ŀ���</label></div>
                                            <input language="javascript" id="lst_rbStyleImage" style="z-index: 111; left: 56px;
                                                position: absolute; top: 152px" disabled onclick="return lst_rblStyleImage_onclick()"
                                                type="radio" checked name="lst_rblStyleImage">
                                            <div style="display: inline; z-index: 112; left: 80px; width: 32px; position: absolute;
                                                top: 156px; height: 15px">
                                                <label for="lst_rblStyleImage">
                                                    ͼ��</label></div>
                                            <input id="lst_tbStyleImage" style="font-size: 12px; z-index: 113; left: 120px; width: 336px;
                                                position: absolute; top: 152px; height: 22px" disabled type="text" onchange="lst_ShowExample();"
                                                size="50">
                                            <input id="lst_btnStyleImage" style="font-size: 12px; z-index: 114; left: 464px;
                                                width: 24px; position: absolute; top: 150px; height: 24px" onclick="javascript:document.all['lst_tbStyleImage'].value=window.showModalDialog('../ftp/default.aspx?obj=0','','dialogHeight:525px;dialogWidth:730px;center:yes;resizable:no;scroll:yes;status:no');"
                                                disabled type="button" value="...">
                                            <input language="javascript" id="lst_rbStyleImageNone" style="z-index: 115; left: 56px;
                                                position: absolute; top: 176px" disabled onclick="return lst_rblStyleImage_onclick()"
                                                type="radio" name="lst_rblStyleImage">
                                            <div style="display: inline; z-index: 116; left: 80px; width: 16px; position: absolute;
                                                top: 180px; height: 15px">
                                                ��</div>
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  �˾� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabFilterContent" style="width: 640px; position: absolute; top: 3500px;
                                            height: 440px">
                                            <div style="display: inline; z-index: 101; left: 16px; width: 56px; position: absolute;
                                                top: 8px; height: 12px">
                                                �˾�����&nbsp;
                                            </div>
                                            <select language="javascript" id="flt_lbFilter" style="font-size: 12px; z-index: 102;
                                                left: 16px; width: 144px; position: absolute; top: 24px; height: 228px" onchange="return flt_lbFilter_onchange()"
                                                size="14">
                                                <option value="��HTMLԪ�����ֳ�͸���Ľ���Ч����" selected pararemark="Opacity:��͸���ĳ̶ȣ��ٷֱȡ���0��100��0������ȫ͸����100��ʾ��ȫ��͸����;FinishOpacit:���ý����͸��Ч��ʱ������ָ������ʱ��͸���ȣ���Χ��0 �� 100��;Style:���ý���͸������ʽ��ֵΪ0����ͳһ��״��1�������Ρ�2�������״��3�������Ρ�;StartX:������͸��Ч���Ŀ�ʼX���ꡣ;StartY:������͸��Ч���Ŀ�ʼY���ꡣ;FinishX:������͸��Ч������ X �����ꡣ;FinishY:������͸��Ч������ Y �����ꡣ;">
                                                    Alpha</option>
                                                <option value="��HTMLԪ�������紵ģ����Ч��" pararemark="Add:�Ƿ񵥷���ģ�����˲�����һ������ֵ��true����0����false��0����;Direction:����ģ���ķ�������0�ȴ���ֱ���ϣ�Ȼ��ÿ45��Ϊһ����λ��;Strength:����ģ��������ֵ��;">
                                                    Blur</option>
                                                <option value="ͼ��֮��ĵ���͵�����Ч��" pararemark="Duration:����򵭳���ʱ��;">BlendTrans</option>
                                                <option value="��ͼ���е�ĳһ��ɫ���͸��ɫ" pararemark="Color:��ָҪ����Ϊ͸������ɫ��;">Chroma</option>
                                                <option value="��HTMLԪ����һ������ʽ����Ӱ" pararemark="Color:ָ����Ӱ����ɫ��;OffX:ָ����Ӱ�����Ԫ����ˮƽ����ƫ������������;OffY:ָ����Ӱ�����Ԫ���ڴ�ֱ����ƫ������������;Positive:��һ������ֵ��ֵΪtrue����0��ʱ����ʾΪ��������Ӱ��Ϊfalse(0)����ʾΪ��������Ӱ��;">
                                                    DropShadow</option>
                                                <option value="��HTMLԪ��ˮƽ��ת" pararemark="">FlipH</option>
                                                <option value="��HTMLԪ����ֱ��ת" pararemark="">FlipV</option>
                                                <option value="��Ԫ������Χ�������ζ�ģ����Ч��" pararemark="Color:ָ���������ɫ��;Strength:���ǿ�ȣ�������1��255֮����κ�����������Խ�󣬷���ķ�Χ��Խ��;">
                                                    Glow</option>
                                                <option value="��һ����ɫ��ͼƬ��ɺڰ�ɫ" pararemark="">Gray</option>
                                                <option value="����ͼƬ����Ƭ��Ƭ��Ч��" pararemark="">Invert</option>
                                                <option value="��HTMLԪ���Ϸ���һ����Ӱ" pararemark="">Light</option>
                                                <option value="������һ��HTMLԪ������һ��Ԫ���ϲ���ͼ�������" pararemark="Color:���õ�ɫ���ö�����ס��ɫ�Ĳ���͸����;">Mask</option>
                                                <option value="�����л�Ч��" pararemark="Duration:�л�ʱ�䣬����Ϊ��λ��;Transtition:�л���ʽ��������Ϊ��0��23��;">
                                                    RevealTrans</option>
                                                <option value="����һ���Ƚ��������Ӱ" pararemark="Color:ָ��Ӱ����ɫ��;Direction:����ͶӰ�ķ���0�ȴ���ֱ���ϣ�Ȼ��ÿ45��Ϊһ����λ��;">
                                                    Shadow</option>
                                                <option value="��HTMLԪ������ˮƽ���Ǵ�ֱ�����ϵĲ��˱���" pararemark="Add:��ʾ�Ƿ���ʾԭ����0��ʾ����ʾ����0��ʾҪ��ʾԭ����;Freq:���ò����ĸ�����;LightStrength:���ò���Ч���Ĺ���ǿ�ȣ���0��100��0��ʾ������100��ʾ��ǿ��;Phase:���˵���ʼ��ǡ���0��100�İٷ���ֵ�������磺25�൱��90�ȣ���50�൱��180�ȡ���;Strength:���ò���ҡ�ڵķ��ȡ�;">
                                                    Wave</option>
                                                <option value="����HTMLԪ������������������X��һ��" pararemark="">XRay</option>
                                            </select>
                                            <div style="display: inline; z-index: 103; left: 192px; width: 72px; position: absolute;
                                                top: 8px; height: 14px">
                                                ѡ�����˾�</div>
                                            <div id="flt_lblFilterRemark" style="display: inline; z-index: 104; left: 16px; width: 320px;
                                                position: absolute; top: 256px; height: 42px">
                                            </div>
                                            <div id="flt_lblParaRemark" style="display: inline; z-index: 105; left: 376px; width: 240px;
                                                position: absolute; top: 216px; height: 82px">
                                            </div>
                                            <input language="javascript" id="flt_tbParaValue" style="font-size: 12px; z-index: 106;
                                                left: 376px; width: 180px; position: absolute; top: 192px; height: 21px" type="text"
                                                onchange="return flt_tbParaValue_onchange()" size="25">
                                            <div id="flt_lblPara" style="display: inline; z-index: 107; left: 376px; width: 176px;
                                                position: absolute; top: 176px; height: 15px" nowrap>
                                                ����ֵ</div>
                                            <select language="javascript" id="flt_lbSelectedFilter" style="z-index: 108; left: 192px;
                                                width: 144px; position: absolute; top: 24px; height: 222px" onchange="return flt_lbSelectedFilter_onchange()"
                                                size="14" name="lbSelectedFont">
                                            </select>
                                            <img id="flt_imgMoveUp" style="z-index: 109; left: 344px; cursor: hand; position: absolute;
                                                top: 24px" onclick="flt_lbSelectedFilter_MoveUp();" alt="����" src="images/font_up.GIF">
                                            <img id="flt_imgMoveDown" style="z-index: 110; left: 344px; cursor: hand; position: absolute;
                                                top: 56px" onclick="flt_lbSelectedFilter_MoveDown();" alt="����" src="images/font_down.GIF">
                                            <img id="flt_imgRemove" style="z-index: 111; left: 344px; width: 16px; cursor: hand;
                                                position: absolute; top: 224px; height: 16px" onclick="flt_lbSelectedFilter_Remove();"
                                                height="16" alt="�Ƴ�" src="images/font_remove.ico" width="16">
                                            <input language="javascript" id="flt_btnAddFilter" style="z-index: 112; left: 168px;
                                                position: absolute; top: 120px" onclick="return flt_btnAddFilter_onclick(null)"
                                                type="button" value="->">
                                            <select language="javascript" id="flt_lbPara" style="z-index: 113; left: 376px; width: 144px;
                                                position: absolute; top: 24px; height: 146px" onchange="return flt_lbPara_onchange()"
                                                size="9">
                                            </select>
                                            <div style="display: inline; z-index: 114; left: 376px; width: 56px; position: absolute;
                                                top: 8px; height: 15px">
                                                �����б�</div>
                                        </div>
                                        <!-- 
								  
								                                               *************                                                         
									                                         ****************                                                        
																			******  ���� ***** 
									                                         ****************
									                                           *************
									                                           
								-->
                                        <div id="tabOtherContent" style="width: 634px; position: absolute; top: 4000px; height: 440px">
                                            <div style="display: inline; z-index: 101; left: 16px; width: 56px; position: absolute;
                                                top: 8px; height: 12px">
                                                �û�����
                                            </div>
                                            <hr style="z-index: 102; left: 72px; width: 500px; position: absolute; top: 16px;
                                                height: 1px" width="561" size="1">
                                            <div style="display: inline; z-index: 103; left: 80px; width: 40px; position: absolute;
                                                top: 24px; height: 12px">
                                                ��꣺</div>
                                            <img id="oth_imgCursor" style="z-index: 107; left: 40px; position: absolute; top: 24px"
                                                height="32" alt="" src="images/oth_notset.gif" width="32">
                                            <select language="javascript" id="oth_ddlCursor" style="font-size: 12px; z-index: 104;
                                                left: 80px; width: 136px; position: absolute; top: 40px" onchange="return oth_ddlCursor_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="auto">�Զ�</option>
                                                <option value="default">Ĭ��</option>
                                                <option value="crosshair">ʮ����</option>
                                                <option value="hand">����</option>
                                                <option value="move">�ƶ�</option>
                                                <option value="n-resize">���ϵ�����С</option>
                                                <option value="s-resize">���µ�����С</option>
                                                <option value="w-resize">���������С</option>
                                                <option value="e-resize">���ҵ�����С</option>
                                                <option value="nw-resize">�����Ͻǵ�����С</option>
                                                <option value="sw-resize">�����½ǵ�����С</option>
                                                <option value="ne-resize">�����Ͻǵ�����С</option>
                                                <option value="se-resize">�����½ǵ�����С</option>
                                                <option value="text">�ı�</option>
                                                <option value="wait">ɳ©</option>
                                                <option value="help">����</option>
                                            </select>
                                            <div style="display: inline; z-index: 106; left: 80px; width: 40px; position: absolute;
                                                top: 80px; height: 12px">
                                                �߿�</div>
                                            <img id="oth_imgBdrColl" style="z-index: 110; left: 40px; position: absolute; top: 80px"
                                                height="32" alt="" src="images/oth_borderCollapse_notset.gif" width="32">
                                            <select language="javascript" id="oth_ddlBdrColl" style="font-size: 12px; z-index: 105;
                                                left: 80px; width: 136px; position: absolute; top: 96px" onchange="return oth_ddlBdrColl_onchange()">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="separate">�ָ���Ԫ��߿�</option>
                                                <option value="collapse">�۵���Ԫ��߿�</option>
                                            </select>
                                            <div style="display: inline; z-index: 108; left: 16px; width: 16px; position: absolute;
                                                top: 64px; height: 15px">
                                                ��</div>
                                            <hr style="z-index: 109; left: 32px; width: 538px; position: absolute; top: 72px;
                                                height: 1px" width="538" size="1">
                                            <div style="display: inline; z-index: 111; left: 240px; width: 40px; position: absolute;
                                                top: 80px; height: 12px">
                                                ���֣�</div>
                                            <select id="oth_ddlTblLay" style="font-size: 12px; z-index: 112; left: 240px; width: 136px;
                                                position: absolute; top: 96px">
                                                <option value="" selected>&lt;δ����&gt;</option>
                                                <option value="auto">�Զ�</option>
                                                <option value="fixed">�̶�����</option>
                                            </select>
                                            <div style="display: inline; z-index: 113; left: 16px; width: 24px; position: absolute;
                                                top: 132px; height: 15px">
                                                URL</div>
                                            <input id="oth_tbBehavior" style="font-size: 12px; z-index: 114; left: 48px; width: 424px;
                                                position: absolute; top: 128px; height: 22px" type="text" size="65">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <hr style="z-index: 101; left: 80px; width: 526px; position: absolute; top: 16px;
                                height: 1px" width="595" size="1">
                            <hr style="z-index: 100; left: 80px; width: 526px; position: absolute; top: 16px;
                                height: 1px" width="595" size="1">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
