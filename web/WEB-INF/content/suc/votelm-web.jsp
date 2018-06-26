<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>${title}</title>
<meta name="viewport" charset="utf-8"
	content="width=device-width, initial-scale=1">
	<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"> 
<!--全局样式结束-->
<!--全局脚本开始-->
<script src="${ctx }/app/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
<link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
<script src="${ctx }/app/js/main.js"></script>
<script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

<!--全局脚本结束-->
<script>
var issend=true;
var fypage=0;
var xszf="";
function ajaxjz(){//加载
    if(!issend){
    	return;
    }
    
   	var submitData = {
    	
    	sel:$('#sel').val()
    	
    };

    issend=false;
    $.post('${ctx }/suc/votelm!ajaxlist.action?custid=${custid}&fypage='+fypage, submitData,
       	function(json) {
    		var xszf=$('#ajaxdiv').html();
	    	if(json.state==0){
	    		var v = json.list;
	    
	    		for(var i=0;i<v.length;i++){
		    		
		    			xszf+='<a href="${ctx }/suc/votelm!index.action?_id='+v[i]._id+'&custid=${custid}&lscode=${lscode}"'+
							  'title="${bean.title}">'+
					          '<div class="div-group-5 " style="position: relative">'+
                              '<img src="${filehttp}'+v[i].picurl+'" alt="'+v[i].title+'" class="width-10 border-radius5">'+ 

                              '<div style="position: absolute; bottom:5px;" class="pr-10 width-10">'+
                              '<div class="width-10 bg-hei-8 hang40 zi-bai size14 weight500" style="border-radius:0px 0px 5px 5px ;">'+
                              '<span class="pl-10">'+v[i].title+'</span>'+
                              '</div>'+
                              '</div>' +
                              '</div>' +
					          '</a>';
				}
	    		fypage++;
	    		
	    	}else{
	    		
	    	}
	    	issend=true;
			$('#ajaxdiv').html(xszf);
			
	},"json")
	
}
 function xz_title(){
	$('#seldiv').show();
}
function gb(){
	$('#seldiv').hide();
}   
function getsel(){
	var sel=$('#sel').val();
	
	window.location.href="${ctx }/wwz/wwz!wxnewscommon.action?type=${type }&toUser=${toUser }&sel="+sel;
}
function  areward(id){  
		 var submitData = {
    	        tid:id, 
	            }; 
		$.post('${ctx}/suc/vote!vtp.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){
        	   alert("投票成功！"); 
        	  }else if(json.state==2){
        	   alert("今日票数已完！");
        	  }else if(json.state==3){
        	   alert("请先登录！");
        	  }
        	 },"json");
	 
    }
</script>
</head>
<body>  
<main id="section1" class="cmp640"> 
	<div class="bg-hei-8 " style="display:none; " id="seldiv">
        <div class=" hang50 bg-hei-8 width-10 " style="z-index: 88888;" >
            <div class="div-group-5 " style="padding-right: 40px">
                <div class=" col-9  hang40 search">
                    <input class="size14 width-10 txt-l zi-hui  pl-10" style="height: 36px" id="sel" name="sel" type="text" value="${sel }" placeholder="请输入..."/>
                </div>
                <a href="javascript:getsel();">
                    <div class="col-3 txt-c btn-lu pb-10 mb-10 hang40 zi-bai" style="border-radius: 0px 3px 3px 0px; "> 搜索</div>
                </a>
            </div>
            <a href="javascript:gb()" class="zi-bai div-group-5"  style="position:relative;line-height: 35px;"><i class="fa fa-1dx fa-remove"></i></a>
        </div>
    </div>

	<c:if test="${not empty advertisement}">
    <div id="banner_box" class="box_swipe overflow-hidden " style="width:100%">
        <ul>
        	<c:forEach items="${advertisement}" var="bean">
            <li>
                <a href="${bean.url}">
                    <img src="${filehttp}${bean.picurl}"  style="width:100%;"/>

                    <div class="" style="width:100%;position: absolute;bottom:0px;">
                        <div class="txt-c hang40 zi-bai  size12 pl-10 pr-10" style=" background:rgba(0,0,0,0.2)">
                            
                            <div class=" pull-left size14 pl-10">${bean.title}</div>
                        </div>
                    </div>
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
                   
                }
            });
        });
    </script>
	</c:if>
 
  
<div  id="ajaxdiv"></div>
 
  <%@include file="/webcom/foot.jsp" %>		
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
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>	 
</body>
</html>