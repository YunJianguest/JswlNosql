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
        .line-bottom-ns {
            border-bottom: 1px solid #630601;
        }
    </style>  
    <script>
   var issend=true;
   var fypage=0;
   var xszf="";
   var type="";
function ajaxjz(){//加载
    if(!issend){
    	return;
    }
    
   	var submitData = {  
    	"voteid":'${voteid}'
    	
    }; 
    issend=false;
    $.post('${ctx}/suc/votelm!ajaxhelp.action?custid=${custid}&fypage=' + fypage, submitData,
       	function(json) {
    		var xszf=$('#ajaxdiv').html(); 
	    	if(json.state==0){
	    		var v = json.list;
	    		for(var i=0;i<v.length;i++){ 
	    		   xszf +='<div class="zi-bai overflow-hidden txt-c weight100 hang40 line-bottom">'
                        +'<div class="col-2 pt-5 pb-5">'
                        +'<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}' + v[i].headimgurl + ');"></div>'
                        +'</div>'
                        +'<div class="col-10 sl txt-l" style="line-height: 40px;"><font size="1"><i>' + v[i].nickname + '</i> 在' + v[i].createdate + '进行了一次投票！</font></div></div>';
				}
	    		fypage++;
	    		
	    	}else{
	    		
	    	}
	    	issend=true;
			$('#ajaxdiv').html(xszf);
			
	},"json")
	
}
    
    </script>
</head>
<body class="bj-huang lock">
 
<main class="cmp640"> 
 
<!--结束--><div id="ajaxdiv" class="pb-20 clear "></div>
 
</main> 
<script type="text/javascript">
ajaxjz();
$(window).scroll(function () {

    var offsetY = $(window).scrollTop();

    var section1 = $("#section1").height();
	if(section1-offsetY<600){
		ajaxjz();
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
		    title: '${menu.name}', // 分享标题
		    desc: '${menu.summary}', // 分享描述
		    link: '${token.url}', // 分享链接
		    imgUrl: '${osshttp}${menu.picurl}', // 分享图标
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