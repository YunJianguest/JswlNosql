<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<link rel="stylesheet" type="text/css" href="${ctx}/index100/css/default.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/index100/css/component.css" />
		<script src="${ctx}/index100/js/modernizr.custom.js"></script>
 <link rel="stylesheet" type="text/css" href="${ctx}/index100/css/reset.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/index100/css/common.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/index100/css/home-28.css-2014-08-28.css"   media="all" />
<link rel="stylesheet" type="text/css" href="${ctx}/index100/css/menu-3.css-2014-08-28.css"   media="all" />
<script type="text/javascript" src="${ctx}/index100/js/jquery.js"  ></script>
<script type="text/javascript" src="${ctx}/index100/js/swipe.js-2014-08-28"  ></script>
<script type="text/javascript" src="${ctx}/index100/js/zepto.js-2014-08-28"  ></script>
<link rel="stylesheet" type="text/css" href="${ctx}/index100/common/css/iscroll.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/index100/common/css/wz.css" />

<link rel="stylesheet" type="text/css" href="${ctx}/index100/music/css/music90.css">

<script src="${ctx}/index100/music/js/player.js" ></script>

<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>${entity.title}</title>
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
			 
       
                <c:forEach items="${list}" var="bean" begin="5" end="20">
                    <c:if test="${bean.summary!='showRight'}">
                   <a href="javascript:void(0)" onClick="show('${bean.summary}')" ><div style=" width:30px; height:30px; border-radius:30px;margin-right:8px;margin-bottom:4px;overflow:hidden;float:left"><img src="${osshttp}${bean.picurl}" width="100%" height="100%";/></div>${bean.name} <c:if test="${bean.summary!=''}"><span style="float:right">定阅</span></c:if></a>
		   
						 
		   
                    	 
              </c:if> 
			 </c:forEach>
		</nav>
	  
		</div>		 
		<!--
	幻灯片管理
	-->

 <c:if test="${entity.mp3!=''}">
<div data-role="widget" data-widget="music90" class="music90">

<a href="javascript:void(0);" class="btn_music on"  onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${entity.mp3}"  autoplay="autoplay" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>   
</c:if> 

 
	<div style="-webkit-transform:translate3d(0,0,0);">

		<div id="banner_box" class="box_swipe">
 
			                             <ul>
                                                            <c:forEach items="${advertisement}" var="bean">
									<li>
												<a onClick="return false;">
																<img src="${osshttp}/${bean.picurl}"  onClick=" window.location.href='${bean.url}'"  style="width:100%;" />
								</a>
					                             </li>
                                                      
 

					                 </c:forEach>		
                                   
							</ul>
                                                        <ol>
                                                                      <c:forEach items="${advertisement}" var="bean">
									<li class="on"></li>
						  </c:forEach>	
							</ol>
                                                       	
		</div>        
     
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


<c:if test="${not empty roll}">

<div id="demo" class="qimo8">
  <div class="qimo">
    <div id="demo1">
      <ul>
      	<c:forEach items="${roll}" var="bean" >
                               <li><a herf="${bean.url}">${bean.title}</a></li>
 	    </c:forEach>
      </ul>
    </div>
    <div id="demo2"></div>
  </div>
</div>
</c:if>
 

       <section >
       <c:if test="${not empty list}"> 
			<ul class="list_ul">

                    	  <c:forEach items="${list}" var="bean" begin="0" end="4">
									<li> 
										<c:if test="${bean.type!='link'}">
                                        			<a href="${ctx }/wwz/wwz!${bean.type}.action?type=${bean.key}&toUser=${bean.toUser}" >
													<figure>
								<div style="background-image:url(${osshttp}${bean.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${bean.name}</figcaption>
							</figure>
						</a>
                            </c:if>   
                            <c:if test="${bean.type=='link'}">                  
                                               <a href="${bean.url}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${bean.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${bean.name}</figcaption>
							</figure>
                                           	</a>
		                                </c:if>   
					</li>
                    	  </c:forEach>
                    
                    
        
                    
                    
                    
                    <c:forEach items="${list}" var="bean" begin="5" end="20">
                                       
		 
                        
									<li  style="display:none" id="${bean.summary}">
                                                                 <c:if test="${bean.type=='link'}">
						  <c:if test="${bean.summary!='showRight'}">

                                                    <a href="${bean.url}&fromUser=${fromUser}" >
							<figure>
								<div style="background-image:url(${osshttp}${bean.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${bean.name}</figcaption>
							</figure>
						</a>
                                                         
                                              </c:if>
                              <c:if test="${bean.summary=='showRight'}">
                                                         <a href="javascript:void(0)">
								<figure>
								<div style="background-image:url(${osshttp}${bean.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${bean.name}</figcaption>
							</figure>
                                                        </a>

                                                
                                                </c:if>
                                              
		                          </c:if>
                                            <c:if test="${bean.type!='link'}">
                                             <c:if test="${bean.summary!='showRight'}">
                                                 <a href="${ctx }/wwz/wwz!${bean.type}.action?type=${bean.key}&toUser=${bean.toUser}&fromUser=${fromUser}" >
			                                <figure>
								<div style="background-image:url(${osshttp}${bean.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${bean.name}</figcaption>
							</figure>
                                           	</a>
                                               </c:if>
                                               
                                                                      <c:if test="${bean.summary=='showRight'}">
                                                 <a href="javascript:void(0)" >
			                                <figure>
								<div style="background-image:url(${osshttp}${bean.picurl});">&nbsp;</div>
								<figcaption style="height:33px; overflow:hidden;">${bean.name}</figcaption>
							</figure>
                                           	</a>
                                               </c:if>          
                                               
                                               
                                             </c:if>
					</li>
                    	 
                  </c:forEach>
                    
                               
      
      
							</ul>
                            </c:if>
		</section>
	</div>




          


<!--
分享前控制
-->
	 
        			<footer style="overflow:visible;">
				<div class="weimob-copyright">
											<span class="weimob-support" >${entity.logo }</span>
				 </div>
			        </footer>
		<!-- Classie - class helper functions by @desandro https://github.com/desandro/classie -->
		<script src="${ctx}/index100/js/classie.js"></script>
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

<script type="text/javascript">
wx.config({
    debug: false,
    appId: '${token.appid}', 
    timestamp: '${token.timestamp}', 
    nonceStr: '${token.noncestr}', 
    signature: '${token.signature}',
    jsApiList: [ 'checkJsApi',
                 'onMenuShareTimeline',
                 'onMenuShareAppMessage',
                 'onMenuShareQQ',
                 'onMenuShareWeibo',
                 'hideMenuItems',
                 'showMenuItems'
                 ] 
});

wx.ready(function(){
	var share={
		    title: '${entity.title}', // 分享标题
		    desc: '${entity.summary}', // 分享描述
		    link: '${token.url}', // 分享链接
		    imgUrl: '${osshttp}${entity.logo}', // 分享图标
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
</script>
	</body>
</html>
