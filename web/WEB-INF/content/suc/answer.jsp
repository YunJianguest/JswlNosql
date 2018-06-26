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
 <link rel="stylesheet" href="http://www.chemingpian.com/MyNosql/test/Bracket1.5/css/dropzone.css" />
<script type="text/javascript" src="http://www.chemingpian.com/MyNosql/test/Bracket1.5/js/dropzone.min.js"></script>

<script type="text/javascript">

function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/suc/answer!delete.action?_id="
				+ id;
				 
	}
}
 function add(){
	 window.location.href='${contextPath}/suc/answer!input.action?';
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
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/answer.action" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>问答管理</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li>
               
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
						<th class="th3">图片</th>
                        <th class="th8">标题</th>
				     	<th class="th12">摘要</th>
                        <th class="th5">时间</th> 
                        
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${AnswerInfoList}" var="bean">
                      <tr>
                       
                      	<td>${bean.sort}</td>
						<td ><img src="${osshttp}${bean.picurl}" style="height:25px;"></td>
						<td>${bean.title}</td> 
						<td>${bean.summary}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bean.createdate}" /></td>
						 
		 
					
                        <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                        <li><a href="${contextPath}/suc/answer!update.action?_id=${bean._id}">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                        <li><a href="javascript:del(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                        <li><a href="${ctx}/suc/answerdetail.action?wid=${bean._id}"><i class="fa fa-credit-card"></i>&nbsp;&nbsp;&nbsp;&nbsp;内容</a></li> 
                                       	<li><a href="javascript:share('${ctxurl}/suc/answer!web.action?_id=${bean._id}&toUser=${bean.toUser}&fromUser=fromUserData')" ><i class="fa fa-credit-card "></i>&nbsp;&nbsp;&nbsp;&nbsp;分享</a></li>
                                  
                                   
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
 
</body>
</html>
