<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html> 
<html> 
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
	<title>卡包</title>
	<!--必选css-->
	<link rel="stylesheet" type="text/css" href="${ctx}/app/vivo/css/vv.css" >
	<script src="${ctx}/app/vivo/js/jquery-1.8.3.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/jquery.rotate.min.js"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/easySlider.js"></script>
	<style>
		#cards{
			background:#fff;
			padding:30px 5px 10px 5px;
		}
		.content ul li{ 
			width:25%;
			text-align:center; 
			position:relative;
			
		}
		.content ul li img{
			height:100px;
			width:90%;
			display: inline;
		}
		.content ul li span{
			padding: 4px;
	    	border-radius: 50%;
	    	background: #fff;
	    	position: absolute;
	    	top: -5px;
	    	right: -3px;
    	}
	</style>
	<script type="text/javascript">
	
	function op(){
		$('#zj').show();
	}
	function zp(){
		$('#zj').hide();
	}
	</script>
</head>
<body>
<div class="mask opacity" id="mask" > </div>
<div class="zxxcontent2" id="zxxcontent2" style="background: none;">

	<div class="hbcont hbcont2" >
		<a href="javascript:;" id="close2" class="close2">
			<img src="${ctx}/app/vivo/images/close.png"/>
		</a>
		<h1>恭喜你！<br/>获得一张奖卡</h1>
		<div class="chekcont" style="height: auto; text-align: center; width: 153px;">
			<img id="lscard" src="images/card1.png" height="272px" width="153px"/>
		</div>
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
			<div class="hbcont hbcont3"   >
					<div class="chekcont">
						<input id="djcode" type="text" placeholder="请输入串码"/>
						<span onclick="dhcard()">兑换</span>
						<div class="clear"></div>
					</div>
			</div>
		</div>

		<div class="cardcount">
			<div class="touxiang" style="top:-1rem;">
				<img src="${filehttp}/${user.headimgurl}"/><span style="top:-1rem;">${user.nickname}的卡包</span>
			</div>
			<ul id="cards">
			    <c:forEach items="${nelist}" var="bean">
			       <li>
					<img src="${filehttp}/${bean.card.logo}"/>
					<span>${bean.lx}</span>
				   </li> 
			    </c:forEach> 
				<div class="clear"></div>
			</ul>

		</div>
		<c:if test="${isdj==0}">
		<div class="hbcont hbcont4" >
			<h2>您已集齐所有额球队卡</h2>
			<span onclick="op()">开启非凡时刻</span>
		</div>
		</c:if>
		
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
<div class="mask" style="background-color: black;" id="zj" onclick="zp()">
<img alt="" width="100%" height="100%" src="${ctx}/app/vivo/images/zjt.jpg">
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
	var bl=true;
	function dhcard(){ 
		if(!bl){
			return;
		}
		bl=false;
		 var submitData={ 
				 djcode:$('#djcode').val(),
		 }
		 $.post('${ctx}//suc/vivo/vivodraw!drawcard.action?lscode=${lscode}&custid=${custid}&lucid=${lucid}', submitData,
	        	 function(json){
			      bl=true;
	        	  if(json.state==0){  
	        		  $('#lscard').attr("src","${filehttp}/"+json.cardimg); 
	        		  $('#zxxcontent2').show();
	        		  $('#mask').show();
	        	  }else if(json.state==3){
	        		  alert("兑换失败，未登录！"); 
	        	  }else if(json.state==4){
	        		  alert("兑换失败，未开始！"); 
	        	  }else if(json.state==5){
	        		  alert("兑换失败，已结束！"); 
	        	  }else if(json.state==9){
	        		  alert("兑换失败，串码已经被使用！"); 
	        	  }else if(json.state==10){
	        		  alert("兑换失败，串码不存在！"); 
	        	  }else{
	        		  alert("系统忙,请稍候！"); 
	        	  }  
	        	  
	        	 },"json");
	}
	$('#close2').click(function () {
		$('.mask').hide();
		$('.zxxcontent2').hide();
		 
	})
</script>
 
</body>
</html>