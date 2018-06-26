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
     
   var issend=true;
   var fypage=0;
   var xszf="";
   var type="";
function ajaxjz(){//加载
    if(!issend){
    	return;
    }
    
   	var submitData = { 
    	"sel":$('#sel').val().replace("搜名字或者编号",""),
    	"vtid":'${entity._id}'
    	
    }; 
    issend=false;
    $.post('${ctx}/suc/votelm!ajaxweb.action?custid=${custid}&fypage=' + fypage, submitData,
       	function(json) {
    		var xszfleft=$('#ajaxdivleft').html(); 
    		var xszfright=$('#ajaxdivright').html(); 
	    	if(json.state==0){
	    		var v = json.list;
	    		for(var i=0;i<v.length;i++){
	    		    if(i&1!=0){
	    		    xszfleft+='<a href="${ctx}/suc/vote!detail.action?custid=${custid}&lscode=${lscode}&_id='+v[i]._id+'"><div class="width-10 position-r mt-10">'
	    		    +'<img src="${filehttp}'+v[i].picurl+'" class="width-10"><div class="position-a width-4" style="top: 0px; right:5px;">'
	    		    +'<div class="pt-5 pr-5 pl-5 txt-c bg-hong3">';
	    		    if(v[i].cunt==null){
	    		    xszfleft+='<font size="2">0</font></div>';
	    		    }else{
	    		    xszfleft+='<font size="2">'+v[i].count+'</font></div>';
	    		    }
	    		    
	    		    xszfleft+='<div class=""><img src="${ctx}/mvccol/img/tplb.png" width="100%"></div></div></div>'
	    		    +'<div class="bg-huang" style="height:50px;"><div class="col-8 pl-10">'
	    		    +'<div class="clear pt-5"><font size="2">姓名</font></div>'
	    		    +'<div class="pt-5"><font size="2">'+v[i].title+'</font></div>'
	    		    +'</div>  <div class="col-4 bg-hong3 hang50 txt-c">投票 </div></div></a>';
	    		          
                     
	    		    }else{
	    		    
	    		    
	    		    xszfright+='<a href="${ctx}/suc/vote!detail.action?custid=${custid}&lscode=${lscode}&_id='+v[i]._id+'"><div class="width-10 position-r mt-10">'
	    		    +'<img src="${filehttp}'+v[i].picurl+'" class="width-10"><div class="position-a width-4" style="top: 0px; right:5px;">'
	    		    +'<div class="pt-5 pr-5 pl-5 txt-c bg-hong3">';
	    		    if(v[i].cunt==null){
	    		    xszfright+='<font size="2">0</font></div>';
	    		    }else{
	    		    xszfright+='<font size="2">'+v[i].count+'</font></div>';
	    		    }
	    		    
	    		    xszfright+='<div class=""><img src="${ctx}/mvccol/img/tplb.png" width="100%"></div></div></div>'
	    		    +'<div class="bg-huang" style="height:50px;"><div class="col-8 pl-10">'
	    		    +'<div class="clear pt-5"><font size="2">姓名</font></div>'
	    		    +'<div class="pt-5"><font size="2">'+v[i].title+'</font></div>'
	    		    +'</div>  <div class="col-4 bg-hong3 hang50 txt-c">投票 </div></div></a>';
	    		    }
	    	       
				}
	    		fypage++;
	         $('#ajaxdivleft').html(xszfleft);
			 $('#ajaxdivright').html(xszfright);
	    	}else{
	    		
	    	}
	    	issend=true;
			
			
	},"json")
	
}
function sel(){
$('#ajaxdivleft').html('');
$('#ajaxdivright').html('');
fypage=0;
ajaxjz();
 
}
    
    </script>
</head>
<body class="bj-huang lock">
 
<main class="cmp640" id="section1">
 
    <div class="maring-a pt-20">
        <font size="2">
            <div class="width-6 maring-a border-radius3 overflow-hidden">
                <div class="pt-5 bg-bai hang30 col-9">
                    <input id="sel" class="  pl-5 zi-hui hang20" style="line-height: 22px;" type="text"
                           name=""
                           value="搜名字或者编号" onfocus="if(value=='搜名字或者编号'){value=''}"
                           onblur="if (value ==''){value='搜名字或者编号'}">
                </div>
                <a href="javascript:sel()">
                    <div class="col-3 txt-c hang30 zi-bai btn-cheng txt-c" style="line-height: 30px;">
                        搜索
                    </div>
                </a>
            </div>
        </font>
    </div>

    <div class="overflow-hidden pt-25 pl-5 pr-5">
        <font size="2">
            <div class="pr-5 button_group">
                <a href="#">
                    <div class="hang30 btn-cheng border-radius3 button txt-c"
                         style="line-height:30px;">
                        首页
                    </div>
                </a>
            </div>
            <div class="pr-5 button_group">
                <a href="#">
                    <div class="hang30 btn-cheng border-radius3 button txt-c"
                         style="line-height:30px;">
                        排行榜
                    </div>
                </a>
            </div>
            <div class="pr-5 button_group">
                <a href="#">
                    <div class="hang30 btn-cheng border-radius3 button txt-c"
                         style="line-height:30px;">
                       我要投票
                    </div>
                </a>
            </div>
            <div class="pr-5 button_group">
                <a href="${ctx}/suc/votelm!moveadd.action?custid=${custid}&fromUserid=${fromUserid}&_id=${entity._id}">
                     
                       我要报名
                    </div>
                </a>
            </div>
        </font>
    </div>

    <div class="width-10 pr-10 pl-10 pt-5 zi-bai overflow-hidden">
    
        <div class="col-6 pr-5" id="ajaxdivleft">
           
        </div>

        <div class="col-6 pl-5" id="ajaxdivright">
            
        </div>
    
    </div>
    
    
    
     <!--活动介绍-->
    <div class="pt-20">
        <div class="div-group-5 pl-20 zi-bai pull-left pr-20 bg-huang " style="border-radius: 0px 100px 100px 0px;">
            <font size="2">活动介绍</font>
        </div>
    </div>
    <div class="div-group-10 clear">
        <div class="bg-bai hang100">
            此处放置的是活动介绍 （图文编辑器进行填充）
        </div>
    </div>

    <!--活动规则奖项设置-->
    <div class="pt-20">
        <div class="div-group-5 pl-20 zi-bai pull-left pr-20 bg-huang " style="border-radius: 0px 100px 100px 0px;">
            <font size="2">活动规则奖项设置</font>
        </div>
    </div>

    <div class="zi-zong div-group-10 clear weight500" style="line-height:20px;">
        <font size="2">
            <div>报名时间：</div>
            <div>即日起-2016年4月20日23:59</div>
            <div>投票时间：</div>
            <div>2016年4月00:00至2016年4月20日23:59</div>

            <div class="pt-10">在此公众号回复“投票”即可为您喜爱的选手投一票</div>
            <div class="">奖品发布：</div>
        </font>
    </div>
</main>
<div class="clear hang50"></div> 
<%@ include file="/webcom/vote-foot.jsp" %>
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