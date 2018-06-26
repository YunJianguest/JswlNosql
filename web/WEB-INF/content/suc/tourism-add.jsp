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
<script type="text/javascript" src="${contextPath}/js/upload/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/jquery.uploadify.v2.1.4.js"></script>
<script type="text/javascript" src="${contextPath}/js/upload/upload.js"></script>
<script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
<link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css" />

<script type="text/javascript"src="http://api.map.baidu.com/api?v=2.0&ak=okxlYE9HTRadFAnCltenxU6G"></script>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	jQuery('#keyword').tagsInput({height: '40px'});
	var validator = $("#custinfoForm").validate({
		rules: {
			title: {
                required: true
            },
            picurl:{
            	required: true
            }, 
			sort:{
				number: true
			},
		  latLng:{
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
function showMap(){
$('#insMap').modal({
		show : true
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
      
      <h2><i class="fa fa-user"></i> 微活动 <span>旅游管理</span></h2>
      
      
    </div>
   	<div class="row">
      <div class="col-md-12">
        <form class="form-horizontal" id="custinfoForm"  method="post"  action="${contextPath}/suc/tourism!save.action" onsubmit="return checksubmit()">
        <input type="hidden" id="_id" value="<s:property value='_id'/>"name="_id" /> 
           
                <div class="panel-body">
                	<div class="form-group">
                        <label class="col-sm-1 control-label">名称 <span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                        	
                        	<input type="text" id="title" class="form-control" value="<s:property value='title'/>" name="title" />      
                        </div>
                        <label class="col-sm-1 control-label">图片 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	<input type="text" id="uploadresult" class="form-control" value="<s:property value='picurl'/>" name="picurl"  />      
                        </div>
                        <div class="col-sm-1">
                        	<input type="file" name="uploadifyfile" id="uploadifyfile" /> 
									<script>
									uploadOneImgMulti();
									</script>
						</div>
                     
                     
                        
                	</div>
                	<div class="form-group">
                     
                       <label class="col-sm-1 control-label">电话 <span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                        	
                        	<input type="text" id="tel" class="form-control" placeholder="请输入电话" value="<s:property value='tel'/>" name="tel" />      
                        </div>
                        <label class="col-sm-1 control-label">位置<span class="asterisk">*</span></label>
                        <div class="col-sm-4">
                          
							<input type="text" name="latLng" id="latLng" readonly="readonly"  value="${entity.latLng}" class="form-control" />
						 
                        </div>
                         <div class="col-sm-2">
                         <a class="btn btn-primary" onclick="showMap()">选&nbsp;&nbsp;择</a> 
                        </div>
                	</div>
                 
                	 
                    <div class="form-group">
                    <label class="col-sm-1 control-label">摘要</label>
                        <div class="col-sm-8">
                          
									<input type="text" name="summary"  placeholder="请输入摘要"  value="<s:property value='summary'/>" class="form-control" />
						 
                        </div>
                        
                	</div>
                             
                    <div class="form-group">
                		<label class="col-sm-1 control-label">描述 <span class="asterisk">*</span></label>
                        <textarea style="display:none"  name="context" id="context" >${context}</textarea>
						 <div class="col-sm-11">
						 <c:if test="${fn:contains(context, 'ognl.OgnlContext') }">
						 <script id="editor" type="text/plain" style="width:960px;height:300px;">
                          
                         </script>  
						 </c:if>
						 <c:if test="${not empty context}">
						 <script id="editor" type="text/plain" style="width:960px;height:300px;">
                          ${context}
                         </script>
                         
						 </c:if>				
						 </div>
                        
                	</div>
                    
                    <div class="form-group">
                    <label class="col-sm-1 control-label">序号</label>
                        <div class="col-sm-8">
                          
									<input type="text" name="sort" id="sort" placeholder="0"  value="<s:property value='sort'/>" class="form-control" />
						 
                        </div>
                        
                	</div>
                    
                  
                 
            	</div>
            	
				<div class="panel-footer">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							
							<input type="submit" class="btn btn-success dropdown-toggle" value="提&nbsp;&nbsp;交"/> 
							<input type="reset" class="btn" value="重&nbsp;&nbsp;置" onClick="document.form.reset();"/>
							<input type="reset" class="btn btn-red" value="返&nbsp;&nbsp;回" onClick="history.back();"/>
				  		
						</div>
			 		</div>
		  		</div><!-- panel-footer -->
           </form>
    	</div><!-- panel -->
    	
	</div><!-- row -->
		
    </div><!-- contentpanel -->
</div>
</section>


 
<div id="insMap" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">&times;</button>
					 <h4 class="modal-title">
						<i class="fa fa-automobile"></i> 地图
					</h4>
				</div>
				<div class="modal-body">
					
					 
						<div class="panel panel-default">
							<div class="panel-body">
							<div class="form-group">
                    
                             <label class="col-sm-1 control-label"></label>
            
							<%@include file="/tengxmap/Map.jsp"%> 
                      
                	           </div>
				 		</div>
							<!-- panel-body -->

							<div class="panel-footer">
								<div class="row" >
									<div class="col-sm-9 col-sm-offset-3" >
										<button class="btn btn-success  btn-block" data-dismiss="modal" aria-hidden="true">确&nbsp;&nbsp;定</button>
									</div>
								</div>
							</div>

						</div>
						<!-- panel -->
					


				</div>
				<!-- row -->
			</div>
		</div>
	</div>

<script type="text/javascript">
  
    //初始化地图
    init();
    codeLatLng();
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    ue.ready(function() {
    	UE.getEditor('editor').setHeight(300);
    });
    
    function checksubmit()
    {
    	 $("#context").val(ue.getContent());
    	

    }
	
	 
    </script>

	
</body>
</html>
