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
    <title>个人中心</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>

        .hang45 {
            height: 45px;
        }

        .pt-13 {
            padding-top: 13px;
        }

        .line-height42 {
            line-height: 49px;
        }

        .line-height22 {
            line-height: 23px;
        }

        .border-radius2 {
            border-radius: 2px;
        }

        .btn-lan-tq {
            background-color: #00a5e0;
        }

        .btn-lan-tq:hover, .btn-lan-tq:focus {
            background-color: #0092c7;
        }
        
        .img-w16 {
            width: 16px;
        }

        .img-h16 {
            height: 16px;
            line-height: 19px;
        }
        

    </style>
</head>
<body class="cmp640">
<main>
    <div class="position-r overflow-hidden clear" style="height:150px;">
        <img src="${ctx}/mvccol/img/bbs2/xingkong.jpg" width="100%">

        <div class="position-a width-10 cmp640 bg-hei-5"
             style="height:150px;top: 0px;">
        </div>
        <div class="position-a width-10 cmp640" style="top:30px;left: 0px;">
            <div class="position-r">
                <div class="pl-15 position-a position-r">
                    <div class=" pt-3 img-wh90  border-radius5"
                         style="background-color:  rgba(255, 255, 255, 0.7)">
                        <c:if test="${empty entity.headimgurl}">
                            <div class="img-wh80 border-radius5 maring-a img-bj"
                                 style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg);width: 84px;height: 84px;"></div>
                        </c:if>
                        <c:if test="${not empty entity.headimgurl}">
                            <div class="img-wh80 border-radius5 maring-a img-bj"
                                 style="background-image: url(${filehttp}/${entity.headimgurl});width: 84px;height: 84px;"></div>
                        </c:if>

                    </div>

                    <div class="position-a display-none" style="bottom: 0px;left:15px;">
                        <div class="bg-cheng " style="width:80px; height: 15px;"></div>
                    </div>

                </div>

                <div class="zi-bai pt-3" style="padding-left:115px;height:90px;">

                    <div class="weight500">
                        <font size="4">
                            <div class="width-5 maring-a clear sl pull-left">${entity.nickname}</div>
                        </font>
                    </div>

                    <div class="pt-5 weight100 clear">
                        <font size="2"><i class="pr-10">帖子${entity.bbscount}</i><i class="">积分</i>${entity.jf}</font>
                    </div>

                    <div class="pt-5">
                        <div class="pull-left img-wh25 display-none">
                            <c:if test="${empty entity.levelimgurl}">
                                <img src="${ctx}/mvccol/img/level/weizhuce.png" width="100%">
                            </c:if>
                            <c:if test="${not empty entity.levelimgurl}">
                                <img src="${ctx}/${entity.levelimgurl}" width="100%">
                            </c:if>

                        </div>
                        <div class="pull-left pt-5">
                            <font size="1">
                                <div class="pl-5 pr-5 weight100 border-radius3"
                                     style="height:18px; line-height:20px;background-color: #f8a963;">
                                    <i>LV</i><i>${entity.level}</i>
                                </div>
                            </font>
                        </div>

                        <div class="pull-left pl-5 pt-5 display-none">
                            <font size="1">
                                <div class="pl-5 pr-5 weight100 border-radius3"
                                     style="height:18px; line-height:20px;background-color: #f88546;">
                                    <i>点赞狂人</i>
                                </div>
                            </font>
                        </div>

                    </div>
                    <div class="clear pt-7">
                        <div class="border-radius5 overflow-hidden bg-hei-8" style="width:100px;height: 4px;">
                            <div class="bg-green border-radius5" style="width:${entity.expbl}px;height:4px;"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="position-a display-none" style="right:15px;top:60px;">
            <a href="#">
                <div class="hang30 border-radius3 pl-10 pr-10 btn-lan-tq zi-bai weight500">
                    <font size="2">
                        <i class="fa fa-edit pr-5" style="line-height: 32px;"></i><i>修改</i>
                    </font>
                </div>
            </a>
        </div>

    </div>

    <div class="div-group-5 pt-10 pb-10">
        <div class="line-left1 line-right line-top overflow-hidden border-radius5">
            <!--循环列表开始-->
            <c:forEach items="${func.lsfunc}" var="bean" varStatus="1">
               <c:choose>
                 <c:when test="${fn:contains(bean.url,'http')}"> 
                   <div class="hang45 line-bottom zi-hui-tq pl-10 pr-10 overflow-hidden weight500 line-height42"
                 onclick="window.location.href='${bean.url}'">
                <font size="2">
                    <div class="pull-left pr-10 pt-13">
                        <div class=" ${bean.color } img-wh20 txt-c zi-bai overflow-hidden border-radius2">
                            <i class="fa ${bean.ioc} line-height20"></i>
                        </div>
                    </div>
                    <div class="pull-left">
                        ${bean.title}
                    </div>
                    <div class="pull-right">
                        <i class="fa fa-chevron-right line-height42"></i>
                    </div>
                </font>
            </div>
                 
                 </c:when>
                 <c:otherwise> 
                 <div class="hang45 line-bottom zi-hui-tq pl-10 pr-10 overflow-hidden weight500 line-height42"
                 onclick="window.location.href='${ctx}${bean.url}?custid=${custid}&lscode=${lscode}'">
                 <font size="2">
                    <div class="pull-left pr-10 pt-13">
                        <div class=" ${bean.color } img-wh20 txt-c zi-bai overflow-hidden border-radius2">
                            <i class="fa ${bean.ioc} line-height20"></i>
                        </div>
                    </div>
                    <div class="pull-left">
                        ${bean.title}
                    </div>
                    <div class="pull-right">
                        <i class="fa fa-chevron-right line-height42"></i>
                    </div>
                    <c:if test="${fn:indexOf(bean.url,'email/email!web.action')>0}">
                      <c:if test="${emailcount>0}">
                        <div class="pull-right weight100 pr-5 pt-15">
                        <font size="2">
                            <div class="zi-hui txt-c border-radius50 bg-hong  img-w16 img-h16">
                                ${emailcount}
                            </div>
                        </font>
                        </div>
                      </c:if>
                    </c:if>
                    
                     <c:if test="${fn:indexOf(bean.url,'user/friends!web.action')>0}">
                      <c:if test="${friedcount>0}">
                        <div class="pull-right weight100 pr-5 pt-15">
                        <font size="2">
                            <div class="zi-hui txt-c border-radius50 bg-hong img-w16 img-h16">
                                ${friedcount}
                            </div>
                        </font>
                        </div>
                      </c:if>
                    </c:if>
                   
                    
                 </font>
                </div>
                 </c:otherwise>
               </c:choose>
               
             
            </c:forEach>
            <!--循环列表结束-->
          
        </div>
    </div>
</main>
<script>
jQuery(document).ready(function($) {

  if (window.history && window.history.pushState) { 
    if('${state}'==123){
      $(window).on('popstate', function() {
      var hashLocation = location.hash;
      var hashSplit = hashLocation.split("#!/");
      var hashName = hashSplit[1];

      if (hashName !== '') {
        var hash = window.location.hash;
        if (hash =='') { 
          window.location.href='${share.fxurl}';
        }
      }
    });

    window.history.pushState('forward', null, location.href);
    }
  
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
</body>
</html>