<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1,maximum-scale=1" />
<title></title>

<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
<link href="${ctx }/app/css/style_0.css" rel="stylesheet"> <!-- Resource style -->
<link rel="stylesheet" type="text/css" href="${ctx}/mvccol/Scratch/css/style.css" />
<script type="text/javascript"  src="${ctx}/mvccol/Scratch/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body style="overflow:hidden">
<h1 class="keTitle">${title}</h1>
<div id="bg" style="position:absolute;top:0;left:0;"><img src="${ctx}/mvccol/Scratch/img/guaguaka_bg.png" style="width:100%; height:auto" / ></div>
<div id="bg2" style="width:295px;height:195px;margin:0 auto;"> <img id="bg2_img" src="${ctx}/mvccol/Scratch/img/guaguaka_word.png" width="295" height="195" style="position: absolute;"> </div>
<div>
 
</div>
<div id="gua1" style="width:295px;;margin:0 auto;" > <img id="gua1_img" src="${ctx}/mvccol/Scratch/img/gua_image.png" style="position: absolute;">
  <canvas id="front" style="position:absolute;no-repeat" />
</div>
<div id="notify" style=" width:100%;height:auto; margin:0 auto;">
  <div id="nImg_div" style="position: absolute;color:white;font-size: 17px;font-family: '黑体'" align="center">
${entity.context}
</div>
</div>

<div id="di" style="width:295px;margin:0 auto;" > 
  <!--<img id="di_img" src="img/detail_declare_bg.png" style="position: absolute;">--> 
</div>
<div id="bg1"></div>
    
<script type="text/javascript">   
var re = 2;
var imgSrc = '${ctx}/mvccol/Scratch/img/aa.png';
var iszj=false;
jQuery(document).ready(function() {
	$.get('${ctx}/suc/luckydraw!drawbox.action?custid=${custid}&lscode=${lscode}&lucid=${entity._id}' , function(data) {
	    if(data.state==3){
               alert("请先登录！");
               window.location.href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}";
               }  
               if(data.state==6){
               
                return; 
               }
               if(data.state==0){ 
                
                 }
                 if(data.no==1){
                 
                 }
                 if(data.no==2){
                
                 }
                 if(data.no==4){
                 
                 }
                 if(data.no==5){
                
                 }
                 if(data.no==6){
                
                 }
                
                
     imgSrc='${ctx}/mvccol/Scratch/img/'+data.no+'.png';           
    var body_width = $(window).width();
    var body_height = $(window).height();
    $("#gua1_img").width(300).height(160);
    var height = 141;
    var width  = 285;
    var bg2_width = $("#bg2_img").width();
    var bg2_height = $("#bg2_img").height();
    
    $("#gua1").css({"margin-top":"20px"});

    $("#notify").css({"margin-top":"200px"});
    $("#nImg").width(300).height(101);
    
    $("#di").css({"margin-top":"50px"});
    $("#di_img").width(414*0.7).height(24*0.7);
 
    var gua1_img_width = $("#gua1_img").width();
    $("#front").css({"margin-top":9.3+"px","margin-left":7.5+"px"});
    $("#bg").width("100%").height($(window).height()-1);
    bodys(height,width);             
 	});  
	
});



function showdiv() { 
     document.getElementById("bg1").style.display ="block"; 
}

function hidediv() {
     document.getElementById("bg1").style.display ='none'; 
}

$(function(){
    var width = $("#show_img").width();
    var height = $("#show_img").height();
    var winheight=$(window).height();
    var winwidth=$(window).width(); 
    $("#show_btn").css({"width":176*0.5+"px","height":76*0.5+"px"}); 
   
})
 
function bodys(height,width){
    var img = new Image();         
    var canvas = document.querySelector('canvas');         
    canvas.style.position = 'absolute';           
    img.addEventListener('load',function(e){  
        var ctx; 
        var w = width, h = height;             
        var offsetX = canvas.offsetLeft, offsetY = canvas.offsetTop;             
        var mousedown = false;               
        function layer(ctx){                 
            ctx.fillStyle = 'gray';                 
            ctx.fillRect(0, 0, w, h);
                       
        }   
        function eventDown(e){                 
            e.preventDefault();                 
            mousedown=true;             
        }   
        function eventUp(e){            
            e.preventDefault();                 
            mousedown=false; 
            var datas=ctx.getImageData(0,0,w,h); 
			var num = 0; 
	        for (var i = 0; i < datas.data.length; i++) { 
		     if (datas.data[i] == 0) { 
			  num++;
		    };
	       }; 
	      if (num >= datas.data.length * 0.6) {
		  // 达到面积要求时执行的内容
		    ctx.fillRect(0,0,w,h);
		    if(iszj){
		    $('#inptel').show(); 
		    }
	      };             
            
            
                        
        }               
        function eventMove(e){                 
            e.preventDefault();                 
            if(mousedown){                     
                if(e.changedTouches){                         
                    e=e.changedTouches[e.changedTouches.length-1];                     
                }                     
                var x = (e.clientX + document.body.scrollLeft || e.pageX) - offsetX || 0,                         
                y = (e.clientY + document.body.scrollTop || e.pageY) - offsetY || 0;                     
                with(ctx){                    
                    beginPath()                     
                    arc(x, y, 15, 0, Math.PI * 2);                         
                    fill(); 
                                        
                }                
            }             
        }               
        canvas.width=w;             
        canvas.height=h; 
        
        canvas.style.backgroundImage='url('+img.src+')';              
        ctx=canvas.getContext('2d');         
        ctx.fillStyle='b9b9b9';             
        ctx.fillRect(0, 0, w, h);

        layer(ctx);               
        ctx.globalCompositeOperation = 'destination-out';               
        canvas.addEventListener('touchstart', eventDown);             
        canvas.addEventListener('touchend', eventUp);             
        canvas.addEventListener('touchmove', eventMove);             
        canvas.addEventListener('mousedown', eventDown);             
        canvas.addEventListener('mouseup', eventUp);             
        canvas.addEventListener('mousemove', eventMove);       
    });
    
    img.src = imgSrc;
    (document.body.style);
}

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
    
</script>
 
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

</body>
</html>

