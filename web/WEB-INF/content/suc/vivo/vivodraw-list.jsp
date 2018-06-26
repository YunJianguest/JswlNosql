<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html> 
<html> 
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
	<title>排行榜</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/app/vivo/css/vv.css" >
	<script src="${ctx}/app/vivo/js/jquery-1.8.3.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/jquery.rotate.min.js"></script>
	<script type="text/javascript" src="${ctx}/app/vivo/js/easySlider.js"></script>
	<style type="text/css">
	html,body{width:100%;height:100%;}
	.chartslists li span{ 
		margin-right 5px;
		text-align: left;
		padding: 0 0.2rem;
		display:inline-block;
		overflow: hidden;
	    height: 14px;
	    font-size: 12px!important;
	}
	 .fir{width:8%;}
	.sen{width:15%;}
	.thre{width:16%;}
	.four{width:12%;}
    .fiv{
		width:5%;
		background: url("../../images/football.png") no-repeat 76% top;
		height: 2rem;
    	background-size: 0.8rem auto;
	} 
	.chartslists li{
		margin: 0 auto;
	}
	
	</style>
</head>

<body>
	<div class="charts">
		<div class="logo" ><img src="${ctx}/app/vivo/images/logo.png"/></div>
		<div class="chartslists" >
			<h1>你的当前排行<font><c:if test="${not empty entity}">${entity.ranking}</c:if><c:if test="${empty entity}">未上榜</c:if></font></h1>
			<div style="height: 300px;overflow: scroll;">
			<ul>
			 <c:forEach items="${list}" var="bean">
			 <li><span class="fir">${bean.ranking}</span><span class="sen">${bean.nickname}</span><span class="thre">${bean.address}</span><span class="four">${bean.count}张</span><span class="fiv"></span></li>
			 </c:forEach> 
			</ul>
			</div>
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
</body>
</html>