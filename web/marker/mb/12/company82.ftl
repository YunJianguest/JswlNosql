<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${company.name}</title>
<link type="text/css" rel="stylesheet" href="/MyNosql/marker/mb/12/css/comom.css"/>
<meta name = "viewport" content = "width=device-width, minimum-scale=1, maximum-scale=1">
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<script language="javascript" type="text/javascript" src="/MyNosql/marker/mb/12/js/jQuery.js"/></script>
<script>
function  show_ewm(){
  $('#ewm_img_y').css('display','block');
  $('#ewm_bj').css('display','block');
  
}
function  hide_ewm()
{
$('#ewm_img_y').css('display','none');
$('#ewm_bj').css('display','none');
} 

</script>
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/12/css/music90.css">
<script src="/MyNosql/marker/mb/12/js/player.js" ></script>
<link rel="stylesheet" type="text/css"
	href="/MyNosql/marker/mb/12/css/snower.css-2014-03-07-1.css"
	media="all" />
</head>
<#if (picurl?size>0)> 
<#list picurl as pic> 
<body style=" background: white url(${osshttp}${pic}) no-repeat fixed;">
<#if footList[0]??>
<div class="ewm_img_y" id="ewm_img_y" style="display:none">
<div class="ewm_bj" id="ewm_bj" onclick="hide_ewm()" style="display:none"">
<img  src="${osshttp}${footList[0].picurl"/>
</div>
</div>
</#if>
<div class="music90">

<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>
<#if footList[1]??>
<div class="snower">
<script type="text/javascript">
var urls = [ '${osshttp}${footList[1].picurl}'/*tpa=http://114.215.116.254/MyNosql/uploads/images/20140708/213938140.jpg*/]
</script>
<script type="text/javascript" src="/MyNosql/marker/mb/12/js/maivl.js" ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/12/js/snower1.js" ></script>
</div>
</#if>
<header>

<div class="companylogo"><img src="${company.logo}"/> </div>
<div class="companyname"><a href=""><strong><span class="name_sp">${company.summary}</span></strong></a></div>
</div>
<div><div class="company_zw">${company.context}<a onclick="show_ewm()">
<img  class="ewm_img" src="/MyNosql/marker/mb/12/img/mp.png"/></a></div></div>
</header>
<#if (funcList?size>0)>
<div class="circle">
  
  <div class="ring">
  <#if funcList[0]??>
    <a href="${funcList[0].url}" class="menuItem fa fa-home fa-2x"></a>
  </#if>
  <#if funcList[1]??>
    <a href="${funcList[1].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
  <#if funcList[2]??>
    <a href="${funcList[2].url}" class="menuItem fa fa-map-marker fa-2x"></a>
  </#if>
  <#if funcList[3]??>
    <a href="${funcList[3].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
  <#if funcList[4]??>
    <a href="${funcList[4].url}" class="menuItem fa fa-music fa-2x"></a>
  </#if>
  <#if funcList[5]??>
    <a href="${funcList[5].url}" class="menuItem fa fa-user fa-2x"></a>
  </#if>
  <#if funcList[6]??>
    <a href="${funcList[6].url}" class="menuItem fa fa-shopping-cart fa-2x"></a>
  </#if>
  <#if funcList[7]??>
    <a href="${funcList[7].url}" class="menuItem fa fa-phone-square fa-2x"></a>
  </#if>
  </div>
  <a href="#" class="center fa fa-th fa-2x"></a>
</div>
</#if>

<#if footList[2]??>
<footer style="overflow:visible;">
		<div class="weimob-support">

<span>${footList[2].summary}</span>
		 </div>
</footer>
</#if>
</body>
</#list>
</#if>
<script language="javascript" type="text/javascript" src="js/nav.js"/></script>
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
