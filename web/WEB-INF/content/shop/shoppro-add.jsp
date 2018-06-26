<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script src="${contextPath}/bracket/js/jquery.tagsinput.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/bracket/css/jquery.tagsinput.css"/>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/ckeditor/ckeditor.js"></script> 
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#but1").val("${but1}");


            $("#but2").val("${but2}");

            var validator = $("#custinfoForm").validate({
                rules: {
                    ptitle: {
                        required: true
                    },
                    sort: {
                        number: true
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

        function changebut(value, no) {

            if (value == '货到付款') {
                $("#gm" + no).val("javascript:hd_pay()");
            } else if (value == '微信支付') {
                $("#gm" + no).val("javascript:wx_pay()");
            } else if (value == '电话购买') {
                $("#gm" + no).val("tel:");
            } else if (value == '商城购买') {
                $("#gm" + no).val("");
            } else if (value == '联系卖家') {
                $("#gm" + no).val("tel:");
            } else if (value == '立即下单') {
                $("#gm" + no).val("javascript:lj_pay()");
            } else {
                $("#gm" + no).val("");
            }
        }

        function cke() {
            var str = "";
            var tmp = document.getElementsByName("ch_type");

            for (var i = 0; i < tmp.length; i++) {
                if (tmp[i].checked) {
                    str += tmp[i].value + ","

                }
            }
            $("#hylx").val(str);

        }
        function setcke() {
            var str = "<s:property value='hylx'/>";
            var tmp = str.split(",");

            for (var i = 0; i < tmp.length; i++) {
                $("#" + tmp[i]).attr("checked", "checked");
            }
        }
        ;

        function changebq() {
            if ($('#bq').val() == 8) {
                $('#kj').show();
                $('.tgrs').show()
            } else {
                $('#kj').hide(); 
            }
            if ($('#bq').val() == 9) {
                $('.tg').show();
                $('.tgrs').show();
            } else {
                $('.tg').hide();
            }
        }

    </script>
    <style type="text/css">

        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .img-60 {
            width: 60px;
            height: 60px;
        }

    </style>
</head>

<body>

<section>

    <%@include file="/webcom/header-bracket.jsp" %>

    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <div class="pageheader">
            <h2>
                <i class="fa fa-user"></i>微网店<span>产品信息</span>
            </h2>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" id="custinfoForm" method="post"
                      action="${contextPath}/shop/shoppro!save.action?fypage=${fypage}">
                    <input id="_id" name="_id" value="<s:property value='_id'/>" type="hidden"/>
                    <input type="hidden" id="logo" value="<s:property value='logo'/>" name="logo"/>
                    <input type="hidden" id="comid" value="${comid }" name="comid"/>

                    <div class="div-group-10 overflow-hidden">
                        <!--左边项目-->
                        <div class="overflow-hidden">
                            <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                                <div class="clear col-2 pl-10 overflow-hidden">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        商品logo<i
                                            class="size12 zi-hui">（仅需一张）</i></div>
                                    <div class="line-bottom line-right line-left1 div-group-5 pt-10 pb-10 overflow-hidden">
                                        <div class="col-6">
                                            <c:if test="${empty entity.logo}">
                                                <div class="img-wh60 maring-a border-radius3 line-lu logos">

                                                </div>
                                        </div>
                                        </c:if>
                                        <c:if test="${not empty entity.logo}">
                                            <div class="img-wh60 maring-a border-radius3 line-lu logos">
                                                <img src="${filehttp}/${entity.logo}" class="img-60">
                                            </div>
                                    </div>
                                    </c:if>
                                    <div class="col-6">
                                        <a href="javascript:pz('logo','200','200',false,this)">
                                            <div class="img-wh60 maring-a border-radius3 line-lu">
                                                <div class="div-group-15">
                                                    <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                </div>
                            </div>

                            <div class="clear pt-25">
                                <div class="col-2">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        商品名称
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="ptitle"
                                               value="<s:property value='ptitle'/>"
                                               name="ptitle"
                                               placeholder="商品名称">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        商品分类
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="hylx" name="hylx" class="select2" data-placeholder="请选择">
                                            <c:forEach items="${typelist}" var="bean" varStatus="status">
                                                <option value="${bean.type}">${bean.name}</option>
                                            </c:forEach>

                                        </select>
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14  weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        模板
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="mb" name="mb" class="select2" data-placeholder="请选择">
                                            <option value="0">默认模板</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        序号
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="sort" value="<s:property value='sort'/>" name="sort"
                                               placeholder="请输入序号">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        分享说明
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="summary" value="<s:property value='summary'/>" name="summary"
                                               placeholder="请输入分享说明">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        外部链接
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="url" value="<s:property value='url'/>" name="url" placeholder="外部链接">
                                    </div>
                                </div>
                            </div>

                            <div class="pt-25 clear">
                                <div class="col-2">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        销售价格
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="price" value="<s:property value='price'/>" name="price"
                                               placeholder="请输入价格">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        市场价格
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="oldprice" value="<s:property value='oldprice'/>" name="oldprice"
                                               placeholder="请输入市场价格">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        代理价格
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="dlprice" value="<s:property value='dlprice'/>" name="dlprice"
                                               placeholder="请输入代理价格">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        库存数量
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="num" value="<s:property value='num'/>" name="num"
                                               placeholder="请输入库存数量">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        已售数量
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="gmnum" value="<s:property value='gmnum'/>" name="gmnum"
                                               placeholder="请输入已售数量">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14  weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        每人可购买的次数
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="gmcs" name="gmcs" class="select2" data-placeholder="请选择">
                                            <option value="0">无限制</option>
                                            <option value="1">一次</option>
                                            <option value="2">二次</option>
                                            <option value="3">三次</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class=" size14 weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        折扣选择
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="bq" name="bq" class="select2" data-placeholder="请选择"
                                                onchange="changebq()">
                                            <c:if test="${empty isjf}">
                                             <option value="0">无</option>
                                             <option value="1">包邮</option>
                                             <option value="2">热卖</option>
                                             <option value="3">定制</option>
                                             <option value="4">折扣</option>
                                             <option value="5">下架</option>
                                             <option value="6">半价</option>
                                             <option value="7">秒杀</option>
                                             <option value="8">砍价</option>
                                             <option value="9">团购</option>
                                             <option value="10">通用</option>
                                            </c:if> 
                                            <c:if test="${not empty isjf}">
                                              <option value="11">积分兑换</option> 
                                            </c:if> 
                                        </select>
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        快递价格
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="kdprice" value="${entity.kdprice}" name="kdprice"
                                               placeholder="请输入快递价格">
                                    </div>
                                </div>
                                <div class="col-2 pl-10" id="kj">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        最多可砍价到多少钱
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="lowprice" value="<s:property value='lowprice'/>" name="lowprice"
                                               placeholder="最多可砍价到多少钱">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        返还积分
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="jffh" value="${entity.jffh}" name="jffh"
                                               placeholder="请输入返还数量">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        是否显示
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="isxs" name="isxs" class="select2"
                                                data-placeholder="请选择">
                                            <option value="0">显示</option>
                                            <option value="1">隐藏</option>
                                            
                                        </select>
                                    </div>
                                </div>
                                <c:if test="${not empty isjf}">
                                 <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        积分兑换
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="jfdh" value="${entity.jfdh}" name="jfdh"
                                               placeholder="请输入兑换数量">
                                    </div>
                                 </div>
                                </c:if>
                               
                                <div class="col-2 pl-10 tgrs">
                                    <div class="size14 weight500  pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        参团人数
                                    </div>
                                    <div class="overflow-hidden">
                                        <select id="pcount" name="pcount" class="select2"
                                                data-placeholder="请选择">
                                            <option value="0">选请择</option>
                                            <option value="2">2人</option>
                                            <option value="5">5人</option>
                                            <option value="10">10人</option>
                                            <option value="20">20人</option>
                                            <option value="30">30人</option>
                                            <option value="50">50人</option>
                                            <option value="60">60人</option>
                                            <option value="70">70人</option>
                                            <option value="80">80人</option>
                                            <option value="100">100人</option>
                                            <option value="300">300人</option>
                                            <option value="500">500人</option>
                                            <option value="1000">1000人</option>
                                            <option value="2000">2000人</option>
                                            <option value="3000">3000人</option>
                                            <option value="5000">5000人</option>
                                            <option value="10000">10000人</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-2 pl-10 tg">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        发起单位
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="unit" value="${entity.unit}" name="unit"
                                               placeholder="请输入单位名称">
                                    </div>
                                </div>
                                <div class="col-2 tg">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        团购价格
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="ppice" value="${entity.ppice}" name="ppice"
                                               placeholder="请输入团购价格">
                                    </div>
                                </div>
                            </div> 

                        </div>
                    </div>

                    <!--下部编辑器-->
                    <div class="pt-10 clear">
                        <div class="div-group-10 border-radius5 bg-bai">
                            <textarea  name="context" id="context" class="ckeditor" rows="10" cols="38">${context}</textarea>
                            <script id="editor" type="text/plain" style="width:100%;height:300px;">${context}</script>
                        </div>
                        <a href="javascript:checksubmit()">
                            <div class="pt-20 pb-20 clear">
                                <div class="col-sm-12 btn btn-primary dropdown-toggle">
                                    提交
                                </div>
                            </div>
                        </a>
                    </div>
                </form>

            </div>

        </div>
    </div>
    <!-- mainpanel -->
</section>
<%@include file="/webcom/cut-img1.jsp" %>

<script type="text/javascript">
    $('#bq').val('${bq}');
    $('#mb').val('${mb}');
    $('#gmcs').val('${gmcs}');
    $('#isxs').val('${entity.isxs}');
    $("#hylx").val("${entity.hylx}");
    $("#pcount").val("${entity.pcount}");
    changebq();
    setcke();
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    jQuery(".select2").select2({
    width: '100%'
   });
   var editor=CKEDITOR.replace('context');

    function checksubmit() {
        $("#context").val(editor.getData());
        $('#custinfoForm').submit();
    }
</script>


</body>
</html>
