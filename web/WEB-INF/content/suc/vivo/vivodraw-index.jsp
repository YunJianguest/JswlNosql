<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html> 
<html> 
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
	<title>首页</title>
	<!--必选css-->
	<link rel="stylesheet" type="text/css" href="${ctx}/app/vivo/css/vv.css" >
	<script src="${ctx}/app/vivo/js/jquery-1.8.3.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/jquery.rotate.min.js"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/easySlider.js"></script>
	<style type="text/css">
	.sendtel{
	width: 12rem;
    margin: 0 auto; 
    height: 1.5rem;
    margin-top: 15px;
	}
	.sendtel input{
	    width: 80%;
    float: left;
    border: none;
    margin-top: 0px;
	}
	</style>
</head>
<body>
<div class="mask opacity" id="mask" > </div>
<div class="zxxcontent2" id="zxxcontent2" >

	<div class="hbcont" >
		<a href="javascript:;" id="close2" class="close2">
			<img src="${ctx}/app/vivo/images/close.png"/>
		</a> 
		<h1>请输入您的手机号<br/>进行身份验证登陆</h1>
		<div class="sendtel">
		<input id="tel" type="text"  placeholder="手机号"/>
		</div>
		<div class="chekcont">
			<input id="yzcode" type="text" placeholder="验证码"/>
			<span onclick="sendsms()">获取</span>
			<div class="clear"></div>
		</div>
		<div class="loagcont" onclick="login()">
		<button>登陆</button>
		</div>
		 
	</div>
</div>

<div class="zxxcontent2" id="zxxcontent3" style="background: none;">

	<div class="hbcont hbcont2" >
		<a href="javascript:;" id="close3" class="close2">
			<img src="${ctx}/app/vivo/images/close.png"/>
		</a>
		<h1>恭喜你！<br/>获得<span id="hb">0元红包</span>一个</h1>
		<div class="chekcont">
			<img src="${ctx}/app/vivo/images/hbbg.png"/>
		</div>
		<h1 class="tip">请在微信服务通知中查收此红包</h1>

	</div>
</div>


	<div class="banner">
		<div>
			<div id="slider">
				<ul class="slides">
				  <c:forEach items="${slide}" var="bean">
				  <li><img src="${filehttp}/${bean.picurl}"/></li>
				  </c:forEach>  	
				</ul>
				<ul class="pagination">
					<li class="active"></li>
					<li></li>

				</ul>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="g-lottery-case">
			<div class="g-left">
				<div class="g-lottery-box">
					<div class="g-lottery-img">
						<a class="playbtn" href="javascript:;" title="开始抽奖"></a>
					</div>
				</div>
			</div>
			
			<div class="clickbg">
				<a href="${ctx}/suc/vivo/vivodraw!cardpackage.action?lscode=${lscode}&custid=${custid}&lucid=${lucid}"><img src="${ctx}/app/vivo/images/clickbg.png"/></a>
			</div>
		</div>
		<div>
			<ul style="padding-top: 2%;">
				<li>
					<img src="${ctx}/app/vivo/images/card1.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card2.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card3.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card4.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card5.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card6.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card7.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card8.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card9.png"/>
				</li>

				<li>
					<img src="${ctx}/app/vivo/images/card10.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card11.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card12.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card13.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card14.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card15.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card16.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card17.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card18.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card19.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card20.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card21.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card22.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card23.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card24.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card25.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card26.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card27.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card28.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card29.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card30.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card31.png"/>
				</li>
				<li>
					<img src="${ctx}/app/vivo/images/card32.png"/>
				</li>

				<div class="clear"></div>
			</ul>
		</div>
	</div>
	<div class="bmenu">
	<ul>
		<li data-num="1" >
			<a href="${ctx}/suc/vivo/vivodraw!index.action?lscode=${lscode}&custid=${custid}&lucid=${lucid}" >
				<img src="${ctx}/app/vivo/images/hover1.png"/>
			</a>
		</li>
		<li data-num="2">
			<a href="${ctx}/suc/vivo/vivodraw!cardpackage.action?lscode=${lscode}&custid=${custid}&lucid=${lucid}">
				<img src="${ctx}/app/vivo/images/hover2.png"/>
			</a>
		</li>
		<li data-num="3">
			<a href="${ctx}/suc/vivo/vivodraw!rules.action?lscode=${lscode}&custid=${custid}&lucid=${lucid}">
				<img src="${ctx}/app/vivo/images/hover3.png"/>
			</a>
		</li>
		<li data-num="4">
			<a href="${ctx}/suc/vivo/vivodraw!list.action?lscode=${lscode}&custid=${custid}&lucid=${lucid}">
				<img src="${ctx}/app/vivo/images/hover4.png"/>
			</a>
		</li>
	</ul>
