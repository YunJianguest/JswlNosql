

<!DOCTYPE html>
<html>
<head>
<title>结婚喜帖</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/16/css/wedding.css"
	media="all">
<script src="/MyNosql/marker/mb/16/js/jquery-1.10.1.min.js"  type="text/javascript"></script>
<script src="/MyNosql/marker/mb/16/js/wedding.js"  type="text/javascript"></script>
<script src="/MyNosql/marker/mb/16/js/jquery_easing.js"  type="text/javascript"></script>
<script src="/MyNosql/marker/mb/16/js/wedding_sys.js"  type="text/javascript"></script>
<script src="/MyNosql/marker/mb/16/js/alert.js" type="text/javascript"></script>

<style type="text/css">
.body img{
	width: 100%;
}
.loading {
	position: absolute;
	width: 100%;
	height: 100%;
	text-align: center;
	top: 0;
	left: 0;
	line-height: 100%;
	border: none;
	z-index: 9999;
}

.loading-part {
	position: absolute;
	padding: 0;
	margin: 0;
	width: 100%;
	height: 50%;
	background-color: #FFFFFF;
	z-index: 1;
}

.loading-part.top {
	top: 0;
}

.loading-part.bottom {
	bottom: 0;
}

.loading-panel {
	position: absolute;
	width: 200px;
	height: 82px;
	top: 50%;
	left: 50%;
	margin-top: -41px;
	margin-left: -100px;
	z-index: 2;
}

.loading-icon {
	position: relative;
	width: 50px;
	height: 50px;
	background: url("/MyNosql/marker/mb/16/img/love.gif")/*tpa=http://114.215.116.254/MyNosql/whd/images/wedding/love.gif*/ center center no-repeat;
	margin: auto;
}

.loading-text {
	position: relative;
	width: 200px;
	height: 32px;
	color: #fc8e65;
	text-align: center;
	line-height: 32px;
	margin: auto;
}

.cover {
	display: none;
	position: absolute;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	padding: 0;
	margin: 0;
	background-color: #A00908;
	box-shadow: 5px 5px 5px 10px rgba(0, 0, 0, .6);
	z-index: 999;
}
/*封面模版:t1*/
.cover.t1 {
	min-height: 330px;
	background-color: #A00908;
}

.cover.t1 .slogan {
	position: absolute;
	width: 266px;
	height: 290px;
	left: 50%;
	margin-left: -133px;
	top: 50%;
	margin-top: -145px;
}

.cover.t1 .mask {
	position: absolute;
	width: 100%;
	height: 100%;
	background: url("/MyNosql/marker/mb/16/img/icons.png")/*tpa=http://114.215.116.254/MyNosql/whd/images/wedding/icons.png*/ 0 0 no-repeat;
	top: 0;
	left: 0;
}

.cover.t1 .head {
	position: absolute;
	width: 158px;
	height: 153px;
	top: 68px;
	left: 48px;
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
}
</style>

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
<body onselectstart="return true;" ondragstart="return false;">
	 	<script>
        $().ready(function(){
        	playbox.init("playbox");

        	$("#overlay_ul").bind("click", function(evt){
        		if("UL" == evt.target.nodeName){
        		this.className = 'overlay_ul';
        		$(this).find('li').removeClass('on');
        		}
        		
        	});
        });

        function show(i){
        	$("#overlay_ul>li").removeClass("on")[i].className = "on";
        	$("#overlay_ul").addClass("on");
        }

    
      
