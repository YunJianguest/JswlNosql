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
        var record='';
        var experience='';
        var industry='';
        var nature='';
        var welfare='';
        var ssalary='';
        var bsalary='';
        function ajaxemploy(tag) {//加载  
            var submitData = { 
                isadmin: '${isadmin}',
                record:record,
                experience:experience,
                industry:industry,
                nature:nature,
                welfare:welfare,
                ssalary:ssalary,
                bsalary:bsalary
            };
            $.post('${ctx}/suc/jobcompay!ajaxemployweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) { 
                        var list = '';
                        if (tag) {
                            list = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var js = json.list;
                          for(var i = 0; i < js.length; i++){
                                list +='<div class="line-bottom-92 div-group-5 pr-10 overflow-hidden position-r" onclick="employdetail(\''+js[i]._id+'\')">'
                                     +'<div class="col-2"><div class="mt-25 clear pr-5">'
                                     +'<div class="img-wh20 bg-bai-5 maring-a txt-c" onclick="check(this)" style="border: solid #45c01a 2px;" id="'+js[i]._id+'">'
                                     +'<font size="1">'
                                     +'<i class="fa  zi-green display-none" style="line-height:16px;"></i>'
                                     +'</font></div></div></div>'
                                     +'<div class="col-10">'
                                     +'<div class="zi-6 weight500 line-height25">'
                                     +'<font size="2"><div class="zi-hei">'+js[i].title+'<i class="zi-hong pr-5">[推荐]</i></div>'
                                     +'</font></div>'
                                     +'<font size="2">'
                                     +'<div class="clear slweight100 line-height25">'
                                     +'<span class="zi-hui"><i class="weight500 pr-5">['+js[i].workaddress+']</i><i>联系方式:</i>'+js[i].tel+'</span>'
                                     +'</div>'
                                     +'<div class="sl weight100 line-height25">'
                                     +'<div class="pull-left">薪资：<span class="zi-green weight500">'+js[i].salary+'</span>'
                                     +'</div><div class="pull-right">'+js[i].createdate+'</div>'
                                     +'</div></font></div></div>';
              
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
                    if (id =='record') {
                        fypage = 0; 
                        show_record();
                    }
                    if (id =='salary') {
                        fypage = 0;
                        show_salary();
                    }
                    if (id =='experience') {
                        fypage = 0;
                        show_experience();
                    }
                    if (id =='industry') {
                        fypage = 0;
                        show_industry();
                    }
                    if (id =='nature') {
                        fypage = 0; 
                        show_nature();
                    }
                    if (id =='welfare') {
                        fypage = 0;
                        show_welfare();
                    }
                }
            })
        })
        function employdetail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!employDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        } 
        $(function () {
            $(".welfare .bg-hui-98").click(function () {
                 $(".welfare .bg-hui-98").removeClass('zi-hong');
                 $(".welfare .bg-hui-98").find('i').removeClass('fa-check');
                 $(".welfare .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".welfare .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 welfare=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".nature div").click(function () {
                 $(".nature .bg-hui-98").removeClass('zi-hong');
                 $(".nature .bg-hui-98").find('i').removeClass('fa-check');
                 $(".nature .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".nature .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 nature=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".industry div").click(function () {
                 $(".industry .bg-hui-98").removeClass('zi-hong');
                 $(".industry .bg-hui-98").find('i').removeClass('fa-check');
                 $(".industry .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".industry .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 industry=$(this).find('font').html(); 
            });
        })
        $(function () {
            $(".experience div").click(function () {
                 $(".experience .bg-hui-98").removeClass('zi-hong');
                 $(".experience .bg-hui-98").find('i').removeClass('fa-check');
                 $(".experience .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".experience .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 experience=$(this).find('font').html();
            });
        })
        $(function () {
            $(".record div").click(function () {
                 $(".record .bg-hui-98").removeClass('zi-hong');
                 $(".record .bg-hui-98").find('i').removeClass('fa-check');
                 $(".record .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".record .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 record=$(this).find('font').html();
            });
        })
        $(function () {
            $(".salary div").click(function () {
                 $(".salary .bg-hui-98").removeClass('zi-hong');
                 $(".salary .bg-hui-98").find('i').removeClass('fa-check');
                 $(".salary .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".salary .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 ssalary=$(this).attr('sm');
                 bsalary=$(this).attr('big');
            });
        })
    </script>
</head>
<body>
<main class="clear cmp640 lock">
    <font size="2">
        <div class="position-f cmp640 position-r" style="left: 0px; z-index:3;">
            <div class="hang40 bg-bai pt-5 line-bottom-92 weight100 yListr2 zi-hui-tq">
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="welfare">
                    福利<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="salary">
                    薪资<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="industry">
                    行业<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <%--<li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="nature">--%>
                   <%--性质<i class="pl-5 fa fa-1x fa-caret-down"></i>--%>
                <%--</li>--%>
                <li class="button_group1 hang30 line-height32 txt-c line-right  weight500" id="record">
                   学历<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c weight500" id="experience">
                   经验<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
            </div>

        </div>
    </font>
    <div class="hang40 clear"></div>
    <div id="ajaxdiv"></div>

</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp" %>



 <div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="experience_tc">

                <div style="height:300px;" class="overflow-auto bg-bai experience">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1年以下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">1-2年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">3-5年</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">6-7年</font></div>
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
                    <div class="button_group1" onclick="hide_experience()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_experience()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="salary_tc">

                <div style="height:300px;" class="overflow-auto bg-bai salary">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="1000" big="">
                        <div class="pull-left"><font size="2">1000元以下</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="1000" big="2000">
                        <div class="pull-left"><font size="2">1000-2000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="2000" big="3000">
                        <div class="pull-left"><font size="2">2000-3000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="3000" big="5000">
                        <div class="pull-left"><font size="2">3000-5000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="5000" big="8000">
                        <div class="pull-left"><font size="2">5000-8000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="8000" big="10000">
                        <div class="pull-left"><font size="2">8000-10000元</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="10000">
                        <div class="pull-left"><font size="2">10000元以上</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                   
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_salary()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_salary()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="record_tc">

                <div style="height:300px;" class="overflow-auto bg-bai record">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">高中</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">技校</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">中专</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">大专</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">本科</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">硕士</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">博士</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                 
                   
                </div>
                 <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_record()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_record()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="industry_tc">

                <div style="height:300px;" class="overflow-auto bg-bai industry">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">计算机硬件</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">通信/电信</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">财务/审计</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">信托/拍卖</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">快速消费品(食品/饮料等)</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">租赁服务</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">汽车/摩托车</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">广告/创意</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">媒体传播</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">建筑/建材</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">检测/认证</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">教育/科研/培训</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">交通/运输/物流</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">能源（电力/水利/矿产）</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">环保</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">人力资源服务</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">纺织服饰</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">互联网/电子商务</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">IT服务/系统集成 </font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">电子技术/半导体/集成电路</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">金融/银行</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">贸易/进出口</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">耐用消费品(家具/家电等)</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">办公用品及设备</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">医疗/保健/卫生/美容</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">公关/市场推广/会展</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">出版/印刷/造纸</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">家居/室内设计/装潢</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">法律/法务</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">旅游/酒店</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">航天/航空</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">原材料和加工</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">农林牧渔</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">陶瓷卫浴</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">计算机软件</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">游戏</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">仪器仪表/工业自动化</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">保险</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">批发/零售</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">服装/纺织/皮革</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">钢铁/机械/设备/重工</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">生物/制药/医疗器械</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">文体/影视/艺术</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">房地产/物业管理</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">中介/专业服务</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">咨询/顾问</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">娱乐休闲/餐饮/服务</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">化工/采掘/冶炼</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">政府/非盈利机构</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">多元化集团</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2"> 家具灯饰</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">其他行业</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                      
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_industry()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_industry()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<%--<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="nature_tc">--%>

                <%--<div style="height:300px;" class="overflow-auto bg-bai nature">--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">私营</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div> --%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">国有</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">股份制</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">外商独资/办事处</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">中贸合资/合作</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">上市公司</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">事业单位</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">政府机关</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">非盈利机构</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                    <%--<div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">--%>
                        <%--<div class="pull-left"><font size="2">个人企业</font></div>--%>
                        <%--<div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>--%>
                    <%--</div>--%>
                     <%----%>
                <%--</div>--%>
                <%--<div class="pt-15 pb-15">--%>
                    <%--<div class="button_group1" onclick="hide_nature()">--%>
                        <%--<div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认--%>
                        <%--</div>--%>
                    <%--</div> --%>
                    <%--<div class="button_group1" onclick="cal_nature()">--%>
                        <%--<div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
 <%----%>
<%--</div>--%>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="welfare_tc">

                <div style="height:300px;" class="overflow-auto bg-bai welfare">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="200" big="">
                        <div class="pull-left"><font size="2">社保</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40" ></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="200" big="500">
                        <div class="pull-left"><font size="2">公积金</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="500" big="1000">
                        <div class="pull-left"><font size="2">双休</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="1000" big="2000">
                        <div class="pull-left"><font size="2">包吃住</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">餐补</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">房补</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">交通补助</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">电话补助</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">年终奖</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="2000">
                        <div class="pull-left"><font size="2">带薪年假</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_welfare()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_welfare()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>
<script>
 function   hide_salary(){
    $("#salary_tc").hide();
    ajaxemploy(false);
 }
 function  show_salary(){
    $("#salary_tc").show();
    hide_experience();
    hide_industry();
    hide_nature();
    hide_record(); 
    hide_welfare();
 }
 function  cal_salary(){
    ssalary='';
    bsalary='';
    hide_salary();
 } 
 function   hide_welfare(){
    $("#welfare_tc").hide();
    ajaxemploy(false);
 }
 function  show_welfare(){
    $("#welfare_tc").show();
    hide_experience();
    hide_industry();
    hide_nature();
    hide_record();
    hide_salary(); 
 }
 function  cal_welfare(){
    welfare='';
    hide_welfare();
 }  
 
 function   hide_nature(){
    $("#nature_tc").hide();
    ajaxemploy(false);
 }
 function  show_nature(){
    $("#nature_tc").show();
    hide_experience();
    hide_industry(); 
    hide_record();
    hide_salary();
    hide_welfare();
 }
 function  cal_nature(){
    nature='';
    hide_nature();
 } 
 
  function   hide_industry(){
    $("#industry_tc").hide();
    ajaxemploy(false);
 }
 function  show_industry(){
    $("#industry_tc").show();
    hide_experience(); 
    hide_nature();
    hide_record();
    hide_salary();
    hide_welfare();
 } 
 function  cal_industry(){
    industry='';
    hide_industry();
 }
 function   hide_experience(){
    $("#experience_tc").hide();
    ajaxemploy(false);
 }
 function  show_experience(){
    $("#experience_tc").show(); 
    hide_industry();
    hide_nature();
    hide_record();
    hide_salary();
    hide_welfare();
 }
 function  cal_experience(){
    experience='';
    hide_experience();
 }
 
 function   hide_record(){
    $("#record_tc").hide();
    ajaxemploy(false);
 }
 function  show_record(){
    $("#record_tc").show();
    hide_experience();
    hide_industry();
    hide_nature(); 
    hide_salary();
    hide_welfare();
 } 
 function  cal_record(){
    record='';
    hide_record();
 }
</script>
<script type="text/javascript">
 ajaxemploy(false);
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            ajaxemploy(true);
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