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
    <title>发布招聘信息</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/app.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/mui.picker.min.css"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .btn-cheng {
            background-color: #26bd93;
        }

        .btn-cheng:hover {
            background-color: #21a883;
        }
        .zi-26bd93{
            color: #26bd93;
        }
        
            .zi-6 {
            color: #666666
        }

        .xzb {
            border: solid 1px #00c44e;
            background-color: #00c44e;
            color: #ffffff;
        }

        .xz {
            border: solid 1px #ccc;
            background-color: #ffffff;
            color: #ffffff;
        }

        .bfcss {
            background-color: #eee;
            color: #666;
        }

        .bfcss:hover {
            background-color: #ddd;
            color: #666;
        }

        .bfcss:active {
            background-color: #ddd;
            color: #666;
        } 
         .yqbtn {
            background-color: #ffffff;
            color: #ef8200;
        }

        .yqbtn:hover {
            background-color: #ef8200;
            color: #ffffff;
        }

        .yqbtn1 {
            background-color: #ffffff;
            color: limegreen;
        }

        .yqbtn1:hover {
            background-color: limegreen;
            color: #ffffff;
        }

        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }

        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
    </style>
    
    <script>
   function  save(){ 
	   
	   var education=0;
	   if($.trim($('#education').html())=="无"){
		   education=0;
	   }else if($.trim($('#education').html())=="大专以上"){
		   education=1;
	   }else if($.trim($('#education').html())=="本科以上"){
		   education=2;
	   }else if($.trim($('#education').html())=="硕士以上"){
		   education=3;
	   }
	   
	   var experience=0;
	   if($.trim($('#experience').html())=="无"){
		   experience=0;
	   }else if($.trim($('#experience').html())=="一年以上"){
		   experience=1;
	   }else if($.trim($('#experience').html())=="一年到三年"){
		   experience=2;
	   }else if($.trim($('#experience').html())=="三年以上"){
		   experience=3;
	   }
	  
	   var age=0;
	   if($.trim($('#age').html())=="18岁以上"){
		   age=0;
	   }else if($.trim($('#age').html())=="36岁以上"){
		   age=1;
	   }else if($.trim($('#age').html())=="40岁以上"){
		   age=2;
	   }else if($.trim($('#age').html())=="45岁以上"){
		   age=3;
	   }
	   
	   var jstype=0;
	   if($.trim($('#jstype').html())=="默认"){
		   jstype=0;
	   }else if($.trim($('#jstype').html())=="小时结算"){
		   jstype=1;
	   }else if($.trim($('#jstype').html())=="日结算"){
		   jstype=2;
	   }else if($.trim($('#jstype').html())=="月结算"){
		   jstype=3;
	   }
	   
	   var type=0;
	   if($.trim($('#type').html())=="平台自营"){
		   type=0;
	   } 
	   var submitData = {
			  title:$('#title').val().replace('职位名称', ''), 
			  num:$('#num').val().replace('招聘人数', ''),
			  price:$('#price').val().replace('薪资待遇', ''),
			  workaddress:$('#workaddress').val().replace('工作地点',''),
			  gatherdate:$('#gatherdate').html().replace('集合时间',''),
			  startdate:$('#startdate').html().replace('开始时间',''),
			  enddate:$('#enddate').html().replace('结束时间',''),
			  company:$('#company').val().replace('公司全称',''),
			  linkname:$('#linkname').val().replace('负责人姓名',''),
			  linktel:$('#linktel').val().replace('负责人电话',''),
			  area:$('#area').val().replace('职位区域',''),
			  summary:$('#summary').val().replace('职位描述10-300个字',''),
			  type:type,
			  jstype:jstype,
			  experience:experience,
			  education:education
	   };
	  
	   $.post('${ctx}/parttime/mission!createMiss.action?custid=${custid}&lscode=${lscode}', submitData,
	           function (json) { 
	                 if(json.state==0){
	                	alert("发布成功！"); 
	                	window.location.href='${ctx}/parttime/employee!index.action?custid=${custid}&lscode=${lscode}'
	                 }else{
	                	alert("发布失败！");  
	                 }        
	                        
	          }, "json")
      }
   </script>