</script>
	<script type="text/javascript">
    $(function () {
             var loading = $('.loading'),
                parts = $('.loading-part', loading),
                height = parts.height();
            var loadingpanel = $('.loading-panel', loading);
            var cover = $('.cover'); 
            function closeLoading(callback) {
                loadingpanel.fadeOut(function () {
                    loading.remove();
                });
                if (typeof callback === 'function') {
                    callback.call(this);
                }
            }
            function closeCover() { 
                cover.animate({
                    'top': -cover.height()
                }, 'linear', function () {
                    cover.remove();
                });
            }
            var handler_touch = function (e) {
                closeCover();
                e.preventDefault();
                return false;
            };
            //处理封面
            function initCover() {
                cover.one('touchstart MSPointerDown', handler_touch); 
                 if (window.navigator.msPointerEnabled !== undefined) {
                    window.setTimeout(function () {
                        closeCover();
                    }, 2000);
                }
            }
            closeLoading(function () {
                initCover();
                cover.fadeIn(1500, function () {
                    cover.animate({
                        top: '-120px'
                    }, 'easeOutBack', function () {
                        cover.animate({
                            top: 0
                        }, 500, 'easeOutElastic', function () { });
                    });
                });
            });
        });
    </script>

	<div class="cover t1" style="display: block; top: 0px;">
    <div class="slogan">
        <div class="head" style="background-image:url(${osshttp}${company.logo})"></div>
        <div class="mask"></div>
    </div>
	</div>


	<div class="container">
		<header>
			<div>
				<ul class="box">
					<li class="relative" style="width:200px; height:200px;"><span class="relative" style="width:200px; height:200px;"><span class="pic"><img
							src="${osshttp}${company.logo}"  ></span></span></li>
					<li>
						<div class="name">
<#if funcList[0]??>
                         ${funcList[0].name}
                         </#if>
                         
                       
							<img src="${osshttp}${company.logo}"  style="width: 30px;">
<#if funcList[1]??>
                         ${funcList[1].name}
                         </#if>
			 
						  <div></div>
					  </div>
					</li>
					<li><span id="playbox" class="btn_music on"
						onclick="playbox.init(this).play();"><audio id="audio"
								loop="" src="${company.mp3}" ></audio></span></li>
				</ul>
			</div>
		</header>
		<div style="height: 70px"></div>

<section class="body">


            <marquee   behavior="alternate" direction="up" scrollamount="3" style="height:600px">
            
           
            <#if (picurl?size>0)>
            <#list picurl as pic> 
<p><img src="${osshttp}${pic}"/><br/></p>

             </#list>
             </#if>
            
            <table><tbody><tr class="firstRow"><td valign="top" width="289"><br/></td><td valign="top" width="289"><img alt="bk-id1406-0.gif" src="/MyNosql/marker/mb/16/img/1408815837156023218.gif"  /></td><td valign="top" width="289"><br/></td></tr></tbody></table><p style="text-align: left;"><img alt="0000000_副本.png" src="/MyNosql/marker/mb/16/img/1408815670578068802.png" /></p><p style="text-align:center"><br/></p></marquee>
			
			<!--想说的话-->
			<div class="des">
				<h3 class="align_center">想说的话</h3>
				<p><#if funcList[2]??>
                         ${funcList[2].summary}
                         </#if></p>
			</div>
			<!--宴会时间地址电话-->
			<div>
				<ul class="list_font">
					<li><a href="javascript:;" class="tbox">
							<div class="dat"> <#if funcList[3]??>
                         ${funcList[3].summary}
                         </#if></div>
							<div>
								<figure>
									<p>
										<span><img src="/MyNosql/marker/mb/16/img/08.png" ></span>
									</p>
									<figcaption>宴会时间</figcaption>
								</figure>
							</div>
					</a></li>
					<li>
                    <#if funcList[4]??><a id="book_list_a"
						href="${funcList[4].url}"
						class="tbox">
							<div class="add"> 
                         ${funcList[4].summary}
                          </div>
							<div>
								<figure>
									<p>
										<span><img src="/MyNosql/marker/mb/16/img/06.png"></span>
									</p>
									<figcaption>点此导航</figcaption>
								</figure>
							</div>
					</a> </#if></li>
					<li><#if funcList[5]??><a
						href="tel:
                         ${funcList[5].summary}
                         "
						class="tbox">
							<div class="tel"><#if funcList[5]??>
                         ${funcList[5].summary}
                         </#if></div>
							<div>
								<figure>
									<p>
										<span><img src="/MyNosql/marker/mb/16/img/07.png" ></span>
									</p>
									<figcaption>接待电话</figcaption>
								</figure>
							</div>
					</a></#if></li>
				</ul>
			</div>
			<div>
			 
			</div>
			<div id="book_list">
						<div class="list_content"
							style="-webkit-transition: all 0.5s ease-in-out; transition: all 0.5s ease-in-out;"
							id="map_container"></div>
			</div>
		</section>
		 

	</div>
 
	
</body>
</html>