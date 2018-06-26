
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="description" content="">

<!-- Mobile Devices Support @begin -->
            <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
            <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
            <meta content="no-cache" http-equiv="pragma">
            <meta content="0" http-equiv="expires">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height" />
            <meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- Mobile Devices Support @end -->

<title>${company.name}</title>
<script type="text/javascript">var yyuc_jspath = "/@system/";</script>
<script type="text/javascript" src="/MyNosql/marker/mb/77/js/jquery.js" ></script><script type="text/javascript" src="/MyNosql/marker/mb/77/js/yyucadapter.js" ></script>
 	    <link rel="stylesheet" href="/MyNosql/marker/mb/77/dummy-images/orbit-1.2.3.css">
	  	<link rel="stylesheet" href="/MyNosql/marker/mb/77/dummy-images/demo-style.css">
	  	
		<!-- Attach necessary JS -->
		<script type="text/javascript" src="/MyNosql/marker/mb/77/dummy-images/jquery-1.5.1.min.js"></script>
		<script type="text/javascript" src="/MyNosql/marker/mb/77/dummy-images/jquery.orbit-1.2.3.min.js"></script>	
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript">
			$(window).load(function() {
				$('#featured').orbit();
			});
		</script>
<style type="text/css">
*{margin:0;padding:0;}
li{list-style-type:none;}
.box{width:100%;height:280px;text-align:center;font-size:50px;border:0px solid #93F;position:relative;margin:0px auto;overflow:hidden;}
.box ul{height:800px;width:100%;position:relative;}
.box ul li{width:100%;height:100%;top:0;position:absolute;}
.box ol{position:absolute;bottom:15px;width:260px;margin-left:-130px;left:50%;z-index:20;text-align:center;}
.box ol a{width:10px;height:10px;margin-right:10px;background:#3F9;border-radius:50%;display:inline-block;box-shadow:2px 3px 5px #CCCCCC;}
.box ol a.active{background:white;z-index:18;}
</style>
<script src="/MyNosql/marker/mb/77/js/jquery-1.7.2.js"></script>
<script src="/MyNosql/marker/mb/77/js/scrollAd.js"></script>
        
<link type="text/css" rel="stylesheet" href="/MyNosql/marker/mb/77/css/list.css"  />
<script type="text/javascript" src="/MyNosql/marker/mb/77/js/3dskin.js"></script>
<script type="text/javascript" src="/MyNosql/marker/mb/77/js/mu.js"></script>
<style type="text/css">
body {
    height: 500px;
}
</style>
<script type="text/javascript" src="/MyNosql/marker/mb/77/js/swipe.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.post('/MyNosql/wwz/wwzajax!zanCount.action?toUser=${toUser}&companyid=${company._id}', null,
    	function(data) {
    		$('#zan').find('span').html("赞("+data.zan+")<p></p>");
    		if (data.iszan == 'true') {
    			alert("已经赞过");
    		} else {
    			alert("没有赞过");
    		}
    	},"json")	
});
$(function(){
	$('img[rrurl]').click(function(){
		location.href = $(this).attr('rrurl');
	});
	$('table').attr("cellpadding","0").attr("cellspacing","0");
	$('[fixed="fixed"]').css('position','fixed');
	resize();
	$(window).resize(function(){
		resize();
	});
	$('.add_qq_more').each(function(){
		var tourl = $.trim($(this).attr('toto'));
		if(tourl ==''){
			tourl = 'javascript:;'
		}
		if(tourl.indexOf(':')==-1){
			tourl = tourl+'.html';
		}
		if(tourl !=''){
			if(tourl.indexOf('tel')!==0){
				if(tourl.indexOf('?')>0){
					tourl = tourl + '&wxid=#mp.weixin.qq.com';
				}else{
					tourl = tourl + '#mp.weixin.qq.com';
				}
				
			}
			if($(this).is('a')){
				$(this).attr('href',tourl);
			}else if($(this).find('a').size()>0){
				$(this).find('a').each(function(){
					if($.trim($(this).attr('href')).indexOf('http')==-1){
						$(this).attr('href',tourl);
					}
				});
			}else{
				$(this).wrap('<a href="'+tourl+'"></a>');
			}			
		}
	});
	if($('.mainpicarea').is('div')){
		var tplth = $('.mainpicarea').find('td').length;
		$('#ppoool').append('<li class="on" style="margin-left:5px;"></li>');
		for(var i=1;i<tplth;i++){
			$('#ppoool').append('<li style="margin-left:5px;"></li>');
		}
		$('.mainpicarea').qswipe({ stime:3600});
		$('.mainpicarea').on('dragok',function(e,msg){
			if((msg+'').indexOf('.')>0){
				msg = 0;
			}
			$('#ppoool').find('li').removeClass('on');
			$('#ppoool').find('li').eq(msg).addClass('on');
		});
		
	}
	

});
function resize(){
	var ww = $(window).width();
	$('.picshowtop,.mainpicshow').css('width',ww+'px');
	$('#tpdhtr').children('td').css('width',ww+'px');
	$('#tpdhtr').children('td').find('img').css('width',ww+'px');
	$('img').each(function(){
		var pw = $(this).parent().width();
		var ppw = $(this).parent().parent().width();
		if($(this).width()>ppw){
			$(this).width(ppw);
		}
	});
}
</script>
  
<style type="text/css">

