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
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <!-- Resource style -->
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script>
        
        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
        function gwc() {

            var submitData = {
                pid: '${entity._id}'
            };
            jQuery.post('${ctx}/shop/shop!ajaxshopcarsave.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            $("#shopcount").html(json.value);
                        } else {
                            alert("添加失败！");
                        }
                    }, "json");
        }
    </script>
    <style>
        .img-100 img{
        width: 100%;
        } 
    </style>
</head>
<body class="cmp640">
<main style="position: relative">
    <c:if test="${not empty slide}">
        <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
            <ul>
                <c:forEach items="${slide}" var="bean">
                    <li>
                        <a href="${bean.url}">
                            <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                        </a>
                    </li>
                </c:forEach>
            </ul>
  
        </div>

        <script>
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
        </script>
    </c:if>

    <div class="hang10 mb-5 clear bg-hui-92"></div>

     <a href="#">
        <div class="col-12 clear div-group-5 pt-10 bg-huang zi-6 weight500">
            <font size="1">
                <font size="3">
                    <div class="clear zi-6 weight500 line-height25" style="color:#333333;">
                      ${entity.ptitle}
                    </div>
                </font>


                <div class="pt-10">
                    <font size="3">
                        <i class="zi-hong">￥<fmt:formatNumber value='${entity.price}' pattern="0.0#"/></i>
                    </font>
                </div>
                <div class="clear pt-10 pb-5 zi-hui overflow-hidden">
                    <font size="2">
                        <div class="txt-l col-4">
                            原价:<i style="text-decoration: line-through;"><fmt:formatNumber value='${entity.oldprice}' pattern="0.0#"/></i>
                        </div>
                        <div class="txt-c col-4">
                            销量:<i>${entity.gmnum}</i>件
                        </div>
                        <div class="txt-r col-4">
                        <c:if test="${not empty entity.kdprice }">
                            <i>快递:${entity.kdprice }元</i>
                        </div>
                        </c:if> 
                        <c:if test="${empty entity.kdprice }">
                            <i>快递:0元</i>
                        </div>
                        </c:if> 
                    </font>
                </div>
            </font>
        </div>
    </a>
   <div class="hang10 clear bg-hui-92"></div>

    <div class="width-10 clear pl-5 pr-5 pt-5 img-100">
        ${entity.context}
    </div>
</main>


<div class="txt-c pr-10"
     style="position: fixed;bottom:60px;right:0px;">
    <a href="${ctx}/shop/shop!shoppingcar.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
        <div class="img-wh35 border-radius50 pull-right bg-hei-5">
            <i class="fa fa-cart-arrow-down fa-1dx zi-bai" style="line-height: 35px;"></i>
        </div>
    </a>
</div>

<div class="txt-c pr-10"
     style="position: fixed;bottom:88px;right:0px;">
     
        <div class="border-radius50 bg-hong pull-right" style=" width:15px; height:15px;">
            <font size="1">
                <i class="zi-bai" id="shopcount" style="line-height:16px;">
                    ${shopcount}
                </i>
            </font>
        </div>
    
</div>

<%@include file="/webcom/foot.jsp" %>

<div class="hang50 clear"></div>

<div class=" button_foot hang50 bg-bai zi-bai shadow-wai div-group-5 cmp640">
    <a href="${ctx}/shop/shop!index.action?lx=1&custid=${custid}&agid=${agid}&lscode=${lscode}">
        <div class="col-2 txt-c zi-green hang40">
            <i class="line-height40 fa fa-2x fa-home"></i>
        </div>
    </a>

    <div class="col-10">
        <div class="pr-5 button_group" onclick="gwc()">

            <div class="btn-cheng hang40 button pr-5 txt-c size18 weight100 line-height40">
                加入购物车
            </div>

        </div>
        <div class="pr-5 button_group">
            <a href="${ctx}/shop/shop!orderconfirmation.action?custid=${custid}&agid=${agid}&lscode=${lscode}&pid=${entity._id}">
                <div class="btn-lu hang40 button pr-5 txt-c size18 weight100 line-height40">
                    立即购买
                </div>
            </a>
        </div>
    </div>
</div>
</a>
<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&agid=${agid}&&lscode=${lscode}', submitData,

                    function (json) { 
                        if (json.state == 0) {
                            var text='分享成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                          swal({
                                text: text,
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }  
                    }, "json");
     
     }
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
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
<!--客服-->
    <div class="position-f img-wh35 txt-c bj-lan1 zi-bai border-radius50"style="bottom:60px; right: 3px;" onclick="window.location.href='${ctx}/android/reply!index.action?custid=${custid}&lscode=${lscode}&id=${entity.comid}&pid=${entity._id}'">
        <i class="fa fa-commenting"style="line-height: 35px;"></i>
    </div>
<!--客服结束-->  
</body>
</html>