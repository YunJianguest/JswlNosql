<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<%@include file="/webcom/jquery.validate_js.jsp"%>
<script type="text/javascript">
 
	function del(id) {
		if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/suc/activity!delete.action?fypage=${fypage}&_id=" + id;
		}
	}
	function  add(){
	       location.href = "${ctx}/suc/activity!input.action?fypage=${fypage}";
	}
	function share(url) {
		window.open("${contextPath}/weixin/share.action?method="+ encodeURIComponent(url));
	}
	function createewmurl(url,id){
	  if(url!=null&&url!=''){
	   window.open('${filehttp}/'+url); 
	   return;  
	  }
       var submitData = {
         id : id
      };
     $.post('${ctx}/suc/activity!ajaxcreateewm.action', submitData, function(json) {
       if(json.state==0){
        window.open('${filehttp}/'+json.value);
       }else{
        alert("生成二维码异常！");
       }
    
     }, "json"); 
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
			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/suc/activity.action">
				<div class="pageheader">
					<h2>
						<i class="fa fa-user"></i> 微官网 <span>活动管理</span>
					</h2>
					<div class="breadcrumb-wrapper1">
						<div class="input-group ">
        	               <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                      	             菜单 <span class="caret"></span>
                           </button>
                           <ul class="dropdown-menu pull-right" role="menu">
                           <li><a href="javascript:updfx('activity_share')"><i class="fa fa-share-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享填写</a></li>
            	           <li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加新活动</a></li>
            	           <li><a href="${ctx}/suc/slide.action?type=activity"><i class="fa fa-photo"></i>&nbsp;&nbsp;添加总活动幻灯片</a></li>
            	           <li><a href="javascript:qrcode('${ctxurl}/suc/totalactivity!web.action?custid=${custid}&type=5')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;首页预览</a></li>
                           </ul>
                        </div> 	
					</div>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table table-striped table-action table-primary mb30">
									<thead>
										<tr>
											<th class="table-action">序号</th>
											<th class="table-action">图片</th> 
											<th class="table-action">标题</th>  
											<th class="table-action">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="bean">
											<tr>
												<td>${bean.sort}</td> 
												<td><img src="${filehttp}/${bean.picurl}" height="25px" style="background-color: black;"/></i>
												</td>
												<td>${bean.title}</td>  
												</td>
												<td class="table-action">
													<div class="btn-group1">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i> </a>
														<ul role="menu" class="dropdown-menu pull-right">
															<li><a href="${ctx}/suc/activity!update.action?_id=${bean._id}"> <i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
															</li>

															<li><a href="javascript:del('${bean._id}');"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
															</li>
															<li><a href="${ctx}/suc/activity!yd.action?id=${bean._id}"><i
																	class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;预订管理</a>
															</li>
															<li><a href="javascript:createewmurl('${bean.ewmurl}',${bean._id})"><i
																	class="fa fa-eye "></i>&nbsp;&nbsp;&nbsp;&nbsp;生成兑奖二维码</a>
															</li>
														</ul>
													</div></td>
											</tr>
										</c:forEach>
								</table>
								<%@include file="/webcom/bracket-page.jsp"%>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</section> 
 <%@ include file="/webcom/share.jsp"%>
 <%@include file="/webcom/cut-img.jsp"%>
 <%@ include file="/webcom/preview.jsp"%> 
</body>
</html>
