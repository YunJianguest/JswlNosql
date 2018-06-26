<%@ page contentType="text/html;charset=UTF-8"%>
<style type="text/css"> 
 
#container {
   width:470px;
   height:330px;
   margin-left: 10%;
   
   
}
</style>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script>
var geocoder,map,marker= null;
var init = function() {
    var center = new qq.maps.LatLng(39.916527,116.397128);
    map = new qq.maps.Map(document.getElementById('container'),{
        center: center,
        zoom: 15
    });
//给map绑定mousemove事件
    var label = new qq.maps.Label({
        offset:new qq.maps.Size(15,0)
    });
    //添加监听事件    监听鼠标移动 添加 当前鼠标的经纬度信息
    qq.maps.event.addListener(map,"mousemove",function(e){
        label.setContent(e.latLng.toString());
        label.setPosition(e.latLng);
    });
    //添加监听事件  当鼠标移到图层上面显示图层
    qq.maps.event.addListener(map,"mouseover",function(e){
        label.setMap(map);
    });
    //添加监听事件  当鼠标离开的时候 设置图层为空
    qq.maps.event.addListener(map,"mouseout",function(e){
        label.setMap(null);
    });
    //添加监听事件  当鼠标点击时，返回经纬度；
    qq.maps.event.addListener(map,"mousedown",function(e){
       $("#latLng").val(e.latLng.toString());
     
    });
    //调用地址解析类
    geocoder = new qq.maps.Geocoder({
        complete : function(result){
            map.setCenter(result.detail.location);
            var marker = new qq.maps.Marker({
                map:map,
                position: result.detail.location
            });
        }
    });
}


function codeAddress() {
    var address = $("#address").val();
    //通过getLocation();方法获取位置信息值
    geocoder.getLocation(address);
}
function codeLatLng() {
    //获取经纬度数值   按照,分割字符串 取出前两位 解析成浮点数
    var input =$("#latLng").val();
    var latlngStr = input.split(",",2);
    var lat = parseFloat(latlngStr[0]);
    var lng = parseFloat(latlngStr[1]);
    var latLng = new qq.maps.LatLng(lat, lng);
    //调用信息窗口
    var info = new qq.maps.InfoWindow({map: map});
    //调用获取位置方法
    geocoder.getAddress(latLng);
}
</script>
 
 
<div class="col-sm-7">
<input  class="form-control" id="address" placeholder="请输入城市" type="text">
</div>
<div class="col-sm-2">
<a class="btn btn-primary" onclick="codeAddress()">搜&nbsp;&nbsp;索</a> 
</div>
<div id="container"></div>
 
 
