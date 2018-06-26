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
<script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
<link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css" />
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
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/set/comboorder.action?" >
    <div class="pageheader">
      <h2><i class="fa fa-user"></i>系统配置<span>系统订单</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
            <div class="input-group ">
                <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                    <a href="javascript:add();"style="color: #ffffff;line-height:25px;">
                        新增&nbsp;<i class="fa fa-plus"style="line-height:30px;font-size: 14px;"></i>
                    </a>
                </div>
            </div>
         </div>
      </div>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            <div class="form-group col-sm-1d">
                <input type="text" name="title"  value="${title}" placeholder="名称"  class="form-control" />
            </div> 
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
        </div>
    </div>
	</div>
    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary table-action mb30" >
                    <thead>
                      <tr>
                      	<th class="th1 table-action">标题</th>
                      	<th class="th1 table-action">订单编号</th>
                      	<th class="th1 table-action">金额</th>
                      	<th class="th1 table-action">状态</th> 
						<th class="th5 table-action">下单时间</th>
						<th class="th5 table-action">支付时间</th>
				 		<th class="th5 table-action">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${list}" var="bean">
                      <tr>  
						<td>${bean.summary}</td>
						<td>${bean._id}</td> 
						<td><fmt:formatNumber value='${bean.price}' pattern="0.0#"/></td> 
						<td><c:if test="${bean.state==2}">已支付</c:if>
						<c:if test="${bean.state==1}">未支付</c:if></td> 
					  
						<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td> 
						<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.paydate}'/></td> 
				        <td class="table-action">
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      
                                       
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
    </div>
	</form>
  </div>
</section>

 
</body>
 
</html>
