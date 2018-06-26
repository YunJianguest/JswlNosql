<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<script src="${ctx}/mvccol/liMarquee/js/xMarquee.js"></script>
<style>
.xMarquee{width:100%; margin:0px auto; overflow:hidden;}
.xMarquee ol{list-style-type:none; margin:0px; padding:0px; font-size:12px; width:100000%;}
.xMarquee ol li{float:left;}
.xMarquee ol li a{ color:#000; text-decoration:none; line-height:25px;}
.xMarquee ol li a:hover{ text-decoration:underline;}
</style>
<div class="xMarquee" id="x1">
 <ol>
 <c:forEach items="${roll}" var="bean">
   <c:if test="${not empty bean.url}">
   <li><a href="${bean.url}">${bean.title}</a></li>
   </c:if>
   <c:if test="${empty bean.url}">
   <li><a href="javascript:void(0);">${bean.title}</a></li>
   </c:if> 
 </c:forEach>  
 </ol>
</div>
<script>
$(function(){
	$('#x1').xMarquee();
});
</script>