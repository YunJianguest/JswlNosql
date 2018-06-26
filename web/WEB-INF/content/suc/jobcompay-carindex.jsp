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
        var brand='';
        var series='';
        var age='';
        var gearbox='';
        var displacement='';
        var sprice='';
        var bprice='';
        function ajaxcar(tag) {//加载  
            var submitData = { 
                isadmin: '${isadmin}',
                brand:$.trim(brand),
                series:series,
                age:age,
                gearbox:gearbox,
                displacement:displacement,
                sprice:sprice,
                bprice:bprice
            };
            $.post('${ctx}/suc/jobcompay!ajaxcarweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
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
                                     +'<span class="zi-hui">'+js[i].brand+'/'+js[i].age+'/'+js[i].displacement+'/'+js[i].gearbox+'</span></div>'
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
                    if (id =='displacement') {
                        fypage = 0; 
                        show_displacement();
                    }
                    if (id =='gearbox') {
                        fypage = 0;
                        show_gearbox();
                    }
                    if (id =='age') {
                        fypage = 0;
                        show_age();
                    }
                    if (id =='series') {
                        fypage = 0;
                        show_series();
                    }
                    if (id =='brand') {
                        fypage = 0; 
                        show_brand();
                    }
                    if (id =='price') {
                        fypage = 0;
                        show_price();
                    }
                }
            })
        })
        function detail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!carDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        }
        
        $(function () {
            $(".brand .bg-hui-98").click(function () {
                 $(".brand .bg-hui-98").removeClass('zi-hong');
                 $(".brand .bg-hui-98").find('i').removeClass('fa-check');
                 $(".brand .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".brand .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 brand=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".displacement div").click(function () {
                 $(".displacement .bg-hui-98").removeClass('zi-hong');
                 $(".displacement .bg-hui-98").find('i').removeClass('fa-check');
                 $(".displacement .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".displacement .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 displacement=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".gearbox div").click(function () {
                 $(".gearbox .bg-hui-98").removeClass('zi-hong');
                 $(".gearbox .bg-hui-98").find('i').removeClass('fa-check');
                 $(".gearbox .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".gearbox .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 gearbox=$(this).find('font').html(); 
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
            $(".series div").click(function () {
                 $(".series .bg-hui-98").removeClass('zi-hong');
                 $(".series .bg-hui-98").find('i').removeClass('fa-check');
                 $(".series .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".series .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 series=$(this).find('font').html();
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
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="brand">
                    品牌<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
               <!-- 
               <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="series">
                    车系<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                --> 
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="age">
                    车龄<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="gearbox">
                   变速箱<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right  weight500" id="displacement">
                  排量<i class="pl-5 fa fa-1x fa-caret-down"></i>
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



 <div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="brand_tc">

                <div style="height:300px;" class="overflow-auto bg-bai brand">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">大众</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">本田</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">别克</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">丰田</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">福特</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">日产</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">奇瑞</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">宝马</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">现代</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">奥迪</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">马自达</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">比亚迪</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">铃木</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">雪铁龙</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">吉利</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                      <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">奔驰</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">长安</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">众泰</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">学佛兰</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">金杯</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">其他品牌</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                   
                </div>
                
                 <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_brand()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_brand()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="age_tc">

                <div style="height:300px;" class="overflow-auto bg-bai age">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1年之内</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1-3年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">3-5年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">5-8年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">8-10年</font></div>
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

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="gearbox_tc">

                <div style="height:300px;" class="overflow-auto bg-bai gearbox">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">自动</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">手动</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                 
                   
                </div>
                 <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_gearbox()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_gearbox()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="displacement_tc">

                <div style="height:300px;" class="overflow-auto bg-bai displacement">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1.0之下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1.0-1.6</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1.6-2.0</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">2.0-2.5</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">2.5-3.0</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">3.0-4.0</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">4.0以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                     
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_displacement()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_displacement()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="series_tc">

                <div style="height:300px;" class="overflow-auto bg-bai series">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">科鲁兹</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">凯越</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">5系</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">A6L</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">捷达</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">君威</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">福尔克斯两厢</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">雅阁</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">北斗星</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">帕萨特</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">凯美瑞</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">哈佛H6</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">五菱宏光</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">君越</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                   
                   
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_series()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_series()">
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
    ajaxcar(false);
 }
 function  show_price(){
    $("#price_tc").show();
    hide_age();
    hide_brand();
    hide_displacement();
    hide_gearbox(); 
    hide_series();
 }
 function  cal_price(){
    sprice='';
    bprice='';
    hide_price();
 } 
 function   hide_series(){
    $("#series_tc").hide();
    ajaxcar(false);
 }
 function  show_series(){
    $("#series_tc").show();
    hide_age();
    hide_brand();
    hide_displacement();
    hide_gearbox();
    hide_price(); 
 }
 function  cal_series(){
    series='';
    hide_series();
 }  
 
 function   hide_displacement(){
    $("#displacement_tc").hide();
    ajaxcar(false);
 }
 function  show_displacement(){
    $("#displacement_tc").show();
    hide_age();
    hide_brand(); 
    hide_gearbox();
    hide_price();
    hide_series();
 }
 function  cal_displacement(){
    displacement='';
    hide_displacement();
 } 
 
  function   hide_gearbox(){
    $("#gearbox_tc").hide();
    ajaxcar(false);
 }
 function  show_gearbox(){
    $("#gearbox_tc").show();
    hide_age();
    hide_brand();
    hide_displacement(); 
    hide_price();
    hide_series();
 } 
 function  cal_gearbox(){
    gearbox='';
    hide_gearbox();
 }
 function   hide_age(){
    $("#age_tc").hide();
    ajaxcar(false);
 }
 function  show_age(){
    $("#age_tc").show(); 
    hide_brand();
    hide_displacement();
    hide_gearbox();
    hide_price();
    hide_series();
 }
 function  cal_age(){
    age='';
    hide_age();
 }
 
 function   hide_brand(){
    $("#brand_tc").hide();
    ajaxcar(false);
 }
 function  show_brand(){
    $("#brand_tc").show();
    hide_age(); 
    hide_displacement();
    hide_gearbox();
    hide_price();
    hide_series();
 } 
 function  cal_brand(){
    brand='';
    hide_brand();
 }
</script>
<script type="text/javascript">
 ajaxcar(false);
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            ajaxcar(true);
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