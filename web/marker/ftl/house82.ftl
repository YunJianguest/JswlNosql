<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${company.name}</title>
<link type="text/css" rel="stylesheet" href="/MyNosql/marker/mb/12/css/comom.css"/>
<meta name = "viewport" content = "width=device-width, minimum-scale=1, maximum-scale=1">
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<script language="javascript" type="text/javascript" src="/MyNosql/marker/mb/12/js/jQuery.js"/></script>
<script>
var winSize = function() {
    var e = window,
        a = 'inner';

    if (!('innerWidth' in window )){
        a = 'client';
        e = document.documentElement || document.body;
    }

    return { width : e[ a+'Width' ] , height : e[ a+'Height' ] };
};

winSize().height;   // height
winSize().width;    // width

var sd=(winSize().width-200)/2;
var ds=(winSize().height-200)/2;
function  item()
{
document.getElementById("circle").style.left=sd+"px";
document.getElementById("circle").style.top=ds+"px";

}

function  show_ewm(){
  $('#ewm_img_y').css('display','block');
  $('#ewm_bj').css('display','block');
  document.getElementById("ewm_bj").style.left=sd+"px";
  
}
function  hide_ewm()
{
$('#ewm_img_y').css('display','none');
$('#ewm_bj').css('display','none');
} 

</script>
<link rel="stylesheet" type="text/css" href="/MyNosql/marker/mb/12/css/music90.css">
<script src="/MyNosql/marker/mb/12/js/player.js" ></script>
<link rel="stylesheet" type="text/css"
	href="/MyNosql/marker/mb/12/css/snower.css-2014-03-07-1.css"
	media="all" />
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body style=" background: white url(/MyNosql/marker/mb/12/img/xu0zS7g.jpg) no-repeat fixed; background-size: cover;" onload="item()">




<div class="music90">

<a href="javascript:void(0);" class="btn_music" onclick="playbox.init(this).play();"></a><audio id="audio" loop src="${company.mp3}" style="pointer-events:none;display:none;width:0!important;height:0!important;"></audio>
</div>

<#if (picurl?size>0)>
<#list picurl as pic> 
<div class="ewm_img_y" id="ewm_img_y" style="display:none">
<div class="ewm_bj" id="ewm_bj" onclick="hide_ewm()" style="display:none">
<img  src="${osshttp}${pic}"/>
</div>
</div>
</#list>
</#if>
<header>
<div class="companyname"><a href=""><strong><span class="name_sp"> ${company.summary}</span></strong></a></div>
<div class="companylogo"><img src="${osshttp}${company.logo}"/> </div>
<div class="ewm_mg">
<a onclick="show_ewm()"><img  class="ewm_img" src="/MyNosql/marker/mb/12/img/mp.png"/></a>
</div>

<div><div class="company_zw">${company.context}</div></div>

