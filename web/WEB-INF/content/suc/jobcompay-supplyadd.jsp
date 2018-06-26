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
           var type=$.trim($('#type').html()); 
           var lx=$.trim($('#lx').html()); 
           var issecond=$.trim($('#issecond').html()); 
           var decorate=$.trim($('#decorate').html()); 
           var big=$.trim($('#big').html()); 
           var standard=$.trim($('#standard').html()); 
           var risingsun=$.trim($('#risingsun').html()); 
           var age=$.trim($('#age').html());  
           var floor=$.trim($('#floor').html()); 
           var equity=$.trim($('#equity').html()); 
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
	           alert("请输入数字");
	           $('#comprice').focus();
	           return;
           }
           if($.trim(equity.replace("产权",""))==""){ 
	           alert("请选择产权");
	           $('#equity').focus(); 
	          return;
	        }
	       if($.trim(floor.replace("楼层",""))==""){ 
	           alert("请选择楼层");
	           $('#floor').focus(); 
	          return;
	        }
           if($.trim(age.replace("房龄",""))==""){ 
	           alert("请选择房龄");
	           $('#age').focus(); 
	          return;
	        }
	       if($.trim(risingsun.replace("朝向",""))==""){ 
	           alert("请选择朝向");
	           $('#risingsun').focus(); 
	          return;
	        }
	       if($.trim(type.replace("类型",""))==""){ 
	           alert("请选择类型");
	           $('#type').focus(); 
	          return;
	        }
	       if($.trim(lx.replace("状态",""))==""){ 
	           alert("请选择状态");
	           $('#lx').focus(); 
	          return;
	        }
	       if($.trim(standard.replace("规格",""))==""){ 
	           alert("请选择规格");
	           $('#standard').focus(); 
	          return;
	        }
	       if($.trim(big.replace("面积",""))==""){ 
	           alert("请选择面积");
	           $('#big').focus(); 
	          return;
	        }
	       if($.trim(decorate.replace("装修",""))==""){ 
	           alert("请选择装修");
	           $('#decorate').focus(); 
	          return;
	        }
	       if($.trim(issecond.replace("是否出租",""))==""){ 
	           alert("请选择是否出租");
	           $('#issecond').focus(); 
	          return;
	        } 
	        if($('#picurl')==""){ 
	           alert("请上传一张相关图片！"); 
	          return;
	        } 
	        if($.trim(lx)=="供"){
	          lx=0;
	        }else{
	          lx=1;
	        }
              var submitData = {
                title: comtitle,
                summary: comsummary, 
                tel: comtel,
                name:comname,
                type:type,
                price:comprice,
                equity:equity,
                lx:lx,
                decorate:decorate,
                big:big,
                standard:standard,
                risingsun:risingsun,
                age:age,
                floor:floor,
                issecond:issecond,
                picurl:$('#picurl').val()
            };
            $.post('${ctx}/suc/jobcompay!ajaxsupplyadd.action?custid=${custid}&lscode=${lscode}', submitData,
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
    
      <input id="picurl" type="hidden"/>
       <div class="size14 line-bottom  weight500 pt-10 pb-10" style="padding-left: 2px;">照片资料</div>
        <div class="line-bottom  line-right  line-left1 div-group-5 pt-10 pb-10 overflow-hidden">
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
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500" type="text" name=""
                   value="标题" onfocus="if(this.value=='标题'){this.value=''};this.style.color='#666666';"
                   id="comtitle" onblur="if(this.value==''||this.value=='标题'){this.value='标题';this.style.color='#aaa';}">
        </div>  
        <div class="line-bottom  line-right  line-left1 overflow-hidden zi-hui">
            <form action="">
                <textarea id="comsummary" onfocus="if(this.value=='描述10-300个字'){this.value=''};this.style.color='#666666';"
                          onblur="if(this.value==''||this.value=='描述10-300个字'){this.value='描述10-300个字';this.style.color='#aaa';}"
                          rows="5" name="message" class="size14 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">描述10-300个字</textarea>
                <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                       class="zi-hui size12 pl-2 pb-10 pull-right">
            </form>
        </div>
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="lx" onclick="show_lx()">供 / 求</div>
        </div>
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="issecond" onclick="show_issecond()">出售 / 出租 / 购买 / 租住</div>
        </div> 
        
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="decorate" onclick="show_decorate()">是否装修</div>
        </div>
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="big" onclick="show_big()">面积</div>
        </div>
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="standard" onclick="show_standard()">户型</div>
        </div>
        <%--<div class="line-bottom  line-right  pt-10 line-left1 hang50">--%>
            <%--<div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"--%>
                   <%--id="type" onclick="show_type()">类型</div>--%>
        <%--</div>--%>
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="risingsun" onclick="show_risingsun()">朝向</div>
        </div>   
         <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="age" onclick="show_age()">房龄</div>
        </div>   
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="floor" onclick="show_floor()">楼层</div>
        </div>   
         <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <div class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500"
                   id="equity" onclick="show_equity()">产权</div>
        </div>   
        
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500" type="text" name=""
                   id="comprice" value="期望价格" onfocus="if(this.value=='期望价格'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='期望价格'){this.value='期望价格';this.style.color='#aaa';}">
        </div> 
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500" type="text" name=""
                   id="comname" value="联系人" onfocus="if(this.value=='联系人'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='联系人'){this.value='联系人';this.style.color='#aaa';}">
        </div>
        <div class="line-bottom  line-right  pt-10 line-left1 hang50">
            <input class="width-10 pl-10 pr-10 size14 zi-hui  hang30 line-height30 weight500" type="text" name=""
                   value="联系电话" onfocus="if(this.value=='联系电话'){this.value=''};this.style.color='#666666';"
                   id="comtel" onblur="if(this.value==''||this.value=='联系电话'){this.value='联系电话';this.style.color='#aaa';}">
        </div>
  
    </div>

    <div class="div-group-10 pt-20 pb-30" onclick="subcom()">
        <div class=" btn-green zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius5 lock">确认发布</div>
    </div>
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp"%>
 
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


<!--装修状态-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="decorate_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_decorate()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_decorate(this)">
                          毛坯
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_decorate(this)">
                          简单装修
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_decorate(this)">
                          中等装修
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_decorate(this)">
                         精装修
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_decorate(this)">
                         豪华装修
                        </div>
         
            </div>
            <a href="javascript:hide_decorate()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

<!--朝向-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="risingsun_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_risingsun()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                          东
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                          南
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                          西
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                         北
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                         东南
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                         东北
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                         西南
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_risingsun(this)">
                         西北
                        </div>
       
         
            </div>
            <a href="javascript:hide_risingsun()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

<!--房龄-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="age_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_age()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_age(this)">
        2年以下
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_age(this)">
        2-5年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_age(this)">
        5-10年
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_age(this)">
        10年以上
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

<!--状态-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="lx_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_lx()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_lx(this)">
        供
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_lx(this)">
        求
                        </div>
       
         
            </div>
            <a href="javascript:hide_lx()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

<!--状态-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="issecond_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_issecond()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_issecond(this)">
        出租
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_issecond(this)">
        出售
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_issecond(this)">
        购买
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_issecond(this)">
        求租
                        </div>
       
         
            </div>
            <a href="javascript:hide_issecond()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 


<!--楼层-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="floor_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_floor()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_floor(this)">
                       底下
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_floor(this)">
        1层
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_floor(this)">
        6层以下
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_floor(this)">
        6-12层
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_floor(this)">
        12层以上
                        </div>
        
         
            </div>
            <a href="javascript:hide_floor()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 

<!--产权-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="equity_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_equity()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_equity(this)">
                        商品房
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_equity(this)">
                        商住两用
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_equity(this)">
                        经济适用房
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_equity(this)">
                        使用权
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_equity(this)">
                        公房
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_equity(this)">
                        其他
                        </div>
        
         
            </div>
            <a href="javascript:hide_equity()">
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
                        普通住房
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        公寓
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                       别墅
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        平房
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        新里洋房
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        老公房
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        四合院
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        排屋
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_type(this)">
                        其他
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
 
<!--厅室-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="standard_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_standard()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_standard(this)">
                        一室
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_standard(this)">
                        二室
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_standard(this)">
                       三室
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_standard(this)">
                       四室
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_standard(this)">
                        四室以上
                        </div>
       
        
         
            </div>
            <a href="javascript:hide_standard()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
<!--面积-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="big_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_big()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        50㎡以下
                        </div>  
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        50-70㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        70-90㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        90-110㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        110-130㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        130-150㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        150-180㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        180-200㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        200-250㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        200-300㎡
                        </div>
                        <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq" onclick="set_big(this)">
        300㎡以上
                        </div>
       
        
         
            </div>
            <a href="javascript:hide_big()">
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
 
 function   hide_big(){
    $("#big_tc").hide();
 }
 function  show_big(){
    $("#big_tc").show();
 }
 function  set_big(v){
   $("#big").html($(v).html());
   hide_big();
 }
 
 function   hide_standard(){
    $("#standard_tc").hide();
 }
 function  show_standard(){
    $("#standard_tc").show();
 }
 function  set_standard(v){
   $("#standard").html($(v).html());
   hide_standard();
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
 
   function   hide_risingsun(){
    $("#risingsun_tc").hide();
 }
 function  show_risingsun(){
    $("#risingsun_tc").show();
 }
 function  set_risingsun(v){
   $("#risingsun").html($(v).html());
   hide_risingsun();
 }
 
   function   hide_age(){
    $("#age_tc").hide();
 }
 function  show_age(){
    $("#age_tc").show();
 }
 function  set_age(v){
   $("#age").html($(v).html());
   hide_age();
 }
 
   function   hide_floor(){
    $("#floor_tc").hide();
 }
 function  show_floor(){
    $("#floor_tc").show();
 }
 function  set_floor(v){
   $("#floor").html($(v).html());
   hide_floor();
 }
 
  function   hide_equity(){
    $("#equity_tc").hide();
 }
 function  show_equity(){
    $("#equity_tc").show();
 }
 function  set_equity(v){
   $("#equity").html($(v).html());
   hide_equity();
 }
 
   function   hide_lx(){
    $("#lx_tc").hide();
 }
 function  show_lx(){
    $("#lx_tc").show();
 }
 function  set_lx(v){
   $("#lx").html($(v).html());
   hide_lx();
 }
 
  function   hide_issecond(){
    $("#issecond_tc").hide();
 }
 function  show_issecond(){
    $("#issecond_tc").show();
 }
 function  set_issecond(v){
   $("#issecond").html($(v).html());
   hide_issecond();
 }
 
  
  function   hide_decorate(){
    $("#decorate_tc").hide();
 }
 function  show_decorate(){
    $("#decorate_tc").show();
 }
 function  set_decorate(v){
   $("#decorate").html($(v).html());
   hide_decorate();
 }
 

</script>
</body>
</html>