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
    <script type="text/javascript" src="${ctx}/wn/js/jquery.form.js"></script>
    <script type="text/javascript">
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${contextPath}/shop/shoppro!delete.action?comid=${comid}&fypage=${fypage}&_id="
                + id;
            }
        }
        function deljp(id) {
            if (confirm('确实要删除下面全部奖品吗?删除后不可恢复')) {
                location.href = "${contextPath}/shop/shoppro!deletejp.action?_id="
                + id;
            }
        }
        function add() {
            window.location.href = '${contextPath}/shop/shoppro!input.action?fypage=${fypage}';
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
        var tgid = '';
        var tgcomid = '';
        function add(id, comid) {
            tgid = id;
            tgcomid = comid;
            $('#inszc').modal({
                show: true
            });
        }
        function sztg() {
            var submitData = {
                _id: tgid,
                comid: tgcomid,
                lx: $('#lx').val()
            };
            $.post('${ctx}/shop/shoppro!ajaxaddtg.action', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("设置成功");
                            window.location.href = window.location.href;
                        }
                    }, "json")
        }
        function qxtg(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/shop/shoppro!ajaxqxtg.action', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("取消成功");
                            window.location.href = window.location.href;
                        }
                    }, "json")
        }
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post"
              action="${contextPath}/shop/shoppro.action?comid=${comid}">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i> 微网站<span>产品管理</span></h2>
                
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1d">
                            <input type="text" name="title" value="${title }" placeholder="名称" class="form-control"/>
                        </div>
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>
                         <div class="form-group col-sm-1d pull-right"> 
                         <button type="button" onclick="window.location.href='${ctx }/shop/shoppro!input.action?comid=${comid}&fypage=${fypage}'" class="btn btn-primary dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                 添加商品&nbsp; <i  class="fa fa-plus"></i>
                         </button>
                          
                      </div>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30 table-bordered">
                                <thead>
                                <tr>
                                    <th class="th5 table-action">序号</th>
                                    <th class="th5 table-action">LOGO</th>
                                    <th class="th8 table-action">标题</th>
                                    <th class="th8 table-action">标签</th>
                                    <th class="th8 table-action">最低价</th>
                                    <th class="th5 table-action">价格</th>
                                    <th class="th5 table-action">销售量</th> 
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${ProductInfoList}" var="bean">
                                    <tr class="table-action">
                                        <td>${bean.sort}</td> 
                                        <td><img src="${filehttp}${bean.logo}" style="height:25px;"></td>
                                        <td title="${bean.ptitle}">
                                            <div class="sl">${bean.ptitle}</div>
                                        </td>
                                        <td>
                                            <c:if test="${bean.bq==0}">无</c:if> 
                                            <c:if test="${bean.bq==1}">包邮</c:if> 
                                            <c:if test="${bean.bq==2}">热卖</c:if> 
                                            <c:if test="${bean.bq==3}">定制</c:if> 
                                            <c:if test="${bean.bq==4}">折扣</c:if> 
                                            <c:if test="${bean.bq==5}">下架</c:if> 
                                            <c:if test="${bean.bq==6}">半价</c:if> 
                                            <c:if test="${bean.bq==7}">秒杀</c:if> 
                                            <c:if test="${bean.bq==8}">砍价</c:if> 
                                            <c:if test="${bean.bq==9}">团购</c:if> 
                                        </td>
                                        <td><fmt:formatNumber value='${bean.lowprice}' pattern="0.0#"/></td>
                                        <td><fmt:formatNumber value='${bean.price}' pattern="0.0#"/>/<fmt:formatNumber
                                                value='${bean.oldprice}' pattern="0.0#"/></td>
                                        <td>${bean.num}/${bean.gmnum}</td> 

                                        <td class="table-action">

                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">

                                                    <li>
                                                        <a href="${contextPath}/shop/shoppro!update.action?_id=${bean._id}&comid=${comid}&fypage=${fypage}">
                                                            <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
                                                    </li>

                                                    <li><a href="javascript:del(${bean._id});"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li>
                                                    <li><a href="${ctx}/shop/specification.action?parentid=${bean._id}"><i
                                                            class="fa fa-cog "></i>&nbsp;&nbsp;&nbsp;&nbsp;规格管理</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/slide.action?type=shoppro-${bean._id}"><i
                                                            class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片</a></li>
                                                     <li>
                                                     <c:if test="${bean.bq==8}">
                                                     <li><a href="${ctx}/shop/shoppro!barlist.action?id=${bean._id}"><i
                                                            class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;砍价管理</a></li>
                                                     <li>
                                                     </c:if>
                                                        <a href="javascript:qrcode('${ctxurl}/shop/shop!shopproduct.action?custid=${custid}&pid=${bean._id}')"><i
                                                                class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;页面预览</a>
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
<div id="inszc" class="modal fade bs-example-modal-static"
     tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-automobile"></i>设置推广
                </h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">类型: <span
                                    class="asterisk">*</span>
                            </label>
                            <div class="col-sm-2">
                                <s:select cssClass="form-control mb15" class="select2" id="lx"
                                          name="mb" list="#{'1':'左图','2':'右上','3':'右下'}" listKey="key"
                                          listValue="value"/>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-sm-12 ">
                                <button class="btn btn-primary btn-block" data-dismiss="modal" onclick="sztg()">提&nbsp;&nbsp;交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/webcom/preview.jsp"%>
</body>
</html>
