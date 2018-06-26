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
        function  subcom(){
           var comtitle=$('#comtitle').val();
           var comtel=$('#comtel').val();
           var comsummary=$('#comsummary').val();
           var comname=$('#comname').val();
           var comprice=$('#comprice').val();
           var comlx=$.trim($('#comlx').html());
           var comtype=$.trim($('#comtype').html());
           var combrand=$.trim($('#combrand').html());
           var comseries=$.trim($('#comseries').html());
           var comage=$.trim($('#comage').html());
           var comgearbox=$.trim($('#comgearbox').html());
           var comdisplacement=$.trim($('#comdisplacement').html());
           if(comtitle.replace('标题', '') == ""){
              alert("请输入标题");
               return;
           }
           if(comtel.replace('联系电话', '') == ""){
              alert("请输入联系电话");
               return;
           }
           if (!(/^1[3|4|5|7|8]\d{9}$/.test(comtel))) {
                alert("手机号码有误，请重填");
                return;
           }
           if(comsummary.replace('请输入描述10-300个字', '') == ""){
              alert("请输入描述10-300个字");
           }
           if(comname.replace('联系人', '') == ""){
               alert("请输入联系人");
               return;
           }
           if(comprice.replace('期望价格','')==""){
               alert("请输入价格");
               return;
           }
           if(isNaN($.trim(comprice.replace("期望价格","")))){
	           alert("价格处请输入数字");
	           $('#comprice').focus();
	           return;
           }
           if($.trim(comlx.replace("供求状态",""))==""){ 
	           alert("请选择供求状态");
	           $('#comlx').focus(); 
	          return;
	        }
	       if($.trim(comtype.replace("类型",""))==""){ 
	           alert("请选择类型");
	           $('#comtype').focus(); 
	          return;
	        }
	        if($.trim(combrand.replace("品牌",""))==""){ 
	           alert("请选择品牌");
	           $('#combrand').focus(); 
	          return;
	        }
	        if($.trim(comseries.replace("车系",""))==""){ 
	           alert("请选择车系");
	           $('#comseries').focus(); 
	          return;
	        }
	        if($.trim(comage.replace("车龄",""))==""){ 
	           alert("请选择车龄");
	           $('#comage').focus(); 
	          return;
	        }
	        if($.trim(comgearbox.replace("变速箱",""))==""){ 
	           alert("请选择变速箱");
	           $('#comgearbox').focus(); 
	          return;
	        }
	        if($.trim(comdisplacement.replace("排量",""))==""){ 
	           alert("请选择排量");
	           $('#comdisplacement').focus(); 
	          return;
	        }
            if($.trim(comlx)=="供"){
	          comlx=0;
	        }else{
	          comlx=1;
	        }
	        if($('#picurl')==""){ 
	           alert("请上传一张相关图片！"); 
	          return;
	        } 
              var submitData = {
                title: comtitle,
                summary: comsummary, 
                tel: comtel,
                name:comname,
                type:comtype,
                price:comprice,
                lx:comlx,
                brand:combrand,
                series:comseries,
                age:comage,
                gearbox:comgearbox,
                displacement:comdisplacement,
                picurl:$('#picurl').val()
            };
            $.post('${ctx}/suc/jobcompay!ajaxcaradd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            noty({text: "发表成功！",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                            afterClose: function() {
                              window.location.href='${ctx}/suc/jobcompay!carindex.action?custid=${custid}&lscode=${lscode}';
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
       <input id="picurl" type="hidden"/>
       <div class="size14 line-bottom  weight500 pt-10 pb-10" style="padding-left: 2px;">二手车辆</div>
        <div class="line-bottom  line-right   line-left1 div-group-5 pt-10 pb-10 overflow-hidden">
            <div class="col-3">
                <a href="javascript:pz('picurl','200','200',false,'logoimg')">
                    <div class="img-wh60 maring-a border-radius3 line-lu">
                        <div class="position-r">
                            <div id="logoimg" class="div-group-15">
                                <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                            </div>
                        </div>
                    </div>
                </a>
            </div>

        </div>  
        <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="标题" onfocus="if(this.value=='标题'){this.value=''};this.style.color='#666666';"
                   id="comtitle" onblur="if(this.value==''||this.value=='标题'){this.value='标题';this.style.color='#aaa';}"/>
        </div>
        
        <div class="line-bottom  line-right   line-left1 overflow-hidden zi-hui">
            <form action="">
                <textarea id="comsummary" onfocus="if(this.value=='描述10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='描述10-300个字'){this.value='描述10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">描述10-300个字</textarea>
                <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right"/>
            </form>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="comlx" onclick="show_comlx()">出售/购买</div>
        </div>
         <%--<div class="line-bottom  line-right  pt-10  line-left1 hang50">--%>
            <%--<div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"--%>
                   <%--id="comtype" onclick="show_comtype()">类型</div>--%>
        <%--</div> --%>
         <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="combrand" onclick="show_combrand()">品牌</div>
        </div> 
        <!-- <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="comseries" onclick="show_comseries()">车系</div>
        </div>  --> 
         <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="comage" onclick="show_comage()">车龄</div>
        </div> 
         <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="comgearbox" onclick="show_comgearbox()">变速箱</div>
        </div> 
         <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500"
                   id="comdisplacement" onclick="show_comdisplacement()">排量</div>
        </div> 
        <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   id="comprice" value="期望价格" onfocus="if(this.value=='期望价格'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='期望价格'){this.value='期望价格';this.style.color='#aaa';}"/>
        </div> 
        <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   id="comname" value="联系人" onfocus="if(this.value=='联系人'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='联系人'){this.value='联系人';this.style.color='#aaa';}"/>
        </div>
        <div class="line-bottom  line-right  pt-10  line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui hang30 line-height30 weight500" type="text" name=""
                   value="联系电话" onfocus="if(this.value=='联系电话'){this.value=''};this.style.color='#666666';"
                   id="comtel" onblur="if(this.value==''||this.value=='联系电话'){this.value='联系电话';this.style.color='#aaa';}"/>
        </div>
  
    </div>

    <div class="div-group-10 pt-20 pb-30" onclick="subcom()">
        <div class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">确认发布</div>
    </div>
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp"%>
<!--供求-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="comlx_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_comlx()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comlx(this)">
                            出售
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comlx(this)">
                             购买
                        </div>
        
            </div>
            <a href="javascript:hide_comlx()">
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
<%--<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="comtype_tc">--%>
    <%--<div class="overflow-hidden width-10">--%>
        <%--<a href="javascript:hide_comtype()">--%>
            <%--<div class="width-10 overflow-hidden" style="height:1000px;"></div>--%>
        <%--</a>--%>

        <%--<div class="overflow-hidden cmp640 position-f weight500 width-10"--%>
             <%--style="bottom:10px;left: 0px;z-index: 10000;">--%>
            <%--<div class=" border-radius5 overflow-hidden maring-a width-9_5">--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                            <%--轿车--%>
                        <%--</div>  --%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                            <%--越野车/SUV--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
         <%--MPV--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                            <%--跑车--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                           <%--客车--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                            <%--面包车--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                           <%--新能源--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                           <%--皮卡--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                          <%--货车--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                           <%--工程车--%>
                        <%--</div>--%>
                        <%--<div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comtype(this)">--%>
                           <%--平行进口车--%>
                        <%--</div>--%>
        <%----%>
            <%--</div>--%>
            <%--<a href="javascript:hide_comtype()">--%>
                <%--<div class="pt-10">--%>
                    <%--<div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">--%>
                        <%--取消--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</a>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>  --%>
<!--品牌-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="combrand_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_combrand()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5"style="height: 200px;overflow: auto">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            大众
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            本田
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            别克
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            丰田
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            福特
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            日产
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                            奇瑞
                        </div>
                        
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           宝马
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           现代
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                          奥迪
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           马自达
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           比亚迪
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           铃木
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           雪铁龙
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           吉利
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           奔驰
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           长安
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           众泰
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           学佛兰
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           金杯
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_combrand(this)">
                           其他品牌
                        </div>
                   
        
            </div>
            <a href="javascript:hide_combrand()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 
<!--车系-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="comseries_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_comseries()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                            科鲁兹
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                            凯越
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
         5系
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
         A6L
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           捷达
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                            君威
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           福尔克斯两厢
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           雅阁
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                          北斗星
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           帕萨特
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           凯美瑞
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           哈佛H6
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           五菱宏光
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comseries(this)">
                           君越
                        </div> 
        
            </div>
            <a href="javascript:hide_comseries()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!--车龄-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="comage_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_comage()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comage(this)">
         1年之内
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comage(this)">
         1-3年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comage(this)">
         3-5年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comage(this)">
         5-8年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comage(this)">
         8-10年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comage(this)">
         10年以上
                        </div>
       
            </div>
            <a href="javascript:hide_comage()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>     

<!--变速箱-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="comgearbox_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_comgearbox()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comgearbox(this)">
                           手动
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comgearbox(this)">
                          自动
                        </div>
         
            </div>
            <a href="javascript:hide_comgearbox()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>     

<!--排量-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="comdisplacement_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_comdisplacement()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         1.0之下
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         1.0-1.6
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         1.6-2.0
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         2.0-2.5
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         2.5-3.0
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         3.0-4.0
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_comdisplacement(this)">
         4.0以上
                        </div>
       
            </div>
            <a href="javascript:hide_comdisplacement()">
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

</script>
<%@include file="/webcom/cut-image.jsp" %>
<script>
function   hide_comdisplacement(){
    $("#comdisplacement_tc").hide();
 }
 function  show_comdisplacement(){
    $("#comdisplacement_tc").show();
 }
 function  set_comdisplacement(v){
   $("#comdisplacement").html($(v).html());
   hide_comdisplacement();
 }
 
 function   hide_comgearbox(){
    $("#comgearbox_tc").hide();
 }
 function  show_comgearbox(){
    $("#comgearbox_tc").show();
 }
 function  set_comgearbox(v){
   $("#comgearbox").html($(v).html());
   hide_comgearbox();
 }
 
 function   hide_comage(){
    $("#comage_tc").hide();
 }
 function  show_comage(){
    $("#comage_tc").show();
 }
 function  set_comage(v){
   $("#comage").html($(v).html());
   hide_comage();
 }
 
 function   hide_comseries(){
    $("#comseries_tc").hide();
 }
 function  show_comseries(){
    $("#comseries_tc").show();
 }
 function  set_comseries(v){
   $("#comseries").html($(v).html());
   hide_comseries();
 }
 
  function   hide_combrand(){
    $("#combrand_tc").hide();
 }
 function  show_combrand(){
    $("#combrand_tc").show();
 }
 function  set_combrand(v){
   $("#combrand").html($(v).html());
   hide_combrand();
 }
 
  function   hide_comtype(){
    $("#comtype_tc").hide();
 }
 function  show_comtype(){
    $("#comtype_tc").show();
 }
 function  set_comtype(v){
   $("#comtype").html($(v).html());
   hide_comtype();
 }
 
  function   hide_comlx(){
    $("#comlx_tc").hide();
 }
 function  show_comlx(){
    $("#comlx_tc").show();
 }
 function  set_comlx(v){
   $("#comlx").html($(v).html());
   hide_comlx();
 }
</script>
</body>
</html>