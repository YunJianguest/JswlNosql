<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %> 
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
    <title>征友条件</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css"/>
    <!--App自定义的css--> 
    <link href="${ctx}/mvccol/mui-css/mui.picker.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/> 
    <style>
        .zi-fa82a5 {
            color: #fa82a5;
        }
         .zi-9b9b9b {
            color: #9b9b9b;
        } 
        .mui-btn-blue{
         background-color: rgba(234, 100, 131, 0.8);
         border-color: rgba(234, 100, 131, 0.8);
        }
    </style>
    <script>
    
         var total=0;
         var remoney=0;
         var jfdh=0;
         var loading;
         function  load(txt){
        var opts = {
		lines: 13, // The number of lines to draw
		length: 6, // The length of each line
		width: 3, // The line thickness
		radius: 8, // The radius of the inner circle
		corners: 1, // Corner roundness (0..1)
		rotate: 0, // The rotation offset
		color: '#FFF', // #rgb or #rrggbb
		speed: 1, // Rounds per second
		trail: 60, // Afterglow percentage
		shadow: false, // Whether to render a shadow
		hwaccel: false, // Whether to use hardware acceleration
		className: 'spinner', // The CSS class to assign to the spinner
		zIndex: 2e9, // The z-index (defaults to 2000000000)
		top: 'auto', // Top position relative to parent in px
		left: 'auto' // Left position relative to parent in px
	}; 
	   var target = document.createElement("div");
	   document.body.appendChild(target);
	   var spinner = new Spinner(opts).spin(target);
	  loading=iosOverlay({
		text: txt, 
		spinner: spinner
	   });
     }
       var u_startAge;
       var u_endAge;
       var u_startHeight;
       var u_endHeight;
       var u_record;
       var u_income; 
       var u_province;
       var u_city;
       var u_county;
       var u_sex;
       function save(){  
          var submitData = {
                startAge:u_startAge,
                endAge:u_endAge,
                startHeight:u_startHeight,
                endHeight:u_endHeight,
                record:u_record,
                income:u_income, 
                province:u_province,
                city:u_city,
                county:u_county, 
                sex:u_sex
	            };
	            load('保存中'); 
		$.post('${ctx}/suc/dating!saveCondition.action?custid=${custid}&lscode=${lscode}', submitData, 
        	 function(json){
        	  loading.hide();
        	  self.location=document.referrer; 
        	  if(json.state==0){ 
        	  }else{ 
        	  }
        	 },"json"); 
       }
    </script>
