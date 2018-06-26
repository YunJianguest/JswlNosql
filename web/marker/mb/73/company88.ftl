<!DOCTYPE html>
<html>
<head>
<title>寿 宴</title>
<meta charset=utf-8"UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/73/css/index.css" tppabs="http://wx.kuaitec.com/Public/css/Sy/index.css" media="all">
<script type="text/javascript" src="/MyNosql/marker/mb/73/js/jquery-1.10.1.min.js" tppabs="http://wx.kuaitec.com/Public/js/jquery-1.10.1.min.js"></script>
</head>
<body onselectstart="return true;" ondragstart="return false;">
<div id="cover">
<div class="mask"></div>
</div>
<div id="mymask" onclick='document.getElementById("mymask").style.display="none"'>
    <img src="/MyNosql/marker/mb/73/img/guide.png" tppabs="http://wx.kuaitec.com/Public/images/Baby/guide.png" />
</div>
<div class="dp">
<img src="/MyNosql/marker/mb/73/img/t.png" tppabs="http://wx.kuaitec.com/Public/images/Sy/t.png" />
</div>
<div class="content">
<#if (picurl?size>0)>

<ul>
<li class="pb_10"><video src="/MyNosql/marker/mb/73/img/sou.mp4" tppabs="http://www.kuaitec.com/vd/sou.mp4" width="100%" id="myvd"  controls></video>
 <#list picurl as pic>
<li class="pb_10"><img src="${osshttp}${pic}"  style="width:100%;"></li>
 
<#list>
</ul>

</#if>
<div style="text-align:left;font-size:22px;margin-top:10px;">想说的话</div>
<div style="text-align:left;margin-top:5px;border:2px solid #000;border-radius:8px;padding:5px;line-height:22px;font-size:18px;">${company.context}</div>

<#if (footList?size>0)>
<#list footList as foot>
<a class="abu" href="${foot.url}">${foot.name}<span class="yuan">${foot.summary}</span></a>
</#list>
</#if>

<a class="sharebutton" href="javascript:void(0)" onclick='document.getElementById("mymask").style.display="block"'><span class="minijiankatong">分享给朋友</span></a>
</div>


<div class="bot"></div>
 

<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
WeixinJSBridge.call('hideToolbar');
});
</script>
</body>
<script type="text/javascript"> 
var ist=true;
var covert=true;
    th=-$('#cover').height()+"px";

function closecover(){
$('#cover').animate({top:th},900,'swing',function(){
    $('#cover').remove();
});
}
var handler_touch=function(e){
    closecover();
	if(document.getElementById('myaudio')){
   document.getElementById('myaudio').play();
	}
	if(document.getElementById('myvd')){
   document.getElementById('myvd').play();
	}
    e.preventDefault();
    return false;
}
$('#cover').one('touchstart',handler_touch);
</script>
    <script type="text/javascript">
    	window.shareData = {
			"imgUrl": "${osshttp}${company.logo}",
			"link": "${ip}/marker/company/company${company._id}.html",
			"title": "${company.name}",
			"content": "${company.summary}"
		};
	</script>
	<script type="text/javascript">

	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	// 发送给好友
	WeixinJSBridge.on('menu:share:appmessage', function (argv) {
		WeixinJSBridge.invoke('sendAppMessage', { 
			"img_url": window.shareData.imgUrl,
			"img_width": "640",
			"img_height": "640",
			"link": window.shareData.link,
			"desc": window.shareData.content,
			"title": window.shareData.title
		}, function (res) {
			weimobAfterShare("",window.shareData.link,'appmessage');
			_report('send_msg', res.err_msg);
		})
	});

	// 分享到朋友圈
	WeixinJSBridge.on('menu:share:timeline', function (argv) {
		WeixinJSBridge.invoke('shareTimeline', {
			"img_url": window.shareData.imgUrl,
			"img_width": "640",
			"img_height": "640",
			"link": window.shareData.link,
			"desc": window.shareData.content,
			"title": window.shareData.title
		}, function (res) {
			weimobAfterShare("",window.shareData.link,'timeline');
			_report('timeline', res.err_msg);
		});
	});

	// 分享到微博
	WeixinJSBridge.on('menu:share:weibo', function (argv) {
		WeixinJSBridge.invoke('shareWeibo', {
			"content": window.shareData.content,
			"url": window.shareData.link
		}, function (res) {
			weimobAfterShare("",window.shareData.link,'weibo');
			_report('weibo', res.err_msg);
		});
	});
}, false);
</script>
</html>