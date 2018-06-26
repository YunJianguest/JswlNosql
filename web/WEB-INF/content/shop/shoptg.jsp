<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<link href="${ctx }/cmp/css/cmp_js_yangshibiao.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">
	$(document).ready(
			function() {

				var validator = $("#inscxForm").validate(
						{
							rules : {
								picurl : {
									required : true
								},
								type : {
									required : true
								},
								name : {
									required : true
								},
								sort : {
									digits : true,
									required : true
								}

							},
							messages : {

							},
							highlight : function(element) {
								jQuery(element).closest('.form-group')
										.removeClass('has-success').addClass(
												'has-error');
							},
							success : function(element) {
								jQuery(element).closest('.form-group')
										.removeClass('has-error');
							}

						});

			});
	function del(id) {
		if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/shop/shoptype!delete.action?_id=" + id;
		}
	}
	function add() {
		$('#_id').val('');
		$('#name').val('');
		$('#type').val('');
		$('#picurl').val('');
		$('#url').val('');
		$('#sort').val(0);
		$('#inszc').modal({
			show : true
		});
	}

	function upd(id) {
		var submitData = {
			_id : id
		};
		$.post('${ctx}/shop/shoptg!upd.action', submitData, function(json) {
			$('#_id').val(json._id);
			$('#name').val(json.name);
			$('#type').val(json.type);
			$('#mb').val(json.mb);
			$('#picurl').val(json.picurl);
			$('#url').val(json.url);
			$('#sort').val(json.sort);

		}, "json")
		$('#inszc').modal({
			show : true
		});

	}

	function getpic() {
		$('#tubiao').show();
	}
	function close_box() {
		$('#tubiao').hide();
	}
	function seltb(key) {
		$('#picurl').val(key);
		$('#tubiao').hide();
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

			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/shop/shoptype.action">

				<div class="pageheader">

					<h2>
						<i class="fa fa-user"></i> 微官网 <span>行业分类</span>
					</h2>

					<div class="breadcrumb-wrapper1">
						<div class="input-group ">
							<button type="button" class="btn btn-success dropdown-toggle"
								data-toggle="dropdown">
								菜单 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu pull-right" role="menu">
								<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a>
								</li>
							</ul>
						</div>
					</div>
				</div>


				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table table-striped table-success mb30">
									<thead>
										<tr>
											<th>序号</th>
											<th>图标</th>
											<th>名称</th>
											<th>类型</th>
											<th>模板</th>
											<th>地址</th>
											<th>操作</th>


										</tr>
									</thead>
									<tbody>
										<c:forEach items="${funcList}" var="bean">
											<tr>
												<td>${bean.sort}</td>
												<td><i class="fa ${bean.picurl} "></i>
												</td>
												<td>${bean.name}</td>
												<td>${bean.type}</td>
												<td>${bean.mb}</td>
												<td><div class="th20 sl">${bean.url}</div>
												</td>
												<td class="table-action">

													<div class="btn-group1">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i> </a>
														<ul role="menu" class="dropdown-menu pull-right">
															<li><a href="javascript:upd('${bean._id}');"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
															</li>

															<li><a href="javascript:del('${bean._id}');"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
															</li>
															<li><a
																href="${contextPath}/news/advertisement.action?type=fl-${bean.type}">
																	<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;广告位</a>
															</li>
															<li><a href="javascript:share('${ctxurl}/wwz/wwz!companyfw.action?type=${bean.type}&toUser=${bean.toUser}&fromUser=fromUserData')" ><i class="fa fa-credit-card "></i>&nbsp;&nbsp;&nbsp;&nbsp;分享预览</a></li>
														</ul>
													</div></td>
											</tr>
										</c:forEach>
								</table>


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
						<i class="fa fa-automobile"></i> 维护行业分类
					</h4>
				</div>
				<div class="modal-body">
					<form id="inscxForm" action="${ctx }/shop/shoptype!save.action"
						class="form-horizontal" method="post">
						<input type="hidden" id="_id" name="_id" />


						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">名称: <span
										class="asterisk">*</span>
									</label>
									<div class="col-sm-3">

										<input type="text" id="name" name="name" class="form-control"
											placeholder="请输入" />
									</div>
									<label class="col-sm-2 control-label">类型: <span
										class="asterisk">*</span>
									</label>
									<div class="col-sm-3">
										<input type="text" id="type" name="type" class="form-control"
											placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">图标: <span
										class="asterisk">*</span>
									</label>
									<div class="col-sm-3">

										<input type="text" id="picurl" name="picurl"
											class="form-control" placeholder="请输入" />
									</div>
									<div class="col-sm-2">
										<div class=" col-sm-offset">
											<div class="btn btn-success btn-block" onclick="getpic()">选择图标</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">链接地址: </label>
									<div class="col-sm-9">

										<input type="text" id="url" name="url" class="form-control"
											placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">模板 <span
										class="asterisk">*</span>
									</label>
									<div class="col-sm-2">
										<s:select cssClass="form-control mb15" class="select2" id="mb"
											name="mb" list="#{'0':'默认模板','1':'模板1','2':'模板二'}" listKey="key" listValue="value"  />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">序号: <span
										class="asterisk">*</span>
									</label>
									<div class="col-sm-5">

										<input type="text" id="sort" name="sort" class="form-control"
											placeholder="请输入" />
									</div>

								</div>

							</div>
							<!-- panel-body -->

							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-9 col-sm-offset-3">
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


	<div class="big_box" id="tubiao"
		style="display: none;width: 400px;height: 100%;position:absolute;left:65%;  overflow: auto;">
		<%@ include file="/marker/set/dict18.html"%>
	</div>
</body>
</html>