</head>
<body class="lock" style="background-color: #f0f0f0">
<main class="cmp640">
    <div class="hang40 line-height40 pl-10 pr-10 zi-bai line-bottom" style="background-color: #fd6c8e">
        <div class="col-3 zi-bai" onclick="self.location=document.referrer;">
            <i class="fa fa-chevron-left pr-5"></i>返回
        </div>
        <div class="col-6">
            <div class="width-9 sl maring-a txt-c">征友条件</div>
        </div>
        <div class="col-3 pull-right pt-5 zi-hui-wx">
            <font size="1">
                <div class="hang30 line-height30 pl-10 pr-10 txt-c pull-right zi-bai border-radius3"
                     style="background-color: #fd87a8" onclick="save()">确定
                </div>
            </font>
        </div>
    </div>
    
    <!--内容-->
    <div class="width-9_5 maring-a pt-10">
        <div class="bg-bai border-radius5">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    年龄范围
                </div>
                <div class="pull-right">
                  <c:if test="${empty entity.startAge}">
                    <div class="pull-left line-height40" id="setting_startAge_button">
                        <i class="zi-fa82a5" id="startAge">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                  <c:if test="${not empty entity.startAge}">
                    <div class="pull-left line-height40" id="setting_startAge_button">
                        <i class="zi-9b9b9b" id="startAge">${entity.startAge}岁</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                  <c:if test="${empty entity.endAge}"> 
                   <div class="pull-left pl-40 line-height40" id="setting_endAge_button">
                        <i class="zi-fa82a5" id="endAge" >请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if> 
                   <c:if test="${not empty entity.endAge}"> 
                   <div class="pull-left pl-40 line-height40" id="setting_endAge_button">
                        <i class="zi-9b9b9b" id="endAge" >${entity.endAge}岁</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if> 
                    
                </div>
            </div>
               <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    性别
                </div>
                <div class="pull-right">
                  <c:if test="${entity.sex==1}">
                    <div class="pull-left line-height40" id="setting_sex_button">
                        <i class="zi-9b9b9b" id="settingsex">男</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                  <c:if test="${entity.sex==2}">
                    <div class="pull-left line-height40" id="setting_sex_button">
                        <i class="zi-9b9b9b" id="settingsex">女</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                   <c:if test="${entity.sex==0}">
                    <div class="pull-left line-height40" id="setting_sex_button">
                        <i class="zi-9b9b9b" id="settingsex">未知</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                  <c:if test="${empty entity.sex}">
                    <div class="pull-left line-height40" id="setting_sex_button">
                        <i class="zi-fa82a5" id="settingsex">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                 
                    
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    身高范围
                </div>
                <div class="pull-right">
                <c:if test="${empty entity.startHeight}">
                    <div class="pull-left line-height40" id="setting_startHeight_button">
                        <i class="zi-fa82a5" id="startHeight">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </c:if>
                <c:if test="${not empty entity.startHeight}">
                    <div class="pull-left line-height40" id="setting_startHeight_button">
                        <i class="zi-9b9b9b" id="startHeight">${entity.startHeight}cm</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </c:if>
                <c:if test="${empty entity.endHeight}">
                    <div class="pull-left pl-40 line-height40" id="setting_endHeight_button">
                        <i class="zi-fa82a5" id="endHeight">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </c:if>
                <c:if test="${not empty entity.endHeight}" >
                    <div class="pull-left pl-40 line-height40" id="setting_endHeight_button">
                        <i class="zi-9b9b9b" id="endHeight">${entity.endHeight}cm</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </c:if>
                    
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    最低学历
                </div>
                 <div class="pull-right">
                   <c:if test="${empty entity.record}">
                    <div class="pull-left line-height40" id="setting_record_button">
                        <i class="zi-fa82a5" id="setting_record">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                   </c:if>
                   <c:if test="${not empty entity.record}" >
                    <div class="pull-left line-height40" id="setting_record_button">
                        <i class="zi-9b9b9b" id="setting_record"><c:if test="${entity.record==0}">高中</c:if><c:if test="${entity.record==1}">技校</c:if><c:if test="${entity.record==2}">中专</c:if><c:if test="${entity.record==3}">本科</c:if><c:if test="${entity.record==4}">硕士</c:if><c:if test="${entity.record==5}">博士</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                   </c:if>
                     
                 </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    收入范围
                </div>
                <div class="pull-right">
                  <c:if test="${empty entity.income}" >
                   <div class="pull-left line-height40" id="setting_income_button">
                        <i class="zi-fa82a5" id="setting_income">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if>
                  <c:if test="${not empty entity.income}" >
                   <div class="pull-left line-height40" id="setting_income_button">
                        <i class="zi-9b9b9b" id="setting_income"><c:if test="${entity.income==0}">2000元以下</c:if><c:if test="${entity.income==1}">2000-5000元</c:if><c:if test="${entity.income==2}">5000-10000元</c:if><c:if test="${entity.income==3}">10000元以上</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                  </c:if> 
                   
                 </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    居住地
                </div>
                <div class="pull-right" id="showCityPicker3">
                   <c:if test="${empty entity.province}">
                    <div class="pull-left line-height40" >
                        <i class="zi-fa82a5" id="province">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                   </c:if>
                   <c:if test="${not empty entity.province}">
                    <div class="pull-left line-height40">
                        <i class="zi-9b9b9b" id="province">${entity.province}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                   </c:if>
                    <c:if test="${empty entity.city}">
                    <div class="pull-left pl-40 line-height40">
                        <i class="zi-fa82a5" id="city">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                    </c:if>
                     <c:if test="${not empty entity.city}">
                    <div class="pull-left pl-40 line-height40">
                        <i class="zi-9b9b9b" id="city">${entity.city}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                    </c:if>
                   
                </div>
            </div>

        </div>
    </div>


</main>
<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.picker.min.js"></script>

<script src="${ctx}/mvccol/mui-js/mui.poppicker.js"></script>