.mainpicshow{
height: 170px;
overflow: hidden;
}
.mainpicarea{
height: 170px;
}
.mainpicarea table,.mainpicarea tr,.mainpicarea td{
border: none;
border-image-width:0px;
}
.mainpicarea img{
height: 170px;
}
#ppoool{
    height:20px;
    position: relative;
    z-index:10;
    margin-top:0px;
    text-align:right;
    padding-right:15px;
    background-color:rgba(0,0,0,0.3);
}
#ppoool>li{
    display:inline-block;
    margin:5px 0;
    width:8px;
    height:8px;
    background-color:#757575;
    border-radius: 8px;
}
#ppoool>li.on{
    background-color:#ffffff;
}


#zan{
	top:50%;
	right:0px;
    width:50px;
	
	height:50px;
	position: fixed;
	z-index:9999;
	background-image:url('/MyNosql/marker/mb/77/img/zan.png');
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
</head>
<body>
<div style="top:0px;left:0px;width: 100%;height: 100%;position: fixed;z-index:-999;background-image: url('/MyNosql/marker/mb/77/img/bj.jpg');background-size:100%,100%;">

</div>



<div class="zan">
<a href="javascript:zanCompany();" id="zan"><br/><span class="pzan">
							赞(${company.sort})<p></p></span></a>
					
				</div>


<div style="width:100%; height:100%">
      
		<div id="featured"> 
		  <#if (picurl?size>0)>
              <#list  picurl as  pic>
			<img src="${osshttp}${pic}" />
			 
              </#list>
              </#if>
		</div>
		
	
</div>
<div class="mainshowtop">
<DIV class=wz_322_wrapper>
<DIV class=wz_322_content>


<ul>
<#if (funcList?size>0)>
<#list funcList as  func>
  <#if func.method=="link">
<a class=add_qq_more href="${func.url}" toto="81acbad108cacbece8c8aeaf">
<li><BUTTON class="wz_322_buttom m_text">${func.name}</BUTTON> </li></a>
<#else>
<a class=add_qq_more href="/MyNosql/wwz/wwz!${ func.method}.action?_id=1&type=${ func.type}&toUser=${toUser}" toto="81acbad108cacbece8c8aeaf">
<li><BUTTON class="wz_322_buttom m_text">${func.name}</BUTTON> </li></a>
</#if>
</#list>
</#if>
</ul>
</DIV></DIV></div>

  <div class="snower">
		<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/77/css/snower.css"  media="all">
        <script type="text/javascript" src="/MyNosql/marker/mb/77/js/snower2.js" ></script>
		<div style="top: -100px; left: 73%; -webkit-animation: fade 10s 0s, drop 9s 0s;">
		<img src="/MyNosql/marker/mb/77/img/xg3.png" style="-webkit-animation: counterclockwiseSpinAndFlip 10s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 30%; -webkit-animation: fade 10s 2s, drop 10s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg1.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 7s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 4%; -webkit-animation: fade 8s 1s, drop 8s 1s;">
		<img src="/MyNosql/marker/mb/77/img/xg3.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 10s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 85%; -webkit-animation: fade 10s 0s, drop 6s 0s;">
		<img src="/MyNosql/marker/mb/77/img/xg1.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 6s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 19%; -webkit-animation: fade 8s 1s, drop 10s 1s;">
		<img src="/MyNosql/marker/mb/77/img/xg2.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 9s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 44%; -webkit-animation: fade 5s 2s, drop 9s 0s;">
		<img src="/MyNosql/marker/mb/77/img/xg1.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 9s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 89%; -webkit-animation: fade 6s 0s, drop 10s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg2.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 8s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 24%; -webkit-animation: fade 10s 1s, drop 5s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg3.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 7s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 98%; -webkit-animation: fade 10s 2s, drop 5s 1s;">
		<img src="/MyNosql/marker/mb/77/img/xg4.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 5s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 82%; -webkit-animation: fade 7s 3s, drop 6s 1s;">
		<img src="/MyNosql/marker/mb/77/img/xg2.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 10s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 62%; -webkit-animation: fade 8s 2s, drop 8s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg3.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 7s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 64%; -webkit-animation: fade 5s 3s, drop 10s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg2.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 10s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 87%; -webkit-animation: fade 5s 1s, drop 9s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg4.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 10s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 31%; -webkit-animation: fade 9s 0s, drop 5s 0s;">
		<img src="/MyNosql/marker/mb/77/img/xg4.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 7s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 66%; -webkit-animation: fade 6s 1s, drop 6s 3s;">
		<img src="/MyNosql/marker/mb/77/img/xg1.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 9s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 69%; -webkit-animation: fade 9s 0s, drop 6s 2s;">
		<img src="/MyNosql/marker/mb/77/img/xg1.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 6s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 66%; -webkit-animation: fade 8s 0s, drop 8s 2s;">
		<img src="/MyNosql/marker/mb/77/img/xg2.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 7s;width:auto;max-width:60px; max-height:60px;">
		</div><div style="top: -100px; left: 48%; -webkit-animation: fade 7s 1s, drop 9s 0s;">
		<img src="/MyNosql/marker/mb/77/img/xg2.png"  style="-webkit-animation: counterclockwiseSpinAndFlip 10s;width:auto;max-width:60px; max-height:60px;">
		</div>		
        </div>
</body>
      
<script src="menu-223.html"  type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/77/css/mu.css"  media="all" />



 
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

