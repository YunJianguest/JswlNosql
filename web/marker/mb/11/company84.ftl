<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/reset.css-2014-08-28.css"  media="all" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/common.css-2014-08-28.css"  media="all" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/home-28.css-2014-08-28-tow.css"  media="all" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/menu-3.css-2014-08-28-tow.css"  media="all" />

<script type="text/javascript" src="/MyNosql/marker/mb/11/js/jQuery.js"  ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/11/js/swipe.js"  ></script>


<script type="text/javascript" src="/MyNosql/marker/mb/11/js/zepto.js"  ></script>

<title>${company.name}</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
        <meta name="Keywords" content="" />
        <meta name="Description" content="" />
        <!-- Mobile Devices Support @begin -->
            <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- Mobile Devices Support @end -->
       
    </head>
    <body onselectstart="return true;" ondragstart="return false;">
        


<div class="body">
		<!--
	幻灯片管理
	-->
	<div style="-webkit-transform:translate3d(0,0,0);">
<#if (picurl?size>0)> 
		<div id="banner_box" class="box_swipe">
			<ul>
                                                 <#list picurl as pic> 
									<li>
												<a onclick="return false;">
																<img src="${osshttp}${pic}"  alt="3" style="width:100%;" />
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
<br/>		
				<!--
		用户分类管理
        -->
		<section>
			<ul class="list_ul">
        <#if (funcList?size>0)>
		<#list funcList as func> 
                                            
							<li>
                                                  <#if func.method=="link">
                                                         
							<a href="${ func.url}">
							<figure>
								<div style="background-image:url('${osshttp}${ func.picurl}');">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${func.name}</figcaption>
							</figure>
						      </a>
                                                     <#else>
                                                       <a href="/MyNosql/wwz/wwz!${ func.method}.action?_id=1&type=${ func.type}&toUser=${toUser}">
							<figure>
								<div style="background-image:url('${osshttp}${ func.picurl}');">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${func.name}</figcaption>
							</figure>
						      </a>
                                                   </#if>
				                    	</li>
				      			 
				            
                                   </#list>
                               </#if>
						
							</ul>
		</section>
                             <#if (footList?size>0)>
                                        <#if footList[0]??>
        			<footer style="overflow:visible;">
				<div class="weimob-copyright">

                                                   <br/>
											<span class="weimob-support" >${footList[0].summary}</span>
									</div>
			    </footer>
                                  </#if>
                            </#if>
	</div>

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

