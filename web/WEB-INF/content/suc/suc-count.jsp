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
<script type="text/javascript" src="http://www.chemingpian.com/MyNosql/test/Bracket1.5/js/dropzone.min.js"></script>

<script type="text/javascript">
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
function delall() {
	if(confirm('确实要删除吗?')) {
	var ids="";
	$("input:checkbox").each(function(){
		if(this.checked==true||this.checked=='checked'){
			if(this.id!=='ck'){
				ids=ids+","+this.id;
			}
		}
    })
	if(ids.length<5){
		alert("请选择数据");
		return;
	}
    var submitData = {
		ids:ids
	};
	$.post('${contextPath}/ht/logis!delall.action', submitData,
	function(data) {
		page_submit(0);
	},"json")
	}
}
function check(){

	if($("#ck").attr("checked")==true||$("#ck").attr("checked")=='checked'){
		$("input:checkbox").attr("checked","true");
	}else{
		$("input:checkbox").each(function(){
             this.checked=false;
         })
	}
}
</script>

 
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/whd/whdcount.action?_id=${_id}" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 素材管理 <span>用户参与详情</span></h2>
      
      <div class="breadcrumb-wrapper1">
        <div class="input-group ">
        	<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu">
            	<li><a href="${contextPath}/whd/whdcount!exp.action?wid=${wid}&tpid=${tpid}&lx=${lx}"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;导出</a></li>
               
            </ul>
         </div>
      </div>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5">
            
            <div class="form-group col-sm-1d">
            <input type="text" name="from"  value="${from}" placeholder="用户ID"  class="form-control" />
            </div>    
            
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

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
                       <th class="th5"><input type="checkbox" onclick="check()" id="ck"></label></th>
                        <th class="th3">头像</th>
                        <th class="th10">昵称</th>
                        <th class="th10">会员号</th>
						<th class="th10">ID</th>
				     	<th class="th6">WID</th>	
				     	<th class="th6">TPID</th>				   
						<th class="th6">投票时间</th>
				        
				 	     
						 
					  
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${list}" var="bean">
                      <tr>
                      	<td><input type="checkbox" id="${bean._id }"></label></td>
                       	<td><div class="th2 sl"><img src="${bean.headimgurl}" style="height: 25px;"></div></td>
                       	<td><div class="th10 sl">${bean.nickname}</div></td>
                       	<td>${bean.no}</td>
                       	<td><div class="th25 sl">${bean.fromUser}</div></td>
                       	<td>${bean.wid}</td>
                       	<td>${bean.tpid}</td>
						<td><div class="th20 sl"><fmt:formatDate pattern="yy-MM-dd HH:mm" value="${bean.createdate}" /></div></td>
                        
		 
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
