<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script type="text/javascript" src="${contextPath}/mvccol/color/jscolor.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var validator = $("#inscxForm").validate({
                rules: {
                    picurl: {
                        required: true
                    },
                    type: {
                        required: true
                    },
                    name: {
                        required: true
                    },
                    byprice: {
                        number: true
                    },
                    sort: {
                        digits: true,
                        required: true
                    }
                },
                messages: {},
                highlight: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                },
                success: function (element) {
                    jQuery(element).closest('.form-group').removeClass('has-error');
                }
            });
        });
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/shop/shopmb!delete.action?fypage=${fypage}&_id=" + id;
            }
        }
        function share(url) {
            window.open("${contextPath}/weixin/share.action?method=" + encodeURIComponent(url));
        }
        function sharejs(url) {
            window.open("${contextPath}/weixin/share!js.action?method=" + encodeURIComponent(url));
        }
        function add() {
            $('#_id').val('');
            $('#name').val('');
            $('#type').val('');
            $('#picurl').val('');
            $('#url').val('');
            $('#sort').val(0);
            $('#jfbl').val('');
            ps_show('inszc');
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/shop/shopmb!upd.action', submitData,
                    function (json) {
                        $('#_id').val(json._id);
                        $('#name').val(json.name);
                        $('#logo').val(json.logo);
                        $('#picurl').val(json.picurl);
                        $('#mb').val(json.mb).trigger("change");;
                        $('#summary').val(json.summary);
                        $('#sort').val(json.sort);
                        $('#type').val(json.type).trigger("change");;
                        $('#lx').val(json.lx);
                        $('#searchcolor').val(json.searchcolor);
                        $('#byprice').val(json.byprice);
                        $('#jfbl').val(json.jfbl).trigger("change");;

                    }, "json")
            ps_show('inszc');
        }
        function setadmin(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/shop/shopmb!setadminshop.action', submitData,
                    function (json) {
                        if (json.state == 0) {
                            window.location.reload();
                        }
                    }, "json");
        }
        function changebt(value, no) {
            if (value == "链接") {
                $("#btboomvalue" + no).val("");
                $("#btboomvalue" + no).show();
            } else if (value == "订单") {
                $("#btboomvalue" + no).val("${ctx}/shop/shop!orderinfo.action?custid=${custid}");
                $("#btboomvalue" + no).hide();
            }
        }
    </script>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/shop/shopmb.action">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i> 微网店 <span>网店列表</span></h2>
                  <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"style="color: white;"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li> <a href="javascript:add();">
                                 <i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp; 添加店铺</a>
                            </li>
                            <li><a href="javascript:qrcode('${ctxurl}/shop/shop!storepayweb.action?custid=${custid}')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;支付预览</a></li>
                             
                        </ul>
                    </div>
                </div>
             
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-action table-primary mb30 table-bordered">
                                <thead>
                                <tr>
                                    <th class="table-action">ID</th>
                                    <th class="table-action">名称</th>
                                    <th class="table-action">类型</th>
                                    <th class="table-action">模板</th>
                                    <th class="table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${shopmbList}" var="bean">
                                    <tr>
                                        <td>${bean._id}</td>
                                        <td>${bean.name}</td>
                                        <td><c:if test="${bean.type==0}">普通店</c:if><c:if test="${bean.type==1}">官方店</c:if><c:if test="${bean.type==2}">商家店</c:if>
                                        </td>
                                        <td>${bean.mb}</td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li><a href="javascript:upd('${bean._id}');">
                                                        <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改店铺分享说明</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/slide.action?type=shopmb-${bean._id}"><i
                                                            class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;首页幻灯片添加</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/roll.action?type=shopmb-${bean._id}"><i
                                                            class="fa fa-i-cursor"></i>&nbsp;&nbsp;&nbsp;&nbsp;首页滚动字幕添加</a>
                                                    </li>
                                                    <li><a href="javascript:setadmin('${bean._id}');"><i
                                                            class="fa fa-institution"></i>&nbsp;&nbsp;&nbsp;设置为官方店</a>
                                                    </li>
                                                    <li><a href="${ctx }/shop/shoptype.action?parentid=${bean._id}"><i
                                                            class="fa fa-cog"></i>&nbsp;&nbsp;&nbsp;&nbsp;分类配置</a></li>
                                                    <li><a href="${ctx }/shop/shoppro.action?comid=${bean._id}"><i
                                                            class="fa fa-shopping-basket"></i>&nbsp;&nbsp;&nbsp;商品管理</a>
                                                    </li>
                                                    <li><a href="javascript:del('${bean._id}');"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li>
                                                    <li><a href="${ctx}/shop/orderform.action?comid=${bean._id}"><i
                                                            class="fa fa-tag"></i>&nbsp;&nbsp;&nbsp;&nbsp;订单管理</a></li>
                                                    <li>
                                                    <li><a href="${ctx}/shop/shopagent.action?wid=${bean._id}"><i
                                                            class="fa fa-tag"></i>&nbsp;&nbsp;&nbsp;&nbsp;代理管理</a></li>
                                                    <li>
                                                    <li><a href="${ctx}/shop/shopcustservice.action?wid=${bean._id}"><i
                                                            class="fa fa-tag"></i>&nbsp;&nbsp;&nbsp;&nbsp;客服管理</a></li>
                                                    <li>
                                                    <li><a href="${ctx}/shop/shopmsg.action?wid=${bean._id}"><i
                                                            class="fa fa-tag"></i>&nbsp;&nbsp;&nbsp;&nbsp;消息管理</a></li>
                                                    <li>
                                                    <li><a href="javascript:qrcode('${ctxurl}/shop/shop!storepay.action?custid=${custid}&id=${bean._id}')"><i
                                                            class="fa fa-tag"></i>&nbsp;&nbsp;&nbsp;&nbsp;支付二维码</a></li>
                                                    <li>
                                                        <a href="javascript:qrcode('${ctxurl}/shop/shop!index.action?comid=${bean._id}&lx=${bean.lx}&custid=${custid}')"><i
                                                                class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;&nbsp;页面预览</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
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
                        <i class="weight500 size14 pl-10 line-height50">店铺管理</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx }/shop/shopmb!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="lx" name="lx"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">店铺名称：</label>
                                <input type="text" id="name" name="name"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">包邮价格：</label>
                                <input type="text" id="byprice" name="byprice"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">分享说明: </label>
                                <input type="text" id="summary" name="summary"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">模板：</label>
                                <select id="mb" name="mb" class="select2 hang40"
                                        data-placeholder="请选择">
                                    <option value="0">图标两行</option>
                                    <option value="1">图标一行</option>
                                    <option value="2">图片两行</option>
                                    <option value="3">瀑布模板</option>
                                    <option value="4">图片一行</option>
                                    <option value="5">分销模板</option>
                                </select>
                                <label class="error" for="color"></label>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">排序：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control hang40" placeholder="请输入"/>
                            </div>
                        </div>
                       <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">类型：</label>
                                <select id="type" name="type" class="select2 hang40"
                                         data-placeholder="请选择">
                                    <option value="0">普通网店</option>
                                    <option value="1">积分商城</option>
                                    <option value="2">商家店铺</option> 
                                </select>
                                <label class="error" for="color"></label>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">搜索条颜色:</label>
                                <input type="text" id="searchcolor" name="searchcolor"
                                       class="form-control color hang40" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">积分返还比例：</label>
                                <select id="jfbl" name="jfbl" class="select2 hang40" 
                                        data-placeholder="请选择">
                                    <option value="0">不开通</option>
                                    <option value="1">1:1</option>
                                    <option value="10">1:10</option>
                                    <option value="50">1:50</option>
                                    <option value="100">1:100</option> 
                                </select>
                                <label class="error" for="color"></label>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label class="control-label">分享图片：</label>
                            <div>
                                <div class="col-sm-9 mb-20" style="padding:0px;">
                                    <input type="text" id="logo" name="logo" class=" form-control hang40"/>
                                </div>
                                <div class="col-sm-3 mb-20" style="padding:0px;position: relative;"
                                     onclick="pz('logo','200','200',false)">
                                    <div class="btn btn-primary"
                                         style="width: 100%;line-height: 20px;height:40px;">
                                        上传
                                    </div>

                                </div>
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

<%@include file="/webcom/cut-img.jsp" %>
<%@ include file="/webcom/preview.jsp" %>
<script type="text/javascript">
jQuery(".select2").select2({
    width: '100%'
});
</script>
</body>
</html>
