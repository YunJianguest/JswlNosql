<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${company.name}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="/MyNosql/marker/mb/donggan/css/demo.css" >
<link rel="stylesheet" href="/MyNosql/marker/mb/donggan/css/kontext.css" >

<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/donggan/css/font-awesome.css" media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/donggan/css/common.css"  media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/music/css/music90.css">
<script src="/MyNosql/marker/mb/music/js/player.js" ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/donggan/js/jquery.js" ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/donggan/js/swipe.js" ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/donggan/js/zepto.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link rel="stylesheet" type="text/css" href="${osshttp}/shop2/css/home.css" />


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
	color:red;
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
$('#zan').find('span').html("<br/><br/><br/>赞("+res+")<p></p>");

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
<body>

<div class="music90">

<a href="javascript:void(0);" class="btn_music on"  onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}"  autoplay="autoplay" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>
<div class="zan">
<a href="javascript:zanCompany();" id="zan"><span class="pzan">
							  赞(${company.sort})<p></p></span></a>
					
				</div>

 <#if (picurl?size>0)>
<article class="kontext">
   <#if picurl[0]??>
	<div class="layer one show" style=" background-image:url(${osshttp}${picurl[0]})">
		<h2></h2>
		<p><div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div></p>

	</div>
    </#if>
    
     <#if picurl[1]??>
	<div class="layer two" style="background-image: url(${osshttp}${picurl[1]})">
		<h2></h2>
	</div>
    </#if>
     <#if picurl[2]??>
	<div class="layer three" style="background-image: url(${osshttp}${picurl[2]})">
		<h2></h2>
	</div>
    </#if>
     <#if picurl[3]??>
        <div class="layer four" style="background-image: url(${osshttp}${picurl[3]})">
		<h2></h2>
	</div>
    </#if>
     <#if picurl[4]??>
       <div class="layer five" style="background-image: url(${osshttp}${picurl[4]})">
		<h2></h2>
	</div></#if>
      <#if picurl[5]??>
       <div class="layer six" style="background-image: url(${osshttp}${picurl[5]})">
		<h2></h2>
	</div></#if>
    <#if picurl[6]??>
       <div class="layer seven" style="background-image: url(${osshttp}${picurl[6]})">
		<h2></h2>
	</div></#if>
      <#if picurl[7]??>
       <div class="layer eight" style="background-image: url(${osshttp}${picurl[7]})">
		<h2></h2>
	</div></#if>
     <#if picurl[8]??>
      <div class="layer nine" style="background-image: url(${osshttp}${picurl[8]})">
		<h2></h2>
	</div></#if>
     <#if picurl[9]??>
      <div class="layer ten" style="background-image: url(${osshttp}${picurl[9]})">
		<h2></h2>
	</div></#if>
</article>
</#if>
<ul class="bullets"></ul>

<script src="/MyNosql/marker/mb/donggan/js/kontext.js" ></script>
<script>
	// Create a new instance of kontext
	var k = kontext( document.querySelector( '.kontext' ) );


	// API METHODS:

	// k.prev(); // Show prev layer
	// k.next(); // Show next layer
	// k.show( 3 ); // Show specific layer
	// k.getIndex(); // Index of current layer
	// k.getTotal(); // Total number of layers


	// DEMO-SPECIFIC:

	var bulletsContainer = document.body.querySelector( '.bullets' );

	// Create one bullet per layer
	for( var i = 0, len = k.getTotal(); i < len; i++ ) {
		var bullet = document.createElement( 'li' );
		bullet.className = i === 0 ? 'active' : '';
		bullet.setAttribute( 'index', i );
		bullet.onclick = function( event ) { k.show( event.target.getAttribute( 'index' ) ) };
		bullet.ontouchstart = function( event ) { k.show( event.target.getAttribute( 'index' ) ) };
		bulletsContainer.appendChild( bullet );
	}

	// Update the bullets when the layer changes
	k.changed.add( function( layer, index ) {
		var bullets = document.body.querySelectorAll( '.bullets li' );
		for( var i = 0, len = bullets.length; i < len; i++ ) {
			bullets[i].className = i === index ? 'active' : '';
		}
	} );

	document.addEventListener( 'keyup', function( event ) {
		if( event.keyCode === 37 ) k.prev();
		if( event.keyCode === 39 ) k.next();
	}, false );

	var touchX = 0;
	var touchConsumed = false;

	document.addEventListener( 'touchstart', function( event ) {
		touchConsumed = false;
		lastX = event.touches[0].clientX;
	}, false );

	document.addEventListener( 'touchmove', function( event ) {
		event.preventDefault();

		if( !touchConsumed ) {
			if( event.touches[0].clientX > lastX + 10 ) {
				k.prev();
				touchConsumed = true;
			}
			else if( event.touches[0].clientX < lastX - 10 ) {
				k.next();
				touchConsumed = true;
			}
		}
	}, false );

</script>



<style>
.top_bar{
    position:fixed;
    width:100%;
    left:0;
    top:0;
    z-index:100;
}
.top_bar+*{
    padding-top:35px;
}
.top_menu{
    display:-webkit-box;
    background: -webkit-gradient(linear, 0 0, 0 100%, from(#212C30), to(#121619));
}

.top_bar .top_menu>li{
    -webkit-box-flex:1;
    height:35px;
    background: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(255,255,255,0.1)),color-stop(50%,rgba(255,255,255,0.8)), to(rgba(255,255,255,0.1)));
    -webkit-background-size:1px 80%;
    background-size:1px 80%;
    background-position: right center;
    background-repeat: no-repeat;
    position:relative;
    text-align:center;
}
.top_menu>li:last-of-type{background:none;}
.top_menu>li span{
    display:inline-block;
    height:100%;
    width:25px;
    margin:auto;
    font-size:24px;
    color:#fff;
    line-height:35px;
    /*background: url(/show/img/Template/weimob-icons.png) no-repeat 0 5px;*/
}
.top_menu>li span.i_back{
    background-position:0 5px;
}
.top_menu>li span.i_home{
    background-position:-33px 5px;
}
.top_menu>li span.i_tel{
    background-position:-65px 5px;
}
.top_menu>li span.i_menu{
    background-position:-95px 5px;
}

.menu_font{
    text-align:left;
    position:absolute;
    top:35px;
    right:10px;
    z-index:500;
}
.menu_font.hidden{
    display:none;
}
</style>
<div class="top_bar">
<nav>
<#if (footList?size>0)>
<ul class="top_menu">
<li onclick="window.history.go(-1);"><span class="icon-chevron-sign-left"></span></li>
<#if footList[0]??>

<li onclick="location.href='${footList[0].url}'"><span class="icon-home"></span></li>

</#if>
<li onclick="$('#menu_font').toggleClass('hidden');">
<span class="icon-list-ul"></span>
<#if (funcList?size>0)>
<ul id="menu_font" class="menu_font hidden" onclick="$('#menu_font').toggleClass('hidden');">
<#list funcList as func>
<li>

<#if func.method=="link">
<a href="${func.url}"  class="icon-smile">${func.name}</a>
<#else>
<a href="/MyNosql/wwz/wwz!${ func.method}.action?_id=1&type=${ func.type}&toUser=${toUser}"  class="icon-smile">${func.name}</a>
</#if>
</li>
</#list>
</ul>
</#if>
</li>
</ul>
</#if>
</nav>
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