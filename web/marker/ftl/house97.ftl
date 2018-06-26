<!DOCTYPE html>
<html>
    <head>
        <meta charset= "utf-8" />
        <link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/css/reset.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/css/common.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/css/home-28.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/css/menu-3.css-2014-08-28.css"   media="all" />
<script type="text/javascript" src="/MyNosql/marker/mb/78/js/jQuery.js"  ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/78/js/swipe.js-2014-08-28"  ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/78/js/zepto.js-2014-08-28"  ></script>
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/common/css/iscroll.css" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/common/css/wz.css" />
<link rel="stylesheet" type="text/css" href="${osshttp}/shop2/css/home.css" />
<title>${company.name }</title>
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
        <link rel="shortcut icon" href="img/favicon.ico" />
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style>

#zan{
	top:50%;
	right:0px;
    width:50px;
	
	height:50px;
	position: fixed;
	z-index:9999;
	background-image:url('/MyNosql/marker/mb/77/img/zan1.png');
	background-size:100%,100%;
	text-align:center;
	}
.pzan{
	color:#FFF;
	width:100%;
	height:100%;
	margin-right:10px!important;
	}

</style>
 <script type="text/javascript">
        window.addEventListener("DOMContentLoaded", function(){
        	playbox.init("playbox");
        }, false);

</script>
<script type="text/javascript">
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
   WeixinJSBridge.call('hideToolbar');
   });
  function zanCompany() {

  $.post('/MyNosql/wwz/wwzajax!zanCompany.action?toUser=${toUser}&companyid=${company._id}',
  function(res) {

  if (res) {

console.info(res);
$('#zan').css('background-image','url(/MyNosql/marker/mb/77/img/zan1.png)');
$('#zan').attr('href', 'javascript:void(0);');
$('#zan').find('span').html("赞("+res+")<p></p>");

  } else {
  alert('请求失败了');
  }
  });
  }
</script>
<script>

$(document).ready(function() {
      
	$.post('/MyNosql/wwz/wwzajax!zanCount.action?toUser=${toUser}&companyid=${company._id}', null,
    	function(data) {
    		
    		$('#zan').find('span').html("<br/><br/><br/>赞("+data.zan+")<p></p>");
    		if (data.iszan == false) {
                       
$('#zan').css('background-image','url(/MyNosql/marker/mb/77/img/zan1.png)');
$('#zan').attr('href', 'javascript:void(0);');

    		} else {
$('#zan').css('background-image','url(/MyNosql/marker/mb/77/img/zan.png)');

                    
    		       
    		}
    	},"json")	
});

</script>


</head>
    <body onselectstart="return true;" ondragstart="return false;">
        





<div class="body">
		<!--
	幻灯片管理
	-->
<div class="zan">
<a href="javascript:zanCompany();" id="zan"><span class="pzan">
							赞(${company.sort})<p></p></span></a>
					
				</div>

<div data-role="widget" data-widget="music90" class="music90">
<link rel="stylesheet" href="/MyNosql/marker/mb/78/css/music90.css">
			<script src="/MyNosql/marker/mb/78/js/player.js" ></script>
			<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>
 
	<div style="-webkit-transform:translate3d(0,0,0);">
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

        
                          <div style="height:25px; padding-top:5px; margin-top:5px;background-color:#FFF"><marquee direction="left"  scrollamount="5"><span style=" font-size:18px">${company.context}</span></marquee></div>
                       
	      <section>
			<a href="tel:${company.tel}" class="link_tel icon-phone">电话：${company.tel}</a>
                        
	     </section>

            <section>
            <a href="${company.notice}" class="link_tel icon-phone">地址：${company.address}</a>
           </section>
				<!--
		用户分类管理
        -->
<section>
			<ul class="list_ul">

                          <#if (funcList?size>0)>
		<#list funcList as func> 
                        
									<li>
                                                                    <#if func.method=="link">
													<a href="${ func.url}" >
													<figure>
								<div style="background-image:url(${osshttp}${ func.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${func.name}</figcaption>
							</figure>
						</a>
                                                <#else>
                                               <a href="/MyNosql/wwz/wwz!${ func.method}.action?_id=1&type=${ func.type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${ func.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${func.name}</figcaption>
							</figure>
                                           	</a>
		                             </#if>
					</li>
                    	</#list>
                    </#if> 
							</ul>
		</section>
	</div>




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
	
<!--
分享前控制
-->
	 
        			<footer style="overflow:visible;">
				<div class="weimob-copyright" style="padding-bottom:50px;">
											<span class="weimob-support" >陕西信使文化科技有限公司</span>
									</div>
			</footer>
				<div mark="stat_code" style="width:0px; height:0px; display:none;">
					</div>
	</body>

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
</html>

