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
        function add() {
            $('#no').val('');
            ps_show('inszc');
        }
     function submit(){
       var submitData = {
       id :$('#no').val()
     };
     if($('#no').val().length==0){
      alert("请输入会员号！");
      return;
     }
     $.post('${ctx}/suc/dating!datingServiceSave.action', submitData, function(json) {
       if(json.state==0){
         window.location.reload();
       }else{
        alert("添加失败！");
       }
    
     }, "json"); 
    }
    function del(id) {
		if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/suc/dating!datingServiceDel.action?fypage=${fypage}&id=" + id;
		}
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

        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/dating!datingService.action?">

            <div class="pageheader">

                <h2><i class="fa fa-user"></i>婚恋管理 <span>婚恋客服</span></h2>

                <div class="breadcrumb-wrapper1">
                 <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                          <li><a href="javascript:add()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加</a></li> 
                           
                        </ul>
                    </div>
                    
                </div>
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="id" value="${id}" placeholder="编号" class="form-control"/>
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
                                    <th class="th1 table-action">头像</th> 
                                    <th class="th5 table-action">姓名</th>
                                    <th class="th5 table-action">时间</th> 
 
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>

                                        <td><img src="${filehttp}/${bean.headimgurl}" style="height: 25px"/></td>
                                        <td>${bean.nickname}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td> 
                                        <td class="table-action">

                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right"> 
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
                        <i class="weight500 size14 pl-10 line-height50">客服管理</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div> 
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">会员号：</label>
                                <input type="text" id="no" name="no"
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
 </body>
</html>
