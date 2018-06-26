<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>我要使用此软件</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/> 
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/app.css"/>
    <link href="${ctx}/mvccol/mui-css/mui.picker.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/>
    <script>
        function submit() { 
            var name = $('#name').val();
            var tel = $('#tel').val(); 
            if (name.replace('姓名', '') == "") {
                alert("请输入姓名");
                return;
            }
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号码有误，请重填");
                return;
            }
            var address = $('#province').val() + " " + $('#city').val() + " " + $('#county').val() + " " + $('#address').val();
            if ($('#province').val().replace('省份', '') == "") {
                alert("请选择省市");
                return;
            }  
            var submitData = {
                name: name, 
                tel: tel,
                address: address, 
            };
            $.post('${ctx}/set/joinin!ajaxwebadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state==0) {
                            alert("报名成功请勿重复提交，谢谢配合");
                            window.location.href='${ctx}/user/fromuser!UserDetail.action?custid=${custid}&lscode=${lscode}'; 
                        }
                    }, "json")
        }
    </script>
     <style>
        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }
        .line-bottom-green {
            border-bottom: 1px solid #45c01a;
        }
    </style>
</head>
<body>
<main class="cmp640">
    <div class="div-group-5 pl-10 pr-10">
        <input type="hidden" id="adrees"/>
         <div class=" line-bottom overflow-hidden">
                <div class="col-3 hang50 line-height50 weight500 zi-6 txt-c">姓名</div>
                <div class="col-7 pt-15">
                    <input class="hang20 width-10 line-height20 size14 zi-hui-wx" type="text"
                           id="name" value="姓名" onfocus="if(value=='姓名'){value=''};"
                           onblur="if (value ==''){value='姓名'};"/>
                </div>
                <div class="col-2 hang50 line-height50 txt-c"><i
                        class="fa fa-1dx fa-user-circle-o zi-green line-height50"></i></div>
            </div>
            <div class="line-bottom overflow-hidden">
                <div class="col-3 hang50 line-height50 weight500 zi-6 txt-c">手机号码</div>
                <div class="col-7 pt-15">
                    <input class="hang20 width-10 line-height20 size14 zi-hui-wx" type="text"
                           id="tel" value="手机号码" onfocus="if(value=='手机号码'){value=''}"
                           onblur="if (value ==''){value='手机号码'}"/>
                </div>
                <div class="col-2 hang50 line-height50 txt-c"><i class="fa fa-1dx fa-phone zi-green line-height50"></i>
                </div>
        </div>
       <div class="line-bottom overflow-hidden">
                <div class="col-3 hang50 line-height50 weight500 zi-6 txt-c">地区信息</div>
                <div class="col-7" id='showCityPicker3'>
                    <div class="col-4">
                        <input class="hang50 width-9 maring-a line-height50 size14 zi-hui-wx" type="text"
                               id="province" value="省份" onfocus="if(value=='省份'){value=''}"
                               onblur="if (value ==''){value='省份'}" readonly="readonly"/>
                    </div>
                    <div class="col-4">
                        <input class="hang50 width-9 maring-a line-height50 size14 zi-hui-wx" type="text"
                               id="city" value="城市" onfocus="if(value=='城市'){value=''}"
                               onblur="if (value ==''){value='城市'}" readonly="readonly"/>
                    </div>
                    <div class="col-4">
                        <input class="hang50 width-9 maring-a line-height50 size14 zi-hui-wx" type="text"
                               id="county" value="区/县" onfocus="if(value=='区/县'){value=''}"
                               onblur="if (value ==''){value='区/县'}" readonly="readonly"/>
                    </div>
                </div>
                <div class="col-2 hang50 line-height50 txt-c"><i
                        class="fa fa-1dx fa-map-marker zi-green line-height50"></i></div>
         </div>
        <div id='cityResult3' class=" bg-cheng zi-bai weight500 display-none">城市位置信息放置处</div>
        <div class="pt-20" onclick="submit()">
            <div class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5">
                提交资料
            </div>
        </div>
    </div>
</main>
<div class="clear hang40"></div>
<%@include file="/webcom/foot.jsp" %>
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
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
            var showCityPickerButton = doc.getElementById('showCityPicker3');
            var province = doc.getElementById('province');
            var city = doc.getElementById('city');
            var county = doc.getElementById('county');
            showCityPickerButton.addEventListener('tap', function (event) {
                cityPicker3.show(function (items) {
                    province.value = (items[0] || {}).text;
                    city.value = (items[1] || {}).text;
                    if (typeof((items[2] || {}).text) == "undefined") {
                        county.value = '';
                    } else {
                        county.value = (items[2] || {}).text;
                    }
                });
            }, false);
        });
    })(mui, document);
</script> 
</body>
</html>