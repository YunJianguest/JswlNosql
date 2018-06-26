<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${company.name }</title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta http-equiv="Pragma" content="no-cache"/>
<link rel="stylesheet" href="/MyNosql/house/themes/css/reset.css" />
<link rel="stylesheet" href="/MyNosql/house/themes/css/index.css" />
<!-- 引入图标样式 -->
<link rel="stylesheet" href="/MyNosql/house/themes/css/font-awesome.min.css" />
<!-- 引入JS -->
<script type="text/javascript" src="/MyNosql/house/themes/js/zepto.js"></script>
<script type="text/javascript" src="/MyNosql/house/themes/js/swipe.js"></script>
</head>
<body>
	<div class="body">
			<!--幻灯片管理-->
		<div style="-webkit-transform:translate3d(0,0,0);">
	
			<div id="banner_box" class="box_swipe">
				<ul>
					<#list picurl as pic> 
					<li>
						<a href="#">
							<img src="${osshttp}${pic}" alt="" />
						</a>
					</li>
					</#list>
					
					
				</ul>
				<ol>
					<#list picurl as pic>
					<li ></li>
					</#list>
					
				</ol>
			</div>
		</div>
	</div>
	<!-- 幻灯片JS -->
	<script type="text/javascript">
		$(function(){
			new Swipe(document.getElementById('banner_box'), {
				speed:500,
				auto:3000,
				callback: function(){
					var lis = $(this.element).next("ol").children();
					lis.removeClass("on").eq(this.index).addClass("on");
				}
			});
		});
	</script>
	<div id="navList_box" class="box_swipe">
		<ul>
			
			<li>
				<#if funcList[0]??>
					<a href="${funcList[0].url}">
					<span class="icon-home"></span>
					<p>${funcList[0].name}</p>
					</a>
					<#else>
					<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData">
					<span class="icon-home"></span>
					<p>未配置</p>
					</a>
				</#if>
				<#if funcList[1]??>
					<a href="${funcList[1].url}">
					<span class="icon-picture"></span>
					<p>${funcList[1].name}</p>
					</a>
					<#else>
					<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData">
					<span class="icon-picture"></span>
					<p>未配置</p>
					</a>
				</#if>
				<#if funcList[2]??>
					<a href="${funcList[2].url}">
					<span class="icon-building"></span>
					<p>${funcList[2].name}</p>
					</a>
					<#else>
					<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData">
					<span class="icon-building"></span>
					<p>未配置</p>
					</a>
				</#if>
				<#if funcList[3]??>
					<a href="${funcList[3].url}">
					<span class="icon-check"></span>
					<p>${funcList[3].name}</p>
					</a>
					<#else>
					<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData">
					<span class="icon-check"></span>
					<p>未配置</p>
					</a>
				</#if>
				
				
			</li>
			
			
			
		</ul>
		<ol>
			<a href="javascript:navList_box.prev();">&nbsp;</a>
			<a href="javascript:navList_box.next();">&nbsp;</a>
		</ol>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			window.navList_box = new Swipe(document.getElementById('navList_box'), {auto:0});
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
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});
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