<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/media/js/DT_bootstrap.js"></script>

    <script type="text/javascript">
        var fid=''; 
        function page_submit(num) {

            if (num == -1) {
                $("#fypage").val(0);
            } else if (num == -2) {
                $("#fypage").val($("#fypage").val() - 1);
            } else {
                $("#fypage").val(num);
            }

            $("#custinfoForm").submit();
        } 
         function del(id) {
		   if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/suc/vivo/vivodraw!membersdel.action?fypage=${fypage}&_id=" + id;
		  }
	   }
	 function submit(){ 
       var submitData = {
    		   _id:$('#_id').val(),
    		   name:$('#name').val(),
    	       tel:$('#tel').val(),
    	       address:$('#address').val(),
        
     };
     
     $.post('${ctx}/suc/vivo/vivodraw!memberssave.action', submitData, function(json) {
       if(json.state==0){
         window.location.reload();
       }else{
        alert("添加失败！换个试试！");
       }
    
     }, "json"); 
    }
       function add() { 
    	    $('#_id').val('');
    	    $('#name').val('');
            $('#tel').val('');  
            $('#address').val('');  
            ps_show('inszc');
        }
       function upd(id) {
           var submitData = {
               _id: id
           };
           $.post('${ctx}/suc/vivo/vivodraw!membersupd.action', submitData, function (json) {
               $('#_id').val(json._id);
               $('#name').val(json.name);
               $('#tel').val(json.tel); 
               $('#address').val(json.address);

           }, "json")

           ps_show('inszc');
       }
       function  inexp(){
    	   ps_show('inszcexp');
    	   
       }
    </script>
    <style>
        .form-group-20 {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>

<section>

    <%@include file="/webcom/header-bracket.jsp" %>

    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>

        <form id="custinfoForm" name="custinfoForm" method="post" action="${ctx}/suc/vivo/vivodraw!members.action">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>vivo世界杯 <span>员工管理</span></h2>

                <div class="breadcrumb-wrapper1">
                 <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                          <li><a href="javascript:add()"><i class="fa fa-share-alt-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a></li> 
                           <li><a href="javascript:inexp()"><i class="fa fa-share-alt-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;导入</a></li> 
                          
                          
                        </ul>
                    </div>
                    
                </div>
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="title" value="${title}" placeholder="名称" class="form-control"/>
                        </div>

                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

                    </div>
                </div>
                <!-- panel-body -->
            </div>
            <!-- panel -->

            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30">
                                <thead>
                                <tr>
                                    <th class="th5 table-action">姓名</th>
                                    <th class="th1 table-action">电话</th>
                                    <th class="th1 table-action">区域</th>   
                                    <th class="th5 table-action">时间</th>
                                    
                                    
 
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean.name}</td>
                                        <td>${bean.tel}</td> 
                                        <td>${bean.address}</td>  
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        
                                        <td class="table-action">

                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:upd('${bean._id}');"><i
                                                            class="fa fa-plus "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
                                                    </li> 
                                                    <c:if test="${not empty bean.fromid}">
                                                    <li><a href="${ctx}/suc/vivo/vivodraw!cardtj.action?selfromid=${bean.fromid}"><i
                                                            class="fa fa-plus "></i>&nbsp;&nbsp;&nbsp;&nbsp;卡包</a>
                                                    </li> 
                                                    </c:if>
                                                    <li><a href="javascript:del('${bean._id}');"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li> 
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </table>
                            <%@include file="/webcom/bracket-page.jsp" %>

                        </div>
                    </div>
                </div>

            </div>
            <!-- contentpanel -->
        </form>
    </div>
    <!-- mainpanel -->
</section>


<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">员工添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div> 
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                     <input type="hidden" id="_id" name="_id" 
                                       class="form-control" placeholder="请输入"/>

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">姓名：</label>
                                <input type="text" id="name" name="name"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">电话：</label>
                                <input type="text" id="tel" name="tel"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">区域：</label>
                                <input type="text" id="address" name="address"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                         
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;" onclick="submit()">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div> 
            </div>
        </div>
    </div>
  </div>
  
   
  <%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszcexp" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">数据导入</i>
                    </div>
                    <a href="javascript:ps_hide('inszcexp')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div> 
                <form action="${ctx}/suc/vivo/excel!importExp.action" method="POST" enctype="multipart/form-data">
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
 
                          <input type="hidden"  name="returnurl"
                                       class="form-control" value="vivodraw!members.action" />
                          <input type="hidden"  name="datatype"
                                       class="form-control" value="employees" />
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">导入数据：</label>
                                <input type="file" id="expexcel" name="image"
                                       class="form-control" dat="djcode" />
                            </div>
                        </div>
                         
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;" >
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div>
                 </form> 
            </div>
        </div>
    </div>
  </div>
<%@ include file="/webcom/share.jsp" %> 
<%@include file="/webcom/cut-img.jsp" %> 
<%@ include file="/webcom/preview.jsp" %>
</body>
</html>
