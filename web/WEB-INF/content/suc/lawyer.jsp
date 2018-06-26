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
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/suc/lawyer!delete.action?fypage=${fypage}&_id=" + id;
            }
        }
        function add() {
            location.href = "${ctx}/suc/lawyer!input.action?fypage=${fypage}";
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
    </script>
    
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/lawyer.action">
            <div class="pageheader">
                <h2><i class="fa fa-qrcode"></i>功能管理<span>律师管理</span></h2>
                
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="name" value="${name }" placeholder="名称" class="form-control"/>
                        </div>
                        <div class="form-group col-sm-1d">
                            <input type="text" name="keyword" value="${keyword }" placeholder="关键字"
                                   class="form-control"/>
                        </div> 
                        <div class="form-group col-sm-1d">
                            <select id="selxs" name="selxs" class="select2" data-placeholder="请选择">
                                 <option value="">请选择</option>
                                 <option value="0">审核通过</option>
                                 <option value="1">审核不合格</option>
                                 <option value="2">待审核</option>
                                 
                            </select>  
                        </div>
                        <div class="form-group col-sm-1d">
                            <input type="text" id="sel_enddate" name="sel_enddate" readonly="readonly" value="${sel_enddate }" placeholder="到期日期"
                                   class="form-control"/>
                        </div> 
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                        <div class="form-group col-sm-1d pull-right"> 
                         <button type="button" class="btn btn-primary dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                    菜单 <i  class="fa fa-align-center"></i>
                         </button>
                         <ul class="dropdown-menu pull-right" role="menu">
                            <li><a href="javascript:add()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增律师</a>

                            </li> 
                            </li>
                            <li><a href="javascript:updfx('lawyer_share')"><i class="fa fa-share-alt-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享设置</a>
                             
                            <li><a href="${ctx}/suc/slide!slidehouse.action?type=lawyer">
                                <i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片</a>
                            </li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/lawyer!web.action?custid=${custid}')"><i
                                    class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;预览</a></li>
                        </ul> 
                      </div> 
                    </div>
                    
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-primary table-action mb30 table-bordered">
                                <thead >
                                <tr>
                                    <th class="table-action">序号</th>
                                    <th class="table-action">头像</th>
                                    <th class="table-action">姓名</th> 
                                    <th class="table-action">入驻时间</th>
                                    <th class="table-action">状态</th> 
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean.sort}</td>
                                         <td><img src="${filehttp}/${bean.picurl}" height="25px"/></td>
                                        <td>
                                            <div style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden; width:100px;margin: auto;">${bean.name}</div>
                                        </td>
                                       
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td> 
                                        <td><c:if test="${bean.state==0}">未审核</c:if><c:if test="${bean.state==1}">审核中</c:if><c:if test="${bean.state==2}">审核通过</c:if><c:if test="${bean.state==3}">审核驳回</c:if></td>   
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="${ctx}/suc/lawyer!update.action?_id=${bean._id}">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>                                           
                                                    <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/lawyerbus.action?lid=${bean._id}">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;服务管理</a></li>
                                                    <li> 
                                                        <a href="javascript:qrcode('${ctxurl}/suc/lawyer!detail.action?id=${bean._id }&custid=${custid}')">
                                                            <i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;预览</a>
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
        </form>
    </div>
</section>
 
<%@ include file="/webcom/share.jsp" %>
<%@include file="/webcom/cut-img.jsp" %>
<%@ include file="/webcom/preview.jsp" %>
<script>
jQuery(".select2").select2({
    width: '100%'
});
jQuery('#sel_enddate').datepicker(); 
    $('#selxs').val('${selxs}');
    $('#hy').val('${hy}');
</script>
</body>
</html>
