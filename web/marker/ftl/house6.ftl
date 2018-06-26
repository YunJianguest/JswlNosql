<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /> 
<title>${company.name }</title>
<meta name="keywords" content="${company.keyword}" />
<meta name="description" content="${company.keyword}" />
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />  
<meta content="yes" name="apple-mobile-web-app-capable" />  
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/public.css"  />
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
<script src="/MyNosql/shop2/js/dining/jquery-1.8.3.min.js" ></script>
<script type="text/javascript" src="/MyNosql/shop2/js/TouchSlide.1.1.js"></script>
<link href="/MyNosql/lanrenmb/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
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
</head>
<body style="background:#f0efef;">

<div id="content"> 
  <!-- 轮播图 开始 -->
  <article class="focu_slide" id="fullSlide">
    <div class="bd"> 
      <ul>
      	<#list advertisement as pic>
      		<li><a href=""><img src="/MyNosql${pic}" ></a></li> 
       		
       </#list>      
      </ul>
    </div>
    <div class="hd">
      <ul>
      </ul>
    </div>
  </article>
  <script type="text/javascript">
                TouchSlide({slideCell: "#fullSlide", titCell: ".hd ul", mainCell: ".bd ul", effect: "leftLoop", autoPlay: true, autoPage: true,delayTime:200,interTime:2500});
  </script> 
  <!-- 轮播图 结束 --> 
  <!-- 栏目 -->
  <!-- 滑动 开始 -->
  <div class="bgstyle indexsub">
	 <ul>
     	<c:forEach items="${list}" var="bean" begin="0" end="3" varStatus="status">
		<li class="s${status.index+1} bg${status.index+1}"><a href="/MyNosql/shop/shop!index.action?type=${bean.type}&toUser=${toUser}&fromUser=${fromUser}">
			<div class="subtype">
				<em> ${bean.name} </em>
				<span>${bean.summary}</span>
				<s></s>
			</div></a>
		</li>
        </c:forEach>
	 </ul>
  </div>
  

${company.context}   
</div>
</br>
</br>
<!-- footer -->
<%@ include file="/wwz/wwz-footer.jsp"%>
<!--返回顶部-->
<a id="toTop" href="#" style="">
	<div class="bg_top"></div> </a>
<#if (footList?size>0)>
<div class="posfixbot f14" style="text-align: center;">
	<dl>
		<#list footList as foot> 
		<dd>
			<a href="${foot.url}" ><img
				src="/MyNosql/${bean.picurl}" ><font
				><p>${bean.name }</p>
			</font>
			</a>
		</dd>
			
		</#list>
		
	</dl>

</div>
</#if>

<script type="text/javascript">
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});
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
