<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>${title}</title>
    <script src="${contextPath}/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <link href="${contextPath}/mvccol/yj/activity-style.css" rel="stylesheet" type="text/css"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>

<body class="activity-lottery-winning">
 
<div class="main pt-50">
     
    <div id="outercont">
        <div id="outer-cont">
            <div id="outer"><img src="${contextPath}/mvccol/yj/whell.png" width="310px"></div>
        </div>
        <div id="inner-cont">
            <div id="inner"><img src="${contextPath}/mvccol/yj/activity-lottery-2.png"></div>
        </div>
    </div>


</div>


 
<script type="text/javascript">
    $(function () {
        window.requestAnimFrame = (function () {
            return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function (callback) {
                        window.setTimeout(callback, 1000 / 60)
                    }
        })();
        var totalDeg = 360 * 3 + 0;
        var steps = [];
        var lostDeg = [36, 66, 96, 156, 186, 216, 276, 306, 336];
        var prizeDeg = [0,30,60,90,120,150,180,210,240,270,300,360];
        var prize, sncode;
        var count = 0;
        var now = 0;
        var a = 0.01;
        var outter, inner, timer, running = false;

        function countSteps() {
            var t = Math.sqrt(2 * totalDeg / a);
            var v = a * t;
            for (var i = 0; i < t; i++) {
                steps.push((2 * v * i - a * i * i) / 2)
            }
            steps.push(totalDeg)
        }

        function step() {
            outter.style.webkitTransform = 'rotate(' + steps[now++] + 'deg)';
            outter.style.MozTransform = 'rotate(' + steps[now++] + 'deg)';
            if (now < steps.length) {
                requestAnimFrame(step)
            } else { 
                setTimeout(function () {
                    if (prize != null) {
                        $("#sncode").text(sncode);
                        alert('恭喜您中奖了，请前去领奖！');
                        
                    } else {
                        alert("谢谢您的参与，下次再接再厉")
                    }
                }, 200)
            }
        }

        function start(deg) {
            deg = deg || lostDeg[parseInt(lostDeg.length * Math.random())]; 
            clearInterval(timer);
            totalDeg = 360 * 5 + deg;
            steps = [];
            now = 0;
            countSteps();
            requestAnimFrame(step)
        }

        window.start = start;
        outter = document.getElementById('outer');
        inner = document.getElementById('inner');
        i = 10;
        $("#inner").click(function () {
             
            $.post("${ctx}/suc/luckydraw!draw.action",{lucid:'${entity._id}',toUser:'${toUser}'},function(data){
               
               if(data.state==0){  
                 prize = data.re.no;
                 sncode =data.re.yhj;
                 start(prizeDeg[data.re.no]);
                 return; 
               
               }
               start(prizeDeg[3]);
            
            },"json");
             
        })
    });
    
</script>
<script>
wx.config({
    debug: false,
    appId: '${token.appid}', 
    timestamp: '${token.timestamp}', 
    nonceStr: '${token.noncestr}', 
    signature: '${token.signature}',
    jsApiList: [ 'checkJsApi',
                 'onMenuShareTimeline',
                 'onMenuShareAppMessage',
                 'onMenuShareQQ',
                 'onMenuShareWeibo',
                 'hideMenuItems',
                 'showMenuItems'
                 ] 
});
wx.ready(function(){ 
	var share={
		    title: '${share.fxtitle}', // 分享标题
		    desc: '${share.fxsummary}', // 分享描述
		    link: '${share.fxurl}', // 分享链接
		    imgUrl: '${filehttp}${share.fximg}', // 分享图标
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

</script>
</body>
</html>