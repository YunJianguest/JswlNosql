<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1">
	<title>${company.name}</title>

	<link rel="stylesheet" href="/MyNosql/marker/mb/17/css/idangerous.swiper.css">
	<link rel="stylesheet" href="/MyNosql/marker/mb/17/css/idangerous.swiper.scrollbar.css">
	<link rel="stylesheet" href="/MyNosql/marker/mb/17/css/normalize.css">
	<link rel="stylesheet" href="/MyNosql/marker/mb/17/css/simple-app.css">
    <script src="/MyNosql/marker/mb/17/js/jquery.min.js"></script>
	<!-- Don't forget to get the latest Swiper and scrollbar version here-->
	<script src="/MyNosql/marker/mb/17/js/idangerous.swiper-2.0.min.js"></script>
	<script src="/MyNosql/marker/mb/17/js/idangerous.swiper.scrollbar-2.0.js"></script>
	<script src="/MyNosql/marker/mb/17/js/simple-app.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>  
<script type="text/javascript">
    	$(document).ready(function() { 
		
		share()
	});
    
	function share() {
		
		$.post('/MyNosql/wwz/wwzajax!share.action?toUser=${toUser}&url='+window.location.href, null,
    		function(data) {
    			wx.config({
    				debug: false,
    				appId: data.appid, 
    				timestamp: data.timestamp, 
    				nonceStr: data.noncestr, 
   	 				signature: data.signature,
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
		   			 link:  data.url, // 分享链接
		    		imgUrl: '${osshttp}${company.logo}', // 分享图标
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
    </head>
<body>
	<div class="swiper-nav swiper-container">
		<div class="swiper-wrapper">
        <#if (funcList?size>0)>
          <#list  funcList as  func>
			<div class="swiper-slide"><span>${func.name}</span></div>
		 </#list>
	    </#if>
		</div>
	</div>
	<div class="swiper-pages swiper-container">
		<div class="swiper-wrapper">
			 
            <#if (footList?size>0)>
             <#list footList  as foot>
			<div class="swiper-slide">
				<div class="swiper-container scroll-container">
					<div class="swiper-scrollbar"></div>
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="page-inner">
                            <a  href="${foot.url}">
				             <img src="${osshttp}${foot.picurl}"/>
							</a>
                            </div>
						</div>
					</div>
				</div>
			</div>
           </#list>
		  </#if>
			 
		</div> 
	</div>
	
</body>
</html>