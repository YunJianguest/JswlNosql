<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%> 
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <title>${share.fxtitle}</title> 
		<link rel="stylesheet" href="${ctx}/mvccol/shake/css/index.css" />
		<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
		<link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet"> 
		<link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
        <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
        <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
        <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
        <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
		<script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<style type="text/css">
		 .img-100 img{
        width: 100%;
        }
		</style>
		<script type="text/javascript">
		 if('${entity.url}'!=''){
          window.location.href='${entity.url}';
        }
		 var isdraw=true;
		 function draw(){ 
		   if(!isdraw){
		     return;
		   }
		    var submitData = { 
                remark:"活动红包！",
                act_name:"活动促销",
                wishing:"祝您春节愉快！",
                lucid: '${entity._id}',
            }; 
            isdraw=false; 
            
            $.post('${ctx}/suc/luckydraw!drawbox.action?custid=${custid}&&lscode=${lscode}', submitData,
                   
                    function (data) {  
                     if (data.state == 3) { 
                      swal({text:'请先登录'});
                     window.location.href = "${ctx}/user/fromuser!UserDetail.action?custid=${custid}";
                    }
                    if (data.state == 4) {
                     swal({text:'活动未开始'});
                    }
                    if(data.state==5){ 
                     swal({text:'活动已结束'});
                    }
                    if(data.state==9){  
                        swal({ 
                               text: "亲，您积分不足，您可以查看其它活动或者赚取积分！",
                               type: 'warning',
                               showCancelButton: true,
                               confirmButtonColor: '#3085d6',
                               cancelButtonColor: '#d33',
                               confirmButtonText: '去赚积分',
                               cancelButtonText: '稍后再说',
                               confirmButtonClass: 'btn btn-success mr-15',
                               cancelButtonClass: 'btn btn-danger ml-15',
                                   buttonsStyling: false
                             }).then(function () {
                                   window.location.href='${ctx}/suc/task!web.action?custid=${custid}&lscode=${lscode}';
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  
                                 }
                            }); 
                }
               
                if(data.state==7){ 
                   swal({ 
                               text:data.tsy,
                               type: 'warning',
                               showCancelButton: true,
                               confirmButtonColor: '#3085d6',
                               cancelButtonColor: '#d33',
                               confirmButtonText: '查看卡卷',
                               cancelButtonText: '稍后再说',
                               confirmButtonClass: 'btn btn-success mr-15',
                               cancelButtonClass: 'btn btn-danger ml-15',
                                   buttonsStyling: false
                             }).then(function () {
                                 window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
                                   
                            }, function (dismiss) {
                            window.location.href='${ctx}/suc/luckydraw!web.action?lucid=${entity._id}&custid=${custid}&lscode=${lscode}';
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  window.location.href='${ctx}/suc/luckydraw!web.action?lucid=${entity._id}&custid=${custid}&lscode=${lscode}';
                                 }
                            });
                  
                 return;
                }
                if(data.state==2){
                 swal({text:data.tsy});  
                }  
                if (data.state == 6) {
                    //未中奖  
                   if('${entity.jfxh}'>0){
                         noty({text:"消耗"+'${entity.jfxh}'+"积分",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                            $('#re_img').attr("src",'${filehttp}'+data.headimgurl);
                            $('#re_txt').html(data.nickname+"<br/>谢谢参与！");
                        } // 关闭之后
                       },}); 
                     }else{
                          $('#re_img').attr("src",'${filehttp}'+data.headimgurl);
                            $('#re_txt').html(data.nickname+"<br/>谢谢参与！");
                     } 
                     audio_match.play();
                     setTimeout(function(){ 
					loading.className = "";
					result.className = "result-in";
				   },600);
				  
				       
                }
                if (data.state == 0) {
                     if('${entity.jfxh}'>0){
                         noty({text:"消耗"+'${entity.jfxh}'+"积分",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                            $('#re_img').attr("src",'${filehttp}'+data.headimgurl);
                            $('#re_txt').html(data.nickname+"<br/>恭喜您获得："+data.text);
                        } // 关闭之后
                       },}); 
                     }else{
                          $('#re_img').attr("src",'${filehttp}'+data.headimgurl);
                            $('#re_txt').html(data.nickname+"<br/>恭喜您获得："+data.text);
                     }
                     audio_match.play();
                     setTimeout(function(){ 
					loading.className = "";
					result.className = "result-in";
					
					
				},600);
				if(data.text.indexOf('积分')>0){
					 	    swal({ 
                                       text:data.nickname+"<br/>恭喜您获得："+data.text,
                                       type: 'success',
                                       allowOutsideClick: false,
                                       showCancelButton: true,
                                       confirmButtonColor: '#3085d6',
                                       cancelButtonColor: '#d33',
                                       confirmButtonText: '积分商城',
                                       cancelButtonText: '稍后再说',
                                       confirmButtonClass: 'btn btn-success mr-15',
                                       cancelButtonClass: 'btn btn-danger ml-15',
                                       buttonsStyling: false
                                     }).then(function () {
                                          loadjfsc();
                                   
                                          }, function (dismiss) { 
                                            window.location.href='${ctx}/suc/luckydraw!web.action?lucid=${entity._id}&custid=${custid}&lscode=${lscode}';
                                          
                                        if (dismiss === 'cancel') {
                                               window.location.href='${ctx}/suc/luckydraw!web.action?lucid=${entity._id}&custid=${custid}&lscode=${lscode}';
                                          }
                                    });
					  
					}
                 
                } 
                isdraw=true;   
                        
              }, "json");
     
		 } 
		  function   loadjfsc(){ 
         var submitData = { 
	            };  
       $.post('${ctx}/shop/shop!checkJfsc.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        	 function(json){ 
        	  if(json.state==0){  
        	     window.location.href='${ctx}/shop/shop!index.action?custid=${custid}&agid=${agid}&lscode={lscode}&comid='+json.value;
        	  }else{
        	       noty({text: "尊敬的用户！暂时没有找到已经开通的积分商城！！",type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() { 
                                              } // 关闭之后
                                            },});
        	  }
        	 },"json");
    }
		</script>
	</head>
	<body>
	<div style="position: fixed;width:100%;font-weight:900;top:0px;left:0px;z-index: 100;color: #ffffff;">
     <font size="2">
        <div style="padding: 10px 10px 10px 10px;">
            <div style="float: left;">参与人数：${reading}</div>
            <div style="float: right;">剩余奖品：${recount}</div>
        </div>
     </font>
    </div>
    <div style="position: fixed;width:100%;font-weight:900;bottom:10px;right:10px;z-index: 100;">
    <font size="2"> 
            <div style="float: right;color:#ffffff;" onclick="hdxq_show()">活动详情</div>   
    </font>
    </div>
    <div class="display-none " style=" position: fixed;top:80px; height:25px;width:160px;left:10px;  background-color: rgba(30, 30, 30, 0.5);border-radius: 50px;z-index:10;" id="gd">
    <div id="gd_img" style="float: left;background-image: url(http://www.pskjyf.com/uploads//logo_ocSuuwTyK4CA-28eZmkfjgwrXrs8.jpg);width:25px;height:25px; border-radius: 50%; background-size: cover;background-position: 80% 80%;background-repeat: no-repeat;"></div>
    <div id="gd_txt" style="float: left; width:130px;line-height: 22px;color: #ffffff;white-space: nowrap;text-overflow: ellipsis;overflow:hidden;padding-left:5px;text-align: center;"><font size="1">张三李四在1分钟前获得了100积分</font></div>
    </div>
		<div id="bg-flower">
			<audio preload="auto" id="audio_male" src="${ctx}/mvccol/shake/audio/male.mp3"></audio>
			<audio preload="auto" id="audio_match" src="${ctx}/mvccol/shake/audio/match.mp3"></audio>
			<audio preload="auto" id="audio_nomatch" src="${ctx}/mvccol/shake/audio/nomatch.mp3"></audio>
		</div>
		<section id="handsome">
			<div></div>
			<div>
				<b id="loading">正在进行奖品匹配...</b>
			</div>
		</section>
		<section>
			<dl id="result"style="color:#ffffff">
				<dt>
					<img width="100%" id="re_img">
				</dt>
				<dd id="re_txt"></dd>
			</dl>
		</section>
		<ul id="footer"style="position: relative;background-color: beige">
			<li style="position: absolute;left:25%;top:-70px;width:50%;height:50px;background-color: #f84a2e;border:solid 3px #ffce0c;border-radius: 100px;line-height: 50px;text-align: center;color: #ffffff;font-weight: 900;">
				点击抢红包
			</li> 
		</ul>
		
