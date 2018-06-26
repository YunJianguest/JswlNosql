<!doctype html>
<html>
<head>
<title>${company.name }</title>
<meta name="keywords" content="${company.keyword}" />
<meta name="description" content="${company.keyword}" />
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta name="apple-touch-fullscreen" content="yes">
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="telephone=no" name="format-detection" />
<meta content="email=no" name="format-detection" />
<link href="/MyNosql/lanrenmb/zhengwu/shouye_style.css"  type="text/css" rel="stylesheet"/> 
<script src="/MyNosql/shop2/js/dining/jquery-1.8.3.min.js" ></script>
<script type="text/javascript" src="/MyNosql/shop2/js/TouchSlide.1.1.js"></script>
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
<link href="/MyNosql/lanrenmb/css/common.css" rel="stylesheet" type="text/css" />
<#setting number_format="0">
</head>
<!--日志-->
<body>
<div class="section">
    	<div id="content"> 
  <!-- 轮播图 开始 -->
  <article class="focu_slide" id="fullSlide">
    <div class="bd"> 
      <ul>
      	<#list picurl as pic> 
      		<li><img src="${osshttp}${pic}" ></li>
      	</#list> 
      </ul>
    </div>
    <div class="hd">
      <ul>
      </ul>
    </div>
  </article>
  <script type="text/javascript">
                TouchSlide({slideCell: "#fullSlide", titCell: ".hd ul", mainCell: ".bd ul", effect: "leftLoop", autoPlay: true, autoPage: true,delayTime:200,interTime:5000});
  </script> 
	 <#if (rollList?size>0)>
	<div class="pmd">
		<marquee width=100%  direction=left align=middle border=0>
			<#list rollList as roll> 
			<a href="${roll.url}" >${roll.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
			</#list> 
		</marquee>
	</div>
	</#if>


	<div class="clearfix"></div>
	<#if (newsList?size>0)>
	<div class="title">
		<img src="/MyNosql/lanrenmb/zhengwu/njzx.gif"  alt=""  class="icon" /> 最近资讯<span> >>
		<a href="/MyNosql/wwz/wwz!wxnewscommon.action?comid=${company._id}&toUser=${toUser }&fromUser=fromUserData" >更多</a></span>
	</div>
	<div class="content">
		<ul>
			<#list newsList as news> 
			<li> <a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=${news._id}&toUser=${toUser}&fromUser=FromUserData" >${news.newtitle}</a></li>
			</#list> 
		</ul>
	</div>
	</#if>
	
	<div class="title">
		<img src="/MyNosql/lanrenmb/zhengwu/wsfw.gif"  alt="" class="icon" /> 网上服务
	</div>
<div class="content-table">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="xuanban">
	<tr>
		<#if funcList[0]??>
			<#if funcList[0].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[0].url}" ><img src="${osshttp}${funcList[0].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[0].method}.action?_id=1&type=${funcList[0].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[0].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		<#if funcList[1]??>
			<#if funcList[1].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[1].url}" ><img src="${osshttp}${funcList[1].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[1].method}.action?_id=1&type=${funcList[1].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[1].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		<#if funcList[2]??>
			<#if funcList[2].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[2].url}" ><img src="${osshttp}${funcList[2].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[2].method}.action?_id=1&type=${funcList[2].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[2].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		
		
	</tr>
	<#if (funcList?size>3)>
	<tr>
		<#if funcList[3]??>
			<#if funcList[3].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[3].url}" ><img src="${osshttp}${funcList[3].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[3].method}.action?_id=1&type=${funcList[3].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[3].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		<#if funcList[4]??>
			<#if funcList[4].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[4].url}" ><img src="${osshttp}${funcList[4].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[4].method}.action?_id=1&type=${funcList[4].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[4].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		<#if funcList[5]??>
			<#if funcList[5].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[5].url}" ><img src="${osshttp}${funcList[5].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[5].method}.action?_id=1&type=${funcList[5].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[5].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		
	</tr>
	</#if>
	<#if (funcList?size>6)>
	<tr>
		
		<#if funcList[6]??>
			<#if funcList[6].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[6].url}" ><img src="${osshttp}${funcList[6].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[6].method}.action?_id=1&type=${funcList[6].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[6].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		<#if funcList[7]??>
			<#if funcList[7].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[7].url}" ><img src="${osshttp}${funcList[7].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[7].method}.action?_id=1&type=${funcList[7].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[7].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
		<#if funcList[8]??>
			<#if funcList[8].method=="link">
			<td align="center"  class="t-1"><a href="${funcList[8].url}" ><img src="${osshttp}${funcList[8].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	
        	<#else>
        	<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!${funcList[8].method}.action?_id=1&type=${funcList[8].type}&toUser=${toUser}" ><img src="/MyNosql${funcList[8].picurl}"  alt="" width="98%" " width="98%" "/></a></td>
        	</#if>
        	<#else>
			<td align="center"  class="t-1"><a href="/MyNosql/wwz/wwz!wxnewscommondetail.action?_id=1&toUser=${toUser}&fromUser=fromUserData" ><img src="/MyNosql/lanrenmb/zhengwu/szxx.gif"  alt="" width="98%" " /></a></td>
		</#if>
	</tr>
	</#if>
		
</table>
</div>

${company.context}

</div>
<#if (footList?size>0)>
<div id="header">
  
    <div class="hewarp">
		<ul>
			<#list footList as foot> 
			<li class="index">
				<a href="${foot.url}" title="${foot.name}" >
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