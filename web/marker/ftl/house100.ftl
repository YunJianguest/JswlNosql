<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>${company.name}</title>
    <link rel="stylesheet" href="/MyNosql/cmp/css/style1.css">
    <link href="/MyNosql/cmp/css/cmp_common.css" rel="stylesheet" type="text/css"/>
    <script src="/MyNosql/cmp/js/jquery-1.11.1.min.js"></script>
    <script src="/MyNosql/cmp/js/main.js"></script>
    <link href="/MyNosql/cmp/css/cmp_sh.css" rel="stylesheet" type="text/css"/>
    <script src="/MyNosql/cmp/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/MyNosql/cmp/js/swipe.js"></script>
    <script type="text/javascript" src="/MyNosql/cmp/js/zepto.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<script>

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
    function zanCompany() {
		
		$.post('/MyNosql/wwz/wwzajax!zanCompany.action?toUser=${toUser}&companyid=${company._id}',null,
				function(res) {
						$('#zan').html(res+"赞");
						$("#zhan").attr("class", "zhan bh");
				},"json");
	}
	function zanCount() {
		
		$.post('/MyNosql/wwz/wwzajax!zanCount.action?toUser=${toUser}&companyid=${company._id}', null,
    		function(data) {
    			$('#zan').html(data.zan+"赞");
    			if (data.iszan == false) {
    
                   	$("#zhan").attr("class", "zhan bh");    
    			} else {
					$("#zhan").attr("class", "zhan");       
    			}
    	},"json");	
	}
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
<body>
<header>
    <a href="javascript:history.go(-1);" class="left back"></a>

    <h1 class="title">${company.name}</h1>
</header>
<main class="cd-main-content">

    <div id="banner_box" class="box_swipe">
        <ul>
        	<#if (picurl?size>0)>
			<#list picurl as pic>            
			<li><img src="${osshttp}${pic}" style="width:100%;"></li>
 
			</#list> 
			</#if>
        </ul>
        <div class="zhan" id="zhan" onclick="zanCompany();">
            <span class="star size15 weight900" id="zan">32赞</span>
            <div class="" ><img  src="/MyNosql/cmp/img/zhan.jpg" style="border-radius: 30px;border: 2px solid #ffffff;"></div>
        </div>
    </div>
	<#if (rollList?size>0)>
    <div class="title3 size15 bai">
		<marquee scrollAmount=2 width=100%>
     		<#list rollList as roll> 
     		<a href="${roll.url}" >${roll.title}</a>&nbsp;&nbsp;&nbsp;&nbsp;
     		</#list>        
        </marquee>
     </div>
     </#if>
<#if (productList?size>0)> 
<#assign n = 0 />    
<#list productList as pro> 

<#assign n = n+1 /> 
<#if n gt 4><#break></#if>
<a href="/MyNosql/shop/shop!productdetail.action?_id=${pro._id}&toUser=${toUser}">
<div class="shangpin">
   <div class="tup">
       <img src="${osshttp}${pro.logo}"/>
       <div class="biao size15 luse">${pro.ptitle}</div>
       <div class="shoujia ">
           <span class="star size13">⑧</span>
           <span class="star size13  ">${pro.price}邦币/</span>
           <span class="lan size10 hd ">市场价:${pro.oldprice}</span>
       </div>
   </div>
</div>
</a>

</#list>      
</#if>


    <div class="hang2 lock">
        <div class="title3 size15 bai">
            <div class="sl float_l " >${company.name}</div>
            <a href="http://api.map.baidu.com/marker?location=${company.loc[1] },${company.loc[0] }&title=${company.name }&name=${company.name }&content=${company.summary }&output=html">
            <div class="daohang1">
                <span class="size15 bai" style="position: relative;bottom:3px ">一键导航</span>
                <img src="/MyNosql/cmp/img/arrow-left.gif" style="position: relative;top:3px ;">
            </div>
            </a>
        </div>
    </div>

    <div class="baoge1 lock size13 ">
        <div class="" >
            <div class="b1 bjh lan">电话:</div>
            <a href="tel:${company.tel}">
            <div class="b2 bjh hui">${company.tel}</div>
            </a>
        </div>
        <div class=" " >
            <div class="b1 bjh lan">好评:</div>
            <div class="b2 bjh">
                <div class=" star size15 float_l" style="position: relative;left:1%">4.5分</div>
                <div class="pingfen " style="position: relative;left:25%">
                    <ul class='rating star5'>
                        <li class="one"><a href="#" title="1 Star">1</a></li>
                        <li class="two"><a href="#" title="2 Stars">2</a></li>
                        <li class="three"><a href="#" title="3 Stars">3</a></li>
                        <li class="four"><a href="#" title="4 Stars">4</a></li>
                        <li class="five"><a href="#" title="5 Stars">5</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class=" ">
            <div class="b3 bjh lan ">地址:</div>
            <a href="http://api.map.baidu.com/marker?location=${company.loc[1] },${company.loc[0] }&title=${company.name }&name=${company.name }&content=${company.summary }&output=html">
            <div class="b4 bjh hui">${company.address }</div>
            </a>
        </div>
    </div>
    <div class="xiangxi">
		${company.context }
	</div>
</body>
</html>