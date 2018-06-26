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


</div>		
<!-- Classie - class helper functions by @desandro https://github.com/desandro/classie -->
		 
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
		    imgUrl: '${osshttp}${entity.bj1}', // 分享图标
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
