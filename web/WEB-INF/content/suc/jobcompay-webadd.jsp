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
    <title>发布信息</title>
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
    function submit(v) { 
            var emptitle = $('#emptitle').val();
            var emppcount = $('#emppcount').val();  
            var empsalary = $('#empsalary').val();
            var empworkaddress = $('#empworkaddress').val();
            var empsummary = $('#empsummary').val();
            var emprecord=$.trim($('#emprecord').html());
            var empexperience=$.trim($('#empexperience').html()); 
            if (emptitle.replace('标题', '')== "") {
                alert("请输入标题");
                return;
            }
            if (emppcount.replace('招聘人数', '') == "") {
                alert("请输入招聘人数");
                return;
            }
            if (emprecord.replace('学历要求', '') == "") {
                alert("请输入学历要求");
                return;
            }
            if (empexperience.replace('经验要求', '') == "") {
                alert("请输入经验要求");
                return;
            }
            if (empsalary.replace('薪资待遇', '') == "") {
                alert("请输入薪资待遇");
                return;
            }
            if(isNaN($.trim(empsalary.replace("薪资待遇","")))){
	           alert("薪资待遇处请输入数字");
	           $('#empsalary').focus();
	           return;
           }
            if (empworkaddress.replace('工作地点', '') == "") {
                alert("请输入工作地点");
                return;
            }
            if (empsummary.replace('职位描述10-300个字', '') == "") {
                alert("职位描述10-300个字");
                return;
            }
           
            
            var submitData = {
                id: v,
                title: emptitle,
                pcount: emppcount, 
                record: emprecord, 
                experience:empexperience,
                salary:empsalary,
                workaddress:empworkaddress,
                summary:empsummary  
            };
            $.post('${ctx}/suc/jobcompay!ajaxemployadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            noty({text: "发表成功！",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                            afterClose: function() {
                              window.location.href='${ctx}/suc/jobcompay!index.action?custid=${custid}&lscode=${lscode}&isadmin=${isadmin}';
                            } // 关闭之后
                          },});      
                        }
                    }, "json")


        }
        function  subcom(){
           var comtitle=$('#comtitle').val();
           var comtel=$('#comtel').val();
           var comsummary=$('#comsummary').val();
           var comlinkman=$('#comlinkman').val();
           var industry=$.trim($('#industry').html());
           var nature=$.trim($('#nature').html());
           if(comtitle.replace('公司名称', '') == ""){
              alert("请输入公司名称");
               return;
           }
           if(comlinkman.replace('联系人', '') == ""){
              alert("请输入联系人");
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
           if(comsummary.replace('请输入您的公司简介10-300个字', '') == ""){
              alert("请输入您的公司简介10-300个字");
              return;
           }
           if(industry.replace('公司行业', '')==""){
              alert("请选择公司行业");
              return;
           } 
           if(nature.replace('公司性质', '')==""){
              alert("请选择公司性质");
              return;
           }  
           
              var submitData = {
                title: comtitle,
                summary: comsummary,
                welfare: $("#comwelfare").val(),
                tel: comtel ,
                linkman:comlinkman,
                industry:industry,
                nature:nature
            };
            $.post('${ctx}/suc/jobcompay!ajaxwebadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            submit(json.value); 
                        }
                    }, "json")

           
           
        }
  </script>
 
