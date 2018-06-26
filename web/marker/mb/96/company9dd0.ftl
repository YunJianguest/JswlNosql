<!DOCTYPE html>
<html>
	<head>
		<title>${company.name}</title>
		<meta charset=UTF-8"utf-8">
		<meta content="" name="description">
		<meta content="" name="keywords">
		<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
		<meta content="telephone=no, address=no" name="format-detection">
		<link href="/MyNosql/marker/mb/74/css/main.css-v=5.css" rel="stylesheet" />
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
			coverUrl:'img/20141120172731_77852.jpg',
			swipeCur: 0,
			swipeDir:'vertical', // 'vertical' // horizontal
		}
        //业务关联链接数组
        var ary_biz_jump_id = new Array();
        var ary_biz_jump_url = new Array();
		</script>
		<script src="/MyNosql/marker/mb/74/js/zepot.js"></script>
		<script src="/MyNosql/marker/mb/74/js/lottery.js"></script>
		<script src="/MyNosql/marker/mb/74/js/swipe.js"></script>
		<script src="/MyNosql/marker/mb/74/js/player.js"></script>
		<script src="/MyNosql/marker/mb/74/js/bur.js"></script>
		<script src="/MyNosql/marker/mb/74/js/app.js"></script>
		
	</head>
	<body onselectstart="return true;" ondragstart="return false;">
		<div class="container">
			<div class="loading-img"><img src="img/loading.gif-v=2014-05-21.gif" /></div>

			<div class="swipe" id="swipe">
				<ul>
                
                <#if (picurl?size>0)>
                <#list picurl  as  pic>

                                    					        <li><div style="background-image: url(${osshttp}${pic})"></div></li>
                </#list>
                </#if>            					
                    
                            					
             
                                    					    <!--带按钮的图片需加上class top/middle/bottom ，   
                                                             <li>
					        	
					        	<div class="bottom" style="background-image: url(http://scene.img.weimob.com/static/1a/50/71/image/20141201/20141201121929_46373.jpg)">
 
 
								        	</div>
					        </li>位置分别在上中下 -->
                            					
                    
                

				</ul>
			</div>
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
