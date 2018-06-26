<!DOCTYPE html>
<html>
	<head>
		<title>${company.name}</title>
		<meta charset=UTF-8"utf-8">
		<meta content="" name="description">
		<meta content="" name="keywords">
		<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
		<meta content="telephone=no, address=no" name="format-detection">
		<link href="/MyNosql/mb/96/css/main.css-v=5.css" rel="stylesheet" />
                <link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
		<script type="text/javascript">
		(function(){
			var phoneWidth = parseInt(window.screen.width),
				phoneScale = phoneWidth/640,
				ua = navigator.userAgent;

			if (/Android (\d+\.\d+)/.test(ua)){
				var version = parseFloat(RegExp.$1);
				// andriod 2.3
				if(version > 2.3){
					document.write('<meta name="viewport" content="width=640, minimum-scale = '+phoneScale+', maximum-scale = '+phoneScale+', target-densitydpi=device-dpi">');
				// andriod 2.3以上
				}else{
					document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
				}
				// 其他系统
			}  
		})();
        		var config = {
                         
			coverUrl:'/MyNosql/mb/96/img/20141120172731_77852.jpg',
			swipeCur: 0,
			swipeDir:'vertical', // 'vertical' // horizontal
                        
		}
        //业务关联链接数组
        var ary_biz_jump_id = new Array();
        var ary_biz_jump_url = new Array();
		</script>
		<script src="/MyNosql/mb/96/js/zepot.js"></script>
		<script src="/MyNosql/mb/96/js/lottery.js"></script>
		<script src="/MyNosql/mb/96/js/swipe.js"></script>
		<script src="/MyNosql/mb/96/js/player.js"></script>
		<script src="/MyNosql/mb/96/js/bur.js"></script>
		<script src="/MyNosql/mb/96/js/app.js"></script>
		
	</head>
	<body onselectstart="return true;" ondragstart="return false;">
		<div class="container">
			<div class="loading-img"><img src="/MyNosql/mb/96/img/loading.gif-v=2014-05-21.gif" /></div>
        <#if (picurl?size>0)>
			<div class="swipe" id="swipe">
				<ul>

     <#list picurl as pic> 
                                    					        <li><div style="background-image: url(${osshttp}${pic})"></div></li>
                            					
                            					
    </#list>
				</ul>
			</div>
            </#if>
            			<div id="musicWrap" class="music_wrap f-hide">
				<span class="text move hide">打开</span>
                				    <i id="audioBtn" data-src="${company.mp3}" class="btn_music on"></i>
                			</div>
            
			<div id="arrowV" class="arrow_v f-hide"><p></p></div>

			<div id="arrowH" class="arrow_h f-hide">
				<span class="arrow_l"></span>
				<span class="arrow_r"></span>
			</div>

			<div class="lottery" id="lottery"></div>
			<div class="download_mask" id="downloadMask"><i></i></div>
		</div>
  
	</body>
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
			"link": "http://www.sxxskw.com/MyNosql/marker/company/company${company._id}.html",
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
