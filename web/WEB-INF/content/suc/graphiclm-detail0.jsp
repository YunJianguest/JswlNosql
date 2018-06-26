<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<script src="${ctx}/app/js/jquery-1.8.3.js"></script>
<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style>
        .img-100 img {
            width: 100%;
        }
        .pd10{padding-left: 10px;padding-right: 10px;}
 </style>
    
</head>
<body class="bg-bai">
<main class="cmp640 img-100 pd10">
    ${entity.context}
</main>
<script type="text/javascript">   
    wx.config({
        debug: false,
        appId: '${token.appid}',
        timestamp: '${token.timestamp}',
        nonceStr: '${token.noncestr}',
        signature: '${token.signature}',
        jsApiList: ['checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems',
            'openLocation',
            'getLocation'
        ]
    });
    wx.ready(function () {
        var share = {
            title: '${share.fxtitle}', // 分享标题
            desc: '${share.fxsummary}', // 分享描述
            link: '${share.fxurl}', // 分享链接
            imgUrl: '${filehttp}${share.fxpicurl}', // 分享图标
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