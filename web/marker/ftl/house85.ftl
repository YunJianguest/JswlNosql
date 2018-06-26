<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${company.name}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta http-equiv="Pragma" content="no-cache"/>
<link rel="stylesheet" href="/MyNosql/marker/mb/18/css/reset.css" tppabs="http://www.sxxskw.com/MyNosql/house/themes/css/reset.css" />
<link rel="stylesheet" href="/MyNosql/marker/mb/18/css/index.css" tppabs="http://www.sxxskw.com/MyNosql/house/themes/css/index.css" />
<!-- 引入图标样式 -->
<link rel="stylesheet" href="/MyNosql/marker/mb/18/css/font-awesome.min.css" tppabs="http://www.sxxskw.com/MyNosql/house/themes/css/font-awesome.min.css" />
<!-- 引入JS -->
<script type="text/javascript" src="/MyNosql/marker/mb/18/js/zepto.js" tppabs="http://www.sxxskw.com/MyNosql/house/themes/js/zepto.js"></script>
<script type="text/javascript" src="/MyNosql/marker/mb/18/js/swipe.js" tppabs="http://www.sxxskw.com/MyNosql/house/themes/js/swipe.js"></script>
<script src="/MyNosql/marker/mb/18/js/jquery-2.1.1.min.js"></script>
<script src="/MyNosql/marker/mb/18/js/jquery-2.1.1.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
	<div class="body">
			<!--幻灯片管理-->
		<div style="-webkit-transform:translate3d(0,0,0);">
	
			<div id="banner_box" class="box_swipe">
				<ul>
					
					 <#if (picurl?size>0)>
              <#list  picurl as  pic>
			 <li>
			 <a href="#">
		<img src="${osshttp}${pic}"  alt="" />
		
	     </a>
           </li>
              </#list>
              </#if>
				 
				</ul>
				<ol>
                <#list picurl as pic>
					<li ></li>
				</#list>
           		
				</ol>
			</div>
		</div>
	</div>
	<!-- 幻灯片JS -->
	<script type="text/javascript">
		$(function(){
			new Swipe(document.getElementById('banner_box'), {
				speed:500,
				auto:3000,
				callback: function(){
					var lis = $(this.element).next("ol").children();
					lis.removeClass("on").eq(this.index).addClass("on");
				}
			});
		});
	</script>
	
	<div id="navList_box" class="box_swipe">
		<ul>
			
			<li>
               <#if (funcList?size>0)>
                  <#if funcList[0]??>
                   <#if funcList[0].method=="link">
			<a href="${funcList[0].url}">
			<span class="icon-home"></span>
			<p>${funcList[0].name}</p>
			</a>
                          <#else>
                    
                        <a href="/MyNosql/wwz/wwz!${ funcList[0].method}.action?_id=1&type=${ funcList[0].type}&toUser=${toUser}">
			 <span class="icon-home"></span>
			 <p>${funcList[0].name}</p>
			 </a>
                   
                    </#if>
                  </#if>

                          <#if funcList[1]??>
                   <#if funcList[1].method=="link">
			<a href="${funcList[1].url}">
			<span class="icon-picture"></span>
			<p>${funcList[1].name}</p>
			</a>
                          <#else>
                    
                        <a href="/MyNosql/wwz/wwz!${ funcList[1].method}.action?_id=1&type=${ funcList[1].type}&toUser=${toUser}">
			 <span class="icon-picture"></span>
			 <p>${funcList[1].name}</p>
			 </a>
                   
                    </#if>
                  </#if>


                      <#if funcList[2]??>
                   <#if funcList[2].method=="link">
			<a href="${funcList[2].url}">
			<span class="icon-building"></span>
			<p>${funcList[2].name}</p>
			</a>
                          <#else>
                    
                        <a href="/MyNosql/wwz/wwz!${ funcList[2].method}.action?_id=1&type=${ funcList[2].type}&toUser=${toUser}">
			 <span class="icon-building"></span>
			 <p>${funcList[2].name}</p>
			 </a>
                   
                    </#if>
                  </#if>
                  

                <#if funcList[3]??>
                   <#if funcList[3].method=="link">
			<a href="${funcList[3].url}">
			<span class="icon-check"></span>
			<p>${funcList[3].name}</p>
			</a>
                          <#else>
                    
                        <a href="/MyNosql/wwz/wwz!${ funcList[3].method}.action?_id=1&type=${ funcList[3].type}&toUser=${toUser}">
			 <span class="icon-check"></span>
			 <p>${funcList[3].name}</p>
			 </a>
                   
                    </#if>
                  </#if>


		 </#if>	
			</li>
			
			
			
		</ul>
		<ol>
			<a href="javascript:navList_box.prev();">&nbsp;</a>
			<a href="javascript:navList_box.next();">&nbsp;</a>
		</ol>
	</div>
<div class="zan">
<a href="javascript:zanCompany();" id="zan"><span class="pzan">
							赞(${company.sort})<p></p></span></a>
					
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