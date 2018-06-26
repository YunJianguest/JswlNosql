<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>${title }</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>${title }</title>
<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
<link href="${ctx }/app/css/style_0.css" rel="stylesheet"> <!-- Resource style -->

    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
<script type="text/javascript" src="${ctx}/wwz/js/jquery-1.9.1.min.js"></script>
<script src="${ctx}/app/js/zns_common.js" type="text/javascript"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style>
.DrawBox {position: relative; width: 293px; height: 291px; border-radius: 147px 147px 147px 147px; background:url("${ctx }/wwz/images/pic8.png") no-repeat top; margin:20px auto 0; background-size:cover}
.DrawBox .productshow .proTitle{ text-align:center; width:70px; font-family:"微软雅黑"; font-size:12px; color:#fff; font-weight:bold; position:absolute;}
.DrawBox .productshow .proTitle1{top:43px;  left:148px; transform: rotate(25deg);-moz-transform: rotate(25deg);-webkit-transform: rotate(25deg);}
.DrawBox .productshow .proTitle2{top:97px; left:203px; transform: rotate(60deg);-moz-transform: rotate(60deg);-webkit-transform: rotate(60deg); }
.DrawBox .productshow .proTitle3{top:170px; left:205px; transform: rotate(110deg);-moz-transform: rotate(110deg);-webkit-transform:rotate(110deg); }
.DrawBox .productshow .proTitle4{top:230px; left:150px; transform:  rotate(150deg); -moz-transform: rotate(150deg);-webkit-transform:rotate(150deg); }
.DrawBox .productshow .proTitle5{top:230px; left:75px; transform: rotate(200deg);-moz-transform: rotate(200deg); -webkit-transform:rotate(200deg); }
.DrawBox .productshow .proTitle6{top:170px; left:20px; transform: rotate(240deg);-moz-transform: rotate(240deg); -webkit-transform:rotate(240deg); }
.DrawBox .productshow .proTitle7{top:97px; left:20px; transform: rotate(290deg);-moz-transform: rotate(290deg);-webkit-transform: rotate(290deg);  }
.DrawBox .productshow .proTitle8{top:45px; left:70px; transform: rotate(335deg);-moz-transform: rotate(335deg);-webkit-transform: rotate(335deg);  }
.Introduction img {
width: 90%;
}
</style>

<script type="text/javascript" src="${ctx }/dial/js/html5.js"></script>
<link rel="stylesheet" href="${ctx}/app/css/drawbox.css" />
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx }/app/js/main.js"></script>
<script src="${ctx }/app/js/qikoo.js"></script>
   
<script type="text/javascript">
var hasJoin=false;
var refurl='';
var yhj='';
var total='';
var no='';
var jp='';
var tsy='';
$(function(){
	el=$("#aDiv")[0];
	$(".contentLZhuanBtn").click(function(){	
		if(!hasJoin){
			hasJoin=true;
			
			 $.get('${ctx}/wwz/wwzajax!drawbox.action?toUser=${toUser}&_id=${hdid}' , function(data) {
				 	setTimeout(function(){ hasJoin=false;},10000);	
				
 	                if (data.status == 6) {//未关注
 	                	qikoo.dialog.alert("您还没有关注我们,请先关注后在抽奖");
 		                 window.location.href=data.method;
 	                    
 	                    return true;
 	                }else if (data.status == 1) {
 	                	alert(data.tsy);
 	                	return;
 	               }else if (data.status == 3) {
	                	alert(data.tsy);
	                	window.location.href="${ctx}/wwz/wwz!record.action?toUser=${toUser}";
	                	return;
 	                } else if (data.status == 0) {
 	                	var cell=8;
 	       				var offset=0;
 	       				no=data.reward.no;
 	       				yhj=data.ysj;
 	       				total=data.total;
 	       				
 	       				jp=data.reward.jp;
 	       				
 	       				getData=(360/cell)*no+offset*1-360/(cell*2);
 	       			
 	       				t = setInterval(function(){doRotate();},36);
 	       				
 	       				setTimeout(function(){end("恭喜你获得了:"+jp);},3000);
 	       				if(data.isjh==0){
 	       				    setTimeout(function(){shuaxin('');},5000);
 	       					//setTimeout(function(){shuaxin(data.re.method);},5000);
 	       				}else{
 	       					setTimeout(function(){
 	       						$('#yhj').val(data.ysj);
 	       						$('#inptel').show();}
 	       					,7000);
 	       					
 	       				}
 	       				
 	                    return true;                        
 	                           
	                } else{

	                	var cell=8;
 	       				var offset=0;
 	       				no=0;
 	       				
 	       				total=data.total;
 	       				
 	       				
 	       				
 	       				getData=(360/cell)*no+offset*1-360/(cell*2);
 	       			
 	       				t = setInterval(function(){doRotate();},36);
						setTimeout(function(){end("很遗憾，这次没有抽中，再接奖励");},3000);
	                	
	                	return;   
 	                }   
 	              
 	           
 	        }); 

		}
		
		
    });
});

