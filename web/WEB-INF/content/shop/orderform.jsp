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
<script type="text/javascript">

function del(id) {
	if (confirm('确实要删除吗?')) {
		location.href = "${contextPath}/shop/orderform!delete.action?_id="
				+ id+"&fypage=${fypage}&comid=${comid}&state=${state}";
	}
}
function exp() {
	var sel_state=$("#sel_state").val();
	var sel_insdate=$("#sel_insdate").val();
	var sel_enddate=$("#sel_enddate").val(); 
	location.href = "${ctx }/shop/orderform!orderfromexp.action?comid=${comid}&sel_state="+sel_state+"&sel_insdate="+sel_insdate+"&sel_enddate="+sel_enddate;
	
}
function fh(id){
	var submitData = {
			_id:id
	};
	$.post('${ctx}/shop/orderform!upd.action', submitData,
		function(json) {
			$('#_id').val(json._id);
			$('#state').val(json.state);
			$('#kdno').val(json.kdno);
			$('#kdcom').val(json.kdcom);
				
	},"json")
	$('#insdd').modal({ 
	    show:true
	});
}
 
function wxpay(id){
	var submitData = {
			payid:id
	};
	$.post('${ctx}/shop/orderform!wxpay.action', submitData,
		function(json) {
			$('#payname').val(json.name);
			$('#price').val(json.price.tofixed(2));
			$('#spbill_create_ip').val(json.spbill_create_ip);
			
				
	},"json")
	$('#paydiv').modal({ 
	    show:true
	});
	
} 
function orderinfo(id){
	var submitData = {
			orderid:id
	};
	$.post('${ctx}/shop/orderform!orderinfo.action', submitData,
		function(json) {
			var xszf='';
			var v = json.list;
			
			for(var i=0;i<v.length;i++){
				xszf=xszf+'<div class="form-group"><label class="col-sm-12 control-label">'+v[i].title+'  价格 ：'+v[i].price+'  数量： '+v[i].num+'</label>'+
				'</div>';
			}
			$('#orderxs').html(xszf);
			
				
	},"json")
	$('#orderdiv').modal({ 
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
 

 </script>

 
</head>

<body>

<section>

  <%@include file="/webcom/header-bracket.jsp"%>

  <div class="mainpanel">
	<%@include file="/webcom/header-headerbar.jsp"%>
    
    
    
   
    
	<form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/shop/orderform.action?comid=${comid}" >
    
    <div class="pageheader">
      
      <h2><i class="fa fa-user"></i> 微网站 <span>订单管理</h2>
      
      <div class="breadcrumb-wrapper1">
          <div class="input-group ">
              <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                  <a href="javascript:exp();"style="color: #ffffff;line-height:25px;">
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
            <input type="text" name="name"  value="${name }" placeholder="姓名"  class="form-control" />
            </div> 
            <div class="form-group col-sm-1d">
            <input type="text" name="tel"  value="${tel }" placeholder="电话"  class="form-control" />
            </div> 
            <div class="form-group col-sm-1">
            <input type="text" name="no"  value="${no}" placeholder="编号"  class="form-control" />
            </div> 
            <div class="form-group col-sm-1d">
            	<select  id="sel_state"  name="state" class="form-control "  data-placeholder="请选择">
            	                <option value="">请选择</option>
            	 				<option value="1">订单</option>
                    			<option value="2">已购买</option>
                    			<option value="3">已发货</option>
                    			<option value="4">已收货</option>
                    			<option value="5">退货</option>
                    			
                 </select>
            </div>
            <div class="form-group col-sm-1">
                 <input type="text" id="sel_insdate" name="sel_insdate" value="${sel_insdate}" placeholder="开始日期"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="form-control" />
            </div>
             <div class="form-group col-sm-1">
                 <input type="text" id="sel_enddate" name="sel_enddate" value="${sel_enddate}" placeholder="结束日期"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="form-control" />
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
                       	<th class="th5">昵称</th>
                        <th class="th5">编号</th>
						<th class="th8">快递号</th> 
				     	<th class="th2">金额</th>
				     	 
				     	<th class="th2">数量</th>
				        <th class="th8">姓名</th>
						<th class="th4">电话</th>
						<th class="th6">地址</th>
                        <th class="th6">日期</th>
                        <th class="th6">备注</th>
                        <th class="th6">状态</th>
						
						<th class="th5">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${OrderFormList}" var="bean">
                      <tr>  
                       <td>${bean.nickname}</td>
                      	<td>${bean._id}</td>
						<td>${bean.kdno}</td> 
						<td><c:if test="${bean.zfmoney>0.0}"><a href="javascript:wxpay('${bean.payid}')" ><fmt:formatNumber value='${bean.zfmoney }' pattern="0.0#"/></a></c:if></td>
						 
						<td><a href="javascript:orderinfo('${bean._id}')" >${bean.count}</a></td>
						<td>${bean.name}</td>
						<td>${bean.tel}</td>	
						<td title="${bean.address}"><div class="th6 sl">${bean.address}</div></td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bean.insDate}" /></td>
                        <td>${bean.remark}</td>
                        <td><c:if test="${bean.state=='1'}">下单</c:if>
                        	<c:if test="${bean.state=='2'}">已购买</c:if>
							<c:if test="${bean.state=='3'}"><span style="color:#F00">已发货</span></c:if>
							<c:if test="${bean.state=='4'}"><span style="color:#F00">已收货</span></c:if>
							<c:if test="${bean.state=='5'}"><span style="color:#F00">已退货</span></c:if></td>
							 
						
					
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
 <div id="paydiv" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 查看支付信息</h4>
            </div>
            <div class="modal-body">
                
                	
                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">备注: <span class="asterisk">*</span></label>
                                <div class="col-sm-9">
                                   
                                   <input type="text" id="payname" name="name" class="form-control" placeholder="请输入" />
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">支付金额: <span class="asterisk">*</span></label>
                                <div class="col-sm-9">
                                   
                                   <input type="text" id="price" name="price" class="form-control" placeholder="请输入" />
                                </div>
                                
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">IP: <span class="asterisk">*</span></label>
                                <div class="col-sm-9">
                                   
                                   <input type="text" id="spbill_create_ip" name="spbill_create_ip" class="form-control" placeholder="请输入" />
                                </div>
                                
                            </div>
                           
                            
                        </div>
                        <!-- panel-body -->

                       

                    </div>
                    <!-- panel -->
               


            </div>
            <!-- row -->
        </div>
    </div>
</div>
 <div id="orderdiv" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa fa-automobile"></i> 查看商品信息</h4>
            </div>
            <div class="modal-body">
                
                	
                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div id="orderxs"></div>
                        	
                            
                            
                        </div>
                        <!-- panel-body -->

                       

                    </div>
                    <!-- panel -->
               


            </div>
            <!-- row -->
        </div>
    </div>
</div>
<div id="insdd" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title">维护订单</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${contextPath}/shop/orderform!save.action?fypage=${fypage}&comid=${comid}" class="form-horizontal"  method="post" >
                	<input type="hidden" id="_id" name="_id" />
                	

                   
                	<div class="form-group">
                		<label class="col-sm-2 control-label">快递公司<span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	
                       		<select  id="kdcom"  name="kdcom" class="form-control "  data-placeholder="请选择">
                       			<option value="">无</option>
            	 				<c:forEach items="${lskd}" var="bean">
            	 				<option value="${bean._id}">${bean.title}</option>
            	 				</c:forEach>
                    			
                    			
                 			</select>
                        </div>
                    	<label class="col-sm-2 control-label">快递单号 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	
                       		<input type="text" id="kdno" class="form-control" placeholder="运单号"  name="kdno" />      
                        </div>
                    </div>  
                    <div class="form-group">    
                         <label class="col-sm-2 control-label">状态 <span class="asterisk">*</span></label>
                        <div class="col-sm-3">
                        	<select  id="state"  name="state" class="form-control "  data-placeholder="请选择">
            	 				<option value="1">订单</option>
                    			<option value="2">已购买</option>
                    			<option value="3">已发货</option>
                    			<option value="4">已收货</option>
                    			<option value="5">退货</option>
                    			
                 			</select>
                        	
                        </div>
                	</div>
                	 
            	</div>
            	
            	 <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-12">
                                    <button class="btn btn-primary btn-block">提&nbsp;&nbsp;交</button>
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
<script type="text/javascript"> 
if('${state}'!=0){ 
$('#sel_state').val('${state}'); 
}
</script>

</body>
</html>
