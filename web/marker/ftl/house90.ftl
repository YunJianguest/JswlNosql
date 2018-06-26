<!DOCTYPE html>
<html>
	<head>
		<title>${company.name}</title>
		<meta charset="utf-8">
		<meta content="" name="description">
		<meta content="" name="keywords">
		<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
		<meta content="telephone=no, address=no" name="format-detection">
		<link href="/MyNosql/marker/mb/96/css/main.css-v=5.css" rel="stylesheet" />
                <link rel="stylesheet" type="text/css" href="/MyNosql/shop2/css/home.css" />
        <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript">
		(function(){
			var phoneWidth = parseInt(window.screen.width),
				phoneScale = phoneWidth/640,
				ua = navigator.userAgent;

			if (/Android (\d+\.\d+)/.test(ua)){
				var version = parseFloat(RegExp.$1);
				// andriod 2.3
				if(version > 2.3){
					document.write('<meta name="viewport" content="width=640, minimum-scale = '+phoneScale+', maximum-scale = '+phoneScale+', target-densitydpi=device-dpi">');
				// andriod 2.3以上
				}else{
					document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
				}
				// 其他系统
			}  
		})();
        		var config = {
                         
			
			swipeCur: 0,
			swipeDir:'vertical', // 'vertical' // horizontal
                        
		}
        //业务关联链接数组
        var ary_biz_jump_id = new Array();
        var ary_biz_jump_url = new Array();
		</script>
		<script src="/MyNosql/marker/mb/96/js/zepot.js"></script>
		<script src="/MyNosql/marker/mb/96/js/lottery.js"></script>
		<script src="/MyNosql/marker/mb/96/js/swipe.js"></script>
		<script src="/MyNosql/marker/mb/96/js/player.js"></script>
		<script src="/MyNosql/marker/mb/96/js/bur.js"></script>
		<script src="/MyNosql/marker/mb/96/js/app.js"></script>

 
	</head>
	<body onselectstart="return true;" ondragstart="return false;">

 
		<div class="container">
			<div class="loading-img"><img src="/MyNosql/marker/mb/96/img/loading.gif-v=2014-05-21.gif" /></div>


 
      
			<div class="swipe" id="swipe">
				<ul>
  <#if (picurl?size>0)>

     <#list picurl as pic> 
                                    					        <li><div style="background-image: url(${osshttp}${pic})"></div></li>
                            					
                            					
    </#list>
   </#if>



<#if (funcList?size>0)>

<#list funcList  as func>

  <li><div  style="background-image: url(${osshttp}${func.picurl})" onClick="window.location.href='${func.url}'"></div></li>

</#list>

</#if>
				</ul>

			</div>
         

          <script>
            
			 function bton()
			 {
				var music=document.getElementById("music");
				 
				     if(music.innerHTML=="打开")
			     {
					 
				music.innerHTML="关闭";
				
				}else
				{
					music.innerHTML="打开"; 
					}
         
				 }
           </script>
            			<div id="musicWrap" class="music_wrap f-hide">
				<span class="text move hide" id="music">打开</span>
                				    <i id="audioBtn" data-src="${company.mp3}" class="btn_music on" onClick="bton()"></i>
                			</div>
            
			<div id="arrowV" class="arrow_v f-hide"><p></p></div>

			<div id="arrowH" class="arrow_h f-hide">
				<span class="arrow_l"></span>
				<span class="arrow_r"></span>
			</div>

			<div class="lottery" id="lottery"></div>
			<div class="download_mask" id="downloadMask"><i></i></div>
		</div>

   <script type="text/javascript">
    	$(document).ready(function() { 
		 
		share()
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
