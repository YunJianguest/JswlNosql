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
                location.href = "${ctx}/suc/bbs!delete.action?fypage=${fypage}&_id="+ id;
            }
        }
        function add(){
            location.href ="${ctx}/suc/bbs!input.action?fypage=${fypage}";
        }
        function upd(id){
            var submitData = {
                id : id
            };
            $.post('${ctx}/suc/bbs!upd.action', submitData, function(json) {
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
        <form  id="custinfoForm" name="custinfoForm" method="post"  action="${contextPath}/suc/bbs.action" >
            <div class="pageheader">
                <h2><i class="fa fa-qrcode"></i>素材管理 <span>论坛管理</span></h2>
                
            </div>
             <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="name" value="${name }" placeholder="关键字" class="form-control"/>
                        </div>
                        
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                        <div class="form-group col-sm-1d pull-right"> 
                         <button type="button" class="btn btn-primary dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                    菜单 <i  class="fa fa-align-center"></i>
                         </button>
                         <ul class="dropdown-menu pull-right" role="menu">
                            <li><a href="${ctx}/suc/bbs!input.action?fypage=${fypage}"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增帖子</a>
                            <li><a href="javascript:updfx('bbs_share')"><i class="fa fa-share-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享填写</a></li>
                            <li><a href="${ctx}/suc/bbstype.action"><i class="fa fa-list-ol"></i>&nbsp;&nbsp;&nbsp;&nbsp;类别添加</a></li>
                            <li><a href="${ctx}/suc/advertising.action?type=bbs_adv"><i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;广告管理</a></li>
                            <li><a href="${ctx}/suc/slide.action?type=bbs"><i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片管理</a></li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/bbs!index.action?custid=${custid}')" ><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;预览</a></li>
                        </ul> 
                      </div> 
                    </div>
                    
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-primary mb30  table-bordered" >
                                <thead>
                                <tr>
                                    <th>头像</th>
                                    <th>用户</th>
                                    <th>内容</th>
                                    <th>时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${bbsList}" var="bean">
                                    <tr>
                                        <td><img src="${filehttp}/${bean.headimgurl}" height="25px"/></td>
                                        <td>${bean.nikename}</td>
                                        <td><div style="width:500px;height:30px; white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">${bean.content}</div></td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <c:if test="${bean.adminstate==1}">
                                                    <li><a href="${ctx}/suc/bbs!update.action?_id=${bean._id}">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                                    </c:if> 
                                                    <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                                    <li><a href="javascript:qrcode('${ctxurl}/suc/bbs!bbsDetails.action?custid=${custid}&bmtid=${bean._id}')" ><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;预览</a></li>
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
<%@ include file="/webcom/share.jsp"%>
<%@ include file="/webcom/cut-img.jsp"%>
<%@ include file="/webcom/preview.jsp"%>
<script type="text/javascript">
jQuery(".select2").select2({
    width: '100%'
});
</script>
</body>
</html>