
<!DOCTYPE html>
<html>
<head>
	
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	

	<title>${company.name}</title>
	
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/style.css" >
	
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/footer.css" >
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/skin_8.css" >
	
	<script type="text/javascript" src="/MyNosql/marker/mb/13/js/swipe.js"></script>
	<script type="text/javascript" src="/MyNosql/marker/mb/13/js/jquery-2.1.1.min.js"></script>
	
	
	<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/13/css/animate.css" />

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
    		
    		$('#zan').find('span').html("<br/><br/>赞("+data.zan+")<p></p>");
    		if (data.iszan == false) {
                       
$('#zan').css('background-image','url(/MyNosql/marker/mb/77/img/zan1.png)');
$('#zan').attr('href', 'javascript:void(0);');

    		} else {
$('#zan').css('background-image','url(/MyNosql/marker/mb/77/img/zan.png)');

                    
    		       
    		}
    	},"json")	
});

</script>

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
	color:red;
	width:100%;
	height:100%;
	margin-right:10px!important;
	}

</style>

</head>

<body>

		<div class="body_bg"><img src="/MyNosql/marker/mb/13/img/160689.jpg"  /></div>
<div class="zan">
<a href="javascript:zanCompany();" id="zan"><span class="pzan">
							赞(${company.sort})<p></p></span></a>
					
				</div>
	
	
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
      	  	<a  href="${funcList[0].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[0].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[0].picurl}" ></div>
		        </div>
	        </a>
	      </li>
     </#if>
     <#if funcList[1]??>
      	  <li class="bounceInDown animated"
      	  	   >
      	  	<a  href="${funcList[1].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[1].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[1].picurl}"></div>
		        </div>
	        </a>
	      </li>
      </#if>
      <#if funcList[2]??>
      	  <li class="rotateInDownRight animated" >
      	  	<a  href="${funcList[2].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[2].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[2].picurl}"></div>
		        </div>
	        </a>
	      </li>
       </#if>
 <#if funcList[3]??>
        <li class="bounceInLeft animated"
      	  	   >
      	  	<a  href="${funcList[3].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[3].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[3].picurl}" ></div>
		        </div>
	        </a>
	      </li>
</#if>
<#if funcList[4]??>
      	  <li class="tada animated" >
      	  	<a  href="${funcList[4].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[4].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[4].picurl}" ></div>
		        </div>
	        </a>
	      </li>
</#if>
<#if funcList[5]??>
      	  <li class="bounceInRight animated" >
      	  	<a  href="${funcList[5].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[5].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[5].picurl}" ></div>
		        </div>
	        </a>
	      </li>
</#if>
<#if funcList[6]??>
            <li class="rotateInUpLeft animated"
      	  	   >
      	  	<a  href="${funcList[6].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[6].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[6].picurl}" ></div>
		        </div>
	        </a>
	      </li>
</#if>
<#if funcList[7]??>
      	  <li class="bounceInUp animated" >
      	  	<a  href="${funcList[7].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[7].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[7].picurl}" ></div>
		        </div>
	        </a>
	      </li>
</#if>
<#if funcList[8]??>
      	  <li class="rotateInUpRight animated" >
      	  	<a  href="${funcList[8].url}">
		        <div class="l_box">
		          <div class="l_tit">${funcList[8].name}</div>
		          <div class="l_pic"><img src="${osshttp}${funcList[8].picurl}" ></div>
		        </div>
	        </a>
	      </li>
</#if>
    </ul>
    <div class="clear"></div>
    
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
</html>
