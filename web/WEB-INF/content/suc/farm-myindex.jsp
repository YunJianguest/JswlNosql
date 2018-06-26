<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
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
    <title>个人动态</title>
      <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <script src="${contextPath}/mvccol/js/fomatdate1.js" type="text/javascript"></script>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>  
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <style>
        .btn-lan-tq {
            background-color: #00a5e0;
        }

        .btn-lan-tq:hover, .btn-lan-tq:focus {
            background-color: #0092c7;
        }

        .padding-lr3 {
            padding-left: 3px;
            padding-right: 3px;;
        }

        .yListr3 .zhiding .div3 {
            color: orange;
        }
        .lin-aaa-4{
            border-left:4px solid #45c01a;
        }
        .top-9-left-14{
            top: 0px;left: -14px;
        }
        .top-4-left-8{
            top: 4px;left: -8px;
        }
        .zi-orange{
            color: orange;
        }
        .border-radius100{
            border-radius: 100px;
        }
        .line-1-orange{
            border: solid 1px orange;
        }
        .line-green {
            border: solid 1px #45c01a;
        }
    </style> 
    <script> 
       var issend = true;
       var fypage = 0;
       var state=0;
       
         $(function () {
            $(".yListr3 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
                if($(this).attr('id')==1){
                   fypage=0;
                   state=1;
                   ajaxfoot(false);
                }else if($(this).attr('id')==2){
                   fypage=0;
                   state=2;
                   ajaxyd(false);
                }
            })
        })
       
       function  ajaxfoot(fag){
           $('#ajaxyd').hide(); 
           var submitData = { 
               fid:'${id}'
            };
            issend = false; 
            $.post('${ctx}/suc/farm!ajaxfoot.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf;
                if (fag) {
                    xszf = $('#ajaxfoot').html();
                } else {
                    xszf = '';
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<div class=" position-r lin-aaa-4">'
                             +'<div class="position-a top-9-left-14">'
                             +'<div class="img-wh25 border-radius50 txt-c zi-bai bg-green"><i class="fa fa-clock-o line-height25"></i></div>'
                             +'</div>'
                             +'<div class="pt-25 pl-15 pb-10">'
                             +'<div class="line-green div-group-5 pb-10 pl-10 pr-10 border-radius5 position-r">'
                             +'<div class="position-a zi-green top-4-left-8">'
                             +'<i class="fa fa-caret-left fa-1dx"></i>'
                             +'</div>'
                             +'<font size="2">'
                             +'<div class="zi-6">'+Date.prototype.format(v[i].createdate)+'</i>'
                             +'</div>'
                             +'<div class="pt-5 line-height20 zi-hui-wx"><i class="zi-lan-tq pr-5">'+v[i].nickname+'</i>'+v[i].summary+'</i>'
                             +'</div></font></div></div></div>';
                      
                    }
                    fypage++;
                } else {
                }
                issend = true;
                $('#ajaxfoot').html(xszf);
                $('#ajaxfoot').show(); 
            }, "json");
       }
       function  ajaxyd(fag){ 
           $('#ajaxfoot').hide();
           var submitData = { 
             fid:'${id}'
            };
            issend = false; 
            $.post('${ctx}/suc/farm!ajaxydweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf;
                if (fag) {
                    xszf = $('#ajaxyd').html();
                } else {
                    xszf = '';
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<div class="overflow-hidden pt-10 pb-10">'
                             +'<div class="width-10 pl-10 pr-10 overflow-hidden zi-6">'
                             +'<div class="position-r">'
                             +'<img src="${filehttp}/'+v[i].obj.picurl+'" class="width-10"></div>'
                             +'<div class="clear pl-10 pr-10 pt-10">'
                             +'<div class="col-8">'
                             +'<div class="maring-a txt-c hang40 line-height40 width-7 zi-orange border-radius100 line-1-orange" onclick="window.location.href=\'${ctx}/suc/farm!webyd.action?custid=${custid}&lscode=${lscode}&id='+v[i]._id+'\'">查看活动</div>'
                             +'</div>'
                             +'<div class="col-4" onclick="window.location.href=\'${ctx}/suc/farm!playinstructions.action?lscode=${lscode}&custid=${custid}&id='+v[i].obj._id+'\'">'
                             +'<div class="txt-c hang40 line-height40 zi-orange">'
                             +'活动规则<i class="pl-10">》》</i>'
                             +'</div></div></div></div></div>'
                             +'<div class="hang10 bg-hui"></div>';
              
                    }
                    fypage++;
                } else {
                }
                issend = true;
                $('#ajaxyd').html(xszf); 
                $('#ajaxyd').show(); 
            }, "json");
       }
    </script>
