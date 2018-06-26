<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
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
    <title>报名人员信息页</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/mvccol/js/fomatdate2.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .zi-jin {
            color: #26bd93;
        }
        .btn-jin {
            background-color: #26bd93;
        }

        .btn-jin:hover {
            background-color: #21a883;
        }
    </style>
    <script>
    var fypage=0;
    var issend=true;
    var vt=1;
    function ajaxjz(fag) {  
       var submitData = {
           mid: '${entity._id}'
       };
       if(!issend){
       	return;
       }
       issend = false; 
       $.post('${ctx}/parttime/mission!ajaxMissonOrder.action?custid=${custid}&lscode=${lscode}&fypage=' +fypage, submitData, function (json) {
           var xszf;
           if (fag) {
               xszf = $('#ajaxdiv').html();
           } else {
               xszf = '';
           }
           if (json.state == 0) {
               var v = json.list;
               for (var i = 0; i < v.length; i++) {
            	   if(v[i].obj!=null){
            		 	xszf+='<div class="weight500 zi-6 pl-10 overflow-hidden">'
                       	    +'<div class="hang40 line-height40 col-9"><i class="pr-10">'+v[i].obj.name+'</i>'+v[i].obj.tel+'</div>'
                       	    +'<div class="hang40 line-height40 btn-jin col-3 txt-c zi-bai">线下结算</div>'
                       	    +'</div>'
                       	    +'<div class="hang10 clear bg-hui-92"></div>';
            	   } 
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
<body>

<main class="cmp640">

    <div class="div-group-10 overflow-hidden bg-hui-98 clear">
        <div class="hang20 line-height20 sl width-9 weight500" style="border-left: 4px solid #26bd93"><i class="pl-10 weight500"></i>${entity.title}
        </div>
    </div>
    <div id="ajaxdiv"></div>
 

</main>
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