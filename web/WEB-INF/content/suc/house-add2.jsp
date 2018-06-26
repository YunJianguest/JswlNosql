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
			name: {
                required: true
            },
            logo:{
            	required: true
            },
            page_lng:{
            	isFloat: true
            },
            page_lat:{
            	isFloat: true
            },
            mb:{
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
	function cke() {
		var str = "";
		var tmp = document.getElementsByName("ch_type");
		
		for (var i = 0;i < tmp.length; i++) { 
			if (tmp[i].checked) {
				str+=tmp[i].value+","
				
			}
		}
		$("#type").val(str);
		
	}
	function setcke() {
		var str = "${type}";
		var tmp = str.split(",");
		
		for (var i = 0;i < tmp.length; i++) { 
			$("#"+tmp[i]).attr("checked", "checked");
		}
	};	
	function xzsb() {
	    $('#tubiao').show();
	}
	function close_box(){
		$('#tubiao').hide();
	}
	function selsb(key,value){
		$('#css').val(key);
		$('#tubiao').hide();
	}
function pz(id,w,h,tag){
$("#clipArea").photoClip({
	    width: w,
	    height: h,
	    file: "#file",
	    view: "#view",
	    ok: "#clipBtn",
	    outputType:"jpg",
	    loadStart: function () {
	        console.log("照片读取中");
	    },
	    loadComplete: function () {
	        console.log("照片读取完成");
	    },
	    clipFinish: function (dataURL) {
	    	upimage(dataURL,id,tag);
	    	$('#clipArea').html('');
	    }
	});

	$('#jqpic').show();
}
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
      
      <h2><i class="fa fa-user"></i> 微网站内容 <span>企业管理</span></h2>
      
      
    </div>
   	<div class="row">
      <div class="col-md-12">
        <form class="form-horizontal" id="custinfoForm"  method="post"  action="${contextPath}/suc/house!save.action" onsubmit="return checksubmit()">
        	<input  id="_id" name="_id" value="<s:property value='_id'/>" type="hidden" />
			<input  id="toUserno" name="toUserno" value="<s:property value='toUserno'/>" type="hidden" />
			<input  id="appID" name="appID" value="<s:property value='appID'/>" type="hidden" />
			<input  id="appSecret" name="appSecret" value="<s:property value='appSecret'/>" type="hidden" />
			<input  id="fromUser" name="fromUser" value="<s:property value='fromUser'/>" type="hidden" />
			<input  id="createdate" name="createdate" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${createdate}'/>" type="hidden" />
            <div class="panel panel-default">
                
                <div class="panel-body">
                	<div class="form-group">
                        <label class="col-sm-1 control-label">名字 <span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                        	
                        	<input type="text" id="name" class="form-control" value="<s:property value='name'/>" name="name" />      
                        </div>
                        <label class="col-sm-1 control-label">关键字 <span class="asterisk">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" id="keyword" class="form-control" value="<s:property value='keyword'/>" name="keyword"/>
                        </div>
                         <label class="col-sm-1 control-label">LOGO<span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                        	
                        	<input type="text" id="logo" class="form-control" value="<s:property value='logo'/>" name="logo" placeholder="图片建议尺寸50*50."/>      
                        </div>
                          <div class="col-sm-1">
                            <div  class="button btn-primary " onclick="pz('logo','200','200',false)">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>上传</div>
                			</div>
                        </div> 
                        
                	</div>
                	<div class="form-group">
                        <label class="col-sm-1 control-label">行业 <span class="asterisk">*</span></label>
                        	<input type="hidden" id="type" value="<s:property value='type'/>" name="type" />
                        	<c:forEach items="${hylist}" var="bean" varStatus="status">
                        	<div class="col-sm-1">
							<label class="checkbox"> <input type="checkbox"  onclick="cke()"
								value="${bean.coding }" id="${bean.coding}" name="ch_type"  />
								${bean.title} </label>
								</div>
							</c:forEach>
                	</div>
                	<div class="form-group">
                       
                        
                        <label class="col-sm-1 control-label">幻灯片 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	<input type="text" id="picurl" class="form-control" value="<s:property value='picurl'/>" name="picurl" placeholder="图片建议尺寸640*320像素,可上传多张图片"/>      
                        </div>
                       <div class="col-sm-1">
                            <div  class="button btn-primary " onclick="pz('picurl','500','300',true)">
                    						<div class="an-normal "><i class="fa fa-scissors  pr-10"></i>上传</div>
                			</div>
                        </div> 
                            	
                        <label class="col-sm-1 control-label">简介 <span class="asterisk">*</span></label>
                        <div class="col-sm-4">
                            <input type="text" id="summary" class="form-control" value="<s:property value='summary'/>" name="summary" />
                        </div>
                        
                	</div>
                	<div class="form-group">
                		
                        <label class="col-sm-1 control-label">链接地址 </label>
                        <div class="col-sm-3">
                            <input type="text" id="toUserid" class="form-control" value="<s:property value='toUserid'/>" name="toUserid" placeholder="用户点击后跳转地址"/>
                        </div>
                        <label class="col-sm-1 control-label">到期日期</label>
                        <div class="col-sm-2">
                            <input type="text" name="enddate" required="required" placeholder="点击输入日期" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${enddate}'/>"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
										readonly="readonly" class="form-control" />
                        </div>
                        	 
                        <label class="col-sm-1 control-label">电话</label>
                        <div class="col-sm-2">
                            <input type="text" id="tel" class="form-control" value="<s:property value='tel'/>" name="tel"/>
                        </div>
                         
                        
                	</div>
                	<div class="form-group">
                	
                	 <label class="col-sm-1 control-label">经度 </label>
                        <div class="col-sm-1">
                            <input type="text" id="page_lng" value="${loc[0]}"name="page_lng" class="form-control"/>
                        </div>
                        <label class="col-sm-1 control-label">纬度</label>
                        <div class="col-sm-1">
                            <input type="text" id="page_lat" value="${loc[1]}"name="page_lat" class="form-control"/>
                        	
                        </div>
                       	<div class="col-sm-1">
                         	<a class="btn btn-primary" onclick="showMap()">选&nbsp;&nbsp;择</a> 
                        	
						</div>
                        <label class="col-sm-1 control-label">详细地址 </label>
                        <div class="col-sm-4">
                            <input type="text" id="address" class="form-control" value="<s:property value='address'/>" name="address"/>
                        </div>
                        
                	</div>
                	<div class="form-group">
                		<label class="col-sm-1 control-label">序号 <span class="asterisk">*</span></label>
                        <div class="col-sm-1">
                            <input type="text" id="sort" class="form-control" value="<s:property value='sort'/>" name="sort" />
                        </div>
                        <label class="col-sm-1 control-label">模板 <span class="asterisk">*</span></label>
                        <div class="col-sm-2">
                            <select  id="mb"  name="mb" class="form-control mb15"  data-placeholder="请选择">
            	 					    <option value="0">默认模板</option>
                    					<option value="1">模板一</option>
                    					<option value="2">模板二</option>
                    					<option value="3">模板三</option>
                    					<option value="4">模板四</option>
                 			</select>
                        </div>
                         <label class="col-sm-1 control-label">状态 <span class="asterisk">*</span></label>
                        <div class="col-sm-1">
									<s:select cssClass="form-control"  id="xs" name="xs"
										list="#{'0':'已审核','1':'待审核'}" listKey="key"
										listValue="value" headerKey="<s:property value='xs'/>" />
                        </div> 
                        <label class="col-sm-1 control-label">背景音乐 </label>
                        <div class="col-sm-2">
                            <input type="text" id="mp3" class="form-control" value="<s:property value='mp3'/>" name="mp3"/>
                        </div>
                	</div>
                	<div class="form-group">
                		<label class="col-sm-1 control-label">描述</label>
                		<textarea style="display:none"  name="context" id="context" >${context}</textarea>
                		<div class="col-sm-11">
										<script id="editor" type="text/plain" style="width:960px;height:300px;">${context}</script>
							</div>
					</div>
            	</div>
				<div class="panel-footer">
					<div class="row">
						<div class="col-sm-6 col-sm-offset-3">
							<input type="submit" class="btn btn-primary dropdown-toggle" value="提&nbsp;&nbsp;交"/>
							<input type="reset" class="btn btn-primary dropdown-toggle" value="重&nbsp;&nbsp;置" onclick="document.form.reset();"/>
							<input type="reset" class="btn btn-primary dropdown-toggle" value="返&nbsp;&nbsp;回" onclick="history.back();"/>
						</div>
			 		</div>
		  		</div>
    	</div>
    	</form>
	</div>
    </div>
</div>
</section>
<div class="fullscreen-xz cmp640" style="display: none;width: 400px;height: 100%;position:absolute;left:65%;  overflow: auto;" id="tubiao">
    <%@ include file="/marker/set/dict2.html"%>
</div>
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
            
							  <%@include file="/app/tengxmap/Map.jsp"%> 
                      
                	           </div>
				 		</div>
							<div class="panel-footer">
								<div class="row" >
									<div class="col-sm-9 col-sm-offset-3" >
										<button class="btn btn-primary dropdown-toggle" data-dismiss="modal" aria-hidden="true">确&nbsp;&nbsp;定</button>
									</div>
								</div>
							</div>

						</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="/webcom/cut-img.jsp"%> 
<script type="text/javascript">
init();
codeLatLng();
setcke();
$("#mb").val("${mb}");
$("#lx").val("${lx}");
 
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
