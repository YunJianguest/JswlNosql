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
$(document).ready(function(){
	jQuery('#keyword').tagsInput({height: '40px'});
	var validator = $("#inscxForm").validate({
		rules: {
		   title: {
                required: true
            }, 
            price:{  
            	isFloat:true,
            	required: true
            }
		},
		messages: {
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		    },
		    success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		    }
	});
});
function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/set/joinin!delete.action?_id="
        + id+"&fypage=${fypage}";
	}
}
function add(){
	$('#_id').val('');
	$('#title').val(''); 
	$('#sort').val(0); 
	$('#inszc').modal({ 
	    show:true
	});
}
function upd(id){
   var submitData = {
    _id : id
  };
  $.post('${ctx}/set/joinin!upd.action', submitData, function(json) {
    $('#_id').val(json._id);
    $('#name').val(json.name); 
    $('#tel').val(json.tel);
    $('#sort').val(json.sort);
  }, "json")
  $('#inszc').modal({
      show : true
    });
}
function updstate(id,st){
   var submitData = {
    _id : id,
    state:st
  };
  $.post('${ctx}/set/joinin!updstate.action', submitData, function(json) {
    if(json.state==0){
     alert("审核完成");
     location.reload()
    }
  }, "json")
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
</script>
</head>
<body>
<section>
  <%@include file="/webcom/header-bracket.jsp"%>
  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/set/joinin.action?" >
    <div class="pageheader">
      <h2><i class="fa fa-user"></i>系统配置<span>加盟管理</span></h2>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
    </div>
	</div>
    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary table-action mb30" >
                    <thead>
                      <tr>
                      	<th class="th1 table-action">姓名</th>
						<th class="th5 table-action">电话</th> 
						<th class="th5 table-action">时间</th> 
						<th class="th5 table-action">状态</th>
						<th class="th5 table-action">来源</th>
				 		<th class="th5 table-action">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${list}" var="bean">
                      <tr>  
						<td>${bean.name}</td>
						<td>
						 ${bean.tel}
						</td>
						<td>
						<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value='${bean.createdate}'/>
						</td>
						<td>
						 <c:if test="${bean.state==0}">未审核</c:if>
						 <c:if test="${bean.state==1}">审核通过</c:if>
						 <c:if test="${bean.state==2}">审核驳回</c:if>
						</td>
						<td>${bean.nickname}</td>
				        <td class="table-action">
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">  
                                      <li><a href="javascript:del(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      <li><a href="javascript:updstate(${bean._id},1);"><i class="fa fa-calendar-check-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;审核通过</a></li>
                                      <li><a href="javascript:updstate(${bean._id},2);"><i class="fa fa-calendar-times-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;审核驳回</a></li>
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
<div id="inszc" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-leaf"></i> 添加内容</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/set/price!save.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="_id" name="_id" />
                    <div class="panel panel-default">
                        <div class="panel-body">
                           <div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="title" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            </div>
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">分类: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                  <select class="form-control form-control" id="type" name="type">
										<option value="bbs_adv">论坛广告</option>   
								  </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">价格: <span class="asterisk">*</span></label>
                                <div class="col-sm-9">
                                   <input type="text" id="price" name="price" class="form-control" placeholder="请输入" />
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-12">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div> 
</body>
</html>
