<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>律师个体首页</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script> 
function submitcomment(){
  var submitData = { 
    	        id:'${id}', 
    	        content:$("#content").val().replace('请输入评论',''),
	            };  
    $.post('${ctx}/suc/lawyer!ajaxcommentadd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 function(json){
        	  if(json.state==0){ 
        	  window.location.href='${ctx}/suc/lawyer!detail.action?custid=${custid}&lscode=${lscode}&id=${id}';
        	  }else{
        	   alert("发表失败！");
        	  }
        	 },"json");
} 
</script> 
</head>
<body class="cmp640">
 <div class="fullscreen cmp640 bg-hei-8 lock">
    <div class="position-r overflow-hidden width-10"> 
        <div class="width-10 overflow-hidden" style="height:1000px;" onclick="history.go(-1)">
        </div> 
        <div class="position-a width-10" style="top:0;left:0;">
            <div class=" div-group-5">
                <div class=" div-group-10  overflow-hidden bg-bai border-radius3">
                    <div class="col-12 ">
                        <form>
                    <textarea id="content" placeholder="请输入评论" onfocus="if(this.value=='请输入评论'){this.value=''};this.style.color='black';"
                              onblur="if(this.value==''||this.value=='请输入评论'){this.value='请输入评论';this.style.color='#aaa';}"
                              rows="5" class="form-control"></textarea>
                        </form>
                    </div>
                    <div class=" pt-5 pb-10 clear"> 
                         <div class="btn-green hang30 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3" onclick="submitcomment()">
                                评论
                         </div> 
                         <div class="btn-lan hang30 mr-10 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3" onclick="history.go(-1)">
                                退出
                         </div>
                    </div>
                    <div class="display-none clear"id="tanchu-b2">
                        <div class="hang60 bg-cheng"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> 
<!--结束-->
<script type="text/javascript"> 
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
</body>
</html>
 