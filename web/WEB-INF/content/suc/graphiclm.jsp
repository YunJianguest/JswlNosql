<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript">
 
function del(id) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/suc/graphiclm!delete.action?_id="+ id+"&fypage=${fypage}";
	}		
}
function add(){
	$('#_id').val('');
	$('#title').val('');
	$('#summary').val('');
    $('#uploadresultFour').val('');
	$('#sort').val(0);
	$('#url').val('');
	 

	$('#inszc').modal({
			show : true
		});
}
function upd(id){
   var submitData = {
		id : id
	};
	$.post('${ctx}/suc/graphiclm!upd.action', submitData, function(json) {
		$('#_id').val(json._id);
		$('#title').val(json.title);
		$('#summary').val(json.summary);
		$('#url').val(json.url);
		$('#sort').val(json.sort);
		$('#type').val(json.type);
		$('#picurl').val(json.picurl);
		

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
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/graphiclm.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>图文管理 <span>栏目管理</span></h2>
      
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
                      	<th>标题</th>
                      	<th>图片</th>
                      	<th>时间</th>
                  		 
						<th>操作</th>
						
                      
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${graphiclmList}" var="bean">
                      <tr>
                      	<td>${bean.sort}</td>
                      	<td>${bean.title}</td>
                      	<td><img src="${filehttp}/${bean.picurl}" height="25px"/></td>
                      	<td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
					
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
                                      <li><a href="javascript:qrcode('${ctxurl}/suc/graphiclm!web.action?custid=${custid}&type=${bean._id}')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;预览</a></li> 
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
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a"
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


                <form id="inscxForm" action="${ctx }/suc/graphiclm!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
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
                                <label class="control-label">描述：</label>
                                <input type="text" id="summary" name="summary"
                                       class="form-control" placeholder="请输入"/>
                             </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">模板：</label>
                                <select id="mb" name="mb" class="select2 form-control"
                                        style="line-height: 28px!important;height: 42px!important;"
                                        required data-placeholder="请选择">
                                    <option value="0">默认模板</option> 
                                </select>
                                <label class="error" for="color"></label>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label class="control-label">图片：</label>
                            <div>
                                <div class="col-sm-9 mb-20" style="padding:   0px;">
                                    <input type="text" id="picurl" name="picurl" class=" form-control"/>
                                </div>
                                <div class="col-sm-3 mb-20" style="padding: 0px;position: relative;"
                                     onclick="pz('picurl','200','200',false)">
                                    <div class="btn btn-primary"
                                         style="width: 100%;line-height: 20px;height:40px;">
                                        上传
                                    </div>
                                </div>
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

<%@include file="/webcom/cut-img.jsp" %>
<%@ include file="/webcom/preview.jsp"%> 
</body>
</html>
