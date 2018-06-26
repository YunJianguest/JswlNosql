<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/20/css/default.css" />
		<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/20/css/component.css" />
		<script src="/MyNosql/marker/mb/20/js/modernizr.custom.js"></script>
 <link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/20/css/reset.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/20/css/common.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/20/css/home-28.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/20/css/menu-3.css-2014-08-28.css"   media="all" />
<script type="text/javascript" src="/MyNosql/marker/mb/11/js/jQuery.js"  ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/20/js/swipe.js-2014-08-28"  ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/20/js/zepto.js-2014-08-28"  ></script>
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/common/css/iscroll.css" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/78/common/css/wz.css" />

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/music/css/music90.css">
<script src="http://www.sxxskw.com/MyNosql/marker/mb/17/js/jquery.min.js"></script>

<script src="/MyNosql/marker/mb/music/js/player.js" ></script>

<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
 
   <script type="text/javascript">
    	$(document).ready(function() { 
		 
		share()
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

<style type="text/css">
.qimo8{ overflow:hidden; max-width:640px;}
.qimo8 .qimo {/*width:99999999px;*/width:8000%; height:30px;background-color:#FFF;margin-bottom:20px;}
.qimo8 .qimo div{ float:left;}
.qimo8 .qimo ul{float:left; height:30px; overflow:hidden; zoom:1; }
.qimo8 .qimo ul li{float:left; line-height:30px; list-style:none;}
.qimo8 li a{margin-right:10px;color:#444444;}
</style>
	</head>
	<body class="cbp-spmenu-push" onselectstart="return true;" ondragstart="return false;">
		
				 
<div class="body" >



 <div class="cbox">
		<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-right" id="cbp-spmenu-s2"  onClick="disableOther()">
			 
            <#if funcList[5]??>
		 
                   
                   <#if funcList[5].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[5].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img  src="${osshttp}${funcList[5].picurl}"  width="100%"  height="100%";/></div>${funcList[5].name} <#if funcList[5].summary!=""><span style="float:right">定阅</span></#if></a>
		  			 
		   </#if>
					 
                    	 
             </#if> 
 <#if funcList[6]??>
		 
                   
                    <#if funcList[6].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[6].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[6].picurl}" width="100%" height="100%";/></div>${funcList[6].name} <#if funcList[6].summary!=""><span style="float:right">定阅</span></#if></a>
		 	 
		   </#if>
					 
                    	 
             </#if> 
 <#if funcList[7]??>
		 
                 
                   <#if funcList[7].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[7].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[7].picurl}" width="100%" height="100%";/></div>${funcList[7].name} <#if funcList[7].summary!=""><span style="float:right">定阅</span></#if></a>
		   
						 
		   </#if>	 
                    	 
             </#if> 
  <#if funcList[8]??>
		 
                
                   <#if funcList[8].summary!="showRight">

                   <a href="javascript:void(0)" onClick="show('${funcList[8].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[8].picurl}" width="100%" height="100%";/></div>${funcList[8].name} <#if funcList[8].summary!=""><span style="float:right">定阅</span></#if></a>
		 
						 
		   </#if>	 
                    	 
             </#if> 
 <#if funcList[9]??>
		 
                   
                   <#if funcList[9].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[9].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[9].picurl}" width="100%" height="100%";/></div>${funcList[9].name} <#if funcList[9].summary!=""><span style="float:right">定阅</span></#if></a>
		 
						 
		   </#if>	 
                    	 
             </#if> 
 <#if funcList[10]??>
		 
                  
                   <#if funcList[10].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[10].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[10].picurl}" width="100%" height="100%";/></div>${funcList[10].name} <#if funcList[10].summary!=""><span style="float:right">定阅</span></#if></a>
		 
						 
		   </#if>	 
                    	 
             </#if> 
<#if funcList[11]??>
		 
                   
                   <#if funcList[11].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[11].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[11].picurl}" width="100%" height="100%";/></div>${funcList[11].name} <#if funcList[11].summary!=""><span style="float:right">定阅</span></#if></a>
		   
						 
		   </#if>	 
                    	 
             </#if> 
<#if funcList[12]??>
		 
                  
                   <#if funcList[12].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[12].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[12].picurl}" width="100%" height="100%";/></div>${funcList[12].name} <#if funcList[12].summary!=""><span style="float:right">定阅</span></#if></a>
		 
						 
		   </#if>	 
                    	 
             </#if> 
<#if funcList[13]??>
		 
                  
                   <#if funcList[13].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[13].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[13].picurl}" width="100%" height="100%";/></div>${funcList[13].name} <#if funcList[13].summary!=""><span style="float:right">定阅</span></#if></a>
		   
						 
		   </#if>	 
                    	 
             </#if> 
<#if funcList[14]??>
		 
                 
                   <#if funcList[14].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[14].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[14].picurl}" width="100%" height="100%";/></div>${funcList[14].name} <#if funcList[14].summary!=""><span style="float:right">定阅</span></#if></a>
		  
						 
		   </#if>	 
                    	 
             </#if> 
<#if funcList[15]??>
		 
                  
                   <#if funcList[15].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[15].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[15].picurl}" width="100%" height="100%";/></div>${funcList[15].name} <#if funcList[15].summary!=""><span style="float:right">定阅</span></#if></a>
		 
						 
		   </#if>	 
                    	 
             </#if> 
<#if funcList[16]??>
		 
                   
                   <#if funcList[16].summary!="showRight">
                   <a href="javascript:void(0)" onClick="show('${funcList[16].summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${funcList[16].picurl}" width="100%" height="100%";/></div>${funcList[16].name} <#if funcList[16].summary!=""><span style="float:right">定阅</span></#if></a>
		   
						 
		   </#if>	 
                    	 
             </#if> 
			 
		</nav>
	  
		</div>		 
		<!--
	幻灯片管理
	-->

 <#if (company.mp3!="")>
<div data-role="widget" data-widget="music90" class="music90">

<a href="javascript:void(0);" class="btn_music on"  onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}"  autoplay="autoplay" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>   
</#if>

 
	<div style="-webkit-transform:translate3d(0,0,0);">
<#if (footList?size>0)>
		<div id="banner_box" class="box_swipe">
 
			                             <ul>
                                                               <#list footList as foot> 
									<li>
												<a onClick="return false;">
																<img src="${osshttp}${foot.picurl}"  onClick=" window.location.href='${foot.url}'"  style="width:100%;" />
								</a>
					                             </li>
                                                      
 

					                      </#list>			
                                   
							</ul>
                                                        <ol>
                                                                        <#list footList as foot> 
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

                        
 
 
			<!--
		用户分类管理
        -->


<#if (company.context!="")>

<div id="demo" class="qimo8">
  <div class="qimo">
    <div id="demo1">
      <ul>
                               <li><a herf="#">${company.context}</a></li>
 
      </ul>
    </div>
    <div id="demo2"></div>
  </div>
</div>
</#if>
 

       <section >
			<ul class="list_ul">

                          <#if funcList[0]??>
		 
                        
									<li>
                                                                    <#if funcList[0].method=="link">
													<a href="${funcList[0].url}" >
													<figure>
								<div style="background-image:url(${osshttp}${funcList[0].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[0].name}</figcaption>
							</figure>
						</a>
                                                <#else>
                                               <a href="/MyNosql/wwz/wwz!${ funcList[0].method}.action?_id=1&type=${funcList[0].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[0].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[0].name}</figcaption>
							</figure>
                                           	</a>
		                             </#if>
					</li>
                    	 
                    </#if> 
                    
                                         <#if funcList[1]??>
		 
                        
									<li>
                                                                    <#if funcList[1].method=="link">
													<a href="${funcList[1].url}" >
													<figure>
								<div style="background-image:url(${osshttp}${funcList[1].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[1].name}</figcaption>
							</figure>
						</a>
                                                <#else>
                                               <a href="/MyNosql/wwz/wwz!${ funcList[1].method}.action?_id=1&type=${funcList[1].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[1].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[1].name}</figcaption>
							</figure>
                                           	</a>
		                             </#if>
					</li>
                    	 
                    </#if> 
                                         <#if funcList[2]??>
		 
                        
									<li>
                                                                    <#if funcList[2].method=="link">
													<a href="${funcList[2].url}" >
													<figure>
								<div style="background-image:url(${osshttp}${funcList[2].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[2].name}</figcaption>
							</figure>
						</a>
                                                <#else>
                                               <a href="/MyNosql/wwz/wwz!${ funcList[2].method}.action?_id=1&type=${funcList[2].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[2].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[2].name}</figcaption>
							</figure>
                                           	</a>
		                             </#if>
					</li>
                    	 
                    </#if> 
                    
                                         <#if funcList[3]??>
		 
                        
									<li>
                                                                    <#if funcList[3].method=="link">
													<a href="${funcList[3].url}" >
													<figure>
								<div style="background-image:url(${osshttp}${funcList[3].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[3].name}</figcaption>
							</figure>
						</a>
                                                <#else>
                                               <a href="/MyNosql/wwz/wwz!${ funcList[3].method}.action?_id=1&type=${funcList[3].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[3].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[3].name}</figcaption>
							</figure>
                                           	</a>
		                             </#if>
					</li>
                    	 
                    </#if> 
                    
                                         <#if funcList[4]??>
		 
                        
									<li>
                                                                    <#if funcList[4].method=="link">
													<a href="${funcList[4].url}">
													<figure>
								<div style="background-image:url(${osshttp}${funcList[4].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[4].name}</figcaption>
							</figure>
						</a>
                                                <#else>
                                               <a href="/MyNosql/wwz/wwz!${ funcList[4].method}.action?_id=1&type=${funcList[4].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[4].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[4].name}</figcaption>
							</figure>
                                           	</a>
		                             </#if>
					</li>
                    	 
                    </#if> 
                    
                                    <#if funcList[5]??>
		 
                        
						<li  style="display:none" id="${funcList[5].summary}">
                                                        <#if funcList[5].method=="link">          
						 <#if funcList[5].summary!="showRight">

                                                   <a href="${funcList[5].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[5].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[5].name}</figcaption>
							</figure>
						</a>
                                                 
                                                       
                                                      <#else>
                                                            <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[5].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[5].name}</figcaption>
							 </figure>
                                                        </a>
    
                                                  
		                             </#if>
		                             </#if>
                                               
                                               <#if funcList[5].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[5].method}.action?_id=1&type=${funcList[5].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[5].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[5].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
                    
                                         <#if funcList[6]??>
		 
                        
									<li  style="display:none" id="${funcList[6].summary}">
                                                                    <#if funcList[6].method=="link">
						  <#if funcList[6].summary!="showRight">

                                                    <a href="${funcList[6].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[6].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[6].name}</figcaption>
							</figure>
						</a>
                                                         
                                                      <#else>

                                                         <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[6].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[6].name}</figcaption>
							</figure>
                                                        </a>

                                                
                                                  </#if>
                                              
		                             </#if>
                                             <#if funcList[6].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[6].method}.action?_id=1&type=${funcList[6].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[6].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[6].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
                    
                                         <#if funcList[7]??>
		 
                        
									<li style="display:none" id="${funcList[7].summary}">
                                                                    <#if funcList[7].method=="link">
                                                <#if funcList[7].summary!="showRight">
                                               <a href="${funcList[7].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[7].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[7].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[7].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[7].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
     
		                             </#if>
                                          <#if funcList[7].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[7].method}.action?_id=1&type=${funcList[7].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[7].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[7].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
            <#if funcList[8]??>
		 
                        
									<li style="display:none" id="${funcList[8].summary}">
                                                                    <#if funcList[8].method=="link">
                                                <#if funcList[8].summary!="showRight">
                                               <a href="${funcList[8].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[8].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[8].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[8].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[8].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
           
                                              
		                             </#if>
                                                 <#if funcList[8].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[8].method}.action?_id=1&type=${funcList[8].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[8].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[8].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
            <#if funcList[9]??>
		 
                        
									<li style="display:none" id="${funcList[9].summary}">
                                                                    <#if funcList[9].method=="link">
                                                <#if funcList[9].summary!="showRight">
                                               <a href="${funcList[9].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[9].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[9].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[9].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[9].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>

                                      <#if funcList[9].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[9].method}.action?_id=1&type=${funcList[9].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[9].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[9].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
            <#if funcList[10]??>
		 
                        
									<li style="display:none" id="${funcList[10].summary}">
                                                                    <#if funcList[10].method=="link">
                                                <#if funcList[10].summary!="showRight">
                                               <a href="${funcList[10].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[10].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[10].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[10].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[10].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>
                                         <#if funcList[10].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[10].method}.action?_id=1&type=${funcList[10].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[10].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[10].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
   <#if funcList[11]??>
		 
                        
									<li style="display:none" id="${funcList[11].summary}">
                                                                    <#if funcList[11].method=="link">
                                                <#if funcList[11].summary!="showRight">
                                               <a href="${funcList[11].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[11].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[11].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[11].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[11].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>
                              <#if funcList[11].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[11].method}.action?_id=1&type=${funcList[11].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[11].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[11].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
   <#if funcList[12]??>
		 
                        
									<li style="display:none" id="${funcList[12].summary}">
                                                                    <#if funcList[12].method=="link">
                                                <#if funcList[12].summary!="showRight">
                                               <a href="${funcList[12].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[12].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[12].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[12].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[12].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>
                                 <#if funcList[12].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[12].method}.action?_id=1&type=${funcList[12].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[12].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[12].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
   <#if funcList[13]??>
		 
                        
									<li style="display:none" id="${funcList[13].summary}">
                                                                    <#if funcList[13].method=="link">
                                                <#if funcList[13].summary!="showRight">
                                               <a href="${funcList[13].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[13].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[13].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[13].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[13].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>

                                   <#if funcList[13].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[13].method}.action?_id=1&type=${funcList[13].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[13].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[13].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
   <#if funcList[14]??>
		 
                        
									<li style="display:none" id="${funcList[14].summary}">
                                                                    <#if funcList[14].method=="link">
                                                <#if funcList[14].summary!="showRight">
                                               <a href="${funcList[14].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[14].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[14].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[14].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[14].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>

                                     <#if funcList[14].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[14].method}.action?_id=1&type=${funcList[14].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[14].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[14].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
   <#if funcList[15]??>
		 
                        
									<li style="display:none" id="${funcList[15].summary}">
                                                                    <#if funcList[15].method=="link">
                                                <#if funcList[15].summary!="showRight">
                                               <a href="${funcList[15].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[15].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[10].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[15].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[15].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>

                                       <#if funcList[15].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[15].method}.action?_id=1&type=${funcList[15].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[15].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[15].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
   <#if funcList[16]??>
		 
                        
									<li style="display:none" id="${funcList[16].summary}">
                                                                    <#if funcList[16].method=="link">
                                                <#if funcList[16].summary!="showRight">
                                               <a href="${funcList[16].url}" >
							<figure>
								<div style="background-image:url(${osshttp}${funcList[16].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[16].name}</figcaption>
							</figure>
						</a>
                                                       
                                                      <#else>
                                                           <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${funcList[16].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[16].name}</figcaption>
							</figure>
                                                        </a>

                                                      
                                                  </#if>
    
                                              
                                              
		                             </#if>

                                   <#if funcList[16].method!="link">
                                                 <a href="/MyNosql/wwz/wwz!${ funcList[16].method}.action?_id=1&type=${funcList[16].type}&toUser=${toUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${funcList[16].picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${funcList[16].name}</figcaption>
							</figure>
                                           	</a>
                                             </#if> 
					</li>
                    	 
                    </#if> 
      
      
      
							</ul>
		</section>
	</div>




          


<!--
分享前控制
-->
	 
        			<footer style="overflow:visible;">
				<div class="weimob-copyright" style="padding-bottom:50px;">
											<span class="weimob-support" ></span>
				 </div>
			        </footer>
		<!-- Classie - class helper functions by @desandro https://github.com/desandro/classie -->
		<script src="/MyNosql/marker/mb/20/js/classie.js"></script>
		<script>
		 
				menuRight = document.getElementById( 'cbp-spmenu-s2' ),
			 

		 
			showRight.onclick = function() {
				classie.toggle( this, 'active' );
				classie.toggle( menuRight, 'cbp-spmenu-open' );
				 
			};
		        function disableOther() {
				 
				classie.remove( menuRight, 'cbp-spmenu-open' )
			 }

                       function  show(c)
                {
                   
                    $('#'+c).show();

                  }

		 
		</script>
        
         <script type="text/javascript">
    	$(document).ready(function() { 
		 
           $('#showRight').show();
           
	});
 
       </script>


<script type="text/javascript">
var demo = document.getElementById("demo");
var demo1 = document.getElementById("demo1");
var demo2 = document.getElementById("demo2");
demo2.innerHTML=document.getElementById("demo1").innerHTML;
function Marquee(){
if(demo.scrollLeft-demo2.offsetWidth>=0){
 demo.scrollLeft-=demo1.offsetWidth;
}
else{
 demo.scrollLeft++;
}
}
var myvar=setInterval(Marquee,25);
demo.onmouseout=function (){myvar=setInterval(Marquee,25);}
demo.onmouseover=function(){clearInterval(myvar);}
</script>
	</body>
</html>
