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
            if(confirm('确实要删除吗?')) {
                location.href = "${ctx}/suc/signup!delete.action?fypage=${fypage}&_id="+ id;
            }
        }
        function add(){
            location.href ="${ctx}/suc/signup!input.action?fypage=${fypage}";
        }
        function upd(id){
            var submitData = {
                id : id
            };
            $.post('${ctx}/suc/signup!upd.action', submitData, function(json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#summary').val(json.summary);
                $('#url').val(json.url);
                $('#sort').val(json.sort);
                $('#type').val(json.type);
                $('#uploadresultFour').val(json.picurl);
            }, "json")
            $('#insadd').modal({
                show : true
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
        <form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/signup.action" >
            <div class="pageheader">
                <h2><i class="fa fa-user"></i>素材管理 <span>报名管理</span></h2>
                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"style="color: white;"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu"> 
                            <li><a href="${ctx}/suc/slide.action?type=bbs"><i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片管理</a></li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/bbs!index.action?custid=${custid}')" ><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;效果预览</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-primary mb30" >
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>名称</th>
                                    <th>图片</th> 
                                    <th>时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean.sort}</td>
                                        <td>${bean.title}</td>
                                        <td><img src="${filehttp}/${bean.picurl}"/></td>
                                        <td><div style="width:500px; white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${bean.content}</div></td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
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
            </div>
        </form>
    </div>
</section>
<%@ include file="/webcom/preview.jsp"%>
</body>
</html>