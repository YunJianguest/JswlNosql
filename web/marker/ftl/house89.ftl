<!DOCTYPE html>
<html>
    <head>
        <meta charset=utf-8"utf-8" />


 <!--3d-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="Slicebox - 3D Image Slider with Fallback" />
        <meta name="keywords" content="jquery, css3, 3d, webkit, fallback, slider, css3, 3d transforms, slices, rotate, box, automatic" />
		<meta name="author" content="Pedro Botelho for Codrops" />
		
        <link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/slicebox.css" />
		<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/custom.css" />
		<link rel="stylesheet" href="/MyNosql/mb/78/css/init.css">
        <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
        <style>
		.top-banner {
			background-color: rgba(255, 255, 255, 0.55);
		}
		.top-banner a {
			color: #019135;
		}
		h1 {
			margin-top: 100px;
			font-family: 'Microsoft Yahei';
			font-size: 36px;
			color: #019157;
		}		
		</style>		
		<script type="text/javascript" src="/MyNosql/mb/78/js/modernizr.custom.46884.js"></script>
        <!-- 3d-->
        


        <link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/reset.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/common.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/home-28.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/css/menu-3.css-2014-08-28.css"   media="all" />
<script type="text/javascript" src="/MyNosql/mb/78/js/jQuery.js"  ></script>
<script type="text/javascript" src="/MyNosql/mb/78/js/swipe.js-2014-08-28"  ></script>
<script type="text/javascript" src="/MyNosql/mb/78/js/zepto.js-2014-08-28"  ></script>
<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/common/css/iscroll.css" />
<link rel="stylesheet" type="text/css" href="/MyNosql/mb/78/common/css/wz.css" />
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
<title>${company.name}</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
         
        <!-- Mobile Devices Support @begin -->
            <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- Mobile Devices Support @end -->
        <link rel="shortcut icon" href="img/favicon.ico" />
    

 

</head>
    <body onselectstart="return true;" ondragstart="return false;">
        
<link rel="stylesheet" type="text/css" href="css/font-awesome.css-v=2014100823.css"  media="all" />




<div class="body">
	 

<div data-role="widget" data-widget="music90" class="music90">
<link rel="stylesheet" href="/MyNosql/mb/78/css/music90.css">
			<script src="/MyNosql/mb/78/js/player.js" ></script>
			<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>

<div class="container">
    <#if (picurl?size>0)>
			<div class="wrapper">

				<ul id="sb-slider" class="sb-slider">
                    <#list picurl as pic>
					<li>
						<a href="javascript:void(0)"><img src="${osshttp}${pic}"/></a>
						 
					</li>
		  </#list>	
				</ul>

			 
				<div id="nav-arrows" class="nav-arrows">
					<a href="#">Next</a>
					<a href="#">Previous</a>
				</div>

				<div id="nav-options" class="nav-options">
					<span id="navPause" class="span_put">Pause</span>
				</div>

			</div><!-- /wrapper -->
      </#if>
		</div>
		<script type="text/javascript" src="/MyNosql/mb/78/js/jquery.min.js"></script>
		<script type="text/javascript" src="/MyNosql/mb/78/js/jquery.slicebox.js"></script>
		<script type="text/javascript">
		  var det=0;
		  var  nvaplay=document.getElementById("navPause");
			$(function() {
				
				var Page = (function() {

					var $navArrows = $( '#nav-arrows' ).hide(),
						$navOptions = $( '#nav-options' ).hide(),
						$shadow = $( '#shadow' ).hide(),
						slicebox = $( '#sb-slider' ).slicebox( {
							onReady : function() {

								$navArrows.show();
								$navOptions.show();
								$shadow.show();

							},
							orientation : 'h',
							cuboidsCount : 3
						} ),
						
						init = function() {

							initEvents();
							
						},
						initEvents = function() {

							// add navigation events
							$navArrows.children( ':first' ).on( 'click', function() {

								slicebox.next();
								return false;

							} );

							$navArrows.children( ':last' ).on( 'click', function() {
								
								slicebox.previous();
								return false;

							} );

							$( '#navPlay' ).on( 'click', function() {
								
								slicebox.play();
								return false;

							} );

							$( '#navPause' ).on( 'click', function() {
						 	
								if(det==0)
								{
									 nvaplay.className="span_de";
									slicebox.play();
									det=1;
									
							     }else if(det==1)
								 {
									  nvaplay.className="span_put";
									 slicebox.pause();
									 det=0;
									
									 }
								return false;

							} );

						};

						return { init : init };

				})();

				Page.init();

			});
		</script>
		 
	 
 
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
											<span class="weimob-support" ></span>
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

