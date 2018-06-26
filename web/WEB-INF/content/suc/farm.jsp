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
 
	function del(id) {
		if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/suc/farm!delete.action?fypage=${fypage}&_id=" + id;
		}
	}
	function add(){
	$('#_id').val('');
	$('#title').val(''); 
	$('#picurl').val('');
	$('#mb').val(0);
	$('#summary').val(''); 	
	$('#sort').val(0); 
	ps_show('inszc');
    }
 
    function upd(id){
       var submitData = {
       _id : id
     };
     $.post('${ctx}/suc/farm!upd.action', submitData, function(json) {
       $('#_id').val(json._id);
	   $('#title').val(json.title); 
	   $('#picurl').val(json.picurl);
	   $('#mb').val(json.mb);
	   $('#summary').val(json.summary); 	
	   $('#sort').val(json.sort); 
    
     }, "json");
     ps_show('inszc');
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
				action="${contextPath}/suc/mark.action">
				<div class="pageheader">
					<h2>
						<i class="fa fa-user"></i>微官网<span>农产品管理</span>
					</h2>
					<div class="breadcrumb-wrapper1">
						<div class="input-group ">
        	               <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	             菜单 <span class="caret"></span>
                           </button>
                           <ul class="dropdown-menu pull-right" role="menu"> 
            	           <li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加农产品</a></li> 
                           </ul>
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
											<th class="table-action">图片</th> 
											<th class="table-action">标题</th>  
											<th class="table-action">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="bean">
											<tr>
												<td>${bean.sort}</td> 
												<td><img src="${filehttp}/${bean.picurl}" height="25px" style="background-color: black;"/></i>
												</td>
												<td>${bean.title}</td>  
												</td>
												<td class="table-action">
													<div class="btn-group1">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i> </a>
														<ul role="menu" class="dropdown-menu pull-right">
															<li><a href="${ctx}/suc/activity!update.action?_id=${bean._id}"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
															</li>

															<li><a href="javascript:del('${bean._id}');"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
															</li>
															<li><a href="${ctx}/suc/mark!webdetail.action?id=${bean._id}"><i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;预览</a>
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
                        <i class="weight500 size14 pl-10 line-height50">添加内容</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/suc/farm!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="title" name="title"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>  
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">类型：</label>
                                <select id="type" name="type" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="apple">苹果树</option> 
                                </select> 
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">描述:</label>
                                <input type="text" id="summary" name="summary"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>  
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">总成长值:</label>
                                <input type="text" id="growth" name="growth"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>  
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">价格:</label>
                                <input type="text" id="price" name="price"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>  
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">库存:</label>
                                <input type="text" id="num" name="num"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>  
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">序号:</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control hang40" placeholder="请输入"/>
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
<%@ include file="/webcom/share.jsp"%>
<%@ include file="/webcom/preview.jsp"%> 
</body>
</html>
