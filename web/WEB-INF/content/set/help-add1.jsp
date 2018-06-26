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
 
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script>
 
<script type="text/javascript">
 
</script>

</head>

<body>

	<section>

		<%@include file="/webcom/header-bracket.jsp"%>

		<div class="mainpanel">
			<%@include file="/webcom/header-headerbar.jsp"%>
			<div class="pageheader">
				<h2>
					<i class="fa fa-user"></i>微官网<span>帮助中心</span>
				</h2>
			</div>
			<div class="row">
				<div class="col-md-12">
					<form class="form-horizontal" id="custinfoForm" method="post"
						action="${contextPath}/set/help!save.action"
						onSubmit="return checksubmit()">
						<input type="hidden" id="_id" value="<s:property value='_id'/>" name="_id" /> 
						 
                         
						<div class="panel-body">
						    <div class="form-group">
						      <label class="col-sm-1 control-label">标题 </label>
                               <div class="col-sm-3">
                               <input type="text" id="title" class="form-control" value="<s:property value='title'/>" name="title" placeholder="请输入标题"/>
                              </div> 
                              <label class="col-sm-1 control-label">模块 </label>
                               <div class="col-sm-3">
                                 <select  id="type"  name="type"  class="form-control mb15"  data-placeholder="请选择">
            	 					    <option value="-1">其他帮助</option>
            	 					    <option value="1">系统帮助</option>
                    					<option value="2">任务帮助</option>
                    					<option value="3">商城帮助</option> 	 
                 			   </select>
                              </div> 	
                               <label class="col-sm-1 control-label">类型</label>
                               <div class="col-sm-3">
                                 <select  id="lx"  name="lx" class="form-control mb15"  data-placeholder="请选择">
            	 					    <option value="0">后台管理</option>
                    					<option value="1">普通用户</option>  	 
                 			   </select>
                              </div> 			
							</div>
							 <label class="col-sm-1 control-label">序号 </label>
                               <div class="col-sm-3">
                               <input type="text" id="sort" class="form-control" value="<s:property value='sort'/>" name="sort" placeholder="请输入序号"/>
                              </div> 
							<div class="form-group">
								<label class="col-sm-1 control-label">描述 <span class="asterisk">*</span> </label>
								<textarea style="display:none" name="content" id="content">${entity.content}</textarea>
								<div class="col-sm-11"><script id="editor" type="text/plain" style="width:960px;height:300px;">${entity.content}</script></div>
							</div>
							

							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-6 col-sm-offset-5">

										<input type="submit" class="btn btn-primary dropdown-toggle"
											value="提&nbsp;&nbsp;交" /> <input type="reset" class="btn"
											value="重&nbsp;&nbsp;置" onClick="document.form.reset();" /> <input
											type="reset" class="btn btn-red" value="返&nbsp;&nbsp;回"
											onClick="history.back();" />

									</div>
								</div>
							</div>
							<!-- panel-footer -->

						</div>
						<!-- panel -->
					</form>
				</div>
				<!-- row -->

			</div>
			<!-- contentpanel -->
		</div>
	</section>
<%@include file="/webcom/cut-img.jsp"%> 

<script type="text/javascript"> 
  $('#lx').val('${entity.lx}'); 
  if('${type}'!=0){
  $('#type').val('${type}');
  }
  if('${entity.type}'!=0){
   $('#type').val('${entity.type}'); 
  }
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    ue.ready(function() {
    	UE.getEditor('editor').setHeight(300);
    });
    
    function checksubmit()
    {
    	 $("#content").val(ue.getContent());
    }
</script>


</body>
</html>
