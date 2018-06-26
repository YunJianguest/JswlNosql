<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
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
    <title></title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <link href="${ctx}/mvccol/css/css3_dh.css" rel="stylesheet" type="text/css"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
 <style>
     .line-height60{
         line-height:60px;
     }
 p { word-wrap:break-word; word-break:normal; } 
 </style>
</head>

<body>
 
<main class="cmp640">
    
    <div class="div-group-10 line-bottom-92 overflow-hidden">
       <c:if test="${empty entity.logo}">
           <div class="img-wh60 pull-left border-radius3 line-lu txt-c zi-hui"><i class="fa fa-leaf fa-2dx line-height60"></i></div>
       </c:if>
       <c:if test="${not empty  entity.logo}">
        <div class="img-wh60 img-bj pull-left border-radius3" style="background-image:url(${filehttp}/${entity.logo})"></div>
       </c:if>
        <div class="pull-left pl-10">
            <div class="zi-hei size16 pt-20">${entity.name}</div>
        </div>

    </div>

    <div class="col-12  pt-10 pb-10 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;">

        <div class="pull-left pl-10">
            <div class="zi-hei size14 weight500">服务热线</div>
            <div class=" size14 sl zi-hui">
                ${entity.tel}
            </div>
        </div>

        <a href="tel:${entity.tel}" >
        <div class="pull-right pr-15 ">
            <div class=" maring-a clear img-wh40 btn-green txt-c border-radius50">
                <i class="fa fa-phone zi-bai pt-7 fa-2x"></i>
            </div>
        </div>
        </a>

    </div>

    <div class="col-12  pt-10 pb-10 line-bottom-92 overflow-hidden" style="line-height:20px;">
        <div class="pull-left pl-10 pr-10">
            <div class="zi-hei size14 weight500">地址</div>
            <div class="clear width-10 size14 zi-hui overflow-hidden">
                ${entity.address}
            </div>
        </div>
    </div>
    <div class="col-12  pt-10 pb-10 overflow-hidden" style="line-height:20px;">
        <div class="pull-left pl-10 pr-10">
            <div class="zi-hei size14 weight500">简介</div>
            <div  class="mb-10 clear width-10 hotel_desc" style="word-wrap:break-word; ">
                ${entity.context}
            </div>
        </div>
    </div> 
</main>
<%@ include file="/webcom/house-comment.jsp"%>
</body>
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
</html>