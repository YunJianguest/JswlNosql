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
                location.href = "${ctx}/suc/house!delete.action?fypage=${fypage}&_id=" + id;
            }
        }
        function add() {
            location.href = "${ctx}/suc/house!input.action?fypage=${fypage}";
        }
        function baidusj() {
            var keyword = $('#keyword').val();
            var type = $('#type').val();
            var region = $('#region').val();
            var submitData = {
                keyword: keyword,
                type: type,
                region: region
            };
            $.post('${ctx}/suc/house!baidusj.action', submitData, function (json) {
                alert("更新了" + json.value + "条数据");
                window.location.reload();
            }, "json");

        }
        function submint() {
            var submitData = {
                fxmb: $('#fxmb').val(),
                fxtitle: $('#fxtitle').val(),
                fxsummary: $('#fxsummary').val(),
                fxurl: $('#fxurl').val(),
                fxpicurl: $('#fxpicurl').val()
            };
            $.post('${ctx}/suc/shareconfig!ajaxsave.action?toUser=${toUser}&type=house', submitData, function (json) {
                location.reload();
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
        function share(url) {
            window.open("${contextPath}/weixin/share.action?method=" + encodeURIComponent(url));
        }

        function auditcancel(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/suc/house!auditcancel.action?', submitData, function (json) {
                if (json.state == 0) {
                    window.location.reload();
                }
            }, "json");
        }
        function auditok(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/suc/house!auditok.action?', submitData, function (json) {
                if (json.state == 0) {
                    window.location.reload();
                }
            }, "json");
        }
        function gengxin() {
            $('#insgengxin').modal({
                show: true
            });
        }
    </script>
    
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/house.action">
            <div class="pageheader">
                <h2><i class="fa fa-qrcode"></i>功能管理<span>城市黄页</span></h2>
                
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
                            <select id="hy" name="hy" class="select2" data-placeholder="请选择">
                                <option value="">请选择</option>
                                <c:forEach items="${hylist}" var="bean">
                                    <option value="${bean.coding}">${bean.title}</option>
                                </c:forEach>

                            </select> 
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
                            <li><a href="${ctx}/suc/house!input.action?fypage=${fypage}"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增黄页</a>

                            </li>
                            <li><a href="${ctx}/suc/housetype.action"><i class="fa fa-server"></i>&nbsp;&nbsp;&nbsp;&nbsp;分类管理</a>
                            </li>
                            <li><a href="javascript:updfx('house_share')"><i class="fa fa-share-alt-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享设置</a>
                            <li><a href="javascript:gengxin()"><i class="fa fa-refresh"></i>&nbsp;&nbsp;&nbsp;&nbsp;更新数据</a>
                            </li>
                            <li><a href="${ctx}/suc/slide!slidehouse.action?type=house">
                                <i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片</a>
                            </li>
                            <li><a href="javascript:qrcode('${ctxurl}/suc/house!web.action?custid=${custid}')"><i
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
                                    <th class="table-action">标题</th>
                                    <th class="table-action">图片</th>
                                    <th class="table-action">时间</th>
                                    <th class="table-action">到期时间</th>
                                    <th class="table-action">状态</th>
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${companyList}" var="bean">
                                    <tr>
                                        <td>${bean.sort}</td>
                                        <td>
                                            <div style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden; width:100px;margin: auto;">${bean.name}</div>
                                        </td>
                                        <td><img src="${filehttp}/${bean.logo}" height="25px"/></td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.enddate}'/></td>
                                        <td>
                                            <c:if test="${bean.xs==0}">审核通过</c:if>
                                            <c:if test="${bean.xs==1}">审核不合格</c:if>
                                            <c:if test="${bean.xs==2}">待审核</c:if>
                                        </td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="${ctx}/suc/house!update.action?_id=${bean._id}">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                                    <li><a href="javascript:del('${bean._id}');">
                                                        <i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/housecomment.action?parentid=${bean._id}">
                                                        <i class="fa fa-cogs"></i>&nbsp;&nbsp;&nbsp;&nbsp;评论管理</a></li>
                                                    <li><a href="javascript:auditok('${bean._id}')">
                                                        <i class="fa fa-calendar-check-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;审核通过</a>
                                                    </li>
                                                    <li><a href="javascript:auditcancel('${bean._id}')">
                                                        <i class="fa fa-calendar-times-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;取消审核</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/housefunc.action?parentid=${bean._id}">
                                                        <i class="fa fa-list-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;菜单管理</a>
                                                    </li>
                                                    <c:if test="${bean.mb==2}">
                                                     <li><a href="${ctx}/suc/slide.action?type=house-${bean._id}&width=250&height=450">
                                                        <i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片</a>
                                                     </li>
                                                    </c:if>
                                                    <c:if test="${bean.mb!=2}">
                                                     <li><a href="${ctx}/suc/slide.action?type=house-${bean._id}">
                                                        <i class="fa fa-bullhorn"></i>&nbsp;&nbsp;&nbsp;&nbsp;幻灯片</a>
                                                     </li>
                                                    </c:if>
                                                   
                                                    <li>
                                                        <a href="javascript:qrcode('${ctxurl}/suc/house!webDetail.action?_id=${bean._id }&custid=${custid}')">
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
<div class="fullscreen bg-hei-8 display-none" id="insgengxin" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">黄页数据填充</i>
                    </div>
                    <a href="javascript:ps_hide('insgengxin')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                        <div class="col-sm-4">
                            <div class="mb-20">
                                <label class="control-label">关键字:</label>
                                <input type="text" id="keyword" name="keyword"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="mb-20">
                                <label class="control-label">地区:</label>
                                <input type="text" id="region" name="region"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-4 "> 
                                <label class="control-label">类型:</label>
                                <select id="type" name="type" class="select2" 
                                         data-placeholder="请选择">
                                    <c:forEach items="${hylist}" var="bean">
                                        <option value="${bean.coding}">${bean.title}</option>
                                    </c:forEach>
                                </select>  
                        </div>
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn-lan width-10 maring-a clear weight500 hang40" onclick="baidusj()">提 交
                        </button>
                    </div> 
            </div>
        </div>
    </div>
</div>
 
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
