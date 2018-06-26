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

<script type="text/javascript"> 
function dj(id) {
	if (confirm('确实要给兑奖吗?')) {
	 var submitData = { 
         id:id
       }; 
        $.post('${ctx}/suc/farm!ajaxhtdj.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) { 
                        if (json.state == '0') {
                             $("#fypage").val($("#fypage").val()+1);	
                             window.location.reload();
                        } else {
                          alert('兑奖失败！');
                        }  
                        
                    }, "json");
		 
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
 function   fh(id){
            $('#cid').val(id);
            $('#courierName').val('');
            $('#courierNo').val(0);
            $('#state').val(0);
            ps_show('inszc');
   }	 
</script>
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/farm!card.action?id=${hdid}" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i>微农场 <span>卡卷统计</span></h2>
      <div class="breadcrumb-wrapper1">
          <div class="input-group ">
              <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                  <a href="${ctx}/suc/farm!exp.action?hdid=${hdid}"style="color: #ffffff;line-height:25px;">
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
                <input type="text" name="djm" id="djm"  value="${djm}" placeholder="中奖码"  class="form-control" />
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
						<th class="th5">头像</th> 
						<th class="th5">兑奖结束日期</th>  
						<th class="th5">兑奖码</th>
						<th class="th5">地址</th>
						<th class="th5">状态</th> 
						<th class="th5">操作</th>
				         
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${list}" var="bean">
                      <tr>
                      	<td>${bean.title}</td>
                      	<td>${bean.nickname}</td> 
						<td><img src="${filehttp}/${bean.headimgurl}" height="25px"/></td> 
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
														value="${bean.enddjdate}" /></td>
						<td>${bean.djm}</td>
						<td>${bean.address}</td>
						<td> 
						<c:if test="${bean.state==0}">
						<a href="javascript:dj(${bean._id});" class="tip"><span
														class="label label-primary">兑奖</span> </a>
						</c:if>
						<c:if test="${bean.state==1}"><span
								class="label bg-hei-5">已兑奖</span></c:if>
						 
						<c:if test="${bean.state==3}"><span
								class="label bg-cheng">已发货</span></c:if>
						 
						<c:if test="${bean.state==4}"><span
								class="label bg-grean">已签收</span></c:if>
						 
						<c:if test="${bean.state==5}"><span
								class="label bg-hei-8">退货</span></c:if>
						</td>
						 <td class="table-action">
                              
                              <div class="btn-group1">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                   
                                      <li><a href="javascript:fh('${bean._id}');">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;发货</a></li>
                                   
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
 

<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">卡卷管理</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/suc/farm!updatecard.action?fypage=${fypage}&id=${hdid}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="cid" name="cid"/> 
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">快递公司：</label>
                                <select id="courierName" name="courierName" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                        <c:forEach items="${lskd}" var="bean">
                                        <option value="${bean.title}">${bean.title }</option>
                                        </c:forEach>
                                  
                                </select> 
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">快递单号:</label>
                                <input type="text" id="courierNo" name="courierNo"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">状态：</label>
                                <select id="state" name="state" class="select2 form-control hang40" style="line-height: 28px!important;"
                                        required data-placeholder="请选择">
                                  <option value="3">发货</option>
                                  <option value="5">退货</option>
                                </select> 
                            </div>
                        </div>
                        
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
