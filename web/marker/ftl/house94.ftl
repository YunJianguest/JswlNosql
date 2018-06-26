<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${company.name}</title> 
<meta name="description" content="" /> 
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<style type="text/css"> 
*{margin:0;padding:0}body{margin:0;font-family:Arial,Helvetica,sans-serif;font-size:13px;line-height:1.5;}.swiper-container{height:1008px;width:640px}.device{width:640px;height:auto;margin:0 auto;position:relative;overflow:hidden}.wiper-container{height:auto;width:640px;overflow:hidden}img{display:block;border:0}.hide{display:none}.rel{position:relative}.abs{position:absolute}.swiper-slide{width:640px;height:1008px}.swiper-slide div{position:absolute;width:100%;height:100%;left:0;top:0;z-index:9}div.bg{text-align:center;z-index:9}div.main{z-index:2}div.draw{opacity:0}div.resize img{width:0;bottom:0;right:0}div.down img{width:0;bottom:0;right:0}div.info{left:640px}.ikea-audio .music p span{background:url(images/music.png) no-repeat 0 0;background-size:cover;cursor:pointer}.ikea-audio{top:1%;right:1%;z-index:999;max-width:50px}.ikea-audio .music p{width:100%;height:100%}.ikea-audio .music p span{display:none;width:100%;height:100%}.ikea-audio .music p span:first-child{display:block}.ikea-audio .music audio{height:0;width:0;opacity:0}.ikea-audio .music p span.audio_open{background-position:-100% 0}.ikea-audio .music p span.audio_close{background-position:0 0}.loading{text-align:center;height:128px;width:100%;z-index:99;top:0;left:0}.loading img{width:128px;margin:0 auto}div.videocontroller,div.video{bottom:0;left:0;height:39%;width:100%;z-index:9}div.video{z-index:10}.citylist{width:50%;height:23%;z-index:9;top:30.75%;left:25%}.citylist a{display:block;float:left;width:33%;height:25%;overflow:hidden;text-indent:-200%} .topShare { opacity:0; display:none; }.light{ cursor:pointer; position: absolute; left: -180px; top: 0; width: 180px; height: 90px; background-image: -moz-linear-gradient(0deg,rgba(255,255,255,0),rgba(255,255,255,0.5),rgba(255,255,255,0)); background-image: -webkit-linear-gradient(0deg,rgba(255,255,255,0),rgba(255,255,255,0.5),rgba(255,255,255,0)); transform: skewx(-25deg); -o-transform: skewx(-25deg); -moz-transform: skewx(-25deg); -webkit-transform: skewx(-25deg); }

.btn_music a{float:left; display:inline-block; width:13px; height:17px;margin-right:2px;}
.btn_music a.weibo{width:17px;position:absolute;right:0px;top:0px;}
.btn_music a.jp-play{background:url(/MyNosql/marker/mb/80/images/music_ico.png) no-repeat}
.btn_music a.jp-pause{background:url(/MyNosql/marker/mb/80/images/music_ico.png) no-repeat -14px 0}
.btn_music .listening-icon{background:url(/MyNosql/marker/mb/80/images/zSGhlXp4.gif) no-repeat;width:14px;height:14px;display:inline-block}
.btn_music .listening-icon-pause{background:url(/MyNosql/marker/mb/80/images/OVZwOkXW.gif) no-repeat;width:14px;height:14px;display:inline-block}
</style>
<meta name="viewport" id="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1.0"> 
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/css/menu-3.css-2014-08-28.css"   media="all" />
<script type="text/javascript" src="/MyNosql/marker/mb/80/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var phoneWidth = parseInt(window.screen.width);
var phoneScale = phoneWidth/640;
var ua = navigator.userAgent; 
if (/Android (\d+\.\d+)/.test(ua)){ 
	if (phoneWidth >  640) {
		document.write('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">');	
	} 
} else {
	
}

</script>
</head>
<body>

 
<#if (picurl?size>0)>
<div class="device rel" id="device">
    <div class="swiper-container" id="swiper-container">
      <div class="swiper-wrapper">

            <#if picurl[0]??>
               <div class="swiper-slide rel"><div class="main"><img src="${osshttp}${picurl[0]}"></div> <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> </div>
            </#if>
            <#if picurl[1]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[1]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[2]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[2]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[3]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[3]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[4]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[4]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[5]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[5]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[6]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[6]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[7]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[7]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[8]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[8]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[9]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[9]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[10]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[10]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[11]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[11]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[12]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[12]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[13]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[13]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[14]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[14]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
 <#if picurl[15]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[15]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[16]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[16]}"></div>
            	<div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div>  
             </div>
             </#if>
 <#if picurl[17]??>
             <div class="swiper-slide rel">
            	<div class="main"><img class="lazy" data-original="${osshttp}${picurl[17]}"></div>
            	 <div id="light"><img src="/MyNosql/marker/mb/80/images/light.png"></div> 
             </div>
             </#if>
      </div>
    </div>
</div>
</#if>
<div id="ikea-audio" class="ikea-audio abs" style="height: 56.2464px; width: 56.232px;">
  <div class="music">
    <p class="music_audio"><span class="abs audio_open" style="background-position: -56.232px 50%;"></span><span class="abs audio_close"></span></p>
    <audio id="music_audio" loop preload="preload">
      <source src="${company.mp3}" type="audio/mpeg">
      您的浏览器不支持HTML5音频格式</audio>
  </div>

<script type="text/javascript" src="/MyNosql/marker/mb/80/js/stylee.js"></script>

 
<script src="/MyNosql/marker/mb/80/js/main.js" type="text/javascript"></script>
 
           <#if (footList?size>0)>
		<section data-role="widget" data-widget="nav7" class="nav7">
			<div class="plug-div-wrap">
				<div class="plug-div model1">
					<div id="plug-phone" class="plug-phone">
                                                                                            <#if footList[0]??>
                                                                                                          <#if footList[0].method=="link">

													<div>
																				<a href="${footList[0].url}" class="icon-phone">
										<label>${footList[0].name}</label>
									</a>
															</div>
                                                                                               </#if>  
                                                                                              </#if>   

                                                                                        
                                                                                            <#if footList[1]??>
                                                                                                          <#if footList[1].method=="link">   
													<div>
																	<a href="${footList[1].url}" class="icon-globe " >
										<label>${footList[1].name}</label>
									</a>
															</div>
                                                                                                     </#if>  
                                                                                              </#if>  

                                                                                               
                                                                                            <#if footList[2]??>
                                                                                                          <#if footList[2].method=="link">   

													<div>
																	<a href="${footList[2].url}" class="icon-edit">
										<label>${footList[2].name}</label>
									</a>
															</div>

                                                                                                           </#if>  
                                                                                              </#if>  
 

                                                                                          <#if footList[3]??>
                                                                                                          <#if footList[3].method=="link">   

												<div>
							<a href="${footList[3].url}" class="icon-share"><label>${footList[3].name}</label></a>
						</div>

                                                                                                           </#if>  
                                                                                              </#if>  
					</div>
				</div>
			</div>
		</section>
           </#if>
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
