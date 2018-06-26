var map;
var mapType="baidu";
var point="";
var pointsStr = "";
var points;
var polyline;
var polygon;
var allDistance = "";
var infoWindow;
var centerMarker = null;
var markers;
var polys;
var curCity = "";
var flag;
// 初始化地图,设置中心点坐标和地图级别。
function init() {

	points = new Array();
	markers = new Array();
	polys = new Array();
	//百度
	if (mapType == "baidu" || mapType == null) {
		map = new BMap.Map("container");                   // 创建Map实例
		point = new BMap.Point(108.94702, 34.25944);       // 创建点坐标
		map.centerAndZoom(point,12); 					   //设置地图中心点和缩放级别
		map.enableScrollWheelZoom();					   //滚轮缩放
		var opts = {offset: new BMap.Size(10, 27)};		   //控制缩放控件位置
		var opts2 = {offset: new BMap.Size(10, 27)};       //控制地图类型控件位置
		map.addControl(new BMap.NavigationControl(opts));  // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl());           // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl());     //添加缩略地图控件
		map.addControl(new BMap.MapTypeControl(opts2));    //添加地图类型控件
	}
	//谷歌
	if (mapType == "google") {
		point = new google.maps.LatLng(34.25944, 108.94702);
	    var mapoptions = {
	        zoom: 12,
	        center: point,
	        panControl: true,
	        streetViewControl: false,
	        zoomControl: true,
	        scaleControl: true,
	        mapTypeControl: true,
	        mapTypeControlOptions: {
	    		position: google.maps.ControlPosition.BOTTOM_CENTER
            },
	        mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
	    map = new google.maps.Map(document.getElementById("container"), mapoptions);
	}
}
/*初始化地图中心点*/
function initCenterMarker(point) {
	if (mapType == "baidu") {
		var icon = new BMap.Icon("../images/cluster.png",new BMap.Size(32,37));
		var centerMarkerOpts = {
			icon:icon 
		};
		centerMarker = new BMap.Marker(point, centerMarkerOpts);
		map.addOverlay(centerMarker);
	}
	if (mapType == "google") {
		 var centerMarkerOpts = {
			  position: point,
			  icon:"../images/cluster.png",
		      map: map  
		 };
		 centerMarker = new google.maps.Marker(centerMarkerOpts);
		 map.setCenter(centerMarker.getPosition());
	}
}
/*根据经纬度创建点*/
function createPoint(lgt, lat) {
	//百度
	if (mapType == "baidu") {
		point = new BMap.Point(lgt, lat);
	} 
	//谷歌
	if (mapType == "google") {
		point = new google.maps.LatLng(lat, lgt);
	}
}
/*编写自定义函数,创建标注*/
function addMarker(point, content, i) {
  var marker;
  setMarkerPro();
  //百度
  if (mapType == "baidu"){
	  marker = new BMap.Marker(point, getOpts(mapType, messageType));
	  marker.setContent(content);
	  var label = new BMap.Label((i+1)+"",{offset:new BMap.Size(3,40)});
	  label.setStyle({color : "#FFFFFF", 
		  fontSize : "12px", 
		  background:"url(../images/car.gif)", 
		  border:"0px",
		  width:"40px",
		  height:"19px",
		  textAlign:"center",
		  lineHeight:"middle"
	});
	  marker.setLabel(label);
	  map.addOverlay(marker);
	  marker.addEventListener("click", function(){
		  createInfoWindow(this.content);
		  this.openInfoWindow(infoWindow);
	  });
  } 
  //谷歌
  if (mapType == "google") {
	  marker = new google.maps.Marker(getOpts(mapType, messageType));
	  markers.push(marker);
	  map.setCenter(marker.getPosition());
	  var label = new Label({       
		  map: map     
	  });  
	  label.bindTo('position', marker, 'position');     
	  label.bindTo('text', marker, 'position');
	  label.setHtml("<div style='background-image: url(../images/images_end/sz_bj.png);width:40px;height:19px; font-size:12px;color:#FFFFFF;text-align:center'>" + (i+1) +"</div>");
	  label.setstyleValues("position: relative;left: -50%;top: -8px;'+'white-space: nowrap;padding: 2px; " );
	  label.setPos(12,3);
	  labelArray.push(label);
	  google.maps.event.addListener(marker, "click", function(){
		  createInfoWindow(this.content);
		  infoWindow.open(map, marker);
	  });
  }
}
/*编写自定义函数,创建标注*/
function addMarker(point, content) {
  var marker;
  setMarkerPro();
  //百度
  if (mapType == "baidu"){
	  marker = new BMap.Marker(point);
	  marker.setContent(content);
	  map.addOverlay(marker);
	  marker.addEventListener("click", function(){
		  createInfoWindow(this.content);
		  this.openInfoWindow(infoWindow);      
	  });
  } 
  //谷歌
  if (mapType == "google") {
	  var opts = {
		  position: point,
		  content:content,
	      map: map  
	  };
	  marker = new google.maps.Marker(opts);
	  markers.push(marker);
	  map.setCenter(marker.getPosition());
	  google.maps.event.addListener(marker, "click", function(){
		  createInfoWindow(this.content);
		  infoWindow.open(map, marker);
	  });
  }
}
/*为Marker类创建setContent方法*/
function setMarkerPro() {
	if (mapType == "baidu") {
		BMap.Marker.prototype.setContent = function(content) {
			this.content = content;
		};
	}
	if (mapType == "google") {
		google.maps.Marker.setContent = function(content) {
			this.content = content;
		};
	}
}

/*清除地图上的覆盖物*/
function clearMarkers() {
	//百度
	if (mapType == "baidu") {
		map.clearOverlays();
	}
	//谷歌
	if (mapType == "google") {
		if (markers.length > 0) {
			for(var i = 0; i < markers.length; i++){
				markers[i].setMap(null);;
			}
			markers.length = 0;
		}
		if (polys.length > 0) {
			for(var j = 0; j < polys.length; j++){
				polys[j].setMap(null);;
			}
			polys.length = 0;
		}
		if (centerMarker != null) {
			centerMarker.setMap(null);
			centerMarker = null;
		}
	}
}
/*创造信息窗口*/
function createInfoWindow(content){
	//百度
	if (mapType == "baidu") {
	    var opts = {
		  width : 250,     // 信息窗口宽度
		  height: 160     // 信息窗口高度
	    };
	    infoWindow = new BMap.InfoWindow(content, opts);  // 创建信息窗口对象
	} 
	//谷歌
	if (mapType == "google") {
		infoWindow = new google.maps.InfoWindow({
	        content: content
		});
	}
}
function getAddress(lng, lat, i) {
	//百度
	if (mapType == "baidu") {
		var point = new BMap.Point(lng,lat);
	    var gc = new BMap.Geocoder();    
		gc.getLocation(point, function(rs){
			 var address = rs.address;
			 $("#position" + i).html("地址：" + address);
		});   
	}
	if (mapType == "google") {
		var latlng = new google.maps.LatLng(lat, lng);
		var geocoder = new google.maps.Geocoder();
		geocoder.geocode({
            'latLng': latlng
        }, function(results, status){
            if (status == google.maps.GeocoderStatus.OK) {
               $("#position" + i).html("地址：" + results[1].formatted_address);
            }
        });
	}
}
/*获得最佳视角*/
function getFitView(points) {
	//百度
	if (mapType == "baidu") {
		map.setViewport(points);
	} 
	//谷歌
	if (mapType == "google") {
		var bounds = new google.maps.LatLngBounds(points[0], points[0]);
	    for (var i = 1; i < points.length; i++) {
	        bounds.extend(points[i]);
	    }
	    map.fitBounds(bounds);
	}
}
/*开始画多边形*/
function startDraw() {
	map.clearOverlays(); 
	map.addEventListener("click", drawPolygon);
	map.addEventListener("rightclick", finishPolygon);
}
/*画多边形*/
function drawPolygon(e) {
	map.clearOverlays(); 
	point = new BMap.Point(e.point.lng, e.point.lat);
	points.push(point); 
	var icon = new BMap.Icon("../images/yq.png",new BMap.Size(12,12));
	for (var i=0; i<points.length; i++) {
		var marker = new BMap.Marker(points[i], {icon:icon});
		map.addOverlay(marker);
	}
	if (points.length>1) {
		//画出多边形的各个边
		polyline = new BMap.Polyline(points,{strokeColor:"red", strokeWeight:3, strokeOpacity:0.5});
		map.addOverlay(polyline);
	}
}
/*完成多边形*/
function finishPolygon(){
	map.clearOverlays(); 
	polygon = new BMap.Polygon(points, {strokeColor:"red", strokeWeight:3, strokeOpacity:0.5});
	map.addOverlay(polygon);
	getPoints(polygon.getPath());
	if (polygon != undefined) {
		polygon.addEventListener("mouseover", polygonEnableEditing);
		polygon.addEventListener("mouseout", polygonUpdate);
	}
}
/*获得多边形的顶点*/
function getPoints(points) {
	pointsStr = "";
	if (points.length > 0) {
		for (var i=0; i<points.length; i++) {
			pointsStr += points[i].lng + ":" + points[i].lat;
			if (i < points.length-1) {
				pointsStr += ",";
			}
		}
		addPointsValue();
	}
}
/*已存在的多边形允许编辑*/
function polygonEnableEditing() {
	polygon.enableEditing();
}
/*编辑多边形*/
function polygonUpdate() {
	map.removeEventListener("click", drawPolygon);
	map.removeEventListener("rightclick", finishPolygon);
	polygon.removeEventListener("mouseover", polygonEnableEditing);
	polygon.addEventListener("lineupdate", function(){
		var p = polygon.getPath();
		getPoints(p);
	});
}
/*反显多边形*/
function showPolygon(points) {
	if (map != undefined) {
		map.setViewport(points);
		map.clearOverlays(); 
	}
	polygon = new BMap.Polygon(points, {strokeColor:"red", strokeWeight:3, strokeOpacity:0.5});
	if (map != undefined) {
		map.addOverlay(polygon);
	}
	if (polygon != undefined) {
		polygon.addEventListener("mouseover", polygonEnableEditing);
		polygon.addEventListener("mouseout", polygonUpdate);
	}
}
/*清屏*/
function clear() {
	clearResult();
	clearMarkers();
	if (mapType == "baidu") {
		map.centerAndZoom(new BMap.Point(108.95, 34.27),12);
		map.removeEventListener("click",getDistanceForBaidu); 

	}
	if (mapType == "google") {
		var latlng = new google.maps.LatLng(34.25944, 108.94702);
		map.setCenter(latlng);
		google.maps.event.clearListeners(map, 'click');
	}
	setCurCityContent();
	closeDiv();
 }
/*折线测距（百度）*/
function getDistanceForBaidu(e) {
	clearMarkers(); 
	point = new BMap.Point(e.point.lng, e.point.lat);
	points.push(point); 
	var icon = new BMap.Icon("../images/yq.png",new BMap.Size(12,12));
	for (var i=0; i<points.length; i++) {
		var marker = new BMap.Marker(points[i], {icon:icon});
		map.addOverlay(marker);
	}
	if (points.length>1) {
		polyline = new BMap.Polyline(points,{strokeColor:"red", strokeWeight:3, strokeOpacity:0.5});
		map.addOverlay(polyline);
		var distance = map.getDistance(points[points.length-2], points[points.length-1])/1000;
		allDistance = allDistance*1+distance;
		var number = allDistance.toString();
		number = number.substring(0, number.indexOf(".")+5);
		addResult(number);
	}
}
/*折线测距（谷歌）*/
function getDistanceForGoogle() {
	flag = 0;
	clearResult();
	clearMarkers(); 
	var polyOptions = {
        strokeColor: '#FF0000',
        strokeOpacity: 0.5,
        strokeWeight: 3
    };
	polyline = new google.maps.Polyline(polyOptions);
	polyline.setMap(map);
	google.maps.event.addListener(map, 'click', addLatLng);
}
/*描点画线测距*/
function addLatLng(event) {
	var path = polyline.getPath();
    path.push(event.latLng);
    var marker = new google.maps.Marker({
        position: event.latLng,
        title: '#' + path.getLength(),
        icon: "../images/yq.png",
        map: map
    });
    markers.push(marker);
    polys.push(polyline);
    var p = path.getArray();
    if (p.length > 1) {
    	var len = distance(p[0].lat(),p[0].lng(), p[flag+1].lat(), p[flag+1].lng())/1000;
    	allDistance = len;
    	var number = allDistance.toString();
    	number = number.substring(0, number.indexOf(".")+5);
    	addResult(number);
    	flag++;
    }
}
/*计算球面距离*/
function distance(sX,sY,eX,eY){
	var lat = [sX, eX];
	var lng = [sY, sY]; //var R = 6371; // km (change this constant to get miles)
	var R = 6378137; // In meters
	var dLat = (lat[1] - lat[0]) * Math.PI / 180;
	var dLng = (lng[1] - lng[0]) * Math.PI / 180;
	var dLat1 = lat[0] * Math.PI / 180;
	var dLat2 = lat[1] * Math.PI / 180;
	var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(dLat1) * Math.cos(dLat1) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	var d = R * c;
	return Math.round(d);
}
/*折线测距*/
function getDistance(){
	if (mapType == "baidu") {
		map.addEventListener("click", getDistanceForBaidu);
	}
	if (mapType == "google") {
		getDistanceForGoogle();
	}
}
/*百度查询*/
function searchForBaidu(addr) {
	if (addr != "") {
		var local = new BMap.LocalSearch(map, {renderOptions:{map: map,autoViewport: true,selectFirstResult: false}});
		local.search(addr);
	} else {
		inputFocus("addr");
	}
}
/*谷歌查询*/
function searchForGoogle(addr) {
	setMarkerPro()
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
        'address': addr
    }, function(results, status){
        if (status == google.maps.GeocoderStatus.OK) {
			var bounds = new google.maps.LatLngBounds();
			for(i = 0; i < results.length; i++){
                map.setCenter(results[i].geometry.location);
				bounds.extend(results[i].geometry.location);
				var marker = new google.maps.Marker({
                    position: results[i].geometry.location,
                    content:results[i].formatted_address,
                    map: map
                });
                google.maps.event.addListener(marker, "click", function(){
          		  createInfoWindow(this.content);
          		  infoWindow.open(map, this);
          	  	});
			}
			map.fitBounds(bounds);
        } else {
            inputFocus("addr");
        }
    });
}
/*本地搜索*/
function search(addr) {
	if (mapType == "baidu") {
		searchForBaidu(addr);
	}
	if (mapType == "google") {
		searchForGoogle(addr);
	}
}