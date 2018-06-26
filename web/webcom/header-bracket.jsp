<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.lsp.sys.security.CustomerUser,com.lsp.pub.util.SpringSecurityUtils,com.lsp.pub.entity.GetAllFunc
,com.lsp.pub.entity.FuncInfo,java.util.List" %>
<%@page import="org.springframework.web.filter.RequestContextFilter"%>
  
<%
    String custName = "";
    String toUser="";
    String wwzqx ="";
    CustomerUser cust =(CustomerUser)SpringSecurityUtils.getCurrentUser();
	if(cust!=null){
	custName=cust.getCustname(); 
	toUser=cust.getToUser();
	wwzqx=cust.getWwzqx();
	}
	
	List<FuncInfo> modules= GetAllFunc.getGetAllFunc(); 
	List<DBObject> wwzmod= GetAllFunc.wxFunc.get(toUser); 
	 

%>
<div class="leftpanel">

    <div class="logopanel"style="height: 50px;overflow: hidden;line-height: 50px;font-weight:font-weight:bold;;">
       <h4><span>&nbsp;管理平台</span></h4>
    </div><!-- logopanel -->

    <div class="leftpanelinner">

      <h5 class="sidebartitle"> </h5>
      
      <ul class="nav nav-pills nav-stacked nav-bracket">
      	<%
      	for (int i=0;i<modules.size();i++){
			FuncInfo module = (FuncInfo)modules.get(i);	
			if(module.getUrl().equals("#")){
	  	%>
	  	<security:authorize ifAllGranted="<%=module.getAuthName() %>">
        <li  class="nav-parent" id="cate_<%=module.get_id().toString() %>"><a href=""><i class="fa <%=module.getLogo() %>"></i> <span><%=module.getName()%></span></a>
  
        <ul class="children">
        	<%
      		for (int j=0;j<module.getTfunc().size();j++){
				FuncInfo module2 = (FuncInfo)module.getTfunc().get(j);	
				
	  		%>
	  		<security:authorize ifAllGranted="<%=module2.getAuthName() %>">
	  		<% 
	  		if(module2.getUrl().replace("**","").contains("?")){
	  		%>
	  		 <li id="cate_<%=module2.get_id().toString() %>"><a href="${ctx}<%=module2.getUrl().replace("**","") %>&cate_id=<%=module2.get_id().toString() %>"><i class="fa fa-caret-right"style="color: #666"></i> <%=module2.getName()%></a></li>
	  		
	  		<% 
	  		}else{
	  		%>
	  		 <li id="cate_<%=module2.get_id().toString() %>"><a href="${ctx}<%=module2.getUrl().replace("**","") %>?cate_id=<%=module2.get_id().toString() %>"><i class="fa fa-caret-right"style="color: #666"></i> <%=module2.getName()%></a></li>
	  		
	  		<% 
	  		
	  		}
	  		%> 
            </security:authorize>
            <% 
				} 
			%>
            
          </ul>
        </li>
        </security:authorize>
        <%  
			} else if(module.getStatus()!=2){
		%> 
		<security:authorize ifAllGranted="<%=module.getAuthName() %>">
		<%
		   if(module.getUrl().replace("**","").contains("?")){
		%>
		 <li class="nav-parent" id="cate_<%=module.get_id().toString() %>"><a href="${contextPath}<%=module.getUrl().replace("**","") %>#cate_id=<%=module.get_id().toString()%>"><i style="color: #666" class="fa <%=module.getLogo() %>"></i> <span><%=module.getName()%></span></a></li>
		   
		 <%
		   
		   }else{
		   
		   %>
		    <li class="nav-parent" id="cate_<%=module.get_id().toString() %>"><a href="${contextPath}<%=module.getUrl().replace("**","") %>?cate_id=<%=module.get_id().toString()%>"><i style="color: #666" class="fa <%=module.getLogo() %>"></i> <span><%=module.getName()%></span></a></li>
		   
		   <%
		   
		   }
		 %>
       
        </security:authorize>
			
        <% 
			} 
		}
		%>
	 
		 
      </ul>

    </div><!-- leftpanelinner -->
  </div><!-- leftpanel -->
  <script>
  $(function(){
	  var cate_id="${cate_id }";
		$("#cate_"+cate_id).addClass("active");
		$("#cate_"+cate_id).parent().css("display","block");
		
		$("#cate_"+cate_id.substring(0,2)).addClass("active");
    });
</script>
 
