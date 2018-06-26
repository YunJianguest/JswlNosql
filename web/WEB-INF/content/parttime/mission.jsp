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
<script type="text/javascript" src="${ctx}/mvccol/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/mvccol/js/fomatdate2.js"></script>
<script type="text/javascript">

function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/parttime/mission!delete.action?_id="
				+ id+"&fypage=${fypage}";
	}
} 
function add(){
	    $('#_id').val('');
	    $('#title').val('');
	    $('#sort').val(0);
	    $('#wages').val('');
	    $('#workaddress').val('');
	    $('#num').val(0);
	    $('#education').val(0).trigger("change");
	    $('#experience').val(0).trigger("change");
	    $('#age').val(0).trigger("change");
	    $('#linkname').val('');
	    $('#linktel').val(''); 
	    $('#type').val(0).trigger("change"); 
	    $('#gatherdate').val(''); 
	    $('#startdate').val(''); 
	    $('#enddate').val(''); 
	    $('#company').val(''); 
	    $('#summary').val(''); 
	    $('#area').val('');
	    $('#price').val(0);
	    $('#jstype').val(0).trigger("change");
	ps_show('inszc');
}
function upd(id){
   var submitData = {
    _id : id
  };
  $.post('${ctx}/parttime/mission!upd.action', submitData, function(json) { 
    $('#_id').val(json._id);
    $('#title').val(json.title);
    $('#sort').val(json.sort);
    $('#wages').val(json.wages);
    $('#workaddress').val(json.workaddress);
    $('#num').val(json.num);
    $('#education').val(json.education).trigger("change");
    $('#experience').val(json.experience).trigger("change");
    $('#age').val(json.age).trigger("change");
    $('#linkname').val(json.linkname);
    $('#linktel').val(json.linktel); 
    $('#company').val(json.company); 
    $('#summary').val(json.summary); 
    $('#area').val(json.area);
    $('#price').val(json.price);
    $('#type').val(json.type).trigger("change"); 
    $('#jstype').val(json.jstype).trigger("change"); 
    $('#gatherdate').val(Date.prototype.format(json.gatherdate)); 
    $('#startdate').val(Date.prototype.format(json.startdate)); 
    $('#enddate').val(Date.prototype.format(json.enddate)); 
  }, "json")
  ps_show('inszc');
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
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/parttime/mission.action?" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>劳务管理</h2>
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
                <li><a href="javascript:updfx('mission_share')"><i class="fa fa-share-alt-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;首页分享设置</a></li> 
            	<li><a href="javascript:add()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li>
            	<li><a href="javascript:qrcode('${ctxurl}/parttime/employee!index.action?custid=${custid}');">
                    <i class="fa fa-mail-reply-all"></i> 预览&nbsp;
                  </a></li>
            </ul>
         </div>
      </div>
       
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
       
    </div><!-- panel-body -->
	</div><!-- panel -->

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-primary">
                <table class="table table-striped table-primary mb30" >
                    <thead>
                      <tr> 
                       	<th class="th5">标题</th> 
                        <th class="th6">日期</th>
                         
						
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${list}" var="bean">
                      <tr>  
                        <td>${bean.title}</td> 
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bean.createdate}" /></td>
                         
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                   <li><a href="javascript:upd('${bean._id}')"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
								   </li>
								   <li><a href="javascript:del('${bean._id}')"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
								   </li>
                                    
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
<%@include file="/webcom/preview.jsp"%>
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">添加任务</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                     </div>
                  <form id="inscxForm" action="${ctx }/parttime/mission!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">标题：</label>
                                <input type="text" id="title" name="title"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">薪资：</label>
                                <input type="text" id="price" name="price"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">结算类型：</label> 
                                <select id="jstype" name="jstype" class="hang40 select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="0">默认</option> 
                                  <option value="1">小时结算</option> 
                                  <option value="2">日结算</option> 
                                  <option value="3">月结算</option> 
                                </select>       
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">工作地点：</label>
                                <input type="text" id="workaddress" name="workaddress"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">招聘人数：</label>
                                <input type="text" id="num" name="num"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">学历要求：</label> 
                                <select id="education" name="education" class="hang40 select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="0">无</option> 
                                  <option value="1">大专以上</option> 
                                  <option value="2">本科以上</option> 
                                  <option value="3">硕士以上</option> 
                                </select>       
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">经验要求：</label> 
                                  <select id="experience" name="experience" class="hang40 select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="0">无</option> 
                                  <option value="1">一年以上</option> 
                                  <option value="2">一年到三年</option> 
                                  <option value="3">三年以上</option> 
                                  </select>  
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">年龄要求：</label> 
                                  <select id="age" name="age" class="hang40 select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="0">18岁以上</option>  
                                  </select> 
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">负责人姓名：</label>
                                <input type="text" id="linkname" name="linkname"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">负责人电话：</label>
                                <input type="text" id="linktel" name="linktel"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">集合时间：</label>
                                <input type="text" id="gatherdate" name="gatherdate"
                                       class="form-control hang40" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">开始时间：</label>
                                <input type="text" id="startdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  name="startdate"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">结束时间：</label>
                                <input type="text" id="enddate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="enddate"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">类型：</label> 
                                  <select id="type" name="type" class="hang40 select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="0">平台自营</option>  
                                  </select>  
                            </div>
                        </div>
                        
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">公司名称：</label>
                                <input type="text" id="company" name="company"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">区域：</label>
                                <input type="text" id="area" name="area"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">序号：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                         <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">工作描述：</label>
                                <textarea style="height: 150px;overflow: scroll;" id="summary" name="summary"
                                       class="form-control " placeholder="请输入"></textarea>
                            </div>
                        </div>
                         
                    </div>
                     <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;" onclick="submit()">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div> 
                    </form>
                   
            </div>
        </div>
    </div>
  </div>
<%@ include file="/webcom/share.jsp" %> 
<%@include file="/webcom/cut-img.jsp" %> 
<%@ include file="/webcom/preview.jsp" %>
</body>
</html>