<script src="${ctx}/mvccol/mui-js/city.data.js" type="text/javascript" charset="utf-8"></script>
<script>
    (function ($, doc) {
        load('加载中');
        $.init();
        $.ready(function () {

            var cityPicker3 = new $.PopPicker({
                layer: 2
            });
            cityPicker3.setData(cityData);
            var showCityPickerButton = doc.getElementById('showCityPicker3');
            var province = doc.getElementById('province');
            var city = doc.getElementById('city');
            var county = doc.getElementById('county');
            showCityPickerButton.addEventListener('tap', function (event) {
                cityPicker3.show(function (items) {
                    province.innerHTML =(items[0] || {}).text;
                    u_province=(items[0] || {}).text;
                    city.innerHTML=(items[1] || {}).text;
                    u_city=(items[1] || {}).text;
                     
                     city.setAttribute("class", "zi-9b9b9b");  
                     province.setAttribute("class", "zi-9b9b9b");   
                    //返回 false 可以阻止选择框的关闭
                    
                    //return false;
                });
            }, false);
            
            var agePicker = new $.PopPicker();
					agePicker.setData([{
						value: '16',
						text: '16岁'
					}, {
						value: '17',
						text: '17岁'
					}, {
						value: '18',
						text: '18岁'
					}, {
						value: '19',
						text: '19岁'
					}, {
						value: '20',
						text: '20岁'
					}, {
						value: '21',
						text: '21岁'
					}, {
						value: '22',
						text: '22岁'
					}, {
						value: '23',
						text: '23岁'
					}, {
						value: '24',
						text: '24岁'
					}, {
						value: '25',
						text: '25岁'
					}, {
						value: '26',
						text: '26岁'
					}, {
						value: '27',
						text: '27岁'
					}, {
						value: '28',
						text: '28岁'
					}, {
						value: '29',
						text: '29岁'
					}, {
						value: '30',
						text: '30岁'
					}, {
						value: '31',
						text: '31岁'
					}, {
						value: '32',
						text: '32岁'
					}, {
						value: '33',
						text: '33岁'
					}, {
						value: '34',
						text: '34岁'
					}, {
						value: '35',
						text: '35岁'
					}, {
						value: '36',
						text: '36岁'
					}, {
						value: '37',
						text: '37岁'
					}, {
						value: '38',
						text: '38岁'
					}, {
						value: '39',
						text: '39岁'
					}, {
						value: '40',
						text: '40岁'
					}, {
						value: '41',
						text: '41岁'
					}, {
						value: '42',
						text: '42岁'
					}, {
						value: '43',
						text: '43岁'
					}, {
						value: '44',
						text: '44岁'
					}, {
						value: '45',
						text: '45岁'
					}, {
						value: '46',
						text: '46岁'
					}, {
						value: '47',
						text: '47岁'
					}, {
						value: '48',
						text: '48岁'
					}, {
						value: '49',
						text: '49岁'
					}, {
						value: '50',
						text: '50岁'
					}, {
						value: '51',
						text: '51岁'
					},{
						value: '52',
						text: '52岁'
					},{
						value: '53',
						text: '53岁'
					},{
						value: '54',
						text: '54岁'
					}, {
						value: '55',
						text: '55岁'
					}]);
					var setting_startAge_button = doc.getElementById('setting_startAge_button');
					var startAge = doc.getElementById('startAge');
					setting_startAge_button.addEventListener('tap', function(event) {
						agePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							startAge.innerText=items[0].text;
							u_startAge=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							startAge.setAttribute("class", "zi-9b9b9b");  
							
						});
					}, false);
					
					var setting_endAge_button = doc.getElementById('setting_endAge_button');
					var endAge = doc.getElementById('endAge');
					setting_endAge_button.addEventListener('tap', function(event) {
						agePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							endAge.innerText=items[0].text;
							u_endAge=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							endAge.setAttribute("class", "zi-9b9b9b");  
							
						});
					}, false);
					
					//身高
					var heightPicker = new $.PopPicker();
					heightPicker.setData([{
						value: '140',
						text: '140cm'
					}, {
						value: '141',
						text: '141cm'
					}, {
						value: '142',
						text: '142cm'
					}, {
						value: '143',
						text: '143cm'
					}, {
						value: '144',
						text: '144cm'
					}, {
						value: '145',
						text: '145cm'
					}, {
						value: '146',
						text: '146cm'
					}, {
						value: '147',
						text: '147cm'
					}, {
						value: '148',
						text: '148cm'
					}, {
						value: '149',
						text: '149cm'
					}, {
						value: '150',
						text: '150cm'
					}, {
						value: '151',
						text: '151cm'
					}, {
						value: '152',
						text: '152cm'
					}, {
						value: '153',
						text: '153cm'
					}, {
						value: '154',
						text: '154cm'
					}, {
						value: '155',
						text: '155cm'
					}, {
						value: '156',
						text: '156cm'
					}, {
						value: '157',
						text: '157cm'
					}, {
						value: '158',
						text: '158cm'
					}, {
						value: '159',
						text: '159cm'
					}, {
						value: '160',
						text: '160cm'
					}, {
						value: '161',
						text: '161cm'
					}, {
						value: '162',
						text: '162cm'
					}, {
						value: '163',
						text: '163cm'
					}, {
						value: '164',
						text: '164cm'
					}, {
						value: '165',
						text: '165cm'
					}, {
						value: '166',
						text: '166cm'
					}, {
						value: '167',
						text: '167cm'
					}, {
						value: '168',
						text: '168cm'
					}, {
						value: '169',
						text: '169cm'
					}, {
						value: '170',
						text: '170cm'
					}, {
						value: '171',
						text: '171cm'
					}, {
						value: '172',
						text: '172cm'
					}, {
						value: '173',
						text: '173cm'
					}, {
						value: '174',
						text: '174cm'
					}, {
						value: '175',
						text: '175cm'
					},{
						value: '176',
						text: '176cm'
					},{
						value: '177',
						text: '177cm'
					},{
						value: '178',
						text: '178cm'
					},{
						value: '179',
						text: '179cm'
					},{
						value: '180',
						text: '180cm'
					},{
						value: '181',
						text: '181cm'
					},{
						value: '182',
						text: '182cm'
					},{
						value: '183',
						text: '183cm'
					},{
						value: '184',
						text: '184cm'
					},{
						value: '185',
						text: '185cm'
					},{
						value: '186',
						text: '186cm'
					},{
						value: '187',
						text: '187cm'
					},{
						value: '188',
						text: '188cm'
					}, {
						value: '189',
						text: '189cm'
					}, {
						value: '190',
						text: '190cm'
					}, {
						value: '191',
						text: '191cm'
					}]);
					var setting_startHeight_button = doc.getElementById('setting_startHeight_button');
					var startHeight = doc.getElementById('startHeight');
					setting_startHeight_button.addEventListener('tap', function(event) {
						heightPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							startHeight.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_startHeight=items[0].value;
							//return false;
							startHeight.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					var setting_endHeight_button = doc.getElementById('setting_endHeight_button');
					var endHeight = doc.getElementById('endHeight');
					setting_endHeight_button.addEventListener('tap', function(event) {
						heightPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							endHeight.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_endHeight=items[0].value;
							//return false;
							endHeight.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					var qqPicker = new $.PopPicker();
					qqPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					 
					
					var telPicker = new $.PopPicker();
					telPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					 
					
					var wxPicker = new $.PopPicker();
					wxPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					 
					 
					//交友目的
					var purposePicker = new $.PopPicker();
					purposePicker.setData([{
						value: '0',
						text: '结婚'
					}, {
						value: '1',
						text: '交友'
					}]);
					 
					//性别
					var sexPicker = new $.PopPicker();
					sexPicker.setData([{
						value: '1',
						text: '男'
					}, {
						value: '2',
						text: '女'
					}]);
					var setting_sex_button = doc.getElementById('setting_sex_button');
					var settingsex = doc.getElementById('settingsex');
					setting_sex_button.addEventListener('tap', function(event) {
						sexPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							settingsex.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_sex=items[0].value;
							//return false;
							settingsex.setAttribute("class", "zi-9b9b9b");
						});
					}, false); 
					//婚姻状态
					var marriagePicker = new $.PopPicker();
					marriagePicker.setData([{
						value: '0',
						text: '未婚'
					}, {
						value: '1',
						text: '已婚'
					}, {
						value: '2',
						text: '离异'
					}, {
						value: '3',
						text: '丧偶'
					}]);
					 
					//收入状态
					var incomePicker = new $.PopPicker();
					incomePicker.setData([{
						value: '0',
						text: '2000元以下'
					}, {
						value: '1',
						text: '2000-5000元'
					}, {
						value: '2',
						text: '5000-10000元'
					}, {
						value: '3',
						text: '10000元以上'
					}]);
					var setting_income_button = doc.getElementById('setting_income_button');
					var setting_income = doc.getElementById('setting_income');
					setting_income_button.addEventListener('tap', function(event) {
						incomePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_income.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_income=items[0].value;
							//return false;
							setting_income.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//学历状态
					var recordPicker = new $.PopPicker();
					recordPicker.setData([{
						value: '0',
						text: '高中'
					}, {
						value: '1',
						text: '技校'
					}, {
						value: '2',
						text: '中专'
					}, {
						value: '3',
						text: '本科'
					}, {
						value: '4',
						text: '硕士'
					}, {
						value: '5',
						text: '博士'
					}]);
					var setting_record_button = doc.getElementById('setting_record_button');
					var setting_record = doc.getElementById('setting_record');
					setting_record_button.addEventListener('tap', function(event) {
						recordPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_record.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_record=items[0].value;
							//return false;
							setting_record.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//职业状态
					var professionalPicker = new $.PopPicker();
					professionalPicker.setData([{
						value: '0',
						text: '各类专业、技术人员'
					}, {
						value: '1',
						text: '办事人员和有关人员'
					}, {
						value: '2',
						text: '商业工作人员'
					}, {
						value: '3',
						text: '服务性工作人员'
					}, {
						value: '4',
						text: '其他'
					}]);
					 
					//星座状态
					var constellationPicker = new $.PopPicker();
					constellationPicker.setData([{
						value: '0',
						text: '白羊座'
					}, {
						value: '1',
						text: '金牛座'
					}, {
						value: '2',
						text: '双子座'
					}, {
						value: '3',
						text: '巨蟹座'
					}, {
						value: '4',
						text: '狮子座'
					}, {
						value: '5',
						text: '处女座'
					}, {
						value: '6',
						text: '天秤座'
					}, {
						value: '7',
						text: '天蝎座'
					}, {
						value: '8',
						text: '射手座'
					}, {
						value: '9',
						text: '摩羯座'
					}, {
						value: '10',
						text: '水瓶座'
					}, {
						value: '11',
						text: '双鱼座'
					}]);
					 
					 
					
					//恋爱观念
					var conceptPicker = new $.PopPicker();
					conceptPicker.setData([{
						value: '0',
						text: '慰藉型'
					}, {
						value: '1',
						text: '友情型'
					}, {
						value: '2',
						text: '理想型'
					}, {
						value: '3',
						text: '志趣型'
					}, {
						value: '4',
						text: '功利型'
					}, {
						value: '5',
						text: '情爱型'
					}]);
					 
					//首次见面
					var firstmeetPicker = new $.PopPicker();
					firstmeetPicker.setData([{
						value: '0',
						text: '学校'
					}, {
						value: '1',
						text: '网吧'
					}, {
						value: '2',
						text: '广场'
					}, {
						value: '3',
						text: '商场'
					}, {
						value: '4',
						text: '公园'
					}, {
						value: '5',
						text: '咖啡厅'
					}, {
						value: '6',
						text: '河边'
					}, {
						value: '7',
						text: '海边'
					}, {
						value: '8',
						text: '宾馆'
					}, {
						value: '9',
						text: '家'
					}]);
					 
					
					//约会地点
					var likeDatingSitePicker = new $.PopPicker();
					likeDatingSitePicker.setData([{
						value: '0',
						text: '学校'
					}, {
						value: '1',
						text: '网吧'
					}, {
						value: '2',
						text: '广场'
					}, {
						value: '3',
						text: '商场'
					}, {
						value: '4',
						text: '公园'
					}, {
						value: '5',
						text: '咖啡厅'
					}, {
						value: '6',
						text: '河边'
					}, {
						value: '7',
						text: '海边'
					}, {
						value: '8',
						text: '宾馆'
					}, {
						value: '9',
						text: '家'
					}]);
				 
					//体重状态
					var weightPicker = new $.PopPicker();
					weightPicker.setData([{
						value: '30',
						text: '30kg'
					}, {
						value: '31',
						text: '30kg'
					}, {
						value: '32',
						text: '32kg'
					}, {
						value: '33',
						text: '33kg'
					}, {
						value: '34',
						text: '34kg'
					}, {
						value: '35',
						text: '35kg'
					}, {
						value: '36',
						text: '36kg'
					}, {
						value: '37',
						text: '37kg'
					}, {
						value: '38',
						text: '38kg'
					}, {
						value: '39',
						text: '39kg'
					}, {
						value: '40',
						text: '40kg'
					}, {
						value: '41',
						text: '41kg'
					}, {
						value: '42',
						text: '42kg'
					}, {
						value: '43',
						text: '43kg'
					}, {
						value: '44',
						text: '44kg'
					}, {
						value: '45',
						text: '45kg'
					}, {
						value: '46',
						text: '46kg'
					}, {
						value: '47',
						text: '47kg'
					}, {
						value: '48',
						text: '48kg'
					}, {
						value: '49',
						text: '49kg'
					}, {
						value: '50',
						text: '50kg'
					}, {
						value: '51',
						text: '51kg'
					}, {
						value: '52',
						text: '52kg'
					}, {
						value: '53',
						text: '53kg'
					}, {
						value: '54',
						text: '54kg'
					}, {
						value: '55',
						text: '55kg'
					}, {
						value: '56',
						text: '56kg'
					}, {
						value: '57',
						text: '57kg'
					}, {
						value: '58',
						text: '58kg'
					}, {
						value: '59',
						text: '59kg'
					}, {
						value: '60',
						text: '60kg'
					}, {
						value: '61',
						text: '61kg'
					}, {
						value: '62',
						text: '62kg'
					}, {
						value: '63',
						text: '63kg'
					}, {
						value: '64',
						text: '64kg'
					}, {
						value: '65',
						text: '65kg'
					}, {
						value: '66',
						text: '66kg'
					}, {
						value: '67',
						text: '67kg'
					}, {
						value: '68',
						text: '68kg'
					}, {
						value: '69',
						text: '69kg'
					}, {
						value: '70',
						text: '70kg'
					}, {
						value: '71',
						text: '71kg'
					}, {
						value: '72',
						text: '72kg'
					}, {
						value: '73',
						text: '73kg'
					}, {
						value: '74',
						text: '74kg'
					}, {
						value: '75',
						text: '75kg'
					}, {
						value: '76',
						text: '76kg'
					}, {
						value: '77',
						text: '77kg'
					}, {
						value: '78',
						text: '78kg'
					}, {
						value: '79',
						text: '79kg'
					}, {
						value: '80',
						text: '80kg'
					}, {
						value: '81',
						text: '81kg'
					}, {
						value: '82',
						text: '82kg'
					}, {
						value: '83',
						text: '83kg'
					}, {
						value: '84',
						text: '84kg'
					}, {
						value: '85',
						text: '85kg'
					}, {
						value: '86',
						text: '86kg'
					}, {
						value: '87',
						text: '87kg'
					}, {
						value: '88',
						text: '88kg'
					}, {
						value: '89',
						text: '89kg'
					}, {
						value: '90',
						text: '90kg'
					}, {
						value: '91',
						text: '91kg'
					}, {
						value: '92',
						text: '92kg'
					}, {
						value: '93',
						text: '93kg'
					}, {
						value: '94',
						text: '94kg'
					}, {
						value: '95',
						text: '95kg'
					}]);
					 
					
        });
        loading.hide();
    })(mui, document);
   
</script> 
<script>
 function  check_task(){
       var submitData = {  
            };
            $.post('${ctx}/suc/dating!ajaxReward.action?custid=${custid}&lscode=${lscode}', submitData, 
                    function (json) { 
                        if (json.state == 0) {
                        
                        }  
                    }, "json"); 
     }
</script>
</body>
<script type="text/javascript"> 
     
    wx.config({
        debug: false,
        appId: '${token.appid}',
        timestamp: '${token.timestamp}',
        nonceStr: '${token.noncestr}',
        signature: '${token.signature}',
        jsApiList: ['checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems'
        ]
    });
    wx.ready(function () {
        var share = {
            title: '${share.fxtitle}', // 分享标题
            desc: '${share.fxsummary}', // 分享描述
            link: '${share.fxurl}', // 分享链接
            imgUrl: '${filehttp}${share.fximg}', // 分享图标
            success: function () {
            check_task();

            },
            cancel: function () {

            }
        };
        wx.onMenuShareAppMessage(share);
        wx.onMenuShareTimeline(share);
        wx.onMenuShareAppMessage(share);
        wx.onMenuShareQQ(share);
        wx.onMenuShareWeibo(share);
    }); 
</script>
</html>