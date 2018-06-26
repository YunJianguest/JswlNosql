<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<link href="${ctx }/cmp/css/cmp_js_yangshibiao.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script>
<script type="text/javascript">
 
function del(id) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/suc/integral!delete.action?_id="+ id;
	}		
}
function add(){
	$('#_id').val('');
	$('#title').val('');
	$('#summary').val('');
    $('#uploadresultFour').val('');
	$('#sort').val(0);
	$('#url').val('');
	 

	$('#insadd').modal({
			show : true
		});
}
function upd(id){
   var submitData = {
		id : id
	};
	$.post('${ctx}/suc/integral!upd.action', submitData, function(json) {
		$('#_id').val(json._id);
		$('#title').val(json.title);
		$('#summary').val(json.summary);
		$('#url').val(json.url);
		$('#sort').val(json.sort);
		$('#type').val(json.type);
		$('#uploadresultFour').val(json.picurl);
		

	}, "json")
	 

	$('#insadd').modal({
			show : true
		});
}
 
function updfx(type) {
	var submitData = {
		fxtype : type
	};
	$.post('${ctx}/weixin/sharefx!upd.action', submitData, function(json) {
		$('#fxtype').val(type);
		$('#fxtitle').val(json.fxtitle);
		$('#fxsummary').val(json.fxsummary);
		$('#oldurl').val(json.oldurl);
		$('#fxurl').val(json.fxurl);
		$('#type').val(json.type);
		$('#uploadresultFour').val(json.fximg);
		

	}, "json")
	$('#insfx').modal({
		show : true
	});

}
function savefx() {
	var submitData = {
		fxtype : $('#fxtype').val(),
		fxtitle : $('#fxtitle').val(),
		fxsummary : $('#fxsummary').val(),
		oldurl : $('#oldurl').val(),
		fxurl : $('#fxurl').val(),
		fximg : $('#uploadresultFour').val()
	};
	$.post('${ctx}/weixin/sharefx!ajaxsave.action', submitData, function(json) {
		window.location.href='${ctx}/whd/wxmatrix.action'; 
		

	}, "json")
	$('#inszc').modal({
		show : true
	});

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
function share(url) {
	window.open("${contextPath}/weixin/share.action?method="+ encodeURIComponent(url));
}
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/integral.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>系统管理 <span>积分管理</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li> 
            	 
            </ul>
         </div>
      </div>
    </div>
   

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-primary mb30" >
                    <thead>
                      <tr>
                        <th>序号</th>
                      	<th>类型</th>
                      	<th>状态</th>
                      	<th>时间</th>
                  		 
						<th>操作</th>
						
                      
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${integralList}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td>
                      	<td>${bean.type}</td>
                      	<c:if test="${bean.value}>0"><td><span style="color: red;">+${bean.value}</span></td>
                      	</c:if>
                      	<c:if test="${bean.value}<0"><td><span style="color:green;">-${bean.value}</span></td>
                      	</c:if>
                      	
                      	<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
					
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:upd('${bean._id}');">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;充值</a></li>
                                       
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
 
<div id="insadd" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-automobile"></i>添加内容
					</h4>
				</div>
				<div class="modal-body">
						<form id="inscxForm" action="${ctx }/suc/integral!save.action"
						class="form-horizontal" method="post" >
						<input type="hidden" id="_id" name="_id" />
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">充值积分: <span class="asterisk">*</span></label>
									<div class="col-sm-3"> 
										<input type="text" id="money" name="money" class="form-control" placeholder="请输入" />
									</div>
									 
									
								</div>
								 
								<div class="form-group">
									<label class="col-sm-2 control-label">说明: </label>
									<div class="col-sm-9">

										<input type="text" id="summary" name="summary" class="form-control" placeholder="请输入" />
									</div>

								</div>
							 
								<div class="form-group">
									<label class="col-sm-2 control-label">序号: </label>
									<div class="col-sm-9">

										<input type="text" id="sort" name="sort" class="form-control" placeholder="请输入" />
									</div>

								</div>
								 
							</div>
							<!-- panel-body -->

							<div class="panel-footer">
								<div class="row" >
									<div class="col-sm-9 col-sm-offset-3" onclick="savefx()">
										<button class="btn btn-success btn-block">提&nbsp;&nbsp;交</button>
									</div>
								</div>
							</div>

						</div>
						<!-- panel -->
					

                 </form>
				</div>
				<!-- row -->
			</div>
		</div>
	</div>
</body>
</html>