</head>
<body class="cmp640">
<main>
    <div class="position-r overflow-hidden clear" style="height:150px;">
        <img src="${ctx}/mvccol/img/bbs2/xingkong.jpg" width="100%">

        <div class="position-a width-10 cmp640 bg-hei-5"
             style="height:150px;top: 0px;">
        </div>
        <div class="position-a width-10 cmp640" style="top:32px;left: 0px;">
            <div class="position-r">
                <div class="pl-15 position-a">
                    <div class=" pt-3 img-wh90 position-r border-radius5"
                         style="background-color:  rgba(255, 255, 255, 0.7)">
                        <div class="img-wh80 border-radius5 maring-a img-bj position-r overflow-hidden"
                             style="background-image: url(${filehttp}/${entity.headimgurl});width: 84px;height: 84px;">
                             
                        </div>

                    </div>

                    <div class="position-a display-none" style="bottom: 0px;left:15px;">
                        <div class="bg-cheng " style="width:80px; height: 15px;"></div>
                    </div>

                </div>

                <div class="zi-bai" style="padding-left:115px;height:90px;">
                    <div class="weight500">
                        <font size="4">
                            <div class="clear sl col-6">${entity.nickname}</div>
                             
                        </font>
                    </div>
                   
 
                    <div class="pt-5 weight100 clear">
                        <font size="2"><i class="pr-10">魅力值${entity.charm}</i><i class="">成长值</i>${entity.growth}</font>
                    </div>

                    <div class="pt-5"> 
                        <div class="pull-left pl-3 pt-5">
                            <font size="1">
                                <div class="padding-lr3 weight100 border-radius3"
                                     style="height:18px; line-height:20px;background-color: #f8a963;">
                                    <i>${rankno}</i>
                                </div>
                            </font>
                        </div> 
                       
                    </div> 
                </div>

            </div>
        </div>
        <div class="position-a display-none" style="right:15px;top:60px;">
            <a href="#">
                <div class="hang30 border-radius3 pl-10 pr-10 btn-lan-tq zi-bai weight500">
                    <font size="2">
                        <i class="fa fa-edit pr-5" style="line-height: 32px;"></i><i>修改</i>
                    </font>
                </div>
            </a>
        </div>

    </div>
    <!--选择按钮-->
    <font size="2">
        <div class="clear pt-10 pb-10 overflow-hidden bg-bai line-bottom yListr3">
            <li class=" button_group1  line-right zhiding" id="2">
                <div class=" div3 zi-hui-wx txt-c weight500">
                    <i>参与的活动</i>
                </div>
            </li>
            <li class=" button_group1 " id="1">
                <div class="div3 zi-hui-wx txt-c weight500">
                    <i>动态消息</i>
                </div>
            </li>
           
        </div>
    </font>
    <!--选择按钮结束-->

    <div class="div-group-10 pl-30 pr-25 display-none" id="ajaxfoot">
        
    </div>
    <div  id="ajaxyd"class="display-none">
        
    </div>
 
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/farm-foot.jsp" %>
<script>
ajaxyd(false); 
</script>
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