<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>小象兼职-我的订单</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
     <style>

        .line-height32 {
            line-height: 32px;
        }

        .line-bottom-red {
            border-bottom: 3px solid #26bd93;
            color: #26bd93;
        }

        .zi-26bd93 {
            color: #26bd93;
        }

        .bg-26bd93 {
            background-color: #26bd93;
        }

        .bottom-26bd93 {
            background-color: white;
        }

        .bottom-26bd93:hover {
            color: #21a883;
        }

        .line-height32 {
            line-height: 32px;
        }

        .line-bottom-red {
            border-bottom: 3px solid #26bd93;
        }

        .zi-26bd93 {
            color: #26bd93;
        }

        .zi-jin {
            color: #e3c06a
        }
    </style>
    <script>
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
                vt=$(this).attr("id");
                fypage=0;
                ajaxjz(false);
            })
        })
    </script>
     <script> 
         var fypage=0;
         var issend=true;
         var vt='';
         function ajaxjz(fag) {  
            var submitData = {
                state: vt
            };
            if(!issend){
            	return;
            }
            issend = false; 
            $.post('${ctx}/parttime/mission!ajaxOrder.action?custid=${custid}&lscode=${lscode}&fypage=' +fypage, submitData, function (json) {
          
            	var xszf;
                if (fag) {
                    xszf = $('#ajaxdiv').html();
                } else {
                    xszf = '';
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                    	xszf+='<div class="div-group-10 overflow-hidden line-bottom-92 clear">'
                    	    +'<div class="hang20 line-height20 weight500">'
                    	    +'<div class="pull-left">岗位名称：['+v[i].mtitle+']<i class="zi-26bd93 pl-10">￥100</i></div>';
                    	    if(v[i].state==3){
                    	    	xszf+='<div class="pull-right zi-jin">待结算</div>';	
                    	    } 
                    	    if(v[i].state==4){
                    	    	xszf+='<div class="pull-right zi-26bd93">已完成</div>';	
                    	    } 
                    	    if(v[i].state==0){
                    	    	xszf+='<div class="pull-right zi-green">已报名</div>';	
                    	    } 
                    	    if(v[i].state==5){
                    	    	xszf+='<div class="pull-right zi-hui-tq">未完成</div>';	
                    	    } 
                    	    xszf+='</div></div>'
                    	    +'<div class="width-9 maring-a pt-10 pb-10 overflow-hidden zi-6 weight500">'
                    	    +'<div class="hang30 line-height30">'
                    	    +'<i class="zi-hei">接单日期：</i>'+Date.prototype.format(v[i].createdate)+'</div>'
                    	    +'<div class="hang30 line-height30"><i class="zi-hei">集合时间：</i>'+Date.prototype.format(v[i].gatherdate)+'</div>'
                    	    +'<div class="hang30 line-height30"><i class="zi-hei">上班时间：</i>'+Date.prototype.format(v[i].startdate)+'<i class="pl-10 pr-10">至</i>'+Date.prototype.format(v[i].enddate)+'</div>'
                    	    +'<div class=" line-height30">'
                    	    +'<i class="zi-hei">地点：</i>'+v[i].workaddress+'<i class="zi-lan-tq pl-5"></i></div>'
                    	    +'<div class="hang30 line-height30"><i class="zi-hei">订单编号：</i>'+v[i]._id+'</div></div>'
                    	    +'<div class="hang10 clear bg-hui"></div>'; 
                    }
                    fypage++;
                } else {
                }
                issend = true;
                $('#ajaxdiv').html(xszf); 
            }, "json");
        }
       
    </script>
</head>
<body class="lock">
<main class="cmp640">

    <!--标题放置-->
    <div class="hang40 line-height40 bg-bai cmp640 position-f"
         style="left:0px;top: 0px;z-index: 10;">
        <div class="clear position-r" style=" z-index:3;">
            <div class="hang40 pt-5 line-bottom weight500 weight100 yListr2 zi-hei">
                <li class="button_group1 hang30 line-height32 txt-c line-bottom-red" id="">
                    全部
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id="0">
                    已报名
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id="3">
                    待结算
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id="5">
                    未完成
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id="4">
                    已完成
                </li>
            </div>
        </div>
    </div>
    <div class="hang40"></div> 
    <div id="ajaxdiv"></div>
</main>

<%@include file="/webcom/mission-foot.jsp"%>
<script> 
ajaxjz(false); 
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) { 
            ajaxjz(true); 
        }
 });
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
		     check_task();
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