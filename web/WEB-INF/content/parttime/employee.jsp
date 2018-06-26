<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/media/js/DT_bootstrap.js"></script>
<script type="text/javascript" src="${ctx}/mvccol/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/mvccol/js/fomatdate2.js"></script>
<script type="text/javascript">

function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/parttime/employee!delete.action?_id="
				+ id+"&fypage=${fypage}";
	}
}  
function page_submit(num){
	
	if(num==-1){
		$("#fypage").val(0);	
	}else if(num==-2){
		$("#fypage").val($("#fypage").val()-1);	
	}else{
		$("#fypage").val(num);	
	}

	$("#custinfoForm").submit();
}
 
function set(id){
	   var submitData = {
	    id : id
	  };
	  $.post('${ctx}/parttime/employee!ajaxSetAdmin.action', submitData, function(json) { 
	  
		  if(json.state==0){
			  alert("设置成功！");
			  window.location.reload();
		  }else{
			  alert("设置失败！"); 
		  }
	  }, "json") 
	}
function setCj(id){
	   var submitData = {
	    id : id
	  };
	  $.post('${ctx}/parttime/employee!ajaxSetCjAdmin.action', submitData, function(json) { 
	  
		  if(json.state==0){
			  alert("设置成功！");
			  window.location.reload();
		  }else{
			  alert("设置失败！"); 
		  }
	  }, "json") 
	}
function cal(id){
	   var submitData = {
	    id : id
	  };
	  $.post('${ctx}/parttime/employee!ajaxCancelAdmin.action', submitData, function(json) { 
		  if(json.state==0){
			  alert("设置成功！");
			  window.location.reload();
		  }else{
			  alert("设置失败！"); 
		  }
	  }, "json") 
	}
 </script>

 
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/parttime/employee.action?" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>劳务管理</h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
           
         </div>
      </div>
       
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
       
    </div><!-- panel-body -->
	</div><!-- panel -->

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-primary">
                <table class="table table-striped table-primary mb30" >
                    <thead>
                      <tr> 
                       	<th class="th5">姓名</th>
                       	<th class="th5">电话</th> 
                       	<th class="th5">身份状态</th> 
                        <th class="th6">日期</th>
                         
						
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${list}" var="bean">
                      <tr>  
                        <td>${bean.name}</td> 
                        <td>${bean.tel}</td> 
                        <td><c:if test="${bean.type==0}">普通用户</c:if>
                        <c:if test="${bean.type==1}">普通管理员</c:if> 
                        <c:if test="${bean.type==2}">超级管理员</c:if></td> 
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bean.createdate}" /></td>
                         
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                   <li><a href="javascript:setCj('${bean._id}')"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;设置超级管理员</a>
								   </li>
                                   <li><a href="javascript:set('${bean._id}')"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;设置普通管理员</a>
								   </li>
								   <li><a href="javascript:cal('${bean._id}')"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;取消管理员</a>
								   </li> 
								   <li><a href="javascript:del('${bean._id}')"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
								   </li> 
                                    
                                  </ul>
                              </div>
                          </td>
                      </tr>
                      </c:forEach>
 
                </table>
                <%@include file="/webcom/bracket-page.jsp"%>
                
            </div>
        </div>
      </div>
		
    </div><!-- contentpanel -->
	</form>
  </div><!-- mainpanel -->
</section>
 
</body>
</html>
