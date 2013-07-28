<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BMapPickerPage.aspx.cs" Inherits="We7.Model.UI.Controls.page.BMapPickerPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>地图定位</title>
    <script src="/Scripts/jQuery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="<%=AppPath%>/theme/Style/main.css" media="screen" />
    <script src="<%=AppPath%>/cgi-bin/DialogHelper.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
    <script type="text/javascript">
        function SearchUserOnClick() {
            var local = new BMap.LocalSearch(map, {
                renderOptions: { map: map }
            });
            var address = document.getElementById("searchkey");
            local.search(address.value);
            marker1.setPosition(map.getCenter());
        }

        function onSelectHyperLinkClick(id, name) {
            var t = name;
            var v = marker1.getPosition();
            weCloseDialog(v.lng+","+v.lat,t);
        }
    </script>
    <style type="text/css">
        #allmap {
            width: 680px;
            height: 380px;
        }
        #searchBar {
            height:50px;
            width: 680px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="searchBar">
            <table>
                <tbody>
                    <tr>
                        <td>
                            <b>地名：</b><input style="width:250px;" type="text" name="searchkey" id="searchkey"/>
                        </td>
                        <td>
                            <input type="button" class="button" value="搜索" onclick="SearchUserOnClick();" style="margin-right:0px;"/>
                            <input type="button"  onclick="onSelectHyperLinkClick('fff','fff');" class="button" value="确定"/>  
                            <span style="font-size:10px;color:#666;">(拖动红点定位)</span>
                        </td>
                    </tr>
                </tbody>
            </table>
           
        </div>
    <div id="allmap"></div>
    </form>
</body>
</html>
<script type="text/javascript">
   

    var map = new BMap.Map("allmap");            // 创建Map实例
    var point = new BMap.Point(115.884133, 28.663079);    // 创建点坐标
    map.centerAndZoom(point, 17);                     // 初始化地图,设置中心点坐标和地图级别。
    map.addControl(new BMap.MapTypeControl({ mapTypes: [BMAP_NORMAL_MAP, BMAP_HYBRID_MAP] }));     //2D图，卫星图
    map.addControl(new BMap.MapTypeControl({ anchor: BMAP_ANCHOR_TOP_LEFT }));    //左上角，默认地图控件
    map.setCurrentCity("南昌");   //由于有3D图，需要设置城市哦
    //map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    map.addControl(new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL }));  //右上角，仅包含平移和缩放按钮
    map.addControl(new BMap.NavigationControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_PAN }));  //左下角，仅包含平移按钮
    map.addControl(new BMap.NavigationControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, type: BMAP_NAVIGATION_CONTROL_ZOOM }));  //右下角，仅包含缩放按钮
    map.enableScrollWheelZoom();                            //启用滚轮放大缩小
    var marker1 = new BMap.Marker(new BMap.Point(115.884133, 28.663079));  // 创建标注
    marker1.enableDragging();
    map.addOverlay(marker1);
    marker1.addEventListener("dragend", function SetCenter() {
        map.panTo(marker1.getPosition());
    });

</script>