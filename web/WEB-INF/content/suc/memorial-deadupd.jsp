<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>祭奠-简介-修改页</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

    <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css">
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/app.css"/>
    <link href="${ctx}/mvccol/mui-css/mui.picker.min.css" rel="stylesheet"/>
    <style>
        .zi-3a {
            color: #aaa;
            background-color: transparent;
        }
    </style>
    <script>
        function changedead(v) {
            var id = $(v).attr('id');
            if (id == "dead_name1") {
                $('#dead_name1').hide();
                $('#dead1').hide();
                $('#dead_name2').show();
                $('#dead2').show();
            } else {
                $('#dead_name1').show();
                $('#dead1').show();
                $('#dead_name2').hide();
                $('#dead2').hide();
            }
        }
        function submint() {
            var name1 = $('#name1').val();
            var picurl1 = $('#picurl1').val();
            var nativePlace1 = $('#nativePlace1').html();
            var professional1 = $('#professional1').val();
            var relashipbetween1 = $('#relashipbetween1').html();
            var birthAddress1 = $('#birthAddress1').html();
            var burialAddress1 = $('#burialAddress1').html();
            var summary1 = $('#summary1').val();
            var birthdate1 = $('#birthdate1').html();
            var burialdate1 = $('#burialdate1').html();

            var name2 = $('#name2').val();
            var picurl2 = $('#picurl2').val();
            var nativePlace2 = $('#nativePlace2').html();
            var professional2 = $('#professional2').val();
            var relashipbetween2 = $('#relashipbetween2').html();
            var birthAddress2 = $('#birthAddress2').html();
            var burialAddress2 = $('#burialAddress2').html();
            var summary2 = $('#summary2').val();
            var birthdate2 = $('#birthdate2').html();
            var burialdate2 = $('#burialdate2').html();

            var submitData = {
                id: '${id}',
                name1: name1,
                picurl1: picurl1,
                nativePlace1: nativePlace1,
                professional1: professional1,
                relashipbetween1: relashipbetween1,
                birthAddress1: birthAddress1,
                burialAddress1: burialAddress1,
                summary1: summary1,
                birthdate1: birthdate1,
                burialdate1: burialdate1,
                name2: name2,
                picurl2: picurl2,
                nativePlace2: nativePlace2,
                professional2: professional2,
                relashipbetween2: relashipbetween2,
                birthAddress2: birthAddress2,
                burialAddress2: burialAddress2,
                summary2: summary2,
                birthdate2: birthdate2,
                burialdate2: burialdate2,


            };
            $.post('${ctx}/suc/memorial!ajaxdeadupd.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {

                if (json.state == 0) {
                    swal({ 
                     text: '保存成功！',
                     timer: 2000,
                     type:'success',
                     showConfirmButton: false
                     }).then(function () {}, 
                      function (dismiss) {
                    if (dismiss === 'timer') {
                         window.location.href = '${ctx}/suc/memorial!detail.action?custid=${custid}&lscode=${lscode}&_id=${id}';
                    }
                   }
                  );
                   
                }
            }, "json");

        }


    </script>
