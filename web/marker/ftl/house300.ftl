<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="keywords" content="${company.keyword}" />
<meta name="description" content="${company.keyword}" />
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<link rel="stylesheet" type="text/css" href="/MyNosql/weimob/css/template/reset.css-2014-03-07-1.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/weimob/css/template/snower.css-2014-03-07-1.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/weimob/css/template/common.css-2014-03-07-1.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/weimob/css/template/font-awesome.css-2014-03-07-1.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/weimob/css/template/home-40.css-2014-03-07-1.css"
	media="all" />
<script type="text/javascript" src="/MyNosql/weimob/js/maivl.js"></script>
<script type="text/javascript" src="/MyNosql/weimob/js/jQuery.js"></script>
<script type="text/javascript" src="/MyNosql/weimob/js/zepto.js"></script>
<script type="text/javascript" src="/MyNosql/weimob/js/swipe.js"></script>
<script type="text/javascript" src="/MyNosql/weimob/js/audio.js"></script>
<title>${company.name }</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta content="application/xhtml+xml;charset=UTF-8"
	http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent" />
<link href="/MyNosql/lanrenmb/css/common.css" rel="stylesheet" type="text/css" />
</head>
<body onselectstart="return true;" ondragstart="return false;">
	<style type="text/css">
body {
	background: url("/MyNosql/weimob/img/template/lib/v42_bg.jpg")
}
</style>
	<div class="body">
		<div style="-webkit-transform: translate3d(0, 0);">
			<div id="banner_box" class="box_swipe">
				<ul>
					<#list picurl as pic> 
						<li><a onclick="return false;"> <img
								src="${osshttp}${pic}" alt="" style="width: 100%;" /> </a></li>
					</#list>

				</ul>
				<ol>
					
					<#list picurl as pic> 
						<li></li>
					</#list>
				</ol>
			</div>
		</div>
		<script>
			$(function() {
				new Swipe(document.getElementById('banner_box'), {
					speed : 500,
					auto : 3000,
					callback : function() {
						var lis = $(this.element).next("ol").children();
						lis.removeClass("on").eq(this.index).addClass("on");
					}
				});
			});
		</script>
		<#if company.mp3 !="">
			<script>
				window.addEventListener("DOMContentLoaded", function(){
					playbox.init("playbox");
				}, false);
			</script>
		<span id="playbox" class="btn_music"
			onclick="playbox.init(this).play();"><audio
				src="${osshttp}${company.mp3 }"
				loop id="audio"></audio>
		</span> <br />
		</#if>
		<section>
			<nav>
				<ul class="nav_links box">
					
					<#if funcList[0]??>
					<#if funcList[0].method=="link">
						<li><a href="${funcList[0].url}">${funcList[0].name}</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[0].method}.action?_id=1&type=${funcList[0].type}&toUser=${toUser}">${funcList[0].name}</a></li>
					</#if>
					</#if>
					
					<#if funcList[1]??>
					<#if funcList[1].method=="link">
						<li><a href="${funcList[1].url}">${funcList[1].name}</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[1].method}.action?_id=1&type=${funcList[1].type}&toUser=${toUser}">${funcList[1].name}</a></li>
					</#if>
					</#if>
					<#if funcList[2]??>
					<#if funcList[2].method=="link">
						<li><a href="${funcList[2].url}">${funcList[2].name}</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[2].method}.action?_id=1&type=${funcList[2].type}&toUser=${toUser}">${funcList[2.name}</a></li>
					</#if>
					</#if>
					<#if funcList[3]??>
					<#if funcList[3].method=="link">
						<li><a href="${funcList[3].url}">${funcList[3].name}</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[3].method}.action?_id=1&type=${funcList[3].type}&toUser=${toUser}">${funcList[3].name}</a></li>
					</#if>
					</#if>
				</ul>
			</nav>
			<div>
				<ul class="ofh ul_list">
					<#if funcList[4]??>
					<#if funcList[4].method=="link">
					<li><a href="${funcList[4].url}"
								style="background-image: url(${osshttp}${funcList[4].picurl});"> <label>${funcList[4].name}</label>
					</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[4].method}.action?_id=1&type=${funcList[4].type}&toUser=${toUser}"
								style="background-image: url(${osshttp}${funcList[4].picurl});"> <label>${funcList[4].name}</label></a></li>
					</#if>
					</#if>
					
					<#if funcList[5]??>
					<#if funcList[5].method=="link">
					<li><a href="${funcList[5].url}"
								style="background-image: url(${osshttp}${funcList[5].picurl});"> <label>${funcList[5].name}</label>
					</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[5].method}.action?_id=1&type=${funcList[5].type}&toUser=${toUser}"
								style="background-image: url(${osshttp}${funcList[5].picurl});"> <label>${funcList[6].name}</label></a></li>
					</#if>
					</#if>
					<#if funcList[6]??>
					<#if funcList[6].method=="link">
					<li><a href="${funcList[6].url}"
								style="background-image: url(${osshttp}${funcList[6].picurl});"> <label>${funcList[6].name}</label>
					</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[6].method}.action?_id=1&type=${funcList[6].type}&toUser=${toUser}"
								style="background-image: url(${osshttp}${funcList[6].picurl});"> <label>${funcList[6].name}</label></a></li>
					</#if>
					</#if>
					<#if funcList[7]??>
					<#if funcList[7].method=="link">
					<li><a href="${funcList[7].url}"
								style="background-image: url(${osshttp}${funcList[7].picurl});"> <label>${funcList[7].name}</label>
					</a></li>
					<#else>
						<li><a href="/MyNosql/wwz/wwz!${funcList[7].method}.action?_id=1&type=${funcList[7].type}&toUser=${toUser}"
								style="background-image: url(${osshttp}${funcList[7].picurl});"> <label>${funcList[7].name}</label></a></li>
					</#if>
					</#if>
					<#if funcList[8]??>
					<#if funcList[8].method=="link">
					<ol style="background-image: url(${osshttp}${funcList[8].picurl});" onclick="window.location.href='${funcList[8].url}'"></ol>
					<#else>
					<ol style="background-image: url(${osshttp}${funcList8].picurl});" onclick="window.location.href='/MyNosql/wwz/wwz!${funcList[8].method}.action?_id=1&type=${funcList[8].type}&toUser=${toUser}'"></ol>
					</#if>
					</#if>
					
				</ul>
			</div>
		</section>
		
	</div>
<#if (footList?size>0)>
<div class="moveleft">

 <div id="header">
  
    <div class="hewarp">
		<ul>
			<#list footList as foot> 
			<li class="index">
				<a href="${foot.url}" title="${foot.name}">
				<img src="${osshttp}${foot.picurl}" alt=""/>
				${foot.name}
			  </a>
			</li>
			</#list>
			
            
			
		</ul>
	</div>
  
 </div>
</#if>
<script type="text/javascript">
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});
	function zanCompany() {

		$.post('/MyNosql/wwz/wwzajax!zanCompany.action?toUser=${toUser}&companyid=${company._id}',
						function(res) {
							
							if (res) {
								
							} else {
								alert('请求失败了');
							}
						});
	}
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

</body>
</html>

