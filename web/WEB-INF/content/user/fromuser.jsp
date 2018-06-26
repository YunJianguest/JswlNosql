<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js"
            type="text/javascript"></script>
    <script type="text/javascript">
        function del(id) {
            if (confirm('确实要删除吗?')) {

                location.href = "${contextPath}/user/fromuser!delete.action?_id=" + id;
            }
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/user/fromuser!upd.action', submitData,
                    function (json) { 
                        $('#_id').val(json._id);  
                        $('#password').val(json.password);
                    }, "json");
           ps_show('inszc');  
        }
        function updjf(id){
          var submitData = {
                fromUserid: id
            };
           $.post('${ctx}/suc/integral!updIntegral.action', submitData,
                    function (json) { 
                        if(json.state==0){
                         alert("更新成功！");
                         location.reload();
                        }else{
                         alert("更新异常！");
                        }
                        
             }, "json");
        }
        function deljf(id) {
            if (confirm('确实要清空吗?')) {
              var submitData = {
                fromUserid: id
             };
             $.post('${ctx}/suc/integral!delIntegral.action', submitData,
                    function (json) { 
                        if(json.state==0){
                         alert("清除成功！");
                         location.reload();
                        }else{
                         alert("清除异常！");
                        }
                        
             }, "json");
            }
        }
        function setadmin(id) { 
              var submitData = {
                id: id
             };
             $.post('${ctx}/user/fromuser!setAndroidAdmin.action', submitData,
                    function (json) { 
                        if(json.state==0){
                         alert("设置成功！");
                         location.reload();
                        }else{
                         alert("设置异常！");
                        }
                        
             }, "json"); 
        }
        function sendMsg() {
        	if($("#_id").val().length==0){
        		alert("发送异常！");
        		return;
        	}
        	alert($("#msg").val());
        	if($("#msg").val().length==0){
        		alert("发送内容不能为空！");
        		return ;
        	}
            var submitData = {
              id:$("#_id").val()+",",
              msg:$("#msg").val()
           };
           $.post('${ctx}/user/remind!sendMsg.action', submitData,
                  function (json) { 
                      if(json.state==0){
                       alert("发送成功！"); 
                       ps_hide('insmsg');
                      }else{
                       alert("发送失败！");
                      }
                      
           }, "json"); 
      }
      function showMsg(id){
    	  $("#_id").val(id);
    	  $("#msg").val("");
    	  ps_show('insmsg');
      }
        function canceladmin(id) { 
              var submitData = {
                id: id
             };
             $.post('${ctx}/user/fromuser!cancelAndroidAdmin.action', submitData,
                    function (json) { 
                        if(json.state==0){
                         alert("取消成功！");
                         location.reload();
                        }else{
                         alert("取消异常！");
                        }
                        
             }, "json"); 
        }
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
        function share(url) {
            window.open("${contextPath}/weixin/share.action?method=" + encodeURIComponent(url));
        }
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post"
              action="${contextPath}/user/fromuser.action?">
            <div class="pageheader">
                <h2>
                    <i class="fa fa-user"></i>微管理 <span>用户管理</span>
                </h2>
                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                            <a href="javascript:updfx('fromuser_share')" style="color: #ffffff;line-height:25px;">
                                会员卡分享填写&nbsp;<i class="fa fa-plus" style="line-height:30px;font-size: 14px;"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="nickname" value="${nickname}"
                                   placeholder="昵称" class="form-control"/>
                        </div>
                        <div class="form-group col-sm-1d">
                            <s:select id="isline" cssClass="form-control" name="isline"
                                      list="#{'':'全部','1':'在线','0':'离线'}" listKey="key"
                                      listValue="value"/>
                        </div>
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30">
                                <thead>
                                <tr>
                                    <th class="th5 table-action">昵称</th>
                                    <th class="th5 table-action">ID</th>
                                    <th class="th5 table-action">会员号</th>
                                    <th class="th5 table-action">头像</th>
                                    <th class="th5 table-action">在线状态</th>
                                    <th class="th8 table-action">创建时间</th>
                                    <th class="th8 table-action">最后登录时间</th>
                                    <th class="th8 table-action">管理员</th>
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${userList}" var="bean">
                                    <tr>
                                        <td>${bean.nickname}</td>
                                        <td>${bean._id}</td>
                                        <td>${bean.no}</td>
                                        <td><img src="${filehttp}/${bean.headimgurl}" height="25px"/></td>
                                        <td><c:if test="${empty bean.online}">离线</c:if><c:if test="${bean.online==0}">离线</c:if><c:if test="${bean.online==1}">在线</c:if></td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.createdate}'/></td>
                                        <td><c:if test="${not empty bean.logindate }"><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.logindate}'/></c:if>
                                             <c:if test="${empty bean.logindate}">暂无信息</c:if>
                                                            
                                                            </td>
                                        <td>
                                        <c:if test="${bean.androidAdmin==1}">
                                        是
                                        </c:if>
                                        <c:if test="${bean.androidAdmin==0}">
                                        否
                                        </c:if>
                                         <c:if test="${empty bean.androidAdmin}">
                                        否
                                        </c:if>
                                        </td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle"> <i
                                                        class="fa fa-cog"></i> </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                <li><a href="javascript:updjf('${bean._id}');">
                                                            <i class="fa fa-refresh"></i>&nbsp;&nbsp;&nbsp;&nbsp;更新积分</a>
                                                </li>
                                                <li><a href="javascript:upd('${bean._id}');">
                                                            <i class="fa fa-refresh"></i>&nbsp;&nbsp;&nbsp;&nbsp;修改密码</a>
                                                </li>
                                                <li><a href="javascript:setadmin('${bean._id}');">
                                                            <i class="fa fa-refresh"></i>&nbsp;&nbsp;&nbsp;&nbsp;设置管理员</a>
                                                </li>
                                                <li><a href="javascript:canceladmin('${bean._id}');">
                                                            <i class="fa fa-refresh"></i>&nbsp;&nbsp;&nbsp;&nbsp;取消管理员</a>
                                                </li>
                                                <li><a href="javascript:deljf('${bean._id}');">
                                                            <i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;清空积分</a>
                                                </li>
                                                <li><a href="javascript:del('${bean._id}');">
                                                            <i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;删除用户</a>
                                                </li>
                                                <c:if test="${bean.online==1}">
                                                <li><a href="javascript:showMsg('${bean._id}');">
                                                            <i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;发送消息</a>
                                                </li>
                                                </c:if> 
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
        </form>
    </div>
</section>
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">添加内容</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/user/fromuser!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" name="nickname" value="${nickname}"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
 
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">登录密码：</label>
                                <input type="password" id="password" name="password"
                                       class="form-control"  placeholder="请输入"/>
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

<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="insmsg" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">发送消息</i>
                    </div>
                    <a href="javascript:ps_hide('insmsg')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div> 
                    <input type="hidden" id="_id"/>
                    <%--row--%> 
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
 
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">发送内容：</label>
                                <textarea type="text" id="msg" 
                                       class="form-control" style="height: 100px" placeholder="请输入"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;" onclick="sendMsg()">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div> 
            </div>
        </div>
    </div>
</div> 
<%@ include file="/webcom/share.jsp" %>
<%@include file="/webcom/cut-img.jsp" %>
<script type="text/javascript">  
$('#isline').val('${isline}');
</script>
</body>
</html>
