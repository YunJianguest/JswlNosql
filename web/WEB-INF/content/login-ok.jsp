<%@ include file="/webcom/taglibs.jsp" %>
<%

String  nickname=(String)session.getAttribute("nickname");
session.setAttribute("nickname", nickname) ;
%>
<script type="text/javascript">
 
 window.location = '${contextPath}/user/user!main.action';
  
</script>