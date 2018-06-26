<!DOCTYPE html>
<html>
<head>
<title>寿 宴</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/73/css/index.css" media="all">
<script type="text/javascript" src="/MyNosql/marker/mb/73/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body onselectstart="return true;" ondragstart="return false;">
<div id="cover">
<div class="mask"></div>
</div>
<div id="mymask" onclick='document.getElementById("mymask").style.display="none"'>
    <img src="/MyNosql/marker/mb/73/img/guide.png"/>
</div>
<div class="dp">
<img src="/MyNosql/marker/mb/73/img/t.png"/>
</div>
<div class="content">



<li class="pb_10"><video src="/MyNosql/marker/mb/73/img/sou.mp4" width="100%" id="myvd"  controls></video></li>
 
<#if (picurl?size>0)>
<#list picurl as  pic>
<li class="pb_10"><img src="${osshttp}${pic}" style="width:100%;"></li>
 </#list>
</#if>

<div style="text-align:left;font-size:22px;margin-top:10px;">想说的话</div>
<div style="text-align:left;margin-top:5px;border:2px solid #000;border-radius:8px;padding:5px;line-height:22px;font-size:18px;">${company.context}</div>
 

<#if (footList?size>0)>
<#list footList as foot>
<a class="abu" href="${foot.url}">${foot.name}<span class="yuan">${foot.summary}</span></a>
</#list>
</#if>


<a class="sharebutton" href="javascript:void(0)" onclick='document.getElementById("mymask").style.display="block"'><span class="minijiankatong">分享给朋友</span></a>
</div>


<div class="bot"></div>
 
</body>
<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
WeixinJSBridge.call('hideToolbar');
});

var ist=true;
var covert=true;
    th=-$('#cover').height()+"px";

function closecover(){
$('#cover').animate({top:th},900,'swing',function(){
    $('#cover').remove();
});
}
var handler_touch=function(e){
    closecover();
	if(document.getElementById('myaudio')){
   document.getElementById('myaudio').play();
	}
	if(document.getElementById('myvd')){
   document.getElementById('myvd').play();
	}
    e.preventDefault();
    return false;
}
$('#cover').one('touchstart',handler_touch);
</script>

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