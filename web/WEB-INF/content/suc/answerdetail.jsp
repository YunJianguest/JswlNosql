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
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$('#sel_type').val('${type}');
		var validator = $("#inscxForm").validate({
			rules: {
				wt: {
	                required: true
	            },
	            sort:{
	            	digits:true,
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

function del(id,wid) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/suc/answerdetail!delete.action?_id="
				+ id+"&wid="+wid;
				 
	}
}
 function add(wid){
	$('#_id').val('');
	$('#wid').val(wid);
	$('#uploadresult').val('');	
	$('#wt').val('');	
	$('#daan0').val('');
	$('#daan1').val('');
	$('#daan2').val('');
	$('#daan3').val('');
	$('#score0').val(0);
	$('#score1').val(0);
	$('#score2').val(0);
	$('#score3').val(0);
	$('#sort').val(0);
	$('#inszc').modal({ 
	    show:true
	});
}
 
 function upd(_id,wid,uploadresult,wt,daan0,daan1,daan2,daan3,score0,score1,score2,score3,sort){
	$('#_id').val(_id);
	$('#wid').val(wid);	
	$('#uploadresult').val(uploadresult);	
	$('#wt').val(wt);	
	$('#daan0').val(daan0);
	$('#daan1').val(daan1);
	$('#daan2').val(daan2);
	$('#daan3').val(daan3);
	$('#score0').val(score0);
	$('#score1').val(score1);
	$('#score2').val(score2);
	$('#score3').val(score3);
	$('#sort').val(sort);
	$('#inszc').modal({ 
	    show:true
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
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/answerdetail.action?wid=${wid}" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>问答管理</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="javascript:add(${wid});"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li>
               
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
          
            <a href="javascript:page_submit(-1);" class="btn btn-success">搜&nbsp;&nbsp;索</a>

        </div>
    </div><!-- panel-body -->
	</div><!-- panel -->

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-success mb30" >
                    <thead>
                      <tr>
                       
                        <th class="th5">序号</th>
                        <th class="th8">标题</th>
				     	<th class="th8">答案1</th>
                        <th class="th8">答案2</th>
                        <th class="th8">答案3</th>
                        <th class="th8">答案4</th>
                      
                        
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${AnswerDetailList}" var="bean">
                      <tr>
                       
                      	<td>${bean.sort}</td>
						<td >${bean.wt}</td>
						<td>${bean.daan0}</td> 
						<td>${bean.daan1}</td>
                        <td>${bean.daan2}</td>
                        <td>${bean.daan3}</td>
						
						 
		 
					
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                        <li><a href="javascript:upd(${bean._id},${bean.wid},'${bean.picurl}','${bean.wt}','${bean.daan0}','${bean.daan1}','${bean.daan2}','${bean.daan3}',${bean.score0},${bean.score1},${bean.score2},${bean.score3},${bean.sort});">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                        <li><a href="javascript:del(${bean._id},${wid});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>          
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
 
 
 <div id="inszc" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 添加活动</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${contextPath}/suc/answerdetail!save.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="_id" name="_id" />
                    <input type="hidden" id="wid" name="wid" />

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="wt" name="wt" class="form-control" placeholder="请输入" />
                                </div>
                            	
                              </div>
                          <div class="form-group">
                                <label class="col-sm-2 control-label">图片: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="picurl" id="uploadresult" class="form-control" placeholder="图片建议尺寸500*300." />
                                </div>
                                <div class="col-sm-2">
                                	<input type="file" name="uploadifyfile" id="uploadifyfile" /> 
                                   <script>
										uploadOneImg();
								   </script>
                                </div>
                            </div>
                            </div>
                           <div class="form-group">
                                <label class="col-sm-2 control-label">答案一: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="daan0" name="daan0" class="form-control" placeholder="请输入答案" />
                                </div>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="score0" name="score0" class="form-control" placeholder="请输入分数" />
                                </div>
                            	
                            </div>
                                <div class="form-group">
                                <label class="col-sm-2 control-label">答案二: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="daan1" name="daan1" class="form-control" placeholder="请输入答案" />
                                </div>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="score1" name="score1" class="form-control" placeholder="请输入分数" />
                                </div>
                            	
                            </div>
                                <div class="form-group">
                                <label class="col-sm-2 control-label">答案三: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="daan2" name="daan2" class="form-control" placeholder="请输入答案" />
                                </div>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="score2" name="score2" class="form-control" placeholder="请输入分数" />
                                </div>
                            	
                            </div>
                              <div class="form-group">
                                <label class="col-sm-2 control-label">答案四: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="daan3" name="daan3" class="form-control" placeholder="请输入答案" />
                                </div>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="score3" name="score3" class="form-control" placeholder="请输入分数" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="sort" name="sort" class="form-control" placeholder="请输入" />
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
</body>
</html>
