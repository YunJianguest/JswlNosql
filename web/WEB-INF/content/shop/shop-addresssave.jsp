<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 

    <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css">
    <!--App自定义的css--> 
    <link href="${ctx}/mvccol/mui-css/mui.picker.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/>
    <!--muiover-->

    <script type="text/javascript">
        $(function () {
            $(".yListr ul li em").click(function () {
                $(this).addClass("yListrclickem ").siblings().removeClass("yListrclickem");
            })
        })
        
         function submit(){
          var  name=$('#name').val(); 
          var  tel=$('#tel').val();
          var  address=$('#province').val()+" "+$('#city').val()+" "+$('#county').val()+" "+$('#address').val();
            
           if(name=='收货人'){
            alert("请输入收货人");
            return
           }
           if (tel=='收货人手机号码') {
            alert("请输入手机号码");
            return
           }
           var regu = /^[1][0-9]{10}$/;
           var re = new RegExp(regu);
           if (!re.test(tel)) {
            alert("请输入正确手机号码");
            return
           }  
          if($('#province').val()=='省份'){
           alert('请选择省份');
           return;
          } 
           if($('#city').val()=='城市'){
           alert('请选择城市');
           return;
          } 
           if($('county').val()=='区县'){
           alert('请选择区县');
           return;
          } 
           if($('#address').val()=='详细地址'){
           alert('请填写详细地址');
          }  
         var submitData = { 
            name:name,
            tel:tel,  
            address:$('#address').val(),
            province:$('#province').val(),
            city:$('#city').val(),
            county:$('county').val()
        };

        $.post('${ctx}/shop/shop!ajaxuseraddresssave.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        	function (json) {
            	if(json.state==0){
            		 alert("添加成功");
            		 if('${addressis}'=='ok'){ 
            		 //window.location.href="${ctx}/shop/shop!useraddress.action?custid=${custid}&agid=${agid}&lscode=${lscode}&addressis=${addressis}&backurl=${backurl}&count=${count}&price=${price}&spec=${spec}";
            		  setadmin(json.value);
            		// window.location.href='${ctx}${backurl}&custid=${custid}&agid=${agid}&lscode=${lscode}&count=${count}&price=${price}&spec=${spec}'; 
            		 }else{
            		 setadmin(json.value);
            		// window.location.href='${ctx}${backurl}&custid=${custid}&agid=${agid}&lscode=${lscode}&count=${count}&price=${price}&spec=${spec}'; 
            		 }
            		 
            	}
            },"json")
        
        
        }
  function setadmin(id){
	var submitData = {
			id:id
	};
	$.post('${ctx}/shop/shop!ajaxsetaddress.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
		function(json) {
		 if(json.state==0){ 
		 window.location.href='${ctx}${backurl}&custid=${custid}&agid=${agid}&lscode=${lscode}&count=${count}&price=${price}&spec=${spec}';
		 }
				
	},"json");
	}
	 $(function () {
            $(".overflow-hidden").click(function () {
                $(this).removeClass("line-bottom").siblings().addClass("line-bottom");
                $(this).addClass("line-bottom-green ").siblings().removeClass("line-bottom-green");
               
            })
        })

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
<body class="lock"> 
<main class="cmp640"> 

     <div class="div-group-10 pt-15">

        <font size="2">
            <div class=" line-bottom overflow-hidden">
                <div class="col-3 hang50 line-height50 weight500 zi-6 txt-c">收货人</div>
                <div class="col-7 pt-15">
                    <input class="hang20 width-10 line-height20 size14 zi-hui-wx" type="text"
                           id="name" value="收货人" onfocus="if(value=='收货人'){value=''};"
                           onblur="if (value ==''){value='收货人'};"/>
                </div>
                <div class="col-2 hang50 line-height50 txt-c"><i
                        class="fa fa-1dx fa-user-circle-o zi-green line-height50"></i></div>
            </div>
            <div class="line-bottom overflow-hidden">
                <div class="col-3 hang50 line-height50 weight500 zi-6 txt-c">手机号码</div>
                <div class="col-7 pt-15">
                    <input class="hang20 width-10 line-height20 size14 zi-hui-wx" type="text"
                           id="tel" value="收货人手机号码" onfocus="if(value=='收货人手机号码'){value=''}"
                           onblur="if (value ==''){value='收货人手机号码'}"/>
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
            <div class="line-bottom overflow-hidden">
                <div class="col-3 hang50 line-height50 weight500 zi-6 txt-c">详细地址</div>
                <div class="col-7 pt-15">
                    <input id="address" class="hang20 width-10 line-height20 size14 zi-hui-wx" type="text"
                           name="" value="详细地址" onfocus="if(value=='详细地址'){value=''}"
                           onblur="if (value ==''){value='详细地址'}"/>
                </div>
                <div class="col-2 hang50 line-height50 txt-c"><i
                        class="fa fa-1dx fa-map-signs zi-green line-height50"></i></div>
            </div>
        </font>

    </div>


    <div class="div-group-10 pt-15" onclick="submit()">
        <div id="bfid"
             class="btn-green zi-bai hang40 line-height40 maring-a size14 txt-c weight500 border-radius5 lock">
            <font size="3">
                保存
            </font>
        </div>
    </div>

   

</main>

<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<!--<script src="../js/mui.picker.min.js"></script>-->
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
                    province.value =(items[0] || {}).text;
                    city.value=(items[1] || {}).text;
                    if (typeof((items[2] || {}).text) == "undefined") { 
                     county.value='';
                     }else{
                     county.value=(items[2] || {}).text;
                     }  
                    
                    //返回 false 可以阻止选择框的关闭
                    
                    //return false;
                });
            }, false);
        });
    })(mui, document);
</script> 
</body>
</html>