</head>
<body>
<main class="cmp640">
    <div class="div-group-5 pl-10 pr-10">


        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">职位简介</div>
        
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="标题" onfocus="if(this.value=='标题'){this.value=''};this.style.color='#666666';"
                   id="emptitle" onblur="if(this.value==''||this.value=='标题'){this.value='标题';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="招聘人数" onfocus="if(this.value=='招聘人数'){this.value=''};this.style.color='#666666';"
                   id="emppcount"onblur="if(this.value==''||this.value=='招聘人数'){this.value='招聘人数';this.style.color='#aaa';}"/>
        </div> 
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500"
                   id="emprecord" onclick="show_record()">学历要求</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500"
                   id="empexperience" onclick="show_experience()">经验要求</div>
        </div> 
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="薪资待遇" onfocus="if(this.value=='薪资待遇'){this.value=''};this.style.color='#666666';"
                   id="empsalary" onblur="if(this.value==''||this.value=='薪资待遇'){this.value='薪资待遇';this.style.color='#aaa';}">
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="工作地点" onfocus="if(this.value=='工作地点'){this.value=''};this.style.color='#666666';"
                   id="empworkaddress" onblur="if(this.value==''||this.value=='工作地点'){this.value='工作地点';this.style.color='#aaa';}">
        </div>
        <div class="line-bottom-92 line-right-92 line-left-92 overflow-hidden zi-hui">
            <form action="">
                <textarea id="empsummary" onfocus="if(this.value=='职位描述10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='职位描述10-300个字'){this.value='职位描述10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">职位描述10-300个字</textarea>
                <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right">
            </form>
        </div>


        <div class="size14 line-bottom-92 weight500 pt-10 pb-10" style="padding-left: 2px;">公司简介</div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   id="comtitle" value="公司名称" onfocus="if(this.value=='公司名称'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='公司名称'){this.value='公司名称';this.style.color='#aaa';}">
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500"
                   id="industry" onclick="show_industry()">公司行业</div>
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500"
                   id="nature" onclick="show_nature()">公司性质</div>
        </div> 
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="联系电话" onfocus="if(this.value=='联系电话'){this.value=''};this.style.color='#666666';"
                   id="comtel" onblur="if(this.value==''||this.value=='联系电话'){this.value='联系电话';this.style.color='#aaa';}">
        </div>
        <div class="line-bottom-92 line-right-92 pt-10 line-left-92 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 weight500" type="text" name=""
                   value="联系人" onfocus="if(this.value=='联系人'){this.value=''};this.style.color='#666666';"
                   id="comlinkman" onblur="if(this.value==''||this.value=='联系人'){this.value='联系人';this.style.color='#aaa';}">
        </div>

        <div class="line-bottom-92 line-right-92 line-left-92 overflow-hidden zi-hui">
            <form action="">
                <textarea id="comsummary" onfocus="if(this.value=='请输入您的公司简介10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='请输入您的公司简介10-300个字'){this.value='请输入您的公司简介10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">请输入您的公司简介10-300个字</textarea>
                <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right">
            </form>
        </div>
        <input type="hidden" id="comwelfare" />
        <div class="size14 line-bottom-92 weight500 div-group-10" style="padding-left: 2px;">公司福利</div>
        <div class="line-bottom-92 line-right-92 line-left-92 overflow-hidden pt-10 pl-10 welfare">
            <font size="2">
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">社保</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">公积金</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">双休</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">包吃住</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">餐补</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">房补</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">交通补助</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">电话补助</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa  zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">年终奖</div>
                </li>
                <li class="col-4 pb-10">
                    <div class="pull-left pr-5">
                        <div class="img-wh20 bg-bai-5 maring-a txt-c"
                             style="border: solid #45c01a 2px;">
                            <font size="1">
                                <i class="fa zi-green display-none"
                                   style="line-height:16px;"></i>
                            </font>
                        </div>
                    </div>
                    <div class="hang20 line-height20 pull-left weight500">带薪年假</div>
                </li>

            </font>
        </div>

    </div>

    <div class="div-group-10 pt-20 pb-30" onclick="subcom()">
        <div class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">确认发布</div>
    </div>
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp"%>
<script>
var obj='${entity}'; 
if(obj!=''){
obj=JSON.parse(obj);   
if(obj.title!=''){
 $('#comtitle').val(obj.title);
}
if(obj.tel!=''){
 $('#comtel').val(obj.tel);
}
if(obj.summary!=''){
 $('#comsummary').val(obj.summary);
}
if(obj.welfare!=''){
 $("#comwelfare").val(obj.welfare);
}
if(obj.linkman!=''){
 $("#comlinkman").val(obj.linkman);
}
if(obj.industry!=''){
 $('#industry').html(obj.industry);
}
if(obj.nature!=''){
 $('#nature').html(obj.nature);
}
var wr=obj.welfare.split(","); 
 for (var l = 0; l < wr.length; l++) {
        $(".welfare li").each(function(){ 
         if($(this).find('.weight500').html()==wr[l]){
          $(this).find('i').addClass("fa-check");
         } 
        });
     }
}

</script>
<!--公司行业-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="industry_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_industry()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5"style="height: 200px;overflow: auto">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           计算机硬件
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           通信/电信
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           财务/审计
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           信托/拍卖
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           快速消费品(食品/饮料等)
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           租赁服务
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           汽车/摩托车
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           广告/创意
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           媒体传播
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                          建筑/建材
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           检测/认证
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           教育/科研/培训
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           交通/运输/物流
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           能源（电力/水利/矿产）
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                          环保
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           人力资源服务
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           纺织服饰
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           互联网/电子商务
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           
         IT服务/系统集成 
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           电子技术/半导体/集成电路
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           金融/银行
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           贸易/进出口
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           耐用消费品(家具/家电等)
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           办公用品及设备
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           医疗/保健/卫生/美容
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           公关/市场推广/会展
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           出版/印刷/造纸
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           家居/室内设计/装潢
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           法律/法务
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           旅游/酒店
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           航天/航空
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           原材料和加工
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           农林牧渔
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           陶瓷卫浴
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           计算机软件
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           游戏
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           仪器仪表/工业自动化
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           保险
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           批发/零售
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           服装/纺织/皮革
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           钢铁/机械/设备/重工
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           生物/制药/医疗器械
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           文体/影视/艺术
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           房地产/物业管理
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           中介/专业服务
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           咨询/顾问
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           娱乐休闲/餐饮/服务
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           化工/采掘/冶炼
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           政府/非盈利机构
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           多元化集团
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                           家具灯饰
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_industry(this)">
                          其他行业
                        </div>
            
         
            </div>
            <a href="javascript:hide_industry()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>     

<!--性质-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="nature_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_nature()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5"style="height: 200px;overflow: auto">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                           私营
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          国有
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          股份制
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          外商独资/办事处
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          中贸合资/合作
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          上市公司
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          事业单位
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          政府机关
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          非盈利机构
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_nature(this)">
                          个人企业
                        </div>
         
            </div>
            <a href="javascript:hide_nature()">
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
 
 function   hide_nature(){
    $("#nature_tc").hide();
 }
 function  show_nature(){
    $("#nature_tc").show();
 }
 function  set_nature(v){
   $("#nature").html($(v).html());
   hide_nature();
 }
 
 function   hide_industry(){
    $("#industry_tc").hide();
 }
 function  show_industry(){
    $("#industry_tc").show();
 }
 function  set_industry(v){
   $("#industry").html($(v).html());
   hide_industry();
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