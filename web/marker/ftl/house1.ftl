<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" type="text/css" href="/marker/mb/79/css/reset.css-2014-08-28.css"  media="all" />
<link rel="stylesheet" type="text/css" href="/marker/mb/79/css/common.css-2014-08-28.css"  media="all" />
<link rel="stylesheet" type="text/css" href="/marker/mb/79/css/home-28.css-2014-08-28.css"  media="all" />
<link rel="stylesheet" type="text/css" href="/marker/mb/79/css/menu-3.css-2014-08-28.css"  media="all" />
<script type="text/javascript" src="/marker/mb/79/js/jQuery.js"></script>
<script type="text/javascript" src="/marker/mb/79/js/swipe.js" ></script>
<script type="text/javascript" src="/marker/mb/79/js/zepto.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>${company.name}</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
      
        <!-- Mobile Devices Support @begin -->
            <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- Mobile Devices Support @end -->
        
    </head>
    <body onselectstart="return true;" ondragstart="return false;">
 <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
<div class="body">
		<!--
	幻灯片管理
	-->
    <#if (slide?size>0)> 
	<div style="-webkit-transform:translate3d(0,0,0);">
    
		<div id="banner_box" class="box_swipe">
			<ul>
             <#list slide as pic>
									<li>
												<a onClick="${pic.url}">
																<img src="${filehttp}${pic.picurl}"  alt="3" style="width:100%;" />
								</a>
					</li>
		    </#list>
							</ul>
			<ol>
								    <#list slide as pic> 
									<li class="on"></li>
									</#list>
							</ol>
		</div>
	</div>
    </#if>
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

         <section>
         <#if (funcList?size>0)>
			<ul class="list_ul">
            <#list funcList as func>
            	<li> 
						<a href="${func.url}" >
							<figure>
								<div style="background-image:url(${filehttp}${ func.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${func.title}</figcaption>
							</figure>
						 </a> 
					</li>
                </#list>
             </ul>
	    </#if>
		</section>
	</div>
 
	</body>
 
 <script type="text/javascript">
    $(document).ready(function() {   
		share();
	}); 
	function share() {
		
		$.post('/suc/ajax!share.action?custid=${custid}&url='+encodeURIComponent(window.location.href), null,
    		function(data) { 
    			wx.config({
    				debug: false,
    				appId: data.token.appid, 
    				timestamp: data.token.timestamp, 
    				nonceStr: data.token.noncestr, 
   	 				signature: data.token.signature,
    				jsApiList: [ 'checkJsApi',
                 		'onMenuShareTimeline',
                 		'onMenuShareAppMessage',
                 		'onMenuShareQQ',
                 		'onMenuShareWeibo'
                	 ] 
				});

			wx.ready(function(){
				var share={
		    		title: '${company.name}', // 分享标题
		    		desc: '${company.summary}', // 分享描述
		   			link:  window.location.href, // 分享链接
		    		imgUrl: '${filehttp}${company.logo}', // 分享图标
		    		success: function () { 
		      
		    		},
		   	 		cancel: function () { 
		    			 
		    		}
			};
			wx.onMenuShareAppMessage(share);
			wx.onMenuShareTimeline(share);
			wx.onMenuShareAppMessage(share);
			wx.onMenuShareQQ(share);
			wx.onMenuShareWeibo(share);
		});
    	},"json");	
	}

</script> 
</html>