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
		location.href = "${ctx}/suc/memoriallm!delete.action?_id="+ id;
	}		
}
function add(){
	$('#_id').val('');
	$('#title').val('');
	$('#summary').val('');
    $('#uploadresultFour').val('');
	$('#sort').val(0);
	$('#type').val(0);
	$('#mb').val(0);
	 
	$('#insadd').modal({
			show : true
		});
}
function upd(id){
   var submitData = {
		_id : id
	};
	$.post('${ctx}/suc/memoriallm!upd.action', submitData, function(json) {
		$('#_id').val(json._id);
		$('#title').val(json.title);
		$('#context').val(json.context);
		$('#type').val(json.type);
		$('#sort').val(json.sort);
		$('#mb').val(json.mb);
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

function onChange(v){
  if(v==1){
    $("#gj").show();
  }else{
    $("#gj").hide();
  }
}
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/graphiclm.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>素材管理 <span>栏目管理</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li> 
            	<li><a href="${contextPath}/news/advertisement.action?type=toursim"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;广告位</a></li>
            	<li><a href="javascript:share('${ctxurl }/suc/tourism!web.action?toUser=${toUser}');"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享预览</a></li>
            	<li><a href="${ctx}/suc/graphiclm!web.action?toUser=${toUser}" target="_blank"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享预览</a></li>
            	<li><a href="javascript:updfx('wxmatrix');"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享配置</a></li>
            </ul>
         </div>
      </div>
    </div>
   
    <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            
            <div class="form-group col-sm-1d">
            <input type="text" name="title"  value="${title}" placeholder="标题"  class="form-control" />
            </div>
           
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

        </div>
    </div><!-- panel-body -->
	</div><!-- panel -->
    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-primary mb30" >
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
                      <c:forEach items="${MemoriallmList}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td>
                      	<td>${bean.title}</td>
                      	<td><img src="${osshttp}${bean.picurl}" height="25px"/></td>
                      	<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
					
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:upd('${bean._id}');">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      <li><a href="${ctx}/suc/memorial.action?toUser=${toUser}&wid=${bean._id}&type=${bean.type}">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;内容</a></li>
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
						<form id="inscxForm" action="${ctx }/suc/memoriallm!save.action"
						class="form-horizontal" method="post" >
						<input type="hidden" id="_id" name="_id" />
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
									<div class="col-sm-3">

										<input type="text" id="title" name="title" class="form-control" placeholder="请输入" />
									</div>
									 <label class="col-sm-1 control-label">类型<span class="asterisk">*</span></label>
                      
                                     <div class="col-sm-2">
                                     <select class="form-control form-control" id="type" name="type" onchange="onChange(this.value)">
										<option value="0">陵园</option>
										<option value="1">公祭</option>
									 	
								     </select>
                                     </div>
                      
									
								</div>
								<div class="form-group">
									
									<label class="col-sm-2 control-label">图标: <span class="asterisk">*</span></label>
									<div class="col-sm-6">

										<input type="text" id="uploadresultFour" name="picurl" class="form-control" placeholder="请输入" />
									</div>
									<div class="col-sm-1">
										<input type="file" name="uploadifyfileFour" id="uploadifyfileFour" />
										<script>
										uploadFourImg();
										</script>
									</div>
								</div>
								
								<div class="form-group">
								 <label class="col-sm-2 control-label">模板:<span class="asterisk">*</span></label>
                      
                                   <div class="col-sm-2">
                                     <select class="form-control form-control" id="mb" name="mb">
										<option value="0">默认模板</option>
										 
								     </select>
                                   </div>

								</div>
								<div style="display: none;"id="gj" class="form-group">
								<div class="form-group" >
								  <label class="col-sm-2 control-label">音乐: </label>
									<div class="col-sm-9">

										<input type="text" id="mp3" name="mp3" class="form-control" placeholder="请输入" />
									</div>
								 </div>
								 <div class="form-group" >
									<label class="col-sm-2 control-label">菜单1名称: </label>
									<div class="col-sm-2">

										<input type="text" id="funcname1" name="funcname1" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">连接: </label>
									<div class="col-sm-2">

										<input type="text" id="funcurl1" name="funcurl1" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">图标: </label>
									<div class="col-sm-2">

										<input type="text" id="funcioc1" name="funcioc1" class="form-control" placeholder="请输入" />
									</div>
									</div>
									<div class="form-group" >
									
									<label class="col-sm-2 control-label">菜单2名称: </label>
									<div class="col-sm-2">

										<input type="text" id="funcname2" name="funcname2" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">连接: </label>
									<div class="col-sm-2">

										<input type="text" id="funcurl2" name="funcurl2" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">图标: </label>
									<div class="col-sm-2">

										<input type="text" id="funcioc2" name="funcioc2" class="form-control" placeholder="请输入" />
									</div>
									</div>
									
									
									<div class="form-group" > 
									<label class="col-sm-2 control-label">菜单3名称: </label>
									<div class="col-sm-2">

										<input type="text" id="funcname3" name="funcname3" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">连接: </label>
									<div class="col-sm-2">

										<input type="text" id="funcurl3" name="funcurl3" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">图标: </label>
									<div class="col-sm-2">

										<input type="text" id="funcioc3" name="funcioc3" class="form-control" placeholder="请输入" />
									</div>
									</div>
									
									<div class="form-group" >
									<label class="col-sm-2 control-label">菜单4名称: </label>
									<div class="col-sm-2">

										<input type="text" id="funcname4" name="funcname4" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">连接: </label>
									<div class="col-sm-2">

										<input type="text" id="funcurl4" name="funcurl4" class="form-control" placeholder="请输入" />
									</div>
									<label class="col-sm-1 control-label">图标: </label>
									<div class="col-sm-2">

										<input type="text" id="funcioc4" name="funcioc4" class="form-control" placeholder="请输入" />
									</div>
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
