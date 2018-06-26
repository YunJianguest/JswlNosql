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

    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/lang/zh-cn/zh-cn.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#but1").val("${but1}");


            $("#but2").val("${but2}");

            var validator = $("#custinfoForm").validate({
                rules: {
                    title: {
                        required: true
                    },
                    type: {
                        required: true
                    },
                    isxs: {
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
                      action="${contextPath}/suc/activity!save.action?fypage=${fypage}">
                    <input id="_id" name="_id" value="<s:property value='_id'/>" type="hidden"/>
                    <input type="hidden" id="picurl" value="<s:property value='picurl'/>" name="picurl"/> 

                    <div class="div-group-10 overflow-hidden">
                        <!--左边项目-->
                        <div class="overflow-hidden">
                            <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                                <div class="clear col-2 pl-10 overflow-hidden">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        活动logo<i
                                            class="size12 zi-hui">（仅需一张）</i></div>
                                    <div class="line-bottom line-right line-left1 div-group-5 pt-10 pb-10 overflow-hidden">
                                        <c:if test="${empty entity.picurl}">
                                        <div class="col-6"> 
                                                <div class="img-wh60 maring-a border-radius3 line-lu logos">

                                                </div>
                                        </div>
                                        </c:if>
                                        <c:if test="${not empty entity.picurl}">
                                        <div class="col-6"> 
                                            <div class="img-wh60 maring-a border-radius3 line-lu logos">
                                                <img src="${filehttp}/${entity.picurl}" class="img-60">
                                            </div>
                                        </div>
                                        </c:if>
                                    
                                    
                                    <div class="col-6">
                                        <a href="javascript:pz('picurl','200','200',false,this)">
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
                                        名称
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="title"
                                               value="<s:property value='title'/>"
                                               name="title"
                                               placeholder="活动名称">
                                    </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        模板
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <select id="type" name="type" class="width-10 hang40" data-placeholder="请选择"> 
                                              <option value="0">砍价</option> 
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
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        活动价格
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="price" value="<s:property value='price'/>" name="price"
                                               placeholder="请输入价格">
                                    </div>
                                </div>
                            </div> 
                            <div class="pt-25 clear">
                                <div class="col-2">
                                            <div class="size14 line-bottom weight500 pt-10 pb-10"
                                                 style="padding-left: 2px;">
                                               兑奖结束日期
                                            </div>
                                            <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                                <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                                       type="text"
                                                       placeholder="点击输入日期"
                                                       value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${djenddate}'/>"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                                       readonly="readonly"
                                                       name="djenddate"
                                                       id="djenddate">
                                            </div>
                                </div>
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10" style="padding-left: 2px;">
                                        活动总量
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="num" value="<s:property value='num'/>" name="num"
                                               placeholder="请输入活动总量">
                                    </div>
                                </div> 
                             
                                <div class="col-2 pl-10">
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
                                        是否显示
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <select id="isxs" name="isxs" class="hang40 width-10"
                                                data-placeholder="请选择">
                                            <option value="0">显示</option>
                                            <option value="1">隐藏</option>
                                            
                                        </select>
                                    </div>
                                </div> 
                                <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        发起需要的积分
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="jfdh" value="${entity.jfdh}" name="jfdh"
                                               placeholder="请输入兑换数量">
                                    </div>
                                 </div> 
                                 <div class="col-2 pl-10">
                                    <div class="size14 line-bottom weight500 pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        参与需要的积分
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <input class="width-10 size14 zi-hui hang40 pl-10 pr-10 weight100"
                                               type="text"
                                               id="jfcy" value="${entity.jfcy}" name="jfcy"
                                               placeholder="请输入需要数量">
                                    </div>
                                 </div> 
                               
                                 <div class="col-2 tgrs">
                                    <div class="size14 weight500 line-bottom pt-10 pb-10"
                                         style="padding-left: 2px;">
                                        参团人数
                                    </div>
                                    <div class="line-bottom line-right line-left1 hang40 overflow-hidden">
                                        <select id="pcount" name="pcount" class="hang40 width-10"
                                                data-placeholder="请选择">
                                            <option value="">选请择</option>
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
                                
                            </div>
                                
                           </div>
 
                       </div>
                    </div>

                    <!--下部编辑器-->
                    <div class="pt-10 clear">
                        <div class="div-group-10 border-radius5 bg-bai">
                            <textarea style="display:none" name="content" id="content">${content}</textarea>
                            <script id="editor" type="text/plain" style="width:100%;height:300px;">${content}</script>
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
    $('#type').val('${entity.type}'); 
    $('#isxs').val('${entity.isxs}'); 
    $("#pcount").val("${entity.pcount}");
    changebq();
    setcke();
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    ue.ready(function () {
        UE.getEditor('editor').setHeight(300);
    });

    function checksubmit() {
        $("#content").val(ue.getContent());
        $('#custinfoForm').submit();
    }
</script>


</body>
</html>
