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
<script type="text/javascript">

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
 

 </script>

 
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/shop/shopstatistical.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>订单统计</h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
       
        	<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            
            <ul class="dropdown-menu pull-right" role="menu">
           
            	<li><a href="#"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;导出</a></li>
            
            </ul>
         
         </div>
      </div>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            
            <div class="form-group col-sm-1d">
            <input type="text" name="name"  value="${name }" placeholder="姓名"  class="form-control" />
            </div> 
            <div class="form-group col-sm-1d">
            <input type="text" name="tel"  value="${tel }" placeholder="电话"  class="form-control" />
            </div> 
            <div class="form-group col-sm-1d">
            <input type="text" name="no"  value="${no }" placeholder="代码"  class="form-control" />
            </div> 
            <a href="javascript:page_submit(-1);" class="btn btn-success">搜&nbsp;&nbsp;索</a>

        </div>
    </div><!-- panel-body -->
	</div><!-- panel -->

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-success mb30" >
                    <thead>
                      <tr>
                       
                        
				        <th class="th8">姓名</th>
						<th class="th4">电话</th>
						<th class="th6">地址</th> 
                        <th class="th6">数量</th>
                         
						
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${OrderFormList}" var="bean">
                      <tr>
                       
                      	 
						<td>${bean.name}</td>
						<td>${bean.tel}</td>	
						<td title="${bean.address}"><div class="th6 sl">${bean.address}</div></td> 
                        <td>${bean.ordercount}</td>
                       
					
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                          <li><a href="${contextPath}/wx/wxuser!detail.action?_id=${bean.fromUser}">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;用户信息</a></li>
                                     
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
