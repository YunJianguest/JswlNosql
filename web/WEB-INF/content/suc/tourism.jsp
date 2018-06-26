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
		location.href = "${ctx}/suc/tourism!delete.action?_id="+ id;
	}		
}
function add(){
	location.href = "${ctx}/suc/tourism!input.action"; 
}
function upd(id){
	location.href = "${ctx}/suc/tourism!update.action?_id="+ id; 
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
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/tourism.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>素材管理 <span>旅游管理</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li> 
            	<li><a href="${contextPath}/news/advertisement.action?type=toursim"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;广告位</a></li>
            	<li><a href="javascript:share('${ctxurl }/suc/tourism!web.action?toUser=${toUser}');"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享预览</a></li>
            	<li><a href="${ctx}/suc/tourism!web.action?toUser=${toUser}" target="_blank"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享预览</a></li>
            	<li><a href="javascript:updfx('wxmatrix');"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享配置</a></li>
            </ul>
         </div>
      </div>
    </div>
   

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary mb30" >
                    <thead>
                      <tr>
                        <th>序号</th>
                      	<th>标题</th>
                      	<th>图片</th>
                      	<th>时间</th>
                  		 
						<th>操作</th>
						
                      
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${tourismList}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td>
                      	<td>${bean.title}</td>
                      	<td><img src="${bean.picurl}" height="25px"/></td>
                      	<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.insdate}'/></td>
					
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:upd('${bean._id}');">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="javascript:del('${bean._id}');">
                                      		<i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                       
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
 
<div id="insfx" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-automobile"></i> 维护分享说明
					</h4>
				</div>
				<div class="modal-body">
					
						<input type="hidden" id="_id" name="_id" />
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
									<div class="col-sm-3">

										<input type="text" id="fxtitle" name="fxtitle" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-2 control-label">类型: <span class="asterisk">*</span></label>
									<div class="col-sm-4">

										<input type="text" id="fxtype" name="fxtype" class="form-control" placeholder="请输入" />
									</div>
									
								</div>
								<div class="form-group">
									
									<label class="col-sm-2 control-label">图标: <span class="asterisk">*</span></label>
									<div class="col-sm-6">

										<input type="text" id="uploadresultFour" name="fximg" class="form-control" placeholder="请输入" />
									</div>
									<div class="col-sm-1">
										<input type="file" name="uploadifyfileFour" id="uploadifyfileFour" />
										<script>
										uploadFourImg();
										</script>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label">分享说明: </label>
									<div class="col-sm-9">

										<input type="text" id="fxsummary" name="fxsummary" class="form-control" placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">分享地址 <span class="asterisk">*</span>
									</label>
									<div class="col-sm-9">
										<input type="text" id="fxurl" name="fxurl" class="form-control" placeholder="请输入" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">原地址 <span class="asterisk">*</span>
									</label>
									<div class="col-sm-9">
										<input type="text" id="oldurl" name="oldurl" class="form-control" placeholder="请输入" />
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
					


				</div>
				<!-- row -->
			</div>
		</div>
	</div>
</body>
</html>
