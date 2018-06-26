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
        <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
        
             <ul class="nav" id="side-menu">
             
                 <li class="nav-header">
                      <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" style="width: 65px" src="${ctx }/bracket/images/photos/loggeduser.png"/></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#"> 
                                 <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold"><%=custName%></strong></span>
                                <span class="text-muted text-xs block">超级管理员<b class="caret"></b></span>
                                </span> 
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                 
                               <!--  <li class="divider"></li> -->
                                <li><a href="${contextPath}/j_spring_security_logout">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <div class="logo-element">YL
                        </div>
                    </li>
               <%
            	for (int i=0;i<modules.size();i++){
			    FuncInfo module = (FuncInfo)modules.get(i);	
			   if(module.getUrl().equals("#")){
	        	%>
	          	<security:authorize ifAllGranted="<%=module.getAuthName() %>">
                    <li>
                        <a href="#">
                            <i class="fa <%=module.getLogo() %>"></i>
                            <span class="nav-label"><%=module.getName()%></span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                           <%
      		               for (int j=0;j<module.getTfunc().size();j++){
				            FuncInfo module2 = (FuncInfo)module.getTfunc().get(j);	
				
	  		              %>
	  		             <security:authorize ifAllGranted="<%=module2.getAuthName() %>">
	  		             <% 
	  		             if(module2.getUrl().replace("**","").contains("?")){
	  		             %>
                            <li>
                                <a  href="${ctx}<%=module2.getUrl().replace("**","") %>&cate_id=<%=module2.get_id().toString() %>" data-index="0"><%=module2.getName()%></a>
                            </li>
                         <% 
	  		              }else{
	  		            %>
	  		             <li>
                                <a  href="${ctx}<%=module2.getUrl().replace("**","") %>?cate_id=<%=module2.get_id().toString() %>" data-index="0"><%=module2.getName()%></a>
                         </li>
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
			        } 
		          }
		        %>
                </ul>
            </div>
      </nav>
     <!--左侧导航结束--> 
  <script>
   
</script>
 
