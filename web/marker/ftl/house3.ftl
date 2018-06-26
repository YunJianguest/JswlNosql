<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${company.name }</title>
<meta name="viewport" content="width=device-width,user-scalable=no, initial-scale=1">
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<link type="text/css" rel="stylesheet" href="/MyNosql/lanrenmb/wiying/index.css" />

<script type="text/javascript" src="/MyNosql/lanrenmb/wiying/jquery.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/wiying/alert.js"></script>
<script type="text/javascript" src="/MyNosql/lanrenmb/wiying/common.js"></script>
<link href="/MyNosql/lanrenmb/css/common.css" rel="stylesheet" type="text/css" />
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
</head>

<body>
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
<header>
    <div class="banner">
        <div id="wrapper" style="overflow: hidden; ">
            <div id="scroller">
                <ul id="thelist">
                	<#list picurl as pic> 
                    <li><p></p><a href="#"><img src="/MyNosql${pic}" /></a></li>
                    </#list>
                 </ul>
            </div>
        </div>
    </div>
    <div id="nav">
        <div id="prev" onclick="javascript:myScroll.scrollToPage('prev', 0);"></div>
        <ul id="indicator">
            <#list picurl as pic> 
						<li></li>
			</#list>
		</ul>
        <div id="next" onclick="javascript:myScroll.scrollToPage('next', 0, 400, 2);"></div>
    </div>
    <div class="clr"></div>
</header>
<script>
    var count = document.getElementById("thelist").getElementsByTagName("img").length;
    for (i = 0; i < count; i++) {
        document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:" + document.body.clientWidth + "px";
    }
    document.getElementById("scroller").style.cssText = " width:" + document.body.clientWidth * count + "px";
    setInterval(function() {
        myScroll.scrollToPage('next', 0, 400, count);
    }, 3500);
    window.onresize = function() {
        for (i = 0; i < count; i++) {
            document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:" + document.body.clientWidth + "px";
        }
        document.getElementById("scroller").style.cssText = " width:" + document.body.clientWidth * count + "px";
    };
</script>
<div class="content">
	<#if funcList[0]??>
    	<a href="${funcList[0].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809673822754.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[0].name}</div></a>
    	<#else>
		<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809673822754.png) center no-repeat; background-size:contain;"></div>
        <div class="text">关于我们</div></a>
	</#if>
	<#if funcList[1]??>
		<a href="${funcList[1].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809673974739.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[1].name}</div> </a>
		<#else>
   		<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809673974739.png) center no-repeat; background-size:contain;"></div>
        <div class="text">设计团队</div> </a>
    </#if>
    <#if funcList[2]??>
    	<a href="${funcList[2].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674157426.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[2].name}</div> </a>
		<#else>
    	<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674157426.png) center no-repeat; background-size:contain;"></div>
        <div class="text">经典案例</div> </a>
    </#if>
    <#if funcList[3]??>
    	<a href="${funcList[3].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674319154.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[3].name}</div> </a>
		<#else>
    	<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674319154.png) center no-repeat; background-size:contain;"></div>
        <div class="text">服务保障</div> </a>
    </#if>
    <#if funcList[4]??>
    	<a href="${funcList[4].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674461949.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[4].name}</div></a>
		<#else>
    	<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674461949.png) center no-repeat; background-size:contain;"></div>
        <div class="text">优惠活动</div></a>
    </#if>
    <#if funcList[5]??>
    	<a href="${funcList[5].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674651404.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[5].name}</div></a>
		<#else>
   		 <a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674651404.png) center no-repeat; background-size:contain;"></div>
        <div class="text">装饰课堂</div></a>
    </#if>
    <#if funcList[6]??>
    	<a href="${funcList[6].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674805918.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[6].name}</div></a>
		<#else>
		<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674805918.png) center no-repeat; background-size:contain;"></div>
        <div class="text">会员中心</div></a>
    </#if>
    <#if funcList[7]??>
    	<a href="${funcList[7].url}" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674974016.png) center no-repeat; background-size:contain;"></div>
        <div class="text">${funcList[7].name}</div></a>
		<#else>
		<a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" data-role="none">
        <div class="img" style="background:url(/MyNosql/lanrenmb/wiying/13809674974016.png) center no-repeat; background-size:contain;"></div>
        <div class="text">联系我们</div></a>
    </#if>
    </div>
${company.context}    
<div class="footer">
<p class="footer-top">&COPY;${logo}</p>
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