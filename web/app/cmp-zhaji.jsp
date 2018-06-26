<%@ page contentType="text/html;charset=UTF-8"%>
<header>
    <a href="javascript:history.go(-1);" class="left back"></a>
    <h1 class="title">${title }</h1>
    <a id="cd-menu-trigger" href="#0"><span class="cd-menu-text"></span><span class="cd-menu-icon"></span></a>
</header>

<nav id="cd-lateral-nav">

    <ul class="cd-navigation cd-single-item-wrapper">
    	<c:forEach items="${list}" var="bean">
    		<c:if test="${bean.type=='link'}">
        	<li><a  href="${bean.url}">${bean.name}</a></li>
        	</c:if>
        	<c:if test="${bean.type!='link'}">
        	<li><a href="${ctx }/wwz/wwz!${bean.type}.action?type=${bean.key}&toUser=${bean.toUser}">${bean.name}</a></li>
        	</c:if>
        </c:forEach>
       
    </ul> 
</nav>