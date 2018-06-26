<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .pr-2 {
            padding-right: 2px;
        }

        .hang25 {
            height: 25px;
            line-height: 26px;
        }

        .btn-hong2 {
            background: #ff6565;
        }

        .btn-hong2:hover {
            background-color: #de4d52;
        }

        .btn-hong2:active {
            background-color: #de4d52;
        }

        .bg-huang {
            background: #f3bc48;
        }

        .bg-hong3 {
            background: #ff6565;
        }

        .btn-huang {
            background: #f3bc48;
        }

        .btn-huang:hover {
            background-color: #eba920;
        }

        .btn-huang:active {
            background-color: #eba920;
        }

        .bj-huang {
            background: #fce559 !important;
        }

        .bj-lan {
            background: #563677;
        }

        .zi-zong {
            color: #630601;
        }

        .zi-huang {
            color: #fce559;
        }

        .line-right-huang {
            border-right: 1px solid #fce559;
        }
    </style>
    <script>
    function  areward(id){  
		 var submitData = {
    	        tid:id, 
	            }; 
		$.post('${ctx}/suc/vote!vtp.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){
        	   alert("投票成功！"); 
        	   $('#vtcount').html(json.value);
        	  }else if(json.state==2){
        	   alert("今日票数已完！");
        	  }else if(json.state==3){
        	   alert("请先登录！");
        	  }
        	 },"json");
	 
    }
    </script>
</head>
<body class="bj-huang lock">
 
<main class="cmp640">
 
   <div class="div-group-10 pt-20 overflow-hidden position-r">
        <div class="bg-huang div-group-10 pb-25 zi-bai overflow-hidden">
            <font size="3">
                <div class=" pt-15">
                    <div class="pull-left"><i class="pr-5">${vote._id}号</i><i>${vote.title}</i></div>
                     <c:if test="${empty vote.count}">
                     <div class="pull-right"><i >票数:</i><i>0</i></div>
                     </c:if>
                     <c:if test="${not empty vote.count}">
                     <div class="pull-right"><i >票数:</i><i id="vtcount">${vote.count}</i></div>
                     </c:if>
                    
                </div>
              
                  <font size="3">
                    <c:if test="${not empty vote.rank}">
                    <div class="clear pt-10">
                        <div class="pull-left"><i class="pr-5">排名:</i><i>${vote.rank.rank}</i></div>
                         
                    </div>
                     </c:if>
                    <div class="clear pt-10"style="line-height: 22px;">
                        <i>描述：</i>${vote.context}
                    </div>
                </font>
              
                <c:forEach items="${fn:split(vote.bgurl,',')}" var="bean">
                 <c:if test="${not empty bean}">
                 <img src="${filehttp}/${bean}"class="width-10 pt-10"> 
                 </c:if> 
                </c:forEach>
              
            </font>
           
            <!--照片展示结束-->
        </div>

        <!--投票button-->
        <div class="pt-10 weight500 txt-c">
            <font size="2">
                <a href="javascript:areward('${vote._id}')">
                    <div class="pt-10 col-6 pr-5">
                        <div class="btn-hong2 div-group-10 border-radius5 zi-bai">
                            为她/他投票
                        </div>
                    </div>
                </a>
                <a href="#">
                    <div class="pt-10 col-6 pl-5">
                        <div class="btn-hong2 div-group-10 border-radius5 zi-bai">
                            我也要参加
                        </div>
                    </div>
                </a>
               
            </font>
        </div>
          <%@include file="/webcom/foot.jsp" %>
<div class="clear hang50"></div> 
<%@ include file="/webcom/vote-foot.jsp" %>
</main>
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
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</html>