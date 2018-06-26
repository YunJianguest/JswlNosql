<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>${company.name}</title>
    <meta name="author" content="Alvaro Trigo Lopez"/>
    <meta name="description" content="fullPage full-screen sliders navigation widh dots."/>
    <meta name="keywords"
          content="fullpage,jquery,demo,screen,fullscreen,sliders navigation, horizontal navigation,horizontal,navigation,dots"/>
    <meta name="Resource-type" content="Document"/>
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
          name="viewport">
    <link href="/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="/app/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/app/css/jquery.fullPage.css"/>
    <link rel="stylesheet" type="text/css" href="/app/css/examples.css"/>
    <script src="/app/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/app/js/jquery.fullPage.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#fullpage').fullpage({
                slidesNavigation: true,
                scrollingSpeed: 1500,
                afterSlideLoad: function (anchorLink, index, slideIndex, direction) {
                    if (index == 1 && direction == length) {

                    }
                }
            });
            setInterval(function () {
                $.fn.fullpage.moveSlideRight();
            }, 3000);

        });
        function startAnimation(v) {
            if (2 == 2) {
                $('#fullpage').fullpage({
                    slidesNavigation: true,
                    scrollingSpeed: 3000,
                    afterSlideLoad: function (anchorLink, index, slideIndex, direction) {
                        if (index == 1 && direction == length) {
                            alert(direction);
                            alert(length);
                        }
                    }
                });
                setInterval(function () {
                    $.fn.fullpage.moveSlideRight();
                }, 3000);
            } else {
                $('#fullpage').fullpage({

                    slidesNavigation: true,
                    scrollingSpeed: 3000,
                });
            }
        }
    </script>
</head>
<body>
<div id="fullpage" class="cmp640">
    <div class="section">
     <#list slide as pic>
        <a href="${pic.url}">
            <div class="slide" id="slide1" data-anchor="slide1"
                 style="background-image:url(${filehttp}${pic.picurl}); background-size:100% auto"></div>
        </a>
     </#list>
    </div>
</div>

<#if (funcList?size>0)>
  <div class="position-f cmp640 " style="top:0px;left:0px;">
    <div class="col-6 pt-5 pl-15">
         <#list funcList as func>
           <a href="${func.url}">
           <div class="col-6 pt-8">
            <div class="img-bj border-radius5 img-wh70 bg-hei-5">
                <div class="img-wh40 maring-a pt-10">
                    <img src="${filehttp}${func.picurl}" class="width-10 border-radius5">
                </div>
                <div class="txt-c zi-bai  pt-10"><font size="1">${func.title}</font></div>
             </div>
            </div>
            </a>
          </#list>    
    </div>
  </div>
</#if>
<script type="text/javascript">
    $(document).ready(function() {   
		share();
	}); 
	function share() {
		
		$.post('/suc/ajax!share.action?custid=${custid}&url='+encodeURIComponent(window.location.href), null,
    		function(data) { 
    			wx.config({
    				debug: false,
    				appId: data.token.appid, 
    				timestamp: data.token.timestamp, 
    				nonceStr: data.token.noncestr, 
   	 				signature: data.token.signature,
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
		   			link:  window.location.href, // 分享链接
		    		imgUrl: '${filehttp}${company.logo}', // 分享图标
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