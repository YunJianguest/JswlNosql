<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html> 
<html> 
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
	<title>页面标题</title>
	<!--必选css-->
	<link rel="stylesheet" type="text/css" href="${ctx}/app/vivo/css/vv.css" >
	<script src="${ctx}/app/vivo/js/jquery-1.8.3.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/jquery.rotate.min.js"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/easySlider.js"></script>
	<style type="text/css">
	html,body{width:100%;height:100%;} 
	</style>
</head>
<body>
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
<div style="width:100%;  height:60%;  background:#eee;padding: 5px">${entity.context}</div>
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
</body>
</html>