<script src="${ctx}/mvccol/shake/js/index.js"></script>
		<script>
		var gdlist;
		getluckytj();
			footer.addEventListener("click",function(e){
				var li = e.target;
				if("LI"===li.tagName){ 
					onShake();
					var lis = footer.getElementsByTagName("li");
					for(var n=0,len=lis.length;n<len;n++){
						lis[n].setAttribute("class","");
					}
					li.setAttribute("class","active");
				}
			});
			function animationend(e){
				var div = e.target;
				div.className = "";
				loading.className = "active";
				result.className = "";
				draw();
				//setTimeout(function(){
				    
				//	audio_match.play();
				//	loading.className = "";
				//	result.className = "result-in";
				//},1200);
			}
			handsome.addEventListener("animationend",animationend);
			handsome.addEventListener("webkitAnimationEnd",animationend);

			var hands = handsome.getElementsByTagName("div");
			function onShake(){ 
				if(hands[1].className){
					return;
				} 
				 if(result.className=="result-in"){ 
					result.className = "result-out";  
				 };
				 audio_male.play(); 
				 setTimeout(function(){
				 hands[0].setAttribute("class","hand-up");
				 hands[1].className = "hand-down";
				},600);
				
				
				
			}
			ShakeHandler(onShake,2500);
			function gd(){ 
			var num=parseInt(10*Math.random());
			if(gdlist.length>0){
			$('#gd_img').css("background-image","url(${filehttp}"+gdlist[num].headimgurl+")");
			$('#gd_txt').html('<font size="1">'+gdlist[num].nickname+'在'+gdlist[num].insDate+'获得'+gdlist[num].jp+'</font>');
			}
			$('#gd').show();
			 setTimeout(function(){
				$('#gd').hide();
				},2000);
			}
			
			function  getluckytj(){
			     var submitData = { 
            };
            $.post('${ctx}/suc/luckydraw!ajaxluckytj.action?hdid=${entity._id}&custid=${custid}&lscode=${lscode}', submitData, function(json) {
                if(json.state==0){
                  gdlist=json.list;
                  gd();
                }
                
            }, "json");
            
			}
			 setInterval(function(){
			       gd();
			      },3000);
		</script>		
		<script> 
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) { 
            
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
  <%@ include file="/webcom/focus-page2.jsp" %> 
 </c:if>
</c:if>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if> 

<div class="fullscreen bg-hei-5 cmp640 display-none" style="height: 100%;" id="hdxq_tanchu">
    <div style="padding-top:20%">
        <div class="pl-15 pr-15 pb-20 maring-a bg-bai border-radius5 position-r width-8"style="height: 400px;">
            <div class="hang40 line-height40 txt-c weight500 zi-hei size12">
                活动详情
            </div>

            <div class="clear div-group-10 border-radius5 weight500 line-height25 zi-bai size12 overflow-auto bg-cheng img-100"style="height: 340px;">
              ${entity.context}
            </div>
  
            <a href="javascript:hdxq_hide()">
                <div class="position-a" style="right:-7px;top:-7px;">
                    <div class="img-wh20 line-height20 border-radius50 bg-hei-8 txt-c">
                        <font size="2">
                            <i class="fa fa-remove zi-bai line-height20"></i>
                        </font>
                    </div>
                </div>
            </a>


        </div>

    </div>
</div>
<script type="text/javascript">
function hdxq_show(){
  $('#hdxq_tanchu').show();
}
function hdxq_hide(){
  $('#hdxq_tanchu').hide();
}
</script>
</body>
</html>