function getcmpno() {
	var tel=$("#tel").val();
    if (tel.length < 11) {
    	qikoo.dialog.alert("请添加正确的手机号码");
    	return;
    }
    var submitData = {
    	tel: tel
    };

    $.post('${ctx}/cmp/pingche!sendsmsno.action?toUser=${toUser}', submitData,
    	function (data) {
    		alert(data.success);
        	if (data.success == 1) {
        		$('#inptel').hide();
            
        		getrecord()
                return;
              } else {
            	  qikoo.dialog.alert("手机号码不正确，无法发送短信");
              }
           },"json")
  
}
function getrecord() {
	var submitData = {
    	yhj: $("#yhj").val(),
    	hdid:'${hdid}',
    	lx:1
     };
	$.post('${ctx}/wwz/wwzajax!getrecord.action?toUser=${toUser}', submitData,
    	function (data) {
        	if (data.state == 0) {
        		shuaxin('');
                return;
             } else if (data.state == 1)  {
            	 qikoo.dialog.alert("优惠劵不对哦");
			}else{
				qikoo.dialog.alert("该奖品已经领取完");
			}
     }, "json")
    
}
function shuaxin(method){
	  if(method==''||method==null||method=='undefined'){
		  refurl="${ctx}/wwz/wwz!record.action?toUser=${toUser}";
		  
	  }else{
		  refurl=method;
	  }
	setTimeout(function(){window.location.href=refurl;},5000);
}

function yzcj() {
	var submitData = {
    	yzm: $("#yzm").val(),
    	wid:'${entity._id}'
     };
	$.post('${ctx}/wwz/wwzajax!drawboxyz.action?toUser=${toUser}', submitData,
    	function (data) {
			
        	if (data.state == 0) {
        		$("#yzdiv").hide();
                return;
             } else if (data.state == 1)  {
            	 qikoo.dialog.alert("验证码不对,请核对重新后重新输入");
             } else if (data.state == 2)  {
            	 qikoo.dialog.alert("该验证码已经使用过");
			 }
     }, "json")
    
}

var iAcc=1;
var pi = Math.PI;
var angle=0;
var el;
var getData=0;
var hasJoin=false;
function degToRad(x){return( x/(360/(2*pi)));}
function radToDeg(x){return( x*(360/(2*pi)));}
function doRotate(){
	
	iAcc++;
	if(iAcc>=50){
		iAcc=50;
	}
	angle += iAcc;
	rotate();
}	
function rotate(){
	
	var rad = degToRad(angle);
	costheta = Math.cos(rad);
	sintheta = Math.sin(rad);
	
	if(el.filters){
	  el.style.filter = "progid:DXImageTransform.Microsoft.Matrix()";
	  el.filters.item("DXImageTransform.Microsoft.Matrix").SizingMethod = "auto expand";
	  el.filters.item("DXImageTransform.Microsoft.Matrix").FilterType = "bilinear";
	  el.filters.item("DXImageTransform.Microsoft.Matrix").M11 = costheta;
	  el.filters.item("DXImageTransform.Microsoft.Matrix").M12 = -sintheta;
	  el.filters.item("DXImageTransform.Microsoft.Matrix").M21 = sintheta;
	  el.filters.item("DXImageTransform.Microsoft.Matrix").M22 = costheta;
	} else if(window.navigator.userAgent.indexOf("Firefox")>=1) {
		el.style.MozTransform = "rotate("+angle+"deg)";
	} else if(window.navigator.userAgent.indexOf("Chrome")>=1) {
		el.style.WebkitTransform = "rotate("+angle+"deg)";
	} else if(window.navigator.appName=="Opera"){
		el.style.OTransform = "rotate("+angle+"deg)";
	} else
	{
		el.style.WebkitTransform = "rotate("+angle+"deg)";
	}
}



function end(jp){
	setTimeout(function(){qikoo.dialog.alert(jp);},3000);
	
	doRotate();
	clearInterval(t);
	iNum = iAcc*(iAcc+1)/2;
	data = angle-iAcc+iNum;
	ts = data%360;
	if(ts > getData) {
		hh = 360-ts+getData;
	} else {
		hh = getData-ts;
	}
	angle+=hh;
	z = setInterval(function(){
		iAcc--;
		angle+=iAcc;
		rotate();
		if(iAcc == 0) {	
			clearInterval(z);
		}
	},50);
}

</script>
 

