<%@ page contentType="text/html;charset=UTF-8"%>
<div class="cmp txt-c">
	<c:if test="${not empty logo}">
    <a href="#">${logo } </a>
    </c:if>
    <c:if test="${empty logo }">
    <a href="#"><img src="${ctx }/app/img/head-foot.png" style="width: 30%"><br>中天科技</a>
    </c:if>
</div>
<div class=" hang50 mt-10"></div>