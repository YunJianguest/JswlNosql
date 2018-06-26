<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
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
    <title></title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${contextPath}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="${contextPath}/app/js/jquery.Spinner.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script>

    <style>
        .bk {
            width: 90px;
            height: 65px;
        }

        .line-height32 {
            line-height: 32px;
        }
    </style>
    <script>
        var fypage=0;
        var id = 0;
        var floor='';
        var risingsun='';
        var age='';
        var type='';
        var decorate='';
        var standard='';
        var big='';
        var sprice='';
        var bprice='';
        function ajaxsup(tag) {//加载
            var submitData = { 
                isadmin: '${isadmin}',
                floor:floor,
                risingsun:risingsun,
                age:age,
                type:type,
                decorate:decorate,
                standard:standard,
                big:big,
                sprice:sprice,
                bprice:bprice
            };
            $.post('${ctx}/suc/jobcompay!ajaxsupplyweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var list = '';
                        if (tag) {
                            list = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var js = json.list;
                            for (var i = 0; i < js.length; i++) { 
                                list +='<div class="line-bottom-92 div-group-5 pl-10 pr-10 overflow-hidden position-r hang80" onclick="detail(\''+js[i]._id+'\')">'
                                     +'<div class="position-r"><div class=" position-a" style="top: 2px;">'
                                     +'<div class="img-bj bk border-radius3" style="background-image: url(${filehttp}/'+js[i].picurl+');"></div>'
                                     +'</div>'
                                     +'<div style="padding-left:100px;"><div class="zi-6 weight500 hang25 line-height25 sl zi-hei">'
                                     +'<font size="2">'
                                     +'<div class="sl"><i class="zi-hong pr-5">[个人]</i>'+js[i].title+'</div>'
                                     +'</font></div>'
                                     +'<font size="2">'
                                     +'<div class="clear sl weight100 hang25 line-height25">'
                                     +'<span class="zi-hui">'+js[i].big+'/'+js[i].decorate+'/'+js[i].issecond+'/'+js[i].standard+'</span></div>'
                                     +'<div class="weight100 hang25 line-height25">'
                                     +'<div class="pull-left"><i class="zi-hong">'+js[i].price+'元</i></div>'
                                     +'<div class="pull-right">'+js[i].createdate+'</div>'
                                     +'</div></font></div></div></div>';
                                     
                            }
                            fypage++;
                        } else {
                            if (list.indexOf('暂无信息，请查看其它内容！') > 0) {

                            } else {
                                list += '<div class="clear txt-c zi-hui size14"><div class="pt-10">'
                                + '<i class="fa fa-tags fa-6x"></i></div><div class="pt-20 pb-20">'
                                + '暂无信息，请查看其它内容！ </div></div>';
                            }
                        }
                        $('#ajaxdiv').html(list);

                    }, "json");
        }
     
    </script>
    <script type="text/javascript">
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("zi-hong").siblings().removeClass("zi-hong");
                $(".yListr2 i").removeClass("fa-caret-up");
                if ($(this).hasClass('zi-hong')) {
                    $(this).find('i').addClass("fa-caret-up");
                    id = $(this).attr("id");
                    if (id =='decorate') {
                        fypage = 0; 
                        show_decorate();
                    }
                    if (id =='big') {
                        fypage = 0;
                        show_big();
                    }
                    if (id =='age') {
                        fypage = 0;
                        show_age();
                    }
                    if (id =='standard') {
                        fypage = 0;
                        show_standard();
                    }
                    if (id =='type') {
                        fypage = 0;
                        show_type();
                    }
                     if (id =='risingsun') {
                        fypage = 0;
                        show_risingsun();
                    }
                    if (id =='floor') {
                        fypage = 0;
                        show_floor();
                    }
                    if (id =='price') {
                        fypage = 0;
                        show_price();
                    }
                   
                }
            })
        })
        function detail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!supplyDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        }
        
        $(function () {
            $(".floor div").click(function () {
                 $(".floor .bg-hui-98").removeClass('zi-hong');
                 $(".floor .bg-hui-98").find('i').removeClass('fa-check');
                 $(".floor .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".floor .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 floor=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".risingsun div").click(function () {
                 $(".risingsun .bg-hui-98").removeClass('zi-hong');
                 $(".risingsun .bg-hui-98").find('i').removeClass('fa-check');
                 $(".risingsun .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".risingsun .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 risingsun=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".type div").click(function () {
                 $(".type .bg-hui-98").removeClass('zi-hong');
                 $(".type .bg-hui-98").find('i').removeClass('fa-check');
                 $(".type .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".type .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 type=$(this).find('font').html();
            });
        })
        $(function () {
            $(".age div").click(function () {
                 $(".age .bg-hui-98").removeClass('zi-hong');
                 $(".age .bg-hui-98").find('i').removeClass('fa-check');
                 $(".age .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".age .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 age=$(this).find('font').html();
            });
        })
        $(function () {
            $(".standard div").click(function () {
                 $(".standard .bg-hui-98").removeClass('zi-hong');
                 $(".standard .bg-hui-98").find('i').removeClass('fa-check');
                 $(".standard .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".standard .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 age=$(this).find('font').html();
            });
        })
         $(function () {
            $(".big div").click(function () {
                 $(".big .bg-hui-98").removeClass('zi-hong');
                 $(".big .bg-hui-98").find('i').removeClass('fa-check');
                 $(".big .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".big .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 big=$(this).find('font').html();
            });
        })
         $(function () {
            $(".decorate div").click(function () {
                 $(".decorate .bg-hui-98").removeClass('zi-hong');
                 $(".decorate .bg-hui-98").find('i').removeClass('fa-check');
                 $(".decorate .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".decorate .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 decorate=$(this).find('font').html();
            });
        })
         $(function () {
            $(".price div").click(function () {
                 $(".price .bg-hui-98").removeClass('zi-hong');
                 $(".price .bg-hui-98").find('i').removeClass('fa-check');
                 $(".price .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".price .bg-hui-98").find('i').addClass('fa-angle-right');
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 sprice=$(this).attr('sm');
                 bprice=$(this).attr('big');
            });
        })
        
    </script>
</head>
<body>
<main class="clear cmp640 lock">
    <font size="2">
        <div class="position-f cmp640 position-r" style="left: 0px; z-index:3;">
            <div class="hang40 bg-bai pt-5 line-bottom-92 weight100 yListr2 zi-hui-tq">
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="decorate">
                    装修<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="big">
                    面积<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <!-- 
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="age">
                    房龄<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                 -->
                
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="standard">
                   规格<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <!-- 
                 <li class="button_group1 hang30 line-height32 txt-c line-right  weight500" id="type">
                   类型<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right  weight500" id="risingsun">
                   朝向<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                 -->
               
                <li class="button_group1 hang30 line-height32 txt-c line-right  weight500" id="floor">
                   楼层<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c weight500" id="price">
                   价格<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
             
            </div>

        </div>
    </font>
    <div class="hang40 clear"></div>
    <div id="ajaxdiv"></div>

</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp" %>



 <div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="floor_tc">

                <div style="height:300px;" class="overflow-auto bg-bai floor">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">底下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1层</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">6层以下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">6-12层</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">12层以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                   
                </div>
                
                 <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_floor()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_floor()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="age_tc">

                <div style="height:300px;" class="overflow-auto bg-bai age">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">2年以下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">2-5年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">5-10年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">10年以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_age()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_age()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="risingsun_tc">

                <div style="height:300px;" class="overflow-auto bg-bai risingsun">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">东</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">南</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">西</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">北</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">东南</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">西南</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">东北</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">西北</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                 
                   
                </div>
                 <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_risingsun()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_risingsun()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="type_tc">

                <div style="height:300px;" class="overflow-auto bg-bai type">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">普通住房</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">公寓</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">别墅</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">平房</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">新里洋房</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">老公房</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">四合院</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">排屋</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">其他</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                     
                     
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_type()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_type()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="standard_tc">

                <div style="height:300px;" class="overflow-auto bg-bai standard">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">一室</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">二室</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">三室</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">四室</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">四室以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    
                   
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_standard()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_standard()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="big_tc">

                <div style="height:300px;" class="overflow-auto bg-bai big">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">50㎡以下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">50-70㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">70-90㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">90-110㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">110-130㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">130-150㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">150-180㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">180-200㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">200-250㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">200-300㎡</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">300㎡以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                     
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_big()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_big()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="decorate_tc">

                <div style="height:300px;" class="overflow-auto bg-bai decorate">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">毛坯</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">简单装修</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">中等装修</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">精装修</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">豪华装修</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_decorate()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_decorate()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="price_tc">

                <div style="height:300px;" class="overflow-auto bg-bai price">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="200" big="">
                        <div class="pull-left"><font size="2">200元以下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40" ></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="200" big="500">
                        <div class="pull-left"><font size="2">200-500元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="500" big="1000">
                        <div class="pull-left"><font size="2">500-1000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="1000" big="2000">
                        <div class="pull-left"><font size="2">1000-2000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">2000元以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_price()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_price()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>
<script>
 function   hide_price(){
    $("#price_tc").hide();
    ajaxsup(false);
 }
 function  show_price(){
    $("#price_tc").show();
    hide_age();
    hide_big();
    hide_decorate();
    hide_floor(); 
    hide_risingsun();
    hide_standard();
    hide_type();
 }
 function  cal_price(){
    sprice='';
    bprice='';
    hide_price();
 }  
 
 function   hide_decorate(){
    $("#decorate_tc").hide();
    ajaxsup(false);
 }
 function  show_decorate(){
    $("#decorate_tc").show();
    hide_age();
    hide_big(); 
    hide_floor();
    hide_price();
    hide_risingsun();
    hide_standard();
    hide_type();
 }
 function  cal_decorate(){
    decorate='';
    hide_decorate();
 } 
 
  function   hide_big(){
    $("#big_tc").hide();
    ajaxsup(false);
 }
 function  show_big(){
    $("#big_tc").show();
    hide_age(); 
    hide_decorate();
    hide_floor();
    hide_price();
    hide_risingsun();
    hide_standard();
    hide_type();
 } 
 function  cal_big(){
    big='';
    hide_big();
 }
 function   hide_standard(){
    $("#standard_tc").hide();
    ajaxsup(false);
 }
 function  show_standard(){
    $("#standard_tc").show();
    hide_age();
    hide_big();
    hide_decorate();
    hide_floor();
    hide_price();
    hide_risingsun(); 
    hide_type();
 }
 function  cal_standard(){
    standard='';
    hide_standard();
 }
 
 function   hide_type(){
    $("#type_tc").hide();
    ajaxsup(false);
 }
 function  show_type(){
    $("#type_tc").show();
    hide_age();
    hide_big();
    hide_decorate();
    hide_floor();
    hide_price();
    hide_risingsun();
    hide_standard(); 
 } 
 function  cal_type(){
    type='';
    hide_type();
 }
 
 function   hide_risingsun(){
    $("#risingsun_tc").hide();
    ajaxsup(false);
 }
 function  show_risingsun(){
    $("#risingsun_tc").show();
    hide_age();
    hide_big();
    hide_decorate();
    hide_floor();
    hide_price(); 
    hide_standard();
    hide_type();
 } 
 function  cal_risingsun(){
    risingsun='';
    hide_risingsun();
 }
 
 function   hide_age(){
    $("#age_tc").hide();
    ajaxsup(false);
 }
 function  show_age(){
    $("#age_tc").show(); 
    hide_big();
    hide_decorate();
    hide_floor();
    hide_price();
    hide_risingsun();
    hide_standard();
    hide_type();
 } 
 function  cal_age(){
    age='';
    hide_age();
 }
  function   hide_floor(){
    $("#floor_tc").hide();
    ajaxsup(false);
 }
 function   show_floor(){
    $("#floor_tc").show();
    hide_age();
    hide_big();
    hide_decorate(); 
    hide_price();
    hide_risingsun();
    hide_standard();
    hide_type();
 } 
 function   cal_floor(){
    floor='';
    hide_floor();
 }
</script>
<script type="text/javascript">
    ajaxsup(false);
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            ajaxsup(true);
        }
    });
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
</body>
</html>