</head>
<body> 
<main class="cd-main-content cmp640" id="section1">
	<input type="hidden"  id="enddate" value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value='${entity.enddate}' />"/>
	<div class="mb-15 width-10 " style="position: absolute;">
            <div class="txt-c hang40 bg-hei-8 zi-bai pl-10 pr-10 size14" >
                <span class=" "><i class="fa fa-clock-o mr-5 "></i>倒计时：</span>
                
                <span class="bg-hong hang30 pl-5 pr-5 size16 mt-5" id="day">00</span>&nbsp;天&nbsp;
                <span class="bg-hong hang30 pl-5 pr-5 size16 mt-5" id="hour">00</span>&nbsp;时&nbsp;
                <span class="bg-hong hang30 pl-5 pr-5 size16 mt-5" id="min">00</span>&nbsp;分&nbsp;
                <span class="bg-hong hang30 pl-5 pr-5 size16 mt-5" id="sec">00</span>&nbsp;秒&nbsp;
            </div>
    </div>
    <div class=" zi-cheng " style="position: absolute;right:10px; top: 100px;">
            <span class="size12" style="">阅读数:${yds }</span>
            
    </div>  
	<div class="ui_page">
		
		<div class="WheelHome" style="width:100%">
			
			
			<div class="DrawBox" style="margin-top:30px">
				<div class="productshow">
					<div class="proTitle1 proTitle">${entity.reward[1].jp }</div>
					<div class="proTitle2 proTitle">${entity.reward[2].jp }</div>
					<div class="proTitle3 proTitle">${entity.reward[3].jp }</div>
					<div class="proTitle4 proTitle">${entity.reward[4].jp }</div>
					<div class="proTitle5 proTitle">${entity.reward[5].jp }</div>
					<div class="proTitle6 proTitle">${entity.reward[6].jp }</div>
					<div class="proTitle7 proTitle">${entity.reward[0].jp }</div>
					<div class="proTitle8 proTitle">${entity.reward[0].jp }</div>
					
				</div>
				<div class="TurntableBox">
					<div id="aDiv" class="PointerBox">
						<span class="pngfix"></span>
					</div>
					<div class="contentLZhuanBtn">
						<span class="pngfix"><a href="javascript:void(0);"
							class="start"></a> </span>
					</div>
				</div>

			</div>
			
     		<div class="Winning" id="nojp" style="display:none">
    			<button  style="width:100%; height:32px;color: #FFFFFF; font-family:'微软雅黑'; font-size:20px;border-radius: 5px; cursor: pointer;background:url(${ctx}/dial/images/button_gua.png) 0 -2px repeat-x;">${context }</button>
     			
     		</div>

			<div class="WheelCer" style=" margin-top:0px; background:#FFF">
				
				<div class="Introduction">
					 
					<dd>${entity.context }</dd>
				</div>
			</div>
			

		</div>
		
	
	</div>
</main>
<%@include file="/app/app-footer.jsp" %>
<div class="fullscreen" style="display:none;background-color: rgba(92, 91, 89, 0.9);" id="inptel">
	<input  id="yhj" name="yhj" type="hidden" value="" />
        <div class="kong">
            <div class="hang50 mt-50"></div>
            <div class=" touxiang t60"  ><span class="touxiang60"><img src="${user.headimgurl }"class="" style="width: 100%;"></span></div>
            <div class="pt-10 pb-10 ">
                <div class="div-group-5 pl-20 pr-20 zi-bai" style="line-height: 20px;">恭喜您中奖了，请输入手机号码以便我们联系您来领取</div>
                <div class="div-group-5 ">
                    <div class="div-group-10 hang50 zi-hui lock mb-15 ">
                        <div class="kuang-big">
                            <input class="sr c"  id="tel" name="tel" type="tel" value="${user.tel }" type="text" placeholder="请输入您的手机号码"/>
                        </div>
                    </div>
                    <div class="hang10"></div>
                    <div class="div-group-5 hang50 zi-hui lock mb-15 ">
                        <div class="button_group ">
                            <a href="javascript:getcmpno()" class="button btn-lu " style="padding: 4px 0px">
                                <div class="an-normal">确认领奖</div>
                            </a>
                        </div>
                        
                    </div> 

                </div>
            </div>
        </div>
    </div>
<c:if test="${entity.yz==1 }">
<div class="fullscreen cmp640 txt-c " style="display:; right: 0px" id="yzdiv" >
    <div class="div-group-5 pl-10 pr-10 mt-40">

        <div class="size14 line-bottom-98 weight500 pt-10 pb-10 zi-bai" style="padding-left: 2px;">请输入验证码</div>

        <div class="line-lu hang40 bg-bai">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 pt-8 weight500 " type="text" name="yzm" id="yzm" value="" >
        </div>
		<div class="hang10"></div>
        <div class="div-group-5 hang50 zi-hui lock mb-15 ">
                        <div class="button_group ">
                            <a href="javascript:yzcj();" class="button btn-lu " style="padding: 4px 0px">
                                <div class="an-normal">验证抽奖</div>
                            </a>
                        </div>
                        
        </div> 

    </div>
</div>
</c:if>
<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&&lscode=${lscode}', submitData,

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
<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}">
  <%@ include file="/webcom/focus-page.jsp" %>
 </c:if>
</c:if>
<div class="clear hang50"></div>
<%@ include file="/webcom/lucky-foot.jsp" %>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</body>
</html>
