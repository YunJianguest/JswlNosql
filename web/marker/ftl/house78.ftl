<!doctype html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>${company.name}</title>
<link rel="stylesheet" href="/MyNosql/marker/mb/15/css/idangerous.swiper.css">
<link rel="stylesheet" href="/MyNosql/marker/mb/15/css/style.css">
<link rel="stylesheet" href="/MyNosql/marker/mb/15/css/animations.css">
<script src="/MyNosql/marker/mb/15/js/jquery.min.js"></script>
<script src="/MyNosql/marker/mb/15/js/idangerous.swiper-1.9.1.min.js"></script>
<script src="/MyNosql/marker/mb/15/js/idangerous.swiper.scrollbar-1.2.js"></script>
<script src="/MyNosql/marker/mb/15/js/swiper-demos.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

<link rel="stylesheet" href="/MyNosql/marker/mb/15/css/animate-animo.css">
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/15/css/music90.css">
 <script type="text/javascript" src="/MyNosql/marker/mb/11/js/jquery.let_it_snow.js"></script>
<script src="/MyNosql/marker/mb/15/js/animo.min.js"></script>
<script src="/MyNosql/marker/mb/15/js/player.js" ></script>


 <script type="text/javascript">
    	$(document).ready(function() { 
		
		share()
	});
    
	function share() {
		
		$.post('/MyNosql/wwz/wwzajax!share.action?toUser=${toUser}&url='+window.location.href, null,
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

</head>
<body>
  
 
  <canvas style="position:absolute; z-index:999"  class="flake"></canvas>
 
 <div data-role="widget" data-widget="music90" class="music90 " >

<a href="javascript:void(0);" id="mp3"  class="btn_music on"  onclick="playbox.init(this).play(); playsp()"></a><audio id="audio" loop src="${company.mp3}"  autoplay="autoplay" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>   
 

  <div class="swiper-container swiper-v">
<img  id="d" src="/MyNosql/marker/mb/15/images/icon_up.png"  class="img1 pt-page-moveIconUp "/>
    <div class="pagination-v"></div>
    <div class="swiper-wrapper">
      
 <#if (picurl?size>0)>
   <#list picurl as pic> 
     <div class="swiper-slide">
   
      <div style="width:100%;">
     <img src="${osshttp}${pic}" width=100%/>
     
     </div> 
    </div>
    </#list>
  </#if>
<#if (funcList?size>0)> 
 <#list funcList as func>
    <div class="swiper-slide">
    <div style="width:100%;">
    <a  href="${func.url}">
     <img src="${osshttp}${func.picurl}" width=100%/>
    </a> 
     </div> 
     </div>
  </#list>
</#if>   
      
       
      
    </div>
  </div>
<#if footList[0]??> 
<footer>
 <div  class="foot">
  ${footList[0].summary}
 </div>
 </footer>
</#if>

<#if footList[1]??>
<script>
	  $(document).ready( function() {
	      
    	  $("canvas.flake").let_it_snow({
    	      windPower: -5,
    	      speed: 1,
    	      count: 50,
    	      size: 2,
    	      image: "${osshttp}${footList[1].picurl}"
    	  });
    	  
	  });
</script>
</#if>


<script>

$(function(){
　 $('#mp3').animo({animation: "spinner", iterate: "infinite"}); 
　　});
function playsp()
{
	if(document.getElementById('mp3').className=="btn_music on")
	{
		$('#mp3').animo({animation: "spinner", iterate: "infinite"});
		}
 
	} 



</script>
 
</body>


</html>