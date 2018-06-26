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
            logo:{
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
	
</script>
 
 
</head>

<body>

<section>

<%@include file="/webcom/header-bracket.jsp"%>

<div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    

    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>订单管理</span></h2>
      
      
    </div>
   	<div class="row">
      <div class="col-md-12">
        <form class="form-horizontal" id="custinfoForm"  method="post"  action="${contextPath}/shop/orderform!save.action?fypage=${fypage}" onSubmit="return checksubmit()">
        <input type="hidden" id="_id" value="<s:property value='_id'/>"
								name="_id" />
                               
                
                <div class="panel-body">
                	<div class="form-group">
                        <label class="col-sm-1 control-label">订单号 <span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                        	
                        	<input type="text" id="no" class="form-control" value="<s:property value='no'/>" readonly="readonly"  name="no"/>      
                        </div>
                        <label class="col-sm-1 control-label">姓名 <span class="asterisk">*</span></label>
                        <div class="col-sm-1d">
                        	<input type="text" id="name" class="form-control" value="<s:property value='name'/>" readonly="readonly" name="name" />      
                        </div>     
                	</div>
                	<div class="form-group">
                    
                    
                        <label class="col-sm-1 control-label">运单号 <span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                        	
                       <input type="text" id="kdno" class="form-control" placeholder="运单号" value="<s:property value='kdno'/>" name="kdno" />      
                        </div>
                        
                        
                         <label class="col-sm-1 control-label">活动类型 <span class="asterisk">*</span></label>
                        <div class="col-sm-1d">
                        	
                        	<s:select  cssClass="form-control" id="state" name="state"
									
										list="#{'1':'订单','2':'确认','3':'发货','4':'收货','5':'退货','6':'取消'}"
										 listKey="key" listValue="value"
										headerKey="<s:property value='state'/>" />
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
           
    	</div><!-- panel -->
    	</form>
	</div><!-- row -->
		
    </div><!-- contentpanel -->
</div>
</section>

 	
</body>
</html>
