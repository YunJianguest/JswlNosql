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
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/public.css"  />
<link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
<script src="/MyNosql/shop2/js/dining/jquery-1.8.3.min.js" ></script>
<script type="text/javascript" src="/MyNosql/shop2/js/TouchSlide.1.1.js"></script>
 <link combofile="mall/xin_v2.shtml" rel="stylesheet" href="/MyNosql/jindong/css/xin_v2.s.min.css" >
<link href="/MyNosql/lanrenmb/css/common.css" rel="stylesheet" type="text/css" />
<#setting number_format="0">
</head>
<body style="background:#f0efef;">
<!-- 头部 -->
<header class="sy_header"> 
  <!--搜索  -->

    <div class="search"> 
      <div class="ssearch2 ssearch_m fl">
         <ul class="ssearch_ul">
             <form name="form_sel" action="/MyNosql/shop/shop!index.action?toUser=${toUser }&fromUser=fromUserData" method="post" id="search_form">
             <li class="TxtBox1_li4 ysh_art_t fl">
                       <span class="TxtBox1_tc">
                       <select name="sel_type" class="fmy dropdown-select">
                            <option value="product" selected="" >产品</option>
                       </select>
                       
             </li>
             <li class="ssearch2_li fl">
                 <input name="sel" id="sel"  type="text" class="ssearch2_left" style="background:none;" value=""  placeholder="请输入搜索关键字" >
             </li>
             </form>
          </ul>
       </div>
        <a href="#">
        <div class="shaoyishao ssearch_m fl" onClick="javascript:document.form_sel.submit()">
        <div class="sys_pic2"></div>
        </div>
        </a>
   </div>
</header>
<div id="content"> 
  <!-- 轮播图 开始 -->
   <#if picurl??>
  <article class="focu_slide" id="fullSlide">
    <div class="bd"> 
      <ul>
      	<#list picurl as pic> 
      		<li><img src="/MyNosql${pic}" ></li>
      	</#list> 
      </ul>
    </div>
    <div class="hd">
      <ul>
      </ul>
    </div>
  </article>
  <script type="text/javascript">
                TouchSlide({slideCell: "#fullSlide", titCell: ".hd ul", mainCell: ".bd ul", effect: "leftLoop", autoPlay: true, autoPage: true,delayTime:200,interTime:1500});
  </script> 
  </#if>
  <!-- 轮播图 结束 --> 
 <!-- 滑动 开始 -->
 <#if (secTypeList?size>0)>
  <article id="picScroll" class="picScroll">
    <div>
      <div class="bd">
        <ul>
		  <#list secTypeList as secType> 
          <li>
          	
          <a href="/MyNosql/shop/shop!index.action?type=${secType.type}&toUser=${toUser}&fromUser=fromUserData" >
          	<img src="/MyNosql${secType.picurl}"  _src="/MyNosql${secType.picurl}"/>
            <p>${secType.name}</p>
            </a>
           
            </li>
          </#list>
       </ul>
      
       
      </div>
      <div class="hd">
        <ul>
        </ul>
        <span class="prev"></span> </div>
    </div>
    <script type="text/javascript">
                    TouchSlide({
                        slideCell: "#picScroll",
                        titCell: ".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
                        autoPage: true, //自动分页
                        pnLoop: "false", // 前后按钮不循环
                        switchLoad: "_src" //切换加载，真实图片路径为"_src" 
                    });
                </script> 
  </article>
  </#if>
  <!-- 滑动 结束 --> 
 
  <div class="clear"></div>
  <div class="sy_pic"></div>
   <!--品牌 开始-->
  
  <div class="wx_wrap wx_xin_wrap">
    
    <!--E 轮播 -->
    <div class="mod_flr xin_flr">
      <div style="min-height:500px;">
          <ul class="xin_list" id="cmdtyList" style="min-height:500px;">
          <#list productList as pro> 
          <li class="hproduct" attr-group="1" id="DE46EC1E0000000004010000398503CD">    
          	  	 <a href="/MyNosql/shop/shop!productdetail.action?_id=${pro._id}&toUser=${toUser}&fromUser=fromUserData" class="url" onclick="recordState();"> 
          	  	 <span class="important">限量推荐</span>              
          	  	 <img class="photo" init_src="/MyNosql${pro.logo}" src="/MyNosql${pro.logo}" attr-line="1" attr-state="loading">       
          	  	 <h3 class="fn"><i class="icon_jd">微信直供</i>${pro.ptitle}</h3>       <p class="disc">${pro.summary}</p>     </a>    
          	  	  <p class="price"><em>微信价：</em>¥${pro.price}</p>    
          	  	   <p class="other"><span class="fav" attr-tag="favAction" id="favBtn_DE46EC1E0000000004010000398503CD">
          	  	   <em attr-tag="num" id="favNumDE46EC1E0000000004010000398503CD">${pro.sort}</em>人喜欢</span></p>    </li>
          </#list> 
          </ul>
          <ul class="xin_list" id="cmdtyList2" style="display:none;min-height:500px;"></ul>
      </div>
    </div>
    
</div>
</div>

<!-- footer -->
<div class="footer">
	<div class="copy_cont">
            <p class="t_center">
            	<#if picurl??>
				${logo }
				<#else>
				<a href="tel:13991284269">&copy;2012-2015大秦信使文化</a>
			</#if>
			
            </p>
     </div>
</div>

<div id="header">
  
    <div class="hewarp">
		<ul>
			
			<li class="index">
				<a href="/MyNosql/shop/shop!member.action?toUser=${toUser}&fromUser=fromUserData" title="我的" >
				<img src="/MyNosql/shop2/images/sy_ioc23.png" alt=""/>
				我的
				</a>
			</li>
			<li class="index">
				<a href="http://api.map.baidu.com/marker?location=${company.loc[1] },${company.loc[0] }&title=${company.name }&name=${company.name }&content=${company.address }&output=html" title="地址" >
				<img src="/MyNosql/shop2/images/location.png" alt=""/>
				地址
				</a>
			</li>
			
			<li class="index">
				<a href="tel:${company.tel}" title="电话" >
				<img src="/MyNosql/shop2/images/tele_lx.png" alt=""/>
				电话
				</a>
			</li>
			<li class="index">
				<a href="/MyNosql/wwz/wwz!index.action?toUser=${toUser}&fromUser=fromUserData" title="首页" >
				<img src="/MyNosql/shop2/images/in_dp.png" alt=""/>
				首页
				</a>
			</li>
            	
            
           
		</ul>
	</div>
  
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
    		<#if picurl??>
			"imgUrl": "${ip}${company.logo}",
			<#else>
			"imgUrl": "${ip}",
			</#if>
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