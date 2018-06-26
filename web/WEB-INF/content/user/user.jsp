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
                location.href = "${contextPath}/user/user!delete.action?_id=" + id;
            }
        }
        function add() {
            $('#_id').val('');
            $('#account').val('');
            $('#password').val('');
            $('#nickname').val('');
            $('#toUser').val('');
            $('#area').val('');
            $('#inszc').modal({
                show: true
            });
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/user/user!upd.action', submitData,
                    function (json) {
                        $('#_id').val(json._id);
                        $('#account').val(json.account);
                        $('#password').val(json.password);
                        $('#toUser').val(json.toUser);
                        $('#nickname').val(json.nickname);
                        $('#roleid').val(json.roleid);
                        $('#type').val(json.type); 
                        $('#province').val(json.province);
                        $('#city').val(json.city);
                        var funcs = json.funclist;
                        $('.ch_type').each(function () {
                            $(this).removeClass("gx-xz-dj");
                        });
                        for (var l = 0; l < funcs.length; l++) {
                            $("#func-" + funcs[l]._id).addClass("gx-xz-dj");
                        }
                        cke();
                        $('#mb').val(json.mb);
                    }, "json")
            $('#inszc').modal({
                show: true
            });
        }
        function submint() {
            var submitData = {
                id: $('#_id').val(),
                funcs: $('#funcs').val(),
                account: $('#account').val(),
                password: $('#password').val(),
                toUser: $('#toUser').val(),
                roleid: $('#roleid').val(),
                type: $('#type').val(),
                province: $('#province').val(),
                city: $('#city').val(),
                nickname: $('#nickname').val(),
                mb: $('#mb').val(),
            };
            $.post('${ctx}/user/user!ajaxsave.action', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("添加成功！");
                            window.location.reload();
                        }
                    }, "json")
            $('#inszc').modal({
                show: true
            });
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
        function cke(v) {
            if ($(v).hasClass('gx-xz-dj')) {
                $(v).removeClass("gx-xz-dj");
            } else {
                $(v).addClass("gx-xz-dj");
            }
            var str = "";
            $('.ch_type').each(function () {
                        if ($(this).is('.gx-xz-dj')) {
                            str += $(this).find('input').val() + ",";
                        }
                    }
            );
            $("#funcs").val(str);
        }
    </script>
    <style>
        .form-group-20 {
            margin-bottom: 20px;
        }

        .select2-container .select2-choice {
            line-height: 28px;
        !important;
        }

        .pr-10 {
            padding-right: 10px;
        }

        .pl-10 {
            padding-left: 10px;
        }

        .gx-xz {
            width: 18px;
            height: 18px;
            line-height: 18px;
            text-align: center;
            color: white;
            border: 1px solid #bbb;
            border-radius: 3px;
        }

        .gx-xz-dj {
            border: 1px solid #428BCA;
            background-color: #428BCA
        }
    </style>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post"
              action="${contextPath}/user/user.action?">
            <div class="pageheader">
                <h2>
                    <i class="fa fa-user"></i>微管理 <span>用户管理</span>
                </h2>

                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <div style="border-radius:3px; height:40px;padding-left:10px;" class="btn-primary">
                            <a href="javascript:add();" style="color: #ffffff;line-height:25px;">
                                新增&nbsp;<i class="fa fa-plus" style="line-height:30px;font-size: 14px;"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="title" value="${title}"
                                   placeholder="登陆名称" class="form-control"/>
                        </div>
                        <div class="form-group col-sm-1d">
                            <input type="text" name="wxname" value="${name}"
                                   placeholder="昵称" class="form-control"/>
                        </div>
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary mb30">
                                <thead>
                                <tr>
                                    <th class="th5">id</th>
                                    <th class="th5">名称</th>
                                    <th class="th8">密码</th>
                                    <th class="th8">创建时间</th>
                                    <th class="th8">角色</th>
                                    <th class="th8">创建者</th>
                                    <th class="th5">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${userList}" var="bean">
                                    <tr>
                                        <td>${bean._id}</td>
                                        <td>${bean.account}</td>
                                        <td>${bean.password}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.createdate}'/></td>
                                        <td>${bean.roleid}</td>
                                        <td>${bean.custid}</td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle"> <i
                                                        class="fa fa-cog"></i> </a>
                                                <c:if test="${bean.custid==custid}">
                                                    <ul role="menu" class="dropdown-menu pull-right">
                                                        <li><a
                                                                href="javascript:upd('${bean._id}');">
                                                            <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
                                                        </li>
                                                        <li><a href="javascript:del('${bean._id}');"><i
                                                                class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                        </li>
                                                    </ul>
                                                </c:if>
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
<div id="inszc" class="modal fade bs-example-modal-static"
     tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-leaf pr-10"></i>帐号管理
                </h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx}/user/user!save.action" class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="funcs" name="funcs"/>

                    <div class="row">
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">登录帐号</label>
                                <input type="text" id="account" name="account"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">登录密码</label>
                                <input type="text" id="password" name="password"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">单位名称:</label>
                                <input type="text" id="nickname" name="nickname"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">ToUser:</label>
                                <input type="text" id="toUser" name="toUser"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">角色:</label>
                                <select id="roleid" class="select2 form-control" style="line-height: 28px!important;"
                                        required data-placeholder="县域管理员">
                                    <c:forEach items="${rolelist}" var="bean">
                                        <option value="${bean._id }">${bean.rolename }</option>
                                    </c:forEach>
                                </select>
                                <label class="error" for="roleid"></label>
                            </div>
                           
                        </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">类型:</label>
                                <select id="type" class="select2 form-control" style="line-height: 28px!important;"
                                        required data-placeholder="管理员">
                                    <option value="1">普通用户</option>
                                    <option value="2">管理员</option>
                                </select>
                                <label class="error" for="type"></label>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">省份:</label>
                                <input type="text" id="province" name="province"
                                       class="form-control" placeholder="请输入"/>
                       </div>
                        </div> 
                         <div class="col-sm-2">
                            <div class="form-group-20">
                                <label class="control-label">区县:</label>
                                <input type="text" id="city" name="city"
                                       class="form-control" placeholder="请输入"/>
                       </div>
                      </div>   
                    <div class="row"> 
                        <div class="col-md-12">
                            <label class="control-label pr-10" style="padding-bottom:10px;!important;">个人中心菜单配置:</label>
                            <div>
                                <c:forEach items="${fromfunc}" var="bean" varStatus="status">
                                    <div class="pull-left pr-10 form-group-20">
                                        <div id="func-${bean._id}" class="pull-left gx-xz ch_type" onclick="cke(this)">
                                            <input type="hidden" value="${bean._id}"/>
                                            <i class="fa fa-check"></i>
                                        </div>
                                        <div class="pull-left pl-10">${bean.title}</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-md-2"> 
                             <div class="form-group-20">
                                <label class="control-label">个人中心模板:</label>
                                <select id="mb" name="mb" class="select2 form-control" style="line-height: 28px!important;"
                                        required data-placeholder="管理员">
                                    <option value="1">普通模板</option>
                                    <option value="2">分销模板</option>
                                </select>
                                <label class="error" for="type"></label>
                            </div>
                        </div>
                    </div> 
                      
                     
                </form>
                <div class="panel-footer">
                    <button class="btn btn-primary col-sm-2" onclick="submint()" style="padding: 9px 15px;">提交</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
