<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="keywords" content="${company.keyword}" />
<meta name="description" content="${company.keyword}" />
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<title>${company.name }</title>
<meta name="viewport" content="width=device-width,user-scalable=no, initial-scale=1">
<link type="text/css" rel="stylesheet" href="/MyNosql/lanrenmb/zaojiao/index.css" />
<link href="/MyNosql/lanrenmb/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/MyNosql/lanrenmb/zaojiao/jquery.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/zaojiao/jquery-1.2.6.pack.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/zaojiao/g.base.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/zaojiao/iscroll.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/zaojiao/alert.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/zaojiao/common.js"></script>
<script type="text/javascript" src="/MyNosql/weimob/js/audio.js"></script>
<script type="text/javascript">
    var myScroll;
    function loaded() {
        myScroll = new iScroll('wrapper', {
            snap: true,
            momentum: false,
            hScrollbar: false,
            onScrollEnd: function() {
                document.querySelector('#indicator > li.active').className = '';
                document.querySelector('#indicator > li:nth-child(' + (this.currPageX + 1) + ')').className = 'active';
            }
        });
    }
    document.addEventListener('DOMContentLoaded', loaded, false);
</script>
    <script>
        $(function() {
            var wei = $(window).width();
            var hei = $(window).height();
            $(".main").css({"height": hei});
            $(window).resize(function() {
                var wei = $(window).width();
                var hei = $(window).height();
                $(".main").css({"height": hei});
            });

            var a = 1;
            $(".banner ul li").eq(a - 1).fadeIn();
            var len = $(".banner ul li").length;
            setInterval(function() {
                if (a == len) {
                    a = 1;
                    $(".banner ul li").stop(true).fadeOut();
                    $(".banner ul li").eq(0).fadeIn();
                } else {
                    $(".banner ul li").stop(true).fadeOut();
                    $(".banner ul li").eq(a).stop(true).fadeIn();
                    a++;
                }
            }, 2500);
        })
    </script>
</head>

<body>
    <div class="logo">
    	<#if funcList[0]??>
    	<img src="/MyNosql${funcList[0].picurl}">
    	<#else>
			<img src="/MyNosql/lanrenmb/zaojiao/logo_03.jpg">
		</#if>
    </div>
	<#if company.mp3 !="">
			<script>
				window.addEventListener("DOMContentLoaded", function(){
					playbox.init("playbox");
				}, false);
			</script>
		<span id="playbox" class="btn_music"
			onclick="playbox.init(this).play();"><audio
				src="/MyNosql${company.mp3 }"
				loop id="audio"></audio>
		</span> <br />
	</#if>
    <div class="main">
        <div class="main-center">
            <div class="banner">
                <ul>
                	<#list picurl as pic> 
                    <li style="background:url(/MyNosql${pic}) center no-repeat; background-size:cover;"></li>
                    </#list>                    
                     </ul>
            </div>

            <div class="main-content">
            	<#if funcList[1]??>
                <a href="${funcList[1].url}" data-role="none">${funcList[1].name}</a>
                <#else>
				<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">未配置</a>
				</#if>
				<#if funcList[2]??>
                <a href="${funcList[2].url}" data-role="none">${funcList[2].name}</a>
                <#else>
				<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">未配置</a>
				</#if>
				<#if funcList[3]??>
                <a href="${funcList[3].url}" data-role="none">${funcList[3].name}</a>
                <#else>
				<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">未配置</a>
				</#if>
				<#if funcList[4]??>
                <a href="${funcList[4].url}" data-role="none">${funcList[4].name}</a>
                <#else>
				<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">未配置</a>
				</#if>
                
            </div>
            <div class="main-bottom">
            	<#if funcList[5]??>
                <a href="${funcList[5].url}" data-role="none">${funcList[5].name}</a>
                <#else>
				<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">未配置</a>
				</#if>
				<#if funcList[6]??>
                <a href="${funcList[6].url}" data-role="none">${funcList[6].name}</a>
                <#else>
				<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">未配置</a>
				</#if>
             </div>
        </div>
    </div>
<#if (footList?size>0)>
<div class="moveleft">

 <div id="header">
  
    <div class="hewarp">
		<ul>
			<#list footList as foot> 
			<li class="index">
				<a href="${foot.url}" title="${foot.name}">
				<img src="/MyNosql${foot.picurl}" alt=""/>
				${foot.name}
			  </a>
			</li>
			</#list>
			
            
			
		</ul>
	</div>
  
 </div>
</#if>
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
			"imgUrl": "${ip}${company.logo}",
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