</head>
<body>
<main class="cmp640 bg-hui-98">
    <font size="2">
        <div class="position-r">

            <c:if test="${fn:length(list)==2}">
                <c:forEach items="${list}" var="bean" begin="0" end="0">
                    <div class="pt-10" id="dead_name1" onclick="changedead(this)">
                        <div class="width-4 maring-a hang30 txt-c border-radius3 line-lu zi-3a"
                             style="line-height:28px;">
                            ${bean.name}<i class="fa fa-angle-down pl-15"></i>
                        </div>
                    </div>
                </c:forEach>
                <c:forEach items="${list}" var="bean" begin="1" end="1">
                    <div class="pt-10 display-none" id="dead_name2" onclick="changedead(this)">
                        <div class="width-4 maring-a hang30 txt-c border-radius3 line-lu zi-3a"
                             style="line-height:28px;">
                            ${bean.name}<i class="fa fa-angle-down pl-15"></i>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

        </div>
        <c:forEach items="${list}" var="bean" begin="0" end="0">
            <div class="div-group-10" id="dead1">
                <input type="hidden" id="picurl1" value="${bean.picurl}"/>

                <div class="width-2 maring-a pt-15 pb-10" onclick="pz('picurl1','130','164',false,'logo1')" id="logo1">
                    <c:if test="${empty bean.picurl}">
                        <img src="${ctx}/img/memorial_sz.jpg" class="width-10">
                    </c:if>
                    <c:if test="${not empty bean.picurl}">
                        <img src="${filehttp}/${bean.picurl}" class="width-10">
                    </c:if>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">姓名</div>
                        <input class="pull-left zi-3a pl-10 pr-10 zi-hui line-height40" type="text" name=""
                               value="${bean.name}" id="name1"/>

                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom showCity">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">籍贯</div>
                        <div class="pull-left zi-3a pl-10" id="nativePlace1">${bean.nativePlace}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">职业</div>
                        <input class="pull-left zi-3a pl-10 pr-10 zi-hui line-height40" type="text" name=""
                               value="${bean.professional}" id="professional1"/>

                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom dates "
                     data-options='{"type":"date","beginYear":1900,"endYear":2016}'>
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">生辰</div>
                        <div class="pull-left zi-3a pl-10 " id="birthdate1">${bean.birthdate}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom dates"
                     data-options='{"type":"date","beginYear":1900,"endYear":2016}'>
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">忌日</div>
                        <div class="pull-left zi-3a pl-10" id="burialdate1">${bean.burialdate}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom showCity">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">出生地</div>
                        <div class="pull-left zi-3a pl-10" id="birthAddress1">${bean.birthAddress}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom showCity">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">安葬地</div>
                        <div class="pull-left zi-3a pl-10" id="burialAddress1">${bean.burialAddress}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="pt-15">
                    <div class="txt-c weight500 pb-15">
                        <font size="2">
                            生平事迹
                        </font>
                    </div>
                    <div class="line-height25 overflow-hidden border-radius5 line-lu">
                        <form action="">
                            <textarea rows="5" id="summary1">${bean.summary}</textarea>
                        </form>
                    </div>
                </div>

            </div>
        </c:forEach>

        <c:forEach items="${list}" var="bean" begin="1" end="1">
            <div class="div-group-10 display-none" id="dead2">
                <input type="hidden" id="picurl2" value="${bean.picurl}"/>

                <div class="width-2 maring-a pt-15" onclick="pz('picurl2','260','328',false,'logo2')" id="logo2">
                    <c:if test="${empty bean.picurl}">
                        <img src="${ctx}/img/memorial_sz.jpg" class="width-10">
                    </c:if>
                    <c:if test="${not empty bean.picurl}">
                        <img src="${filehttp}/${bean.picurl}" class="width-10">
                    </c:if>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">姓名</div>
                        <input class="pull-left zi-3a pl-10 pr-10 zi-hui line-height40" type="text" name=""
                               value="${bean.name}" id="name2"/>

                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom showCity">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">籍贯</div>
                        <div class="pull-left zi-3a pl-10" id="nativePlace2">${bean.nativePlace}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">职业</div>
                        <font size="2">
                            <input class="pull-left zi-3a pl-10 pr-10 zi-hui size12 line-height40" type="text" name=""
                                   value="${bean.professional}" id="professional2"/>
                        </font>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom dates"
                     data-options='{"type":"date","beginYear":1900,"endYear":2016}'>
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">生辰</div>
                        <div class="pull-left zi-3a pl-10" id="birthdate2">${bean.birthdate}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom dates"
                     data-options='{"type":"date","beginYear":1900,"endYear":2016}'>
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">忌日</div>
                        <div class="pull-left zi-3a pl-10" id="burialdate2">${bean.burialdate}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom showCity">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">出生地</div>
                        <div class="pull-left zi-3a pl-10" id="birthAddress2">${bean.birthAddress}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="hang40 line-height40 overflow-hidden pl-5 pr-5 line-bottom showCity">
                    <font size="2">
                        <div class="col-2 zi-hei-tq weight500">安葬地</div>
                        <div class="pull-left zi-3a pl-10" id="burialAddress2">${bean.burialAddress}</div>
                        <div class="pull-right zi-6"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </font>
                </div>
                <div class="pt-15">
                    <div class="txt-c weight500 pb-15">
                        <font size="2">
                            生平事迹
                        </font>
                    </div>
                    <div class="line-height25 overflow-hidden border-radius5 line-lu">
                        <form action="">
                            <textarea rows="5" id="summary2">${bean.summary}</textarea>
                        </form>
                    </div>
                </div>

            </div>
        </c:forEach>

        <div class="div-group-10 pt-25 pb-25">
            <div class="line-height40 txt-c hang40 zi-bai btn-green border-radius3" onclick="submint()">
                保存
            </div>
        </div>

    </font>
</main>
<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.dtpicker.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.picker.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.poppicker.js"></script>

<script src="${ctx}/mvccol/mui-js/city.data-3.js" type="text/javascript" charset="utf-8"></script>
<script>
    (function ($, doc) {
        $.init();
        $.ready(function () {

            var cityPicker3 = new $.PopPicker({
                layer: 3
            });
            cityPicker3.setData(cityData3);
            var showCity = $('.showCity');
            var province = '';
            var city = '';
            var county = '';
            showCity.each(function (i, btn) {
                btn.addEventListener('tap', function () {
                    var id = this.getElementsByClassName('zi-3a');
                    cityPicker3.show(function (items) {
                        province = (items[0] || {}).text;
                        city = (items[1] || {}).text;
                        if (typeof((items[2] || {}).text) == "undefined") {
                            county = '';
                        } else {
                            county = (items[2] || {}).text;
                        }
                        id[0].innerText = province + "-" + city + "-" + county;

                    });
                }, false);

            });

            var dates = $('.dates');
            dates.each(function (i, btn) {

                btn.addEventListener('tap', function () {
                    var optionsJson = this.getAttribute('data-options') || '{}';
                    var options = JSON.parse(optionsJson);
                    var id = this.getElementsByClassName('zi-3a');
                    var picker = new $.DtPicker(options);
                    picker.show(function (rs) {
                        id[0].innerText = rs.text;
                        picker.dispose();
                    });
                }, false);
            });
        });
    })(mui, document);

</script>
<%@ include file="/webcom/cut-image.jsp" %>
</body>
</html>