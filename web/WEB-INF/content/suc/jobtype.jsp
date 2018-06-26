<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<script type="text/javascript">
	$(document).ready(
			function() {
				var validator = $("#inscxForm").validate(
						{
							rules : {
								picurl : {
									required : true
								}, 
								title : {
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
			location.href = "${ctx}/suc/jobtype!delete.action?fypage=${fypage}&_id=" + id;
		}
	}
	function add() {
		$('#_id').val('');
		$('#title').val('');
		$('#type').val('');
		$('#picurl').val('');
		$('#url').val('');
		$('#sort').val(0);
		ps_show('inszc');
	}
	function upd(id) {
		var submitData = {
			_id : id
		};
		$.post('${ctx}/suc/jobtype!upd.action', submitData, function(json) {
			$('#_id').val(json._id);
			$('#title').val(json.title);
			$('#type').val(json.type);
			$('#ioc').val(json.ioc);
			$('#picurl').val(json.picurl);
			$('#url').val(json.url);
			$('#bgcolor').val(json.bgcolor);
			$('#sort').val(json.sort);

		}, "json")
		ps_show('inszc');
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
				action="${contextPath}/suc/jobtype.action">
				<div class="pageheader">
					<h2>
						<i class="fa fa-user"></i> 微官网 <span>招聘分类</span>
					</h2>
					<div class="breadcrumb-wrapper1">
						<div class="input-group ">
							<div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
								<a href="javascript:add();"style="color: #ffffff;line-height:25px;">
									新增&nbsp;<i class="fa fa-plus"style="line-height:30px;font-size: 14px;"></i>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table table-striped table-action table-primary mb30">
									<thead>
										<tr>
											<th class="table-action">序号</th>
											<th class="table-action">图标</th>
											<th class="table-action">图片</th>
											<th class="table-action">名称</th> 
											<th class="table-action">地址</th>
											<th class="table-action">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="bean">
											<tr>
												<td>${bean.sort}</td>
												<td><i class="fa ${bean.ioc} "></i>
												</td>
												<td><img src="${filehttp}/${bean.picurl}" height="25px" style="background-color: black;"/></i>
												</td>
												<td>${bean.title}</td> 
												<td><div class="th10 sl">${bean.url}</div>
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
														</ul>
													</div></td>
											</tr>
										</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>
 
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">内容管理</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/suc/jobtype!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/> 
					<input type="hidden" id="type" name="type"/> 
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="title" name="title"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">链接：</label>
                                <input type="text" id="url" name="url"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">图标：</label>
                                <input type="text" id="ioc" name="ioc"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                      
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">图片:</label>
                                <input type="text" id="picurl" name="picurl"
                                       class="form-control" placeholder="请输入" onclick="init_ioc('picurl','inszc'),color_hide()"/>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">背景颜色:</label>
                                <input type="text" id="bgcolor" name="bgcolor"
                                       class="form-control" placeholder="请输入" onclick="init_color('bgcolor','inszc'),ioc_hide()"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">序号：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>	 
	<%@ include file="/webcom/preview.jsp"%>
	<%@ include file="/webcom/color.jsp"%>
	<%@ include file="/webcom/ioc.jsp"%> 
</body>
</html>