</head>
<body>


<!--在用户要发布信息时候会做选择是个人发布还是公司发布，在用户选择后会做不同的跳转进行区别  填写信息也会不相同 NO1:个人用户需要采集身份证信息等  NO2:公司会需要营业执照等信息-->



<main class="cmp640">
    <div class="div-group-5 pl-10 pr-10">

        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">职位简介</div>
        <div class="line-top-92 line-bottom-92 line-right-92 line-left-92">
            <a href="javascript:shopping_xianshi()">
                <div class="width-10 size14 pt-10 zi-hui hang50 weight500">
                    <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" id="title"
                           value="职位名称"  onfocus="if(this.value=='职位名称'){this.value=''};this.style.color='#666666';"
                           onblur="if(this.value==''||this.value=='职位名称'){this.value='职位名称';this.style.color='#aaa';}"/>
                </div>
            </a>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="招聘人数" id="num" onfocus="if(this.value=='招聘人数'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='招聘人数'){this.value='招聘人数';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50" onclick="show_jstype()">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" 
                  id="jstype" >结算类型</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
           <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" 
                  id="age" onclick="show_age()" >年龄要求</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
           <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" 
                  id="education" onclick="show_education()">学历要求</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" 
                  id="experience" onclick="show_experience()">经验要求</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="薪资待遇" id="price" onfocus="if(this.value=='薪资待遇'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='薪资待遇'){this.value='薪资待遇';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="工作地点" id="workaddress" onfocus="if(this.value=='工作地点'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='工作地点'){this.value='工作地点';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50 dates">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500 datevalue"
                   id="gatherdate" >集合时间</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50 dates">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500 datevalue"
                   id="startdate" >开始时间</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50 dates">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500 datevalue"
                   id="enddate"  >结束时间</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500"  
                    id="type" onclick="show_type()">职位类型</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" id="company"
                   value="公司名称" onfocus="if(this.value=='公司名称'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='公司名称'){this.value='公司名称';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" id="linkname"
                   value="负责人姓名" onfocus="if(this.value=='负责人姓名'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='负责人姓名'){this.value='负责人姓名';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" id="linktel"
                   value="负责人电话" onfocus="if(this.value=='负责人电话'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='负责人电话'){this.value='负责人电话';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text"
                   value="职位区域" id="area" onfocus="if(this.value=='职位区域'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='职位区域'){this.value='职位区域';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 line-left-92 overflow-hidden zi-hui">
            <form action="">
                <textarea id="summary" onfocus="if(this.value=='职位描述10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='职位描述10-300个字'){this.value='职位描述10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">职位描述10-300个字</textarea>
                <input name="summary" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right"/>
            </form>
        </div>
        
    </div>

</main>
<div class="clear hang70"></div>

<div class=" button_foot bg-bai zi-hui shadow-wai cmp640" onclick="save()">
    <div class="zi-hui-wx txt-c weight500 button_group1">
        <div class="hang50 line-height50 zi-bai btn-cheng txt-c">
            保存发布
        </div>
    </div>
</div>

<!--年龄要求-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="age_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_age()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_age(this)">
                           18岁以上
                        </div>  
     
            </div>
            
            <a href="javascript:hide_age()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

<!--职位类型-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="type_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_type()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                           平台自营
                        </div>  
     
            </div>
            <a href="javascript:hide_type()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>     
<!--职位类型-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="jstype_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_jstype()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_jstype(this)">
                           默认
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_jstype(this)">
                         小时结算
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_jstype(this)">
                          日结算
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_jstype(this)">
                           月结算
                        </div>  
     
            </div>
            <a href="javascript:hide_jstype()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>     

<!--学历-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="education_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_education()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_education(this)">
                           无
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_education(this)">
                         大专以上
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_education(this)">
                         本科以上
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_education(this)">
                         硕士以上
                        </div>
          
            </div>
            <a href="javascript:hide_education()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>     

<!--工作经验-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="experience_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_experience()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
         无
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
        一年以上
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
        一到三年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
      三年以上
                        </div>
              </div>
            <a href="javascript:hide_experience()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

 
<!--限制textarea框字数代码-->
<script language="JavaScript">

    function textCounter(field, countfield, maxlimit) {
        // 函数，3个参数，表单名字，表单域积分素名，限制字符；
        if (field.value.length > maxlimit)
        //如果积分素区字符数大于最大字符数，按照最大字符数截断；
            field.value = field.value.substring(0, maxlimit);
        else
        //在记数区文本框内显示剩余的字符数；
            countfield.value = maxlimit - field.value.length;
    }

    function   show_type(){
     $("#type_tc").show();
    }
    function   hide_type(){
     $("#type_tc").hide();
    }
    function   hide_type(){
   	 $("#type_tc").hide();
    }
    function   set_type(v){
   	  $("#type").html($(v).html());
   	  hide_type();
    }
    
    
    function   show_jstype(){ 
        $("#jstype_tc").show();
        
    } 
    function   hide_jstype(){
        $("#jstype_tc").hide();
    }
       function   hide_jstype(){
      	 $("#jstype_tc").hide();
    }
       function   set_jstype(v){
      	 $("#jstype").html($(v).html());
      	 hide_jstype();
    }
    
       
    function   show_experience(){
    	     $("#experience_tc").show();
    }
    function   hide_experience(){
       $("#experience_tc").hide();
    }
    function  show_experience(){
       $("#experience_tc").show();
    }
    function  set_experience(v){
      $("#experience").html($(v).html());
      hide_experience();
    }
    
    
    function   show_age(){
	     $("#age_tc").show();
    }
    function   hide_age(){
     $("#age_tc").hide();
    } 
    function  set_age(v){
    $("#age").html($(v).html());
     hide_age();
    }
    
    function   show_education(){
	     $("#education_tc").show();
   } 
    function   hide_education(){
       $("#education_tc").hide();
    }
    function  show_education(){
       $("#education_tc").show();
    }
    function  set_education(v){
      $("#education").html($(v).html());
      hide_education();
    }
    </script>
    <script src="${contextPath}/mvccol/mui-js/mui.min.js"></script>
    <script src="${contextPath}/mvccol/mui-js/mui.dtpicker.js"></script>

    <script src="${contextPath}/mvccol/mui-js/mui.picker.min.js"></script>
    <script>
        (function ($) {
            $.init();
            var result = $('.datevalue');
            var btns = $('.dates');
            btns.each(function (i, btn) {
                btn.addEventListener('tap', function () {
                    var optionsJson = this.getAttribute('data-options') || '{}';
                    var options = JSON.parse(optionsJson);
                    var id = this.getAttribute('id');
                    /*
                     * 首次显示时实例化组件
                     * 示例为了简洁，将 options 放在了按钮的 dom 上
                     * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
                     */
                    var picker = new $.DtPicker(options);
                    picker.show(function (rs) {
                        /*
                         * rs.value 拼合后的 value
                         * rs.text 拼合后的 text
                         * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
                         * rs.m 月，用法同年
                         * rs.d 日，用法同年
                         * rs.h 时，用法同年
                         * rs.i 分（minutes 的第二个字母），用法同年
                         */
                        result[i].innerText = rs.text;
                        /*
                         * 返回 false 可以阻止选择框的关闭
                         * return false;
                         */
                        /*
                         * 释放组件资源，释放后将将不能再操作组件
                         * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
                         * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
                         * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
                         */
                        picker.dispose();
                    });
                }, false);
            });
        })(mui);
</script>
</body>
</html>