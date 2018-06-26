<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${company.name}</title>
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta charset="utf-8">

<link rel="stylesheet" href="/MyNosql/marker/mb/76/index/css/idangerous.swiper.css">
<link href="/MyNosql/marker/mb/76/index/css/iscroll.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/MyNosql/marker/mb/76/index/css/plugmenu.css">
<link href="/MyNosql/marker/mb/76/index/css/cate/cate18_.css" rel="stylesheet" type="text/css">
<style>
  
</style>

<script src="/MyNosql/marker/mb/76/index/js/iscroll.js" type="text/javascript"></script>
<script type="text/javascript">
var myScroll;

function loaded() {
myScroll = new iScroll('wrapper', {
snap: true,
momentum: false,
hScrollbar: false,
onScrollEnd: function () {
document.querySelector('#indicator > li.active').className = '';
document.querySelector('#indicator > li:nth-child(' + (this.currPageX+1) + ')').className = 'active';
}
 });
 
 
}

document.addEventListener('DOMContentLoaded', loaded, false);
</script>
 
</head>

<body id="cate18" style="">
<div id="insert1" style="z-index:10000; position:fixed; top:20px;"></div>
<iframe src="?ac=cookie&amp;c=fromUsername" width="0" height="0" frameborder="0"></iframe>
<div class="banner">
<div id="wrapper" style="overflow: hidden; ">
<div id="scroller" style="width: 5637px; -webkit-transition: 0ms; -webkit-transform: translate3d(-3758px, 0px, 0px) scale(1); ">
<ul id="thelist">
<#if (picurl?size>0)>
<#list picurl as pic>            
<li><p></p><img src="${osshttp}${pic}" style="width: 1879px; "></li>
 
</#list> 
</#if>
</ul>
</div>
</div>
<div id="nav">
<div id="prev" onClick="myScroll.scrollToPage('prev', 0,400,3);return false">← prev</div>
<ul id="indicator">
<#list picurl as pic>           
<li class="active"></li>
</#list>
 
</ul>
<div id="next" onClick="myScroll.scrollToPage('next', 0,400,3);return false">next →</div>
</div>
    <div class="clr"></div>
</div>
 

<div class="device">
    <a class="arrow-left" href="#"></a> 
    <a class="arrow-right" href="#"></a>
    <div class="swiper-container" style="cursor: -webkit-grab; ">
      <div class="swiper-wrapper" style="width: 5637px; height: 185px; -webkit-transform: translate3d(-1879px, 0px, 0px); -webkit-transition: 0s; "><div class="swiper-slide" style="width: 1879px; height: 185px; ">
            <div class="content-slide">
            <#if  (funcList?size>0)>
            <#list  funcList  as  func>
                <#if func.method=="link">
                <a href="func.url">
                    <p class="ico"><img src="${osshttp}${func.picurl}"></p>
                    <p class="title">${func.name}</p>
                </a>
                <#else>
                 <a href="/MyNosql/wwz/wwz!${ func.method}.action?_id=1&type=${ func.type}&toUser=${toUser}">
                    <p class="ico"><img src="${osshttp}${func.picurl}"></p>
                    <p class="title">${func.name}</p>
                </a>
                </#if>
             </#list>
             </#if>                            
                            
  
                     </div>
    		</div>
      
     
    		</div> 
    </div>
  </div>
  <div class="pagination"><span class="swiper-pagination-switch swiper-visible-switch swiper-active-switch"></span></div>






 


<script src="/MyNosql/marker/mb/76/index/js/jquery-1.10.1.min.js" type="text/javascript"></script>
  <script src="/MyNosql/marker/mb/76/index/js/idangerous.swiper-2.1.min.js" type="text/javascript"></script>
  <script>
  var mySwiper = new Swiper('.swiper-container',{
    pagination: '.pagination',
    loop:true,
    grabCursor: true,
    paginationClickable: true
  })
  $('.arrow-left').on('click', function(e){
    e.preventDefault()
    mySwiper.swipePrev()
  })
  $('.arrow-right').on('click', function(e){
    e.preventDefault()
    mySwiper.swipeNext()
  })
  </script>


<script>
var count = document.getElementById("thelist").getElementsByTagName("img").length;	

var count2 = document.getElementsByClassName("menuimg").length;
for(i=0;i<count;i++){
 document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:"+document.body.clientWidth+"px";

}
document.getElementById("scroller").style.cssText = " width:"+document.body.clientWidth*count+"px";

 setInterval(function(){
myScroll.scrollToPage('next', 0,400,count);
},3500 );
window.onresize = function(){ 
for(i=0;i<count;i++){
document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:"+document.body.clientWidth+"px";

}
 document.getElementById("scroller").style.cssText = " width:"+document.body.clientWidth*count+"px";
} 


</script>
 
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
</script>
 

</body></html>