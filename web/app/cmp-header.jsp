<%@ page contentType="text/html;charset=UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<header class="bg-lu hang40 txt-c cmp640">
	<a href="javascript:go_back();" class="pull-left pl-10 "style="position: absolute;left: 5px"><p class="fa fa-chevron-left mr-10"></p>返回</a>
	<c:if test="${not empty bqsel}">
	<a href="javascript:xz_title();" class="pull-right zi-bai size14" style="position: absolute;right:50px"><i class="fa ${bqsel.marker } mr-5"></i>${bqsel.title }</a>
   	</c:if>
   	<span class="size16 zi-bai sl" >${fn:substring(title,0,10)}</span>
   
    <a id="cd-menu-trigger" href=" "><span class="cd-menu-text "></span><span class="cd-menu-icon"></span></a>
</header>

<nav id="cd-lateral-nav">

    <ul class="cd-navigation cd-single-item-wrapper">
    	<c:forEach items="${list}" var="bean">
    	
        	<c:if test="${empty bean.xs||bean.xs==1||bean.xs==0}">
        	<li><a href="${ctx }/wwz/wwz!${bean.type}.action?type=${bean.key}&toUser=${bean.toUser}">${bean.name}</a></li>
        	</c:if>
        </c:forEach>
       
    </ul> 
</nav>
<script type="text/javascript">
	function go_back(){
		
		history.go(-1);
	}
</script>