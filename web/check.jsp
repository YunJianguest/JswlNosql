<%@page import="com.mongodb.DBObject"%>
<%@page import="com.lsp.sys.security.CustomerUser,com.lsp.pub.util.SpringSecurityUtils,com.lsp.pub.entity.GetAllFunc
,com.lsp.pub.entity.FuncInfo,java.util.List" %>
<%@page import="org.springframework.web.filter.RequestContextFilter"%>
  
<%  
    CustomerUser cust =(CustomerUser)SpringSecurityUtils.getCurrentUser();
	if(cust!=null){
	 response.sendRedirect("index.action");
	}
	 
%>
 