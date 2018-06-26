<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
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
    <title>发布招聘信息</title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${contextPath}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <%@ include file="/webcom/toast.jsp" %>
    <!--muiover-->

    <style>
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
        .welfare{
        }
    </style>

    <script>
     $(function () {
            $(".welfare li").click(function () {
             if ($(this).find('i').hasClass('fa-check')) { 
                    $(this).find('i').removeClass("fa-check");
                    $('#comwelfare').val($('#comwelfare').val().replace($(this).find('.weight500').html()+",",""));
                 }else{
                   $(this).find('i').addClass("fa-check");
                   $('#comwelfare').val($('#comwelfare').val()+$(this).find('.weight500').html()+",");
                } 
                
            })
        });
    function submit() {
            var empname = $('#empname').val();
            var emptitle = $('#emptitle').val(); 
            var emprecord=$.trim($('#emprecord').html());
            var empexperience=$.trim($('#empexperience').html());
            var type=$.trim($('#type').html()); 
            var sex=$.trim($('#sex').html()); 
            var empsalary = $('#empsalary').val();
            var age = $('#age').val();
            var empworkaddress = $('#empworkaddress').val();
            var empsummary = $('#empsummary').val(); 
            var comtel=$('#comtel').val(); 
            if (empname.replace('姓名', '') == "") {
                alert("请输入姓名");
                return;
            }
            if (emptitle.replace('目标岗位', '')== "") {
                alert("请输入目标岗位");
                return;
            } 
            if (emprecord.replace('学历', '') == "") {
                alert("请选择学历");
                return;
            }
            if (empexperience.replace('工作经验', '') == "") {
                alert("请选择工作经验");
                return;
            }
            if (empsalary.replace('期望薪资', '') == "") {
                alert("请输入期望薪资");
                return;
            }
            if(isNaN($.trim(empsalary.replace("期望薪资","")))){
	           alert("期望薪资处请输入数字");
	           $('#empsalary').focus();
	           return;
           }
            if (empworkaddress.replace('工作地点', '') == "") {
                alert("请输入工作地点");
                return;
            }
            if (empsummary.replace('工作经历10-300个字', '') == "") {
                alert("工作经历10-300个字");
                return;
            }
            if(comtel.replace('联系电话', '') == ""){
              alert("联系电话");
               return;
            }
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(comtel))) {
                alert("手机号码有误，请重填");
                return;
            }
            if(sex.replace('性别', '') == ""){
               alert("请选择性别");
               return;
            }
            if(age.replace('年龄', '') == ""){
               alert("请输入年龄");
               return;
            }
            if(type.replace('类型', '') == ""){
               alert("请选择类型");
               return;
            }
            if(isNaN($.trim(age.replace("年龄","")))){
	           alert("年龄处请输入数字");
	           $('#age').focus();
	           return;
             }
           
            
            var submitData = {
                name:empname, 
                title: emptitle, 
                record: emprecord, 
                experience:empexperience,
                salary:empsalary,
                workaddress:empworkaddress,
                summary:empsummary,
                tel:comtel,
                age:age,
                sex:sex,
                type:type
            };
            $.post('${ctx}/suc/jobcompay!ajaxseekersadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            noty({text: "发表成功！",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                            afterClose: function() {
                              window.location.href='${ctx}/suc/jobcompay!index.action?custid=${custid}&lscode=${lscode}';
                            } // 关闭之后
                          },});        
                        }
                    }, "json")


        }
      
  </script>
 
</head>
<body>
<main class="cmp640">
    <div class="div-group-5 pl-10 pr-10">


        <div class="size14 line-bottom  weight500 pt-10 pb-10" style="padding-left: 2px;">个人简历</div>
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="姓名" onfocus="if(this.value=='姓名'){this.value=''};this.style.color='#666666';"
                   id="empname" onblur="if(this.value==''||this.value=='姓名'){this.value='姓名';this.style.color='#aaa';}"/>
        </div>  
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="目标岗位" onfocus="if(this.value=='目标岗位'){this.value=''};this.style.color='#666666';"
                   id="emptitle" onblur="if(this.value==''||this.value=='目标岗位'){this.value='目标岗位';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="年龄" onfocus="if(this.value=='年龄'){this.value=''};this.style.color='#666666';"
                   id="age" onblur="if(this.value==''||this.value=='年龄'){this.value='年龄';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="sex" onclick="show_sex()">性别</div>
        </div> 
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="emprecord" onclick="show_record()">学历</div>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="type" onclick="show_type()">类型</div>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="empexperience" onclick="show_experience()">工作经验</div>
        </div> 
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="期望薪资" onfocus="if(this.value=='期望薪资'){this.value=''};this.style.color='#666666';"
                   id="empsalary" onblur="if(this.value==''||this.value=='期望薪资'){this.value='期望薪资';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="工作地点" onfocus="if(this.value=='工作地点'){this.value=''};this.style.color='#666666';"
                   id="empworkaddress" onblur="if(this.value==''||this.value=='工作地点'){this.value='工作地点';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom  line-right   line-left1  overflow-hidden zi-hui">
            <form action="">
                <textarea id="empsummary" onfocus="if(this.value=='工作经历10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='工作经历10-300个字'){this.value='工作经历10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">工作经历10-300个字</textarea>
                <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right"/>
            </form>
        </div> 
        <div class="line-bottom  line-right  pt-10  line-left1  hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="联系电话" onfocus="if(this.value=='联系电话'){this.value=''};this.style.color='#666666';"
                   id="comtel" onblur="if(this.value==''||this.value=='联系电话'){this.value='联系电话';this.style.color='#aaa';}"/>
        </div>
 
    </div>

    <div class="div-group-10 pt-20 pb-30" onclick="submit()">
        <div class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">确认发布</div>
    </div>
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp"%>

<!--学历-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="record_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_record()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           高中
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           技校
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           中专
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           大专
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           本科
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           硕士
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_record(this)">
                           博士
                        </div>
         
            </div>
            <a href="javascript:hide_record()">
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
         1年以下
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
         1-2年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
         3-5年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
         6-7年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
         8-10年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_experience(this)">
         10年以上
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

<!--性别-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="sex_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_sex()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_sex(this)">
         男
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_sex(this)">
         女
                        </div>
                    
         
            </div>
            <a href="javascript:hide_sex()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

<!--类型-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="type_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_type()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
        全职
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
         兼职
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
<script>
function   hide_experience(){
    $("#experience_tc").hide();
 }
 function  show_experience(){
    $("#experience_tc").show();
 }
 function  set_experience(v){
   $("#empexperience").html($(v).html());
   hide_experience();
 }
 function   hide_record(){
    $("#record_tc").hide();
 }
 function  show_record(){
    $("#record_tc").show();
 }
 function  set_record(v){
   $("#emprecord").html($(v).html());
   hide_record();
 }
 
 function   hide_sex(){
    $("#sex_tc").hide();
 }
 function  show_sex(){
    $("#sex_tc").show();
 }
 function  set_sex(v){
   $("#sex").html($(v).html());
   hide_sex();
 }
 
 function   hide_type(){
    $("#type_tc").hide();
 }
 function  show_type(){
    $("#type_tc").show();
 }
 function  set_type(v){
   $("#type").html($(v).html());
   hide_type();
 }
</script> 
 
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

</script>
</body>
</html>