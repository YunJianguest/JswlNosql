<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
 
<!DOCTYPE html>
<html lang="en">
<head>
<title>管理后台</title>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<link href="${ctx}/bracket/css/logo.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	
	var validator = $("#insppForm").validate({
		rules: {
			value: {
                required: true
            }
			
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		    },
		    success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		    }
		
	});
	var validator = $("#inscxForm").validate({
		rules: {
			cx: {
                required: true
            },
            tjp: {
                required: true,
                digits: true
            },
            bf: {
                required: true,
                digits: true
            },
            maxp: {
                required: true,
                digits: true
            }
			
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
	if(confirm('确实要删除吗?')) {
		location.href = "${contextPath}/weixin/wxmenu!delete.action?_id="+id;
	}		
}
function delcx(id) {
	if(confirm('确实要删除吗?')) {
		location.href = "${contextPath}/weixin/wxmenu!delcx.action?_id="+id;
	}		
}
function page_submit(num){
	
	if(num<0){
		$("#fypage").val(0);	
				
	}else{
		$("#fypage").val(num);	
	}

	$("form").submit();
}
function add(no){

	$('#_id').val('');
	$('#parentid').val(no);	
	$('#name').val('');	
	$('#type').val('');	
	$('#key').val('');	
	$('#sort').val(0);	
	if(no==0){
		$('#s_menu').show();
	}else{
		$('#s_menu').hide();
	}
	$('#inspp').modal({ 
	    show:true
	});
}

function upd(id){
	$('#_id').val(id);
	var submitData = {
			_id:id
	};
	$.post('${ctx}/weixin/wxmenu!upd.action', submitData,
		function(json) {
			$('#_id').val(json._id);
			$('#parentid').val(json.parentid);	
			$('#name').val(json.name);	
			$('#type').val(json.type);	
			$('#key').val(json.key);	
			$('#sort').val(json.sort);	
			if(json.parentid==0){
				$('#s_menu').show();
			}else{
				$('#s_menu').hide();
			}
	},"json")
	
	
	$('#inspp').modal({ 
	    show:true
	});
	
}

</script>
</head>

<body>

<section>

<%@include file="/webcom/header-bracket.jsp"%>

<div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
	

    <div class="pageheader">
      
      <h2><i class="fa fa-home"></i>微信配置<span>菜单配置<s:actionmessage theme="custom" cssClass="success" /></span></h2>
      
      <div class="breadcrumb-wrapper1">
      	<div class="input-group">

            <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                <a href="${contextPath}/weixin/wxmenu!creatmenu.action"style="color: #ffffff;line-height:25px;">
                    确认提交&nbsp;<i class="fa fa-check"style="line-height:30px;font-size: 14px;"></i>
                </a>
            </div>

            <%----%>
                  <%--<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">--%>
                      	<%--菜单 <span class="caret"></span>--%>
                  <%--</button>--%>
                  <%--<ul class="dropdown-menu pull-right" role="menu">--%>
                      <%--<li><a href="${contextPath}/weixin/wxmenu!creatmenu.action"><i class="fa fa-share-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;发布菜单</a></li>--%>
                  <%--</ul>--%>

       
       	</div>
      </div>
	</div>
	<div class="col-md-5 mt10">
    <div class="form-horizontal">
        <div class="panel">
            <div class="panel-body">
                <div class="col-sm-12 ">
                    <c:if test="${fn:length(menu1List)<3 }"> 
                    <a href="javascript:add(0);" class="btn btn-block btn-primary"><i class="fa fa-plus-square"></i>&nbsp;&nbsp;&nbsp;添加一级菜单&nbsp;&nbsp;</a>
                    </c:if>
                    <div class="mb10"></div>
                    <div class=" table-responsive">
                        <table class="table table-hidaction  table-hover mb30 " id="table1">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>菜单名称</th>
                                <th>类型</th>
                                <th>地址</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${menu1List}" var="bean">
                            
                            <tr id="pp_${bean._id }">
                            	<c:if test="${bean.type=='menu'}">
                                <td><a href="${ctx }/weixin/wxmenu.action?parentid=${bean._id}&cate_id=${cate_id}"> ${bean.sort}</a></td>
                                <td><a href="${ctx }/weixin/wxmenu.action?parentid=${bean._id}&cate_id=${cate_id}">${bean.name}</a></td>
								</c:if>
								<c:if test="${bean.type!='menu'}">
                                <td> ${bean.sort}</td>
                                <td>${bean.name}</td>
								</c:if>
								
								<td><c:if test="${bean.type=='menu'}">一级菜单</c:if><c:if test="${bean.type=='click'}">关键字</c:if><c:if test="${bean.type=='view'}">直接跳转</c:if></td>
								<td title="${bean.key}"><div class="th10 sl">${bean.key}</div></td>
                                <td class="th5 table-action">
                                    <div class="btn-group1">
                                        <a data-toggle="dropdown" class="dropdown-toggle">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <ul role="menu" class="dropdown-menu dropdown-menu-usermenu pull-right">
                                            <li><a href="javascript:upd(${bean._id });" ><i class="fa fa-pencil"></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                            <li><a href="javascript:del(${bean._id });"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                           
                                        </ul>
                                    </div>
                                </td>
             
                            </tr>
                           
                            </c:forEach>
                           

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- panel-body -->
        </div>
        <!-- panel -->
    </div>
	</div>
	
	<c:if test="${parentid>0}">
	<div class="col-md-7 mt10">
    <div class="form-horizontal">
        <div class="panel">
            <div class="panel-body">
                <div class="col-sm-12 ">
                	<c:if test="${fn:length(menu2List)<5 }"> 
                    <a href="javascript:add('${parentid}');" class="btn btn-block btn-primary"><i class="fa fa-plus-square"></i>&nbsp;&nbsp;&nbsp;添加二级菜单&nbsp;&nbsp;</a>
                    </c:if>
                    <div class="mb10"></div>
                    <div class=" table-responsive">
                        <table class="table table-hidaction  table-hover mb30 " id="table2">
                            <thead>
                            <tr>
                            	<th>序号</th>
                                <th>菜单名称</th>
                                <th>类型</th>
                                <th>地址</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${menu2List}" var="bean">
                            	<tr >
                            		<td>${bean.sort}</td>
									<td>${bean.name}</td>
									<td><c:if test="${bean.type=='click'}">关键字</c:if><c:if test="${bean.type=='view'}">直接跳转</c:if></td>
									<td title="${bean.key}"><div class="th20 sl">${bean.key}</div></td>
                                	<td class="th5 table-action">
                                    	<div class="btn-group1">
                                        <a data-toggle="dropdown" class="dropdown-toggle">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <ul role="menu" class="dropdown-menu dropdown-menu-usermenu pull-right">
                                            <li><a href="javascript:upd(${bean._id },'${bean.parentid }','${bean.name }','${bean.type }','${bean.key }','${bean.sort }');" ><i class="fa fa-pencil"></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                            <li><a href="javascript:del(${bean._id });"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                           
                                        </ul>
                                    	</div>
                                	</td>
                            	</tr>
                            	
                            
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- panel-body -->
        </div>
        <!-- panel -->
    </div>
	</div>
	
	</c:if>
	
</div><!-- mainpanel -->
</section>
 
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inspp" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">菜单添加</i>
                    </div>
                    <a href="javascript:ps_hide('inspp')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>


                <form id="inscxForm" action="${ctx }/weixin/wxmenu!save.action"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" value="" name="_id" /> 
                	<input type="hidden" id="parentid" value="" name="parentid" />
                    <%--row--%>
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="name" name="name"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">类型：</label>
                                <select id="type" name="type" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                    <option value="click">关键字回复</option>
                                    <option value="view">直接跳转</option>
                                    <option value="menu" id="s_menu">一级菜单</option> 
                                </select> 
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">链接：</label>
                                <input type="text" id="key" name="key"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
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
<script>
    jQuery(document).ready(function () {
		$("#pp_${parentid}").addClass("active");
    });
</script>
</body>
</html>
