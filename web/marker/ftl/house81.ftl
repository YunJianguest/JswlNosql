
<!DOCTYPE html>
<html>
<head>
	
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
	<meta HTTP-EQUIV="expires" CONTENT="0">

	<title>${company.name}</title>
	
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/style.css" >
	
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/footer.css" >
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/skin_8.css" >
	
	<script type="text/javascript" src="/MyNosql/marker/mb/13/js/swipe.js"></script>
	<script type="text/javascript" src="/MyNosql/marker/mb/13/js/jquery-2.1.1.min.js"></script>
	
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/animate.css" />
 <script type="text/javascript">
    	$(document).ready(function() { 
		
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
                 		'onMenuShareWeibo',
                 		'openLocation',
                 		'showOptionMenu'
                	 ] 
				});

			wx.ready(function(){
				wx.showOptionMenu();
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

		<div class="body_bg"><img src="/MyNosql/marker/mb/13/img/160689.jpg"  /></div>
	
	
  <section class="section">
	    <div class="ad_box">
            <div>
              ${company.context}
            </div>             
           <div class="edit_btn"><span onClick=mode_tab(1)></span></div>
	    </div>
    <div id="blockSlide"></div>
    <ul class="ad_list">
    <#if funcList[0]??>
      
      	  <li class="rotateInDownLeft animated action" >
<#if funcList[0].method=="link">
      	  	<a  href="${funcList[0].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[0].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[0].picurl}" ></div>
		        </div>
	        </a>
  <#else>
       <a  href="/MyNosql/wwz/wwz!${ funcList[0].method}.action?_id=1&type=${ funcList[0].type}&toUser=${toUser}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[0].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[0].picurl}" ></div>
		        </div>
	        </a>
   
   </#if>
	      </li>
     
  
     </#if>
     <#if funcList[1]??>
      	  <li class="bounceInDown animated"
      	  	   >
<#if funcList[1].method=="link">
      	  	<a  href="${funcList[1].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[1].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[1].picurl}"></div>
		        </div>
	        </a>
 <#else>
<a  href="/MyNosql/wwz/wwz!${ funcList[1].method}.action?_id=1&type=${ funcList[1].type}&toUser=${toUser}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[1].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[1].picurl}"></div>
		        </div>
	        </a>
  
   </#if>
	      </li>
      </#if>
      <#if funcList[2]??>
      	  <li class="rotateInDownRight animated" >
  <#if funcList[2].method=="link">
      	  	<a  href="${funcList[2].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[2].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[2].picurl}"></div>
		        </div>
	        </a>
    <#else>
     <a  href="/MyNosql/wwz/wwz!${ funcList[2].method}.action?_id=1&type=${ funcList[2].type}&toUser=${toUser}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[2].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[2].picurl}"></div>
		        </div>
	        </a>

   </#if>
	      </li>
       </#if>
       <#if funcList[3]??>
      	  <li class="rotateInUpLeft animated"
      	  	   >
 <#if funcList[3].method=="link">
      	  	<a  href="${funcList[3].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[3].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[3].picurl}" ></div>
		        </div>
	        </a>
<#else>
<a  href="/MyNosql/wwz/wwz!${ funcList[3].method}.action?_id=1&type=${ funcList[3].type}&toUser=${toUser}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[3].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[3].picurl}" ></div>
		        </div>
	        </a>
  </#if>
	      </li>
        </#if>
        <#if funcList[4]??>
      	  <li class="bounceInUp animated" >
  <#if funcList[4].method=="link">
      	  	<a  href="${funcList[4].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[4].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[4].picurl}" ></div>
		        </div>
	        </a>
<#else>
  	<a  href="/MyNosql/wwz/wwz!${ funcList[4].method}.action?_id=1&type=${ funcList[4].type}&toUser=${toUser}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[4].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[4].picurl}" ></div>
		        </div>
	        </a>

</#if>
	      </li>
        </#if>
        <#if funcList[5]??>
      	  <li class="rotateInUpRight animated" >
 <#if funcList[5].method=="link">
      	  	<a  href="${funcList[5].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[5].name}</div>
		          <div class="l_pic"><img src="	${osshttp}${funcList[5].picurl}" ></div>
		        </div>
	        </a>
 <#else>
	<a  href="/MyNosql/wwz/wwz!${ funcList[5].method}.action?_id=1&type=${ funcList[5].type}&toUser=${toUser}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[5].name}</div>
		          <div class="l_pic"><img src="	${osshttp}${funcList[5].picurl}" ></div>
		        </div>
	        </a>

  </#if>
	      </li>
         </#if>
    </ul>
    <div class="clear"></div>
<#if footList[1]??>
      <div style="height:25px; padding-top:5px; margin-top:5px;background-color:#FFF"><marquee direction="left"  scrollamount="5"><span style=" font-size:18px"> ${footList[1].summary}</span></marquee></div>
</#if>    
<#if (picurl?size>0)>
    	<div id="banner_box" class="box_swipe">
			<ul>
				  <#list picurl as pic> 
									<li>
												<a onClick="return false;">
																<img src="${osshttp}${pic}"     style="width:100%;" />
								</a>
					                             </li>
                                                      
 

					                      </#list>			
							</ul>
			                <ol>
							   <#list picurl as pic> 
									<li class="on"></li>
									</#list>	
							</ol>
		</div>

    </#if>
		<script>
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
  </section>
  <#if footList[0]??>
  <footer id="navbarFooter">
  <div class="menu_bottom">
    <ul>
  ${footList[0].summary}
    </ul>
  </div>
  </footer>
  </#if>
	
</body>

 
</html>