</div>

<script>
	$(function(){
        //轮播图
        $("#slider").easySlider( {
            slideSpeed: 500,
            autoSlide: true,
            paginationSpacing: "15px",
            paginationDiameter: "10px",
            paginationPositionFromBottom: "0px",
            slidesClass: ".slides",
            controlsClass: ".controls",
            paginationClass: ".pagination"
        });
    
	});
</script>
<script>
		$(function() {
			var $btn = $('.playbtn'); 
			var tsy='';
			var dat=0;
			$('.playnum').html("${playnum}");
			var isture = 0;
			var clickfunc = function() { 
				switch(dat) {
					case 1:
						rotateFunc(1, 0, tsy);
						break;
					case 2:
						rotateFunc(2, 60, tsy);
						break;
					case 3:
						rotateFunc(3, 120,tsy);
						break;
					case 4:
						rotateFunc(4, 180,tsy);
						break;
					case 5:
						rotateFunc(5, 240,tsy);
						break;
					case 6:
						rotateFunc(6, 300,tsy);
						break;
					case 7:
						rotateFunc(7, 360,tsy);
						break;
				}
			 	
			}
			$btn.click(function() {
				if(isture) return; // 如果在执行就退出
				isture = true; // 标志为 在执行
				var submitData={
					lucid:'${lucid}',
				}
				  $.post('${ctx}/suc/vivo/vivodraw!drawbox.action?lscode=${lscode}&custid=${custid}', submitData,
				        	 function(json){ 
				        	  if(json.state==0){  
				        		  tsy=json.text;
				        		  dat=(json.no+1); 
				        		  clickfunc();
				        		  isture =false; 
				        	  }else if(json.state==3){
				        		  //未登录
				        		  alert("请登录");
				        		  isture =false; 
				        	  }else if(json.state==5){
				        		  //已结束
				        		  alert("已结束");
				        		  isture =false; 
				        	  }else if(json.state==4){
				        		  //未开始
				        		  alert("未开始");
				        		  isture =false; 
				        	  }else if(json.state==2){
				        		  //没有次数
				        		  alert("没有次数");
				        		  isture =false; 
				        	  }else if(json.state==6){
				        		  tsy="谢谢参与，请再接再厉！";
				        		  dat=7; 
				        		  clickfunc(); 
				        	  }
				        	 },"json");
			   
			});
			var rotateFunc = function(awards, angle, text) {
				isture = true;
				$btn.stopRotate();
				$btn.rotate({
					angle: 0,
					duration: 4000, //旋转时间
					animateTo: angle + 1440, //让它根据得出来的结果加上1440度旋转
					callback: function() {
						isture = false; // 标志为 执行完毕
						if(awards<7){
							$('#hb').html(tsy);
							$('#zxxcontent3').show();
				      		$('#mask').show();
						}else{
							alert(tsy);
						}
						
					}
				});
				
			};
		});
		
		function sendsms(){ 
			 var submitData={
					 tel:$('#tel').val(),
			 }
			 $.post('${ctx}//suc/vivo/vivodraw!createTelCode.action?lscode=${lscode}&custid=${custid}', submitData,
		        	 function(json){
		        	  if(json.state==0){ 
		        		  alert("验证码已经发送！");
		        	  }else{
		        		  alert("发送失败！");
		        	  }  
		        	 },"json");
		};
		
		function login(){
			 var submitData={
					 tel:$('#tel').val(),
					 yzcode:$('#yzcode').val(),
			 }
			 $.post('${ctx}//suc/vivo/vivodraw!weblogin.action?lscode=${lscode}&custid=${custid}', submitData,
		        	 function(json){
		        	  if(json.state==0){ 
		        		  alert("登录成功！");
		        		  window.location.reload();
		        	  }else{
		        		  alert("登录失败！");
		        	  } 
		        	 },"json");
		}
	</script> 
<script type="text/javascript">
    var vivo='${vivo_user}';
    console.log('vivo','${vivo_user.tel}');
    if(vivo==""){ 
    	$(function () {
    		document.getElementsByTagName('body').height="100%";
    		$("body").css("overflow","hidden");
    		$('#close2').click(function () {
    			$('#mask').hide();
    			$('#zxxcontent2').hide();
    			document.getElementsByTagName('body').height="auto";
    			$("body").css("overflow","visible");
    		})
    		
    	});
    	document.getElementById("mask").style.display = "block";
    	document.getElementById("zxxcontent2").style.display = "block";
    }
    $('#close3').click(function () {
		$('#mask').hide();
		$('#zxxcontent3').hide();
		document.getElementsByTagName('body').height="auto";
		$("body").css("overflow","visible");
	})
</script>
</body>
</html>