<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${company.name}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="/MyNosql/mb/donggan/css/demo.css" >
<link rel="stylesheet" href="/MyNosql/mb/donggan/css/kontext.css" >

<link rel="stylesheet" type="text/css" href="/MyNosql/mb/donggan/css/font-awesome.css" media="all" />
<link rel="stylesheet" type="text/css" href="/MyNosql/mb/donggan/css/common.css"  media="all" />
<script type="text/javascript" src="/MyNosql/mb/donggan/js/jquery.js" ></script>
<script type="text/javascript" src="/MyNosql/mb/donggan/js/swipe.js" ></script>
<script type="text/javascript" src="/MyNosql/mb/donggan/js/zepto.js" ></script>

<link rel="stylesheet" type="text/css" href="${osshttp}/shop2/css/home.css" />

</head>
<body>
<#if company.mp3!=""||company.mp3!=null>
<div data-role="widget" data-widget="music90" class="music90" style="top:35px">
<link rel="stylesheet" href="/MyNosql/mb/music/css/music90.css">
			<script src="/MyNosql/mb/music/js/player.js" ></script>
			<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>
 </#if>
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

<script src="/MyNosql/mb/donggan/js/kontext.js" ></script>
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
<ul class="top_menu">
<li onclick="window.history.go(-1);"><span class="icon-chevron-sign-left"></span></li>
<#if (funcList?size>0)>
<#list funcList as func>
<li onclick="location.href='${func.url}'"><span class="icon-home"></span></li>
</#list>
</#if>
<li onclick="$('#menu_font').toggleClass('hidden');">
<span class="icon-list-ul"></span>
<#if (footList?size>0)>
<ul id="menu_font" class="menu_font hidden" onclick="$('#menu_font').toggleClass('hidden');">
<#list footList as foot> 
<li><a href="${foot.url}"  class="icon-smile">${foot.name}</a></li>
</#list>
</ul>
</#if>
</li>
</ul>
</nav>
</div> 


 <script type="text/javascript">
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});
	
	function zanCompany() {

		$.post('/MyNosql/wwz/wwzajax!zanCompany.action?toUser=${toUser}&companyid=${company._id}',
						function(res) {
							
							if (res) {
								
							} else {
								alert('请求失败了');
							}
						});
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

</body>
</html>