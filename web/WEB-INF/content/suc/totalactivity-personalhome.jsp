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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <!-- Resource style -->
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script>
  


        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
    </script>

    <style>
        .zi-hui-da {
            color: #dadada;
        }

        .bg-zong {
            background: #630601
        }

        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }

        .border-radius5s {
            border-radius: 5px 5px 0 0;
        }
    </style>
</head>
<script>
 
 
     
   var issend=true;
   var fypage=0;
   var xszf="";
   var type="";
   var lx=0;
   var vt=1;
function ajaxjzyj(){//加载
    if(!issend){
    	return;
    }
    
   	var submitData = { 
    	"sel":$('#sel').val(), 
    	"lx":lx
    }; 
    issend=false;
    $.post('${ctx}/suc/totalactivity!ajaxperlucky.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
       	function(json) {
    		var xszfleft=$('#ajaxleft').html(); 
    		var xszfright=$('#ajaxright').html(); 
	    	if(json.state==0){
	    		var v = json.list;
	    		for(var i=0;i<v.length;i++){
	    		    if(i&1!=0){
	    		    xszfleft+='<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
	    		           +'<div class="position-r"><a href="${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid='+v[i]._id+'"><img src="${filehttp}/'+v[i].picurl+'" class="width-10 border-radius5s"></a>'
	    		           +'<div class="position-a width-3" style="top: 0px; right:10px;">'
	    		           +'<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">'+v[i].state+'</font></div>'
	    		           +'<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
	    		           +'<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
	    		           +'<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
	    		           +'<font size="1"><i class="pr-5">参与人数:</i>'+v[i].pcount+'<i class="pl-5">人</i></font></div></div></div>'
	    		           +'<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
	    		           +'<div class="clear sl zi-hei-tq">'+v[i].title+'</div>'
	    		           +'</a></div>';
	    		          
                     
	    		    }else{
	    		    
	    		    
	    		    xszfright+='<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
	    		           +'<div class="position-r"><a href="${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid='+v[i]._id+'"><img src="${filehttp}/'+v[i].picurl+'" class="width-10 border-radius5s"></a>'
	    		           +'<div class="position-a width-3" style="top: 0px; right:10px;">'
	    		           +'<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">'+v[i].state+'</font></div>'
	    		           +'<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
	    		           +'<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
	    		           +'<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
	    		           +'<font size="1"><i class="pr-5">参与人数:</i>'+v[i].pcount+'<i class="pl-5">人</i></font></div></div></div>'
	    		           +'<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
	    		           +'<div class="clear sl zi-hei-tq">'+v[i].title+'</div>'
	    		           +'</a></div>';
	    		    }
	    	       
				}
	    		fypage++;
	         $('#ajaxleft').html(xszfleft);
			 $('#ajaxright').html(xszfright);
	    	}else{
	    		
	    	}
	    	issend=true;
			
			
	},"json")
	
}
function ajaxjztp(){//加载
    if(!issend){
    	return;
    }
    
   	var submitData = { 
    	"sel":$('#sel').val(), 
    	
    }; 
    issend=false;
    $.post('${ctx}/suc/totalactivity!ajaxpervotolm.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
       	function(json) {
    		var xszfleft=$('#ajaxleft').html(); 
    		var xszfright=$('#ajaxright').html(); 
	    	if(json.state==0){
	    		var v = json.list;
	    		for(var i=0;i<v.length;i++){
	    		    if(i&1!=0){
	    		    xszfleft+='<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
	    		           +'<div class="position-r"><a href="${ctx }/suc/votelm!index.action?_id='+v[i]._id+'&custid=${custid}&lscode=${lscode}"><img src="${filehttp}/'+v[i].picurl+'" class="width-10 border-radius5s"></a>'
	    		           +'<div class="position-a width-3" style="top: 0px; right:10px;">'
	    		           +'<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">'+v[i].state+'</font></div>'
	    		           +'<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
	    		           +'<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
	    		           +'<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
	    		           +'<font size="1"><i class="pr-5">参与人数:</i>'+v[i].pcount+'<i class="pl-5">人</i></font></div></div></div>'
	    		           +'<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
	    		           +'<div class="clear sl zi-hei-tq">'+v[i].title+'</div>'
	    		           +'</a></div>';
	    		          
                     
	    		    }else{
	    		    
	    		    
	    		    xszfright+='<div class="width-10 mt-15 shadow-wai1 overflow-hidden border-radius5 zi-6">'
	    		           +'<div class="position-r"><a href="${ctx }/suc/votelm!index.action?_id='+v[i]._id+'&custid=${custid}&lscode=${lscode}"><img src="${filehttp}/'+v[i].picurl+'" class="width-10 border-radius5s"></a>'
	    		           +'<div class="position-a width-3" style="top: 0px; right:10px;">'
	    		           +'<div class="pt-5 txt-c zi-bai weight500 bg-zong"><font size="1">'+v[i].state+'</font></div>'
	    		           +'<div class=""><img src="${ctx}/mvccol/img/pbl/ns-xs2.png" width="100%"></div></div>'
	    		           +'<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
	    		           +'<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
	    		           +'<font size="1"><i class="pr-5">参与人数:</i>'+v[i].pcount+'<i class="pl-5">人</i></font></div></div></div>'
	    		           +'<a href="#"> <div class="col-12 div-group-5 zi-6 bg-bai weight500"><font size="1">'
	    		           +'<div class="clear sl zi-hei-tq">'+v[i].title+'</div>'
	    		           +'</a></div>';
	    		    }
	    	       
				}
	    		fypage++;
	         $('#ajaxleft').html(xszfleft);
			 $('#ajaxright').html(xszfright);
	    	}else{
	    		
	    	}
	    	issend=true;
			
			
	},"json")
	
}

