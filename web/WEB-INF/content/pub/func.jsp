<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/media/js/DT_bootstrap.js"></script>
<script type="text/javascript"
	src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript"
	src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script>

<script type="text/javascript">
	function del(id) {
		if (confirm('确实要删除吗?')) {

			location.href = "${contextPath}/pub/func!delete.action?_id=" + id;

		}
	}
	function delchild(id){
	     if (confirm('确实要删除吗?')) {

			location.href = "${contextPath}/pub/func!deletchildfunc.action?_id=" + id;

		}
	}
	function getchild(id){
	      
		   location.href = "${contextPath}/pub/func.action?parentid="+id;
 
	}

	function add() {
		$('#_id').val('');
		$('#name').val(''); 
		$('#logo').val('');
		$('#url').val(''); 
		$('#sort').val(0);
		$('#inszc').modal({
			show : true
		});
	}
	function upd(id, name, logo, url, parentid, sort) {
		$('#_id').val(id);
		$('#name').val(name);

		$('#logo').val(logo);
		$('#url').val(url);
		$('#parentid').val(parentid);
		$('#sort').val(sort);

		$('#inszc').modal({
			show : true
		});

	}
	function page_submit(num) {

		if (num == -1) {
			$("#fypage").val(0);
		} else if (num == -2) {
			$("#fypage").val($("#fypage").val() - 1);
		} else {
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

			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/pub/func.action?parentid=${parentid}">

				<div class="pageheader">

					<h2>
						<i class="fa fa-user"></i>微管理 <span>资源管理</span>
					</h2>

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
								<input type="text" name="title" value="${title}"
									placeholder="标题" class="form-control" />
							</div>

							<a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

						</div>
					</div>
					<!-- panel-body -->
				</div>
				<!-- panel -->

				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table table-striped table-action table-primary mb30">
									<thead>
										<tr>
											<th class="th5 table-action">名称</th>
											<th class="th8 table-action">链接</th>
											<th class="th8 table-action">父资源</th>
											<th class="th8 table-action">序号</th>
											<th class="th8 table-action">ID</th>
											<th class="th5 table-action">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${funcList}" var="bean">
											<tr>
												<td>${bean.name}</td>
												<td>${bean.url}</td>
												<td>${bean.parentid}</td>
												<td>${bean.sort}</td>
												<td>${bean._id}</td>
												<td class="table-action">

													<div class="btn-group1">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i> </a>
														<ul role="menu" class="dropdown-menu pull-right">
															<li><a
																href="javascript:upd('${bean._id}','${bean.name}','${bean.logo}','${bean.url}',${bean.parentid},${bean.sort});">
																	<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
															</li>
															<li><a href="javascript:del(${bean._id});"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
															<li><a href="javascript:getchild(${bean._id});"><i
																	class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;查看子资源</a></li>
															<li><a href="javascript:delchild(${bean._id});"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;清除子资源</a></li>
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
				<!-- contentpanel -->
			</form>
		</div>
		<!-- mainpanel -->
	</section>
	<div id="inszc" class="modal fade bs-example-modal-static"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-leaf"></i> 添加内容
					</h4>
				</div>
				<div class="modal-body">
					<form id="inscxForm" action="${ctx }/pub/func!save.action"
						class="form-horizontal" method="post">
						<input type="hidden" id="_id" name="_id"  />


						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">资源名称: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="name" name="name"
											class="form-control" placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">图标: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="logo" name="logo"
											class="form-control" placeholder="请输入" />
									</div>

								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label">链接: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="url" name="url"
											class="form-control" placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">父资源ID: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="parentid" name="parentid"
											class="form-control" value="${parentid}" placeholder="请输入" readonly="readonly" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">序号: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="sort" name="sort"
											class="form-control" placeholder="请输入" />
									</div>

								</div>
								


							</div>
							<!-- panel-body -->

							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-12 ">
										<button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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
