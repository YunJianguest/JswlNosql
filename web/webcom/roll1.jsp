<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<link rel="stylesheet" href="${ctx}/mvccol/liMarquee/css/liMarquee.css">
<script src="${ctx}/mvccol/liMarquee/js/jquery.liMarquee.js"></script>
<style>
.dowebok { width:100%; margin: 0px auto; font-size: 14px;}
.dowebok a { margin: 0 15px; color: #333; text-decoration: none;}
.dowebok a:hover { text-decoration: underline;}
</style>
<div class="dowebok">
 <c:forEach items="${roll}" var="bean">
   <c:if test="${not empty bean.url}">
   <a href="${bean.url}">${bean.title}</a>
   </c:if>
   <c:if test="${empty bean.url}">
   <a href="javascript:void(0);">${bean.title}</a>
   </c:if> 
 </c:forEach>  
</div>
<script>
$(function(){
	$('.dowebok').liMarquee(
	{
        scrollamount: 30,
        hoverstop: false
    }
	);
});
</script>