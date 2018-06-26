
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8"utf-8" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/mb/95/css/reset.css-2014-03-07-1.css" 
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/mb/95/css/snower.css-2014-03-07-1.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/mb/95/css/common.css-2014-03-07-1.css" 
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/mb/95/css/font-awesome.css-2014-03-07-1.css" 
	media="all" />
<link rel="stylesheet" type="text/css"
	href="/MyNosql/mb/95/css/home-40.css-2014-03-07-1.css" 
	media="all" />
<script type="text/javascript" src="/MyNosql/mb/95/js/maivl.js" ></script>
<script type="text/javascript" src="/MyNosql/mb/95/js/jQuery.js"></script>
<script type="text/javascript" src="/MyNosql/mb/95/js/zepto.js" ></script>
<script type="text/javascript" src="/MyNosql/mb/95/js/swipe.js" ></script>
<script type="text/javascript" src="/MyNosql/mb/95/js/audio.js" ></script>
<title></title>
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

</head>
<body onselectstart="return true;" ondragstart="return false;">
	<style type="text/css">
body {
	background: url("/MyNosql/mb/95/img/v42_bg.jpg")/*tpa=http://114.215.116.254/MyNosql/weimob/img/template/lib/v42_bg.jpg*//*tpa=http://114.215.116.254/MyNosql/weimob/img/template/lib/v42_bg.jpg*/
}
</style>
	<div class="body">
		
		<header>
        <#if funcList[0]??>
			<div class="snower">
				<script type="text/javascript">
					var urls = [ '${osshttp}${funcList[0].picurl}'/*tpa=http://114.215.116.254/MyNosql/uploads/images/20140708/213938140.jpg*/ ]
				</script>
				<script type="text/javascript" src="/MyNosql/mb/95/js/snower1.js" ></script>
			</div>
        </#if>
		</header>
		
		<div style="-webkit-transform: translate3d(0, 0);">
        <#if (picurl?size>0)> 
			<div id="banner_box" class="box_swipe">
				<ul>
					     <#list picurl as pic> 
									<li>
												<a onClick="return false;">
																<img src="${osshttp}${pic}"     style="width:100%;" />
								</a>
					                             </li>
                                                      
 

					                      </#list>			
                                   

				</ul>
				<ol>
				     <#list picurl as pic> 
									<li class="on"></li>
									</#list>	
					
				</ol>
			</div>
             </#if>
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
		
			<script>
				window.addEventListener("DOMContentLoaded", function(){
					playbox.init("playbox");
				}, false);
			</script>
   <div data-role="widget" data-widget="music90" class="music90">
   <link rel="stylesheet" href="/MyNosql/mb/78/css/music90.css">
			<script src="/MyNosql/mb/78/js/player.js" ></script>
			<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>
		
		<section>
			<nav>
 <#if footList[1]??>
                          <div style="height:25px; padding-top:5px; margin-top:5px;background-color:#FFF"><marquee direction="left"  scrollamount="5"><span style=" font-size:18px">${footList[1].summary}</span></marquee></div>
                         </#if>
				<ul class="nav_links box">
				
					
						

							
							    <#if funcList[1]??>
                                                          
								    <li>
                                                                  <#if funcList[1].method=="link">
                                                                     <a href="${funcList[1].url}">
										${funcList[1].name}</a>

                                                                        <#else>
                                                                    <a href="/MyNosql/wwz/wwz!${ funcList[1].method}.action?_id=4&type=${ funcList[1].type}&toUser=${toUser}">
										${funcList[1].name}</a>
 
                                                                      </#if>
                                                                  </li>
        
							    </#if>

						

							   <#if funcList[2]??>
								    <li>
                                                                  <#if funcList[2].method=="link">
                                                                     <a href="${funcList[2].url}">
										${funcList[2].name}</a>

                                                                        <#else>
                                                                    <a href="/MyNosql/wwz/wwz!${ funcList[2].method}.action?_id=4&type=${ funcList[2].type}&toUser=${toUser}">
										${funcList[2].name}</a>
 
                                                                      </#if>
                                                                  </li>
                                                             
							    </#if>
							

						

							
							    <#if funcList[3]??>
								    <li>
                                                                  <#if funcList[3].method=="link">
                                                                     <a href="${funcList[3].url}">
										${funcList[3].name}</a>

                                                                        <#else>
                                                                    <a href="/MyNosql/wwz/wwz!${ funcList[3].method}.action?_id=4&type=${ funcList[3].type}&toUser=${toUser}">
										${funcList[3].name}</a>
 
                                                                      </#if>
                                                                  </li>
							    </#if>

						

							
							   <#if funcList[4]??>
                                                                         
								    <li>
                                                                  <#if funcList[4].method=="link">
                                                                     <a href="${funcList[4].url}">
										${funcList[4].name}</a>

                                                                        <#else>
                                                                    <a href="/MyNosql/wwz/wwz!${ funcList[4].method}.action?_id=1&type=${ funcList[4].type}&toUser=${toUser}">
										${funcList[4].name}</a>
 
                                                                      </#if>
                                                                  </li>
							    </#if>

						
					

				</ul>
			</nav>
			<div>
				<ul class="ofh ul_list">
					
						
						  <#if funcList[5]??>
							 
                                                         <li>
                                                          <#if funcList[5].method=="link">
                                                             <a href="${funcList[5].url}" 
								style="background-image: url(${osshttp}${funcList[5].picurl});"> <label>${funcList[5].name}</label>
							</a>
                                                          <#else>
                                                            <a href="/MyNosql/wwz/wwz!${ funcList[5].method}.action?_id=4&type=${ funcList[5].type}&toUser=${toUser}" 
 								style="background-image: url(${osshttp}${funcList[5].picurl});"> <label>${funcList[5].name}</label>
							</a>
                                                          </#if></li>
						  </#if>
						
					
						
								  <#if funcList[6]??>
							     <li>
                                                          <#if funcList[6].method=="link">
                                                             <a href="${funcList[6].url}" 
								style="background-image: url(${osshttp}${funcList[6].picurl});"> <label>${funcList[6].name}</label>
							</a>
                                                          <#else>
                                                            <a href="/MyNosql/wwz/wwz!${ funcList[6].method}.action?_id=4&type=${ funcList[6].type}&toUser=${toUser}" 
 								style="background-image: url(${osshttp}${funcList[6].picurl});"> <label>${funcList[6].name}</label>
							</a>
                                                          </#if></li>
						  </#if>
						
					
					
						
						
			  <#if funcList[7]??>
							     <li>
                                                          <#if funcList[7].method=="link">
                                                             <a href="${funcList[7].url}" 
								style="background-image: url(${osshttp}${funcList[7].picurl});"> <label>${funcList[7].name}</label>
							</a>
                                                          <#else>
                                                            <a href="/MyNosql/wwz/wwz!${ funcList[7].method}.action?_id=4&type=${ funcList[7].type}&toUser=${toUser}" 
 								style="background-image: url(${osshttp}${funcList[7].picurl});"> <label>${funcList[7].name}</label>
							</a>
                                                          </#if></li>
						  </#if>
						
						
					
						
						
			  <#if funcList[8]??>
							   <li>
                                                          <#if funcList[8].method=="link">
                                                             <a href="${funcList[8].url}" 
								style="background-image: url(${osshttp}${funcList[8].picurl});"> <label>${funcList[8].name}</label>
							</a>
                                                          <#else>
                                                            <a href="/MyNosql/wwz/wwz!${ funcList[8].method}.action?_id=4&type=${ funcList[8].type}&toUser=${toUser}" 
 								style="background-image: url(${osshttp}${funcList[8].picurl});"> <label>${funcList[8].name}</label>
							</a>
                                                          </#if></li>
						  </#if>
					
					
					<#if funcList[9]??>
					<ol style="background-image: url(${osshttp}${funcList[9].picurl});" onclick="location.href='${funcList[9].url}'"></ol>
					</#if>
					
					
				</ul>
			</div>
		</section>
	</div>

	




<#if footList[0]??>

<footer style="overflow:visible;">
				<div class="weimob-copyright" style="padding-bottom:30px;">
					
	
		 ${footList[0].summary}
	
	
</div>

</footer>
</#if>

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
</script></body>
</html>

