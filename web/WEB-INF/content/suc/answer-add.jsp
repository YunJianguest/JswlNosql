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
			newtitle: {
                required: true
            } 
			,
		   sort:{
			     number: true
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
      
      <h2><i class="fa fa-user"></i>微管理 <span>问答管理</span></h2>
      
      
    </div>
   	<div class="row">
      <div class="col-md-12">
        <form class="form-horizontal" id="custinfoForm"  method="post"  action="${contextPath}/suc/answer!save.action" onSubmit="return checksubmit()">
        <input type="hidden" id="_id" value="<s:property value='_id'/>" name="_id" /> 
		<input type="hidden" id="comid" value="<s:property value='comid'/>" name="comid" />
        <input type="hidden" id="type" value="<s:property value='type'/>" name="type" />

                
                <div class="panel-body">
                	<div class="form-group">
                        <label class="col-sm-1 control-label">标题 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	
                        	<input type="text" id="title" class="form-control" value="<s:property value='title'/>" name="title" />      
                        </div>
                       <label class="col-sm-1 control-label">模板 <span class="asterisk">*</span></label>
                        <div class="form-group col-sm-1d">
                        <!-- '0':'问答模板','1':'调查问卷', -->
                          <s:select  name="mb" cssClass="form-control"  list="#{'2':'随机考试','3':'默认模板'}" id="mb" listKey="key" listValue="value" headerKey="<s:property value='mb'/>">
                          </s:select>
                        </div>
                       <label class="col-sm-1 control-label">频率<span class="asterisk">*</span></label>
                       <div class="form-group col-sm-1d">
                          <s:select  name="rate" cssClass="form-control"  list="#{'0':'不限次数','1':'每日一次','2':'每日二次','3':'每日三次','4':'每日四次','5':'每日五次','8':'每日八次','10':'每日十次','99':'停止'}" listKey="key" listValue="value" headerKey="<s:property value='rate'/>" >
                          </s:select>
                       </div>
                      
	         
                 	</div>
                 	<div class="form-group">
                       
                       <label class="col-sm-1 control-label">出题数 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	
                        	<input type="text" id="cts" class="form-control" value="<s:property value='cts'/>" name="cts" />      
                        </div>
                        <label class="col-sm-1 control-label">答题时间 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	
                        	<input type="text" id="dtsj" class="form-control" value="<s:property value='dtsj'/>" name="dtsj" />分钟      
                        </div>
	         
                 	</div>
                
                	<div class="form-group">
                	   
                        <label class="col-sm-1 control-label">图片 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	<input type="text" id="uploadresultTwo" class="form-control" value="<s:property value='picurl'/>" name="picurl"  />      
                        </div>
                        <div class="col-sm-1">
                        	<input type="file" name="uploadifyfileTwo" id="uploadifyfileTwo" /> 
									<script>
									uploadTwoImg();
									</script>
			           </div>
			           
                        
                    </div>
                    
                  <div class="form-group">
                     <label class="col-sm-1 control-label">不及格提示<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="result0"  placeholder="请输入提示"  value="<s:property value='result0'/>" class="form-control" />
                     </div>
                   </div>
                     
                     <div class="form-group">
                     <label class="col-sm-1 control-label">60分提示<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="result6"  placeholder="请输入提示"  value="<s:property value='result6'/>" class="form-control" />
                     </div>
                   </div>
                     <div class="form-group">
                     <label class="col-sm-1 control-label">70分提示<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="result7"  placeholder="请输入提示"  value="<s:property value='result7'/>" class="form-control" />
                     </div>
                   </div>
                     <div class="form-group">
                     <label class="col-sm-1 control-label">80分提示<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="result8"  placeholder="请输入提示"  value="<s:property value='result8'/>" class="form-control" />
                     </div>
                   </div>
                     <div class="form-group">
                     <label class="col-sm-1 control-label">90分提示<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="result9"  placeholder="请输入提示"  value="<s:property value='result9'/>" class="form-control" />
                     </div>
                   </div>
                    
                     <div class="form-group">
                     <label class="col-sm-1 control-label">100分提示<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="result10"  placeholder="请输入提示"  value="<s:property value='result10'/>" class="form-control" />
                     </div>
                   </div>
                    <div class="form-group">
                     <label class="col-sm-1 control-label">摘要<span class="asterisk">*</span></label>
                          <div class="col-sm-10">
                          <input type="text" name="summary"  placeholder="请输入摘要"  value="<s:property value='summary'/>" class="form-control" />
                     </div>
                   </div>
               
                  <div class="form-group">
                	 <label class="col-sm-1 control-label">描述 <span class="asterisk">*</span></label>
                     <textarea style="display:none"  name="context" id="context" >${context}</textarea>
					 <div class="col-sm-11">
						 <script id="editor" type="text/plain" style="width:960px;height:300px;">${context}</script>
					 </div>           
                 </div>
                 <div class="form-group">
                    
                    <label class="col-sm-1 control-label">序号 <span class="asterisk">*</span></label>
                    <div class="col-sm-1">
                        <input type="text" id="sort" class="form-control" value="<s:property value='sort'/>" name="sort" />      
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


<script type="text/javascript">
 
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
