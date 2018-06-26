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
        var sex=''; 
        var ssalary='';
        var bsalary='';
        var sage='';
        var bage='';
        function ajaxseek(tag) {//加载  
            var submitData = { 
                isadmin: '${isadmin}',
                record:record,
                experience:experience,
                sex:sex, 
                ssalary:ssalary,
                bsalary:bsalary,
                sage:sage,
                bage:bage
            };
            $.post('${ctx}/suc/jobcompay!ajaxseekersweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) { 
                        var list = '';
                        if (tag) {
                            list = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var js = json.list;
                          for(var i = 0; i < js.length; i++){
                               list +='<div class="line-bottom-92 div-group-5 pt-10 pl-10 pr-10 overflow-hidden position-r" onclick="seekdetail(\''+js[i]._id+'\')">'
                                    +'<div class="zi-6 weight500 hang25 line-height25">'
                                    +'<font size="2">'
                                    +'<div class="sl"><i class="zi-hong pr-5">[全职]</i>'+js[i].name+'</div>'
                                    +'</font></div>'
                                    +'<font size="2"><div class="clear sl weight100 hang25 line-height25">'
                                    +'<span class="zi-hui"><i>工作经验：</i>'+js[i].experience+'</span></div>'
                                    +'<div class="sl weight100 hang25 line-height25">'
                                    +'<div class="pull-left">渴望薪资：<span class="zi-green weight500">'+js[i].salary+'</span>'
                                    +'</div><div class="pull-right">'+js[i].createdate+'</div>'
                                    +'</div></font></div>';
                    
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
                    if (id =='sex') {
                        fypage = 0;
                        show_sex();
                    }
                    if (id =='age') {
                        fypage = 0; 
                        show_age();
                    } 
                }
            });
        });
        function seekdetail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!seekersDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        } 
         
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
                 sage=$(this).attr('sm');
                 bage=$(this).attr('big');
            });
        })
        $(function () {
            $(".sex div").click(function () {
                 $(".sex .bg-hui-98").removeClass('zi-hong');
                 $(".sex .bg-hui-98").find('i').removeClass('fa-check');
                 $(".sex .bg-hui-98").addClass('zi-hui-tq'); 
                 $(".sex .bg-hui-98").find('i').addClass('fa-angle-right'); 
                 $(this).find('i').removeClass('fa-angle-right');
                 $(this).removeClass('zi-hui-tq');
                 $(this).addClass('zi-hong'); 
                 $(this).find('i').addClass('fa-check');
                 sex=$(this).find('font').html(); 
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
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="salary">
                    薪资<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="sex">
                    性别<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500" id="age">
                   年龄<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
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

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="sex_tc">

                <div style="height:300px;" class="overflow-auto bg-bai sex">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">男</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10">
                        <div class="pull-left"><font size="2">女</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    
                      
                </div>
                <div class="pt-15 pb-15">
                    <div class="button_group1" onclick="hide_sex()">
                        <div class="hang30 line-height30 zi-bai btn-cheng txt-c width-7 maring-a border-radius5" >确认
                        </div>
                    </div> 
                    <div class="button_group1" onclick="cal_sex()">
                        <div class="hang30 line-height30 zi-bai bg-hei-5 txt-c width-7 maring-a border-radius5">返回</div>
                    </div>
                </div>
 
</div>

<div class="position-a bg-hei-5 width-10 overflow-hidden display-none" style="top:40px;z-index:2;" id="age_tc">

                <div style="height:300px;" class="overflow-auto bg-bai age">
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="16" big="20">
                        <div class="pull-left"><font size="2">16-20岁</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div> 
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="21" big="30">
                        <div class="pull-left"><font size="2">21-30岁</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="31" big="40">
                        <div class="pull-left"><font size="2">31-40岁</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="41" big="50">
                        <div class="pull-left"><font size="2">41-50岁</font></div>
                        <div class="pull-right"><i class="fa fa-angle-right fa-1dx line-height40"></i></div>
                    </div>
                    <div class="bg-hui-98 hang40 line-height40 zi-hui-tq line-bottom pl-10 pr-10" sm="" big="50">
                        <div class="pull-left"><font size="2">50岁以上</font></div>
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
 
<script>
 function   hide_salary(){
    $("#salary_tc").hide();
    ajaxseek(false);
 }
 function  show_salary(){
    $("#salary_tc").show();
    hide_age();
    hide_experience();  
    hide_sex();
    hide_record()
 }
 function  cal_salary(){
    ssalary='';
    bsalary='';
    hide_salary();
 } 
  
 function   hide_sex(){
    $("#sex_tc").hide();
    ajaxseek(false);
 }
 function  show_sex(){
    $("#sex_tc").show();
    hide_age();
    hide_experience(); 
    hide_salary(); 
    hide_record()
 }
 function  cal_sex(){
    sex='';
    hide_sex();
 } 
 
  function   hide_age(){
    $("#age_tc").hide();
    ajaxseek(false);
 }
 function  show_age(){
    $("#age_tc").show(); 
    hide_experience(); 
    hide_salary();
    hide_sex();
    hide_record()
 } 
 function  cal_age(){
    sage='';
    bage='';
    hide_age();
 }
 function   hide_experience(){
    $("#experience_tc").hide();
    ajaxseek(false);
 }
 function  show_experience(){
    $("#experience_tc").show();
    hide_age(); 
    hide_salary();
    hide_sex();
    hide_record()
 }
 function  cal_experience(){
    experience='';
    hide_experience();
 }
 
 function   hide_record(){
    $("#record_tc").hide();
    ajaxseek(false);
 }
 function  show_record(){
    $("#record_tc").show();
    hide_age();
    hide_experience(); 
    hide_salary();
    hide_sex(); 
 } 
 function  cal_record(){
    record='';
    hide_record();
 }
</script>
<script type="text/javascript">
 ajaxseek(false);
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            ajaxseek(true);
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