</header>
<#if (funcList?size>0)>
<div class="circle" id="circle">
  
  <div class="ring">
  <#if funcList[0]??>
    
   <#if funcList[0].name=="home">
   <a href="${funcList[0].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[0].name=="comm">
    <a href="${funcList[0].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[0].name=="map">
   <a href="${funcList[0].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[0].name=="camer">
   <a href="${funcList[0].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[0].name=="user">
   <a href="${funcList[0].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[0].name=="music">
    <a href="${funcList[0].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[0].name=="shop">
    <a href="${funcList[0].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[0].name=="phone">
   <a href="${funcList[0].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[1]??>
    
   <#if funcList[1].name=="home">
   <a href="${funcList[1].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[1].name=="comm">
    <a href="${funcList[1].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[1].name=="map">
   <a href="${funcList[1].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[1].name=="camer">
   <a href="${funcList[1].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[1].name=="user">
   <a href="${funcList[1].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[1].name=="music">
    <a href="${funcList[1].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[1].name=="shop">
    <a href="${funcList[1].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[1].name=="phone">
   <a href="${funcList[1].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[2]??>
    
   <#if funcList[2].name=="home">
   <a href="${funcList[2].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[2].name=="comm">
    <a href="${funcList[2].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[2].name=="map">
   <a href="${funcList[2].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[2].name=="camer">
   <a href="${funcList[2].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[2].name=="user">
   <a href="${funcList[2].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[2].name=="music">
    <a href="${funcList[2].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[2].name=="shop">
    <a href="${funcList[2].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[2].name=="phone">
   <a href="${funcList[2].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[3]??>
    
   <#if funcList[3].name=="home">
   <a href="${funcList[3].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[3].name=="comm">
    <a href="${funcList[3].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[3].name=="map">
   <a href="${funcList[3].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[3].name=="camer">
   <a href="${funcList[3].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[3].name=="user">
   <a href="${funcList[3].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[3].name=="music">
    <a href="${funcList[3].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[3].name=="shop">
    <a href="${funcList[3].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[3].name=="phone">
   <a href="${funcList[3].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[4]??>
    
   <#if funcList[4].name=="home">
   <a href="${funcList[4].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[4].name=="comm">
    <a href="${funcList[4].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[4].name=="map">
   <a href="${funcList[4].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[4].name=="camer">
   <a href="${funcList[4].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[4].name=="user">
   <a href="${funcList[4].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[4].name=="music">
    <a href="${funcList[4].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[4].name=="shop">
    <a href="${funcList[4].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[4].name=="phone">
   <a href="${funcList[4].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[5]??>
   
   <#if funcList[5].name=="home">
   <a href="${funcList[5].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[5].name=="comm">
    <a href="${funcList[5].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[5].name=="map">
   <a href="${funcList[5].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[5].name=="camer">
   <a href="${funcList[5].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[5].name=="user">
   <a href="${funcList[5].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[5].name=="music">
    <a href="${funcList[5].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[5].name=="shop">
    <a href="${funcList[5].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[5].name=="phone">
   <a href="${funcList[5].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[6]??>


   <#if funcList[6].name=="home">
   <a href="${funcList[6].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[6].name=="comm">
    <a href="${funcList[6].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[6].name=="map">
   <a href="${funcList[6].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[6].name=="camer">
   <a href="${funcList[6].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[6].name=="user">
   <a href="${funcList[6].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[6].name=="music">
    <a href="${funcList[6].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[6].name=="shop">
    <a href="${funcList[6].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[6].name=="phone">
   <a href="${funcList[6].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  <#if funcList[7]??>
    
   <#if funcList[7].name=="home">
   <a href="${funcList[7].url}" class="menuItem fa fa-home fa-2x"></a>
   </#if>
   <#if funcList[7].name=="comm">
    <a href="${funcList[7].url}" class="menuItem fa fa-comment fa-2x"></a>
  </#if>
   <#if funcList[7].name=="map">
   <a href="${funcList[7].url}" class="menuItem fa fa-map-marker fa-2x"></a>
   </#if>
   <#if funcList[7].name=="camer">
   <a href="${funcList[7].url}" class="menuItem fa fa-camera fa-2x"></a>
  </#if>
   <#if funcList[7].name=="user">
   <a href="${funcList[7].url}" class="menuItem fa fa-user fa-2x"></a>
   </#if>
   <#if  funcList[7].name=="music">
    <a href="${funcList[7].url}" class="menuItem fa fa-music fa-2x"></a>
   </#if>
   <#if  funcList[7].name=="shop">
    <a href="${funcList[7].url}" class="menuItem fa fa-shopping-cart fa-2x"></a> 
  </#if>
   <#if funcList[7].name=="phone">
   <a href="${funcList[7].url}" class="menuItem fa fa-phone-square fa-2x"></a> 
   </#if>
  </#if>
  </div>
  <a href="#" class="center fa fa-th fa-2x"></a>
</div>
</#if>
<#if footList[0]??>
<div class="snower">
<script type="text/javascript">
var urls = [ '${osshttp}${footList[0].picurl}'/*tpa=http://114.215.116.254/MyNosql/uploads/images/20140708/213938140.jpg*/]
</script>
<script type="text/javascript" src="/MyNosql/marker/mb/12/js/maivl.js" ></script>
<script type="text/javascript" src="/MyNosql/marker/mb/12/js/snower1.js" ></script>
</div>
</#if>
<#if footList[1]??>
<footer class="footer">
		<div class="weimob-support">

<span>${footList[1].summary}</span>
		 </div>
</footer>
</#if>

</body>
<script language="javascript" type="text/javascript" src="/MyNosql/marker/mb/12/js/nav.js"/></script>
  
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
