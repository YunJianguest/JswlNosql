<!doctype html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /> 
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<meta HTTP-EQUIV="expires" CONTENT="0">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta name="apple-touch-fullscreen" content="yes">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>${aboutus.name}</title>
<link rel="stylesheet" type="text/css" href="http://114.215.116.254/MyNosql/shop2/css/public.css">
<link rel="stylesheet" type="text/css" href="http://114.215.116.254/MyNosql/shop2/css/login.css">
<script type="text/javascript" src="http://www.0085.com/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/MyNosql/js/jquery.enplaceholder.js"></script>
<script type='text/javascript' src='/MyNosql/dwr/engine.js'></script>
<script type='text/javascript' src='/MyNosql/dwr/util.js'></script>
<script type='text/javascript'
	src='/MyNosql/dwr/interface/DwrAjaxServer.js'></script>
<script>
	$(document).ready(function(){

		$('input').placeholder({isUseSpan:true});
	
	});
	function checkName(value) {
	
	
		var tname = "userinfo";
		//数据库名称
		var pname = "loginname";
		//当前页面ID名称

		var rvalue = "";
		
		DwrAjaxServer.checkQjService(tname, pname, value, rvalue, {
			callback : function(backJson) {
				if (backJson == "yes") {
					$("#loginname").val("");
					$('#loginname').focus();
					$("#validmsg").html('手机号已注册,请重新输入');
				} else {
					$("#validmsg").html('');
				}

			}
		});
	}
	
</script>

</head>
<body style="background:#efefef;">
<!-- 头部 -->
<header class="ysh_header">
  <p>商户注册</p>
</header>
<article class="ysh_art mt30">
<form action="/MyNosql/shop/shop!register.action?toUser=${toUser}" method="post" onsubmit="return checkform();">
	<input id="loc0" name="loc0"  type="hidden" value="${aboutus.loc[0]}">
	<input id="loc1" name="loc1"  type="hidden" value="${aboutus.loc[1]}">
	<ul>
		<li class="TxtBox1_li ysh_art_t"> <span class="TxtBox1_tc">* </span>用户名：
		
		  <input id="loginname" name="loginname" required="required" placeholder="请输入手机号码" onblur="checkName(this.value)" class="ysh_art_int" type="text">
		  <span class="help-inline" id="validmsg"></span>
		</li>
		<li class="TxtBox1_li2 ysh_art_t"> <span class="TxtBox1_tc">* </span><span style="font-size:16px;letter-spacing:17px;">密</span>码：
		  <input id="password" placeholder="密码为6-30位数字字母组合" required="required" name="password" class="ysh_art_int" type="password">
		</li>
		
		<li class="TxtBox1_li3 ysh_art_t"> 商铺名称：
		  <input id="comname" name="comname" placeholder="请输入商铺名称" required="required" class="ysh_art_int" type="text">
		</li>
		<li class="TxtBox1_li3 ysh_art_t"> 商铺地址：
		  <input id="address" name="address" placeholder="请输入商铺地址" required="required" class="ysh_art_int" type="text">
		</li>
		<li class="TxtBox1_li3 ysh_art_t"> 经营类型：
		 <select class="ysh_art_int" id="type" name="type" >
		 	<#list typeList as type>     
  			<option value ="${type.type}">${type.name}</option>
  			</#list>  
			</select>
		</li>
		<input class="ysh_art_but but_col" value="注册" type="submit">
		
	</ul>
</form>
 <p>商户注册</p>
 ${content.content}
<script type="text/javascript">
var checkform = function(){
	checkName($.trim($('#loginname').val()))
	
	var Regex_username = /^[\w]{4,15}$/;
    var Regex_password = /^[\w]{6,30}$/;
    var Regex_phone = /^(1[0-9]{10})$/;
    var loginname = $.trim($('#loginname').val());
    var password = $.trim($('#password').val());
   
   
	if (Regex_phone.test(loginname) === false) {
		alert('请输入正确的手机号码');
		$('#loginname').focus();
		return false;
	}
	if (Regex_password.test(password) === false){
		alert('密码必须为6-30位数字字母组合');
		$('#password').focus();
		return false;
	}
}
</script>
<script type="text/javascript">
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});
	
    </script>
    <script type="text/javascript">
    	window.shareData = {
			"imgUrl": "${ip}${aboutus.picurl}",
			"link": "${ip}/marker/register/register${toUser}.html",
			"title": "${content.title}",
			"content": "${content.summary}"
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

</body></html>