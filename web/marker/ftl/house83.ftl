<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/reset.css-2014-08-28.css"  media="all" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/common.css-2014-08-28.css"  media="all" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/home-28.css-2014-08-28.css"  media="all" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/11/css/menu-3.css-2014-08-28-tow.css"  media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/12/css/music90.css">
<script src="/MyNosql/marker/mb/12/js/player.js" ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/11/js/jQuery.js"  ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/11/js/swipe.js"  ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

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
	
<div class="music90">

<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.address}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>   
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





    <div style="-webkit-transform:translate3d(0,0,0);">
<#if (picurl?size>0)>
		<div id="banner_box" class="box_swipe">
			<ul> <#list picurl as pic> 
									<li>
												<a onclick="return false;">
																<img src="${osshttp}${pic}"  alt="3" style="width:100%;" />
								    </a>
					                       </li>

					                </#list>	
                     </ul>

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


	<#if (footList?size>0)>
                                        <#if footList[0]??>
        			<footer style="overflow:visible;">
				<div class="weimob-copyright">

                                                   <br/><br/><br/>
											<span class="weimob-support" >${footList[0].summary}</span>
									</div>
			    </footer>
                                  </#if>
                            </#if>
	</div>

 <script type="text/javascript">
    	$(document).ready(function() { 
		zanCount();
		share()
	});
    $(function () {
        new Swipe(document.getElementById('banner_box'), {
            speed: 500,
            auto: 3000,
            callback: function () {
                var lis = $(this.element).next("ol").children();
                lis.removeClass("on").eq(this.index).addClass("on");
            }
        });
    });
	function share() {
		
		$.post('/MyNosql/wwz/wwzajax!share.action?toUser=${toUser}&url='+encodeURIComponent(window.location.href), null,
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
		    			alert("别这样啦，好东西要和朋友分享的嘛！分享后我告诉你一个秘密哦！");
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
</body>

</html>

