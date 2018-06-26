
var map = new BMap.Map("container");
/*$(document).ready(function() {
	creteMap();
});*/
//创建地图
function creteMap(page_lng,page_lat) {
	map.centerAndZoom(new BMap.Point(page_lng,page_lat), 14);
	map.enableScrollWheelZoom();
	map.enableDragging();	
}