function change(v){
vt=v;
$('#ajaxleft').html('');
$('#ajaxright').html(''); 
 if(v==1){
   lx=0;
   fypage=0;
   ajaxjzyj();
 }else if(v==3){
   lx=1;
   fypage=0;
   ajaxjzyj();
 }else if(v==2){
   fypage=0;
   ajaxjztp();
 }
}         
 
</script>
<body class="cmp640 bg-hui-98 lock"> 
<main>


        <!--早期导航不能动-->
        <div class=" hang30 pt-3 width-10 weight500 bg-hei-8 cmp640"
             style="bottom:0px; left:0px;">

            <a href="javascript:change(1)">
                <div class="col-4 txt-c line-right hang25 overflow-hidden" style="line-height:25px;">
                    <font size="2">
                        <div class="width-9_5 maring-a zi-hui-da clear sl" style="line-height:25px;">
                            摇奖活动
                        </div>
                    </font>
                </div>
            </a>
            <a href="javascript:change(2)">
                <div class="col-4 txt-c line-right hang25 overflow-hidden" style="line-height:25px;">
                    <font size="2">
                        <div class="width-9_5 maring-a zi-hui-da clear sl" style="line-height:25px;">
                            投票活动
                        </div>
                    </font>
                </div>
            </a>
            <a href="javascript:change(3)">
                <div class="col-4 txt-c hang25 overflow-hidden" style="line-height:25px;">
                    <font size="2">
                        <div class="width-9_5 maring-a zi-hui-da clear sl" style="line-height:25px;">
                            刮刮乐活动
                        </div>
                    </font>
                </div>
            </a>
        </div>
        <!--早期导航不能动结束-->


    </div>

  <c:if test="${not empty user.isadmin}">
     <div class="pl-5 pr-5 pt-10 clear">
        <a href="${ctx}/suc/luckydraw!webadd.action?custid=${custid}&lscode=${lscode}">
            <div class="btn-lu txt-c div-group-10 weight500 zi-bai border-radius5">
                <font size="2">
                    活动发起
                </font>
            </div>
        </a>
    </div>
    </c:if>
   <div class="hang40"></div>
    <div class="pl-5 pr-5">
        <div class="col-6" style="padding-right: 5px;" id="ajaxleft">
         
        </div>
        <div class="col-6" style="padding-left: 5px;" id="ajaxright">
           
        </div>
    </div>
  <%@include file="/webcom/foot.jsp" %>
<%@ include file="/webcom/lucky-foot.jsp" %>   
</main>
<script type="text/javascript">
ajaxjzyj();
$(window).scroll(function () {

    var offsetY = $(window).scrollTop();
   
    var section1 = $("#section1").height();
   
	if(section1-offsetY<600){ 
		 if(vt==1){
           lx=0; 
           ajaxjzyj();
          }else if(vt==3){
              lx=1;
    
             ajaxjzyj();
          }else if(v==2){
  
            ajaxjztp();
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