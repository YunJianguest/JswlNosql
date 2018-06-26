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
<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet"> 

<script type="text/javascript"> 
function dj(id,hdid) {
	if (confirm('确实要给兑奖吗?')) { 
          var submitData = {
            id:id,
            hdid:hdid
            };
            $.post("${ctx}/suc/vivo/vivodraw!carddj.action?",submitData,function(json){
               
              if(json.state==0){
                window.location.reload();
              }else{
              alert(json.value);
              }
            },"json");
          
	}
}
function del(id) {
	if (confirm('确实要删除吗?')) { 
          var submitData = {
            _id:id, 
            };
            $.post("${ctx}/suc/vivo/vivodraw!delcardreload.action?",submitData,function(json){
               
              if(json.state==0){
                window.location.reload();
              }else{
              alert("删除异常");
              }
            },"json");
          
	}
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
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/vivo/vivodraw!cardtj.action?selfromid=${selfromid}" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>摇奖管理 <span>中奖统计</span></h2>
      <div class="breadcrumb-wrapper1">
          <div class="input-group ">
              <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                  <a href="${ctx}/suc/vivo/vivodraw!expcard.action?hdid=${hdid}"style="color: #ffffff;line-height:25px;">
                      导出&nbsp;<i class="fa fa-mail-reply-all"style="line-height:30px;font-size: 14px;"></i>
                  </a>
              </div>
          </div>
      </div>
    </div>
   <div class="panelss ">
   <div class="panel-body fu10">
        <div class="row-pad-5"> 
            <div class="form-group col-sm-1d">
                <input type="text" name="jp" id="jp"  value="${jp}" placeholder="奖品名称"  class="form-control" />
            </div> 
            <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

        </div>
    </div><!-- panel-body -->
	</div><!-- panel -->

    <div class="panel-body">
      <div class="row">
		<div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-primary mb30" >
                    <thead>
                      <tr>
                        <th class="th2">奖品</th>
                      	<th class="th2">昵称</th>  
						<th class="th5">中奖日期</th> 
						<th class="th5 table-action">操作</th>   
				         
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${rewardList}" var="bean">
                      <tr>
                      	<td>${bean.jp}</td>
                      	<td>${bean.card.title}</td>  
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
														value="${bean.createdate}" /></td>
														 <td class="table-action">
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right"> 
                                        <li><a href="javascript:del(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                        
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
 

<script type="text/javascript">
$('#state').val('${state}');
</script>
</body>
</html>
