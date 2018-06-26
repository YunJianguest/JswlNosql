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


<script type="text/javascript">

	function del(id) {
		if (confirm('确实要删除吗?')) {

			location.href = "${contextPath}/web/music!delete.action?_id=" + id;

		}
	}
	 
	function add() {
		$('#_id').val('');
		$('#title').val('');
        $('#fileupload').val('');
		$('#sort').val(0);
		$('#url').val('');
		$('#path').val('');

		$('#inszc').modal({
			show : true
		});
	}
		function upd(id, title, url,path,sort) {
		$('#_id').val(id);
		$('#title').val(title); 
		$('#fileupload').val(url);
		$('#upresult').val(path);
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
	
	 
  function  getfolder(){
    
			location.href = "${contextPath}/web/folder!getFolders.action?type=${type}";
    }
  function  share(url){
    location.href = "${contextPath}/pub/share.action?type=${type}&url="+url;
  }
  
</script>

</head>

<body>

	<section>

		<%@include file="/webcom/header-bracket.jsp"%>

		<div class="mainpanel">
			<%@include file="/webcom/header-headerbar.jsp"%>

			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/web/music.action?">

				<div class="pageheader">

					<h2>
						<i class="fa fa-user"></i>微管理 <span>资源管理</span>
					</h2>

					<div class="breadcrumb-wrapper1">
						<div class="input-group ">
							<button type="button" class="btn btn-primary dropdown-toggle"
								data-toggle="dropdown">
								菜单 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu pull-right" role="menu">
								<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a>
								</li>
								<li><a href="javascript:getfolder();"><i class="fa  fa-rotate-right"></i>&nbsp;&nbsp;&nbsp;&nbsp;切换到文件夹模式</a>
								</li>

							</ul>
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
								<table class="table table-striped table-primary mb30">
									<thead>
										<tr>

											<th class="th5">名称</th>
											<th class="th5">序号</th>
											<th class="th8">上传时间</th>
											<th class="th8">地址</th>
											<th class="th8">上传者</th>



											<th class="th5">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${musicList}" var="bean">
											<tr>


												<td>${bean.title}</td>
												<td>${bean.sort}</td>
												<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
														value='${bean.createdate}' />
												</td>
												<td>${bean.url}</td>
												<td>${bean.custid}</td>

												<td class="table-action">

													<div class="btn-group1">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i> </a>
														<ul role="menu" class="dropdown-menu pull-right">
														 <security:authorize ifAllGranted="ROLE_46">
															<li><a
																href="javascript:upd('${bean._id}','${bean.title}','${bean.url}','${bean.path}',${bean.sort});">
																	<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
															</li>
														 </security:authorize>
														 <security:authorize ifAllGranted="ROLE_47">
															<li><a href="javascript:del(${bean._id});"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
															</li>
														 </security:authorize>
														    <li><a href="javascript:share('${bean.url}');"><i
																	class="fa fa-share "></i>&nbsp;&nbsp;&nbsp;&nbsp;分享</a>
															</li>
															 

														</ul>
													</div></td>
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
					<form id="inscxForm" action="${ctx }/web/music!save.action"
						class="form-horizontal" method="post" onsubmit="return check()">
						<input type="hidden" id="_id" name="_id" /> 
						<input type="hidden" id="upresult" name="path" />


						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">名称: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="title" name="title"
											class="form-control" placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">文件夹: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										 <s:select cssClass="col-sm-2 form-control" name="folderid"
											list="#request.map" listKey="key" listValue="value" />
									</div>

								</div>


								<div class="form-group">
									<label class="col-sm-2 control-label">文件地址 <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="fileupload" name="url" class="form-control"
											placeholder="请输入" />

									</div>

								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label">序号: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="sort" name="sort" class="form-control"
											placeholder="请输入" />
									</div>

								</div>

								<%@include file="/webcom/upload.jsp"%>

							</div>
							<!-- panel-body -->

							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-12 ">
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
