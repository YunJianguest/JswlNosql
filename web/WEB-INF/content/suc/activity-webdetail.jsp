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
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <!-- Resource style -->
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script>

        function phb_xiaoshi() {
            $('#phb_tanchu').hide();
        }
        function phb_xianshi() {
            $('#phb_tanchu').show();
        }
        function yd() { 
            var submitData = {
                id: '${entity._id}',
            };
            $.post('${ctx}/suc/activity!ajaxyd.action?lscode=${lscode}&custid=${custid}', submitData,
                    function (json) {
                          if (json.state == 0) {
                             swal({
                                text: '恭喜您预订成功！共花费 ${entity.jfdh}积分',
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                             }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {
                                            window.location.href = '${ctx}/suc/activity!webyd.action?id=' + json.value + '&custid=${custid}&lscode=${lscode}';
                                        }
                                    }
                            ); 
                        } else if (json.state == 2) {
                            swal({
                                text: '您已经预定了该商品！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {
                                            window.location.href = '${ctx}/suc/activity!webyd.action?id=' + json.value + '&custid=${custid}&lscode=${lscode}';
                                        }
                                    }
                            );
                        } else if(json.state==1){
                            swal({
                                text: '亲，来迟了一步，库存已完，请查看其它商品！',
                                timer: 2000,
                                type: 'warning',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }else if(json.state==3){ 
                            swal({ 
                               text: "亲，您积分不足，您可以查看其它产品或者赚取积分！",
                               type: 'warning',
                               showCancelButton: true,
                               confirmButtonColor: '#3085d6',
                               cancelButtonColor: '#d33',
                               confirmButtonText: '去赚积分',
                               cancelButtonText: '稍后再说',
                               confirmButtonClass: 'btn btn-success mr-15',
                               cancelButtonClass: 'btn btn-danger ml-15',
                                   buttonsStyling: false
                             }).then(function () {
                                   window.location.href='${ctx}/suc/task!web.action?custid=${custid}&lscode=${lscode}';
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  
                                 }
                            });
                        }
                    }, "json");
        }
        
        var fypage=0;
        function  gmlb(){
         var submitData = {
    	         id:'${entity._id}', 
	          }; 
           $.post('${ctx}/suc/activity!ajaxydweblist.action?lscode=${lscode}&custid=${custid}&fypage='+fypage, submitData,
        	 function(json){
        	  if(json.state==0){ 
        	     var html=$('#ajaxgmdiv').html();
        	     var list=json.list;
        	     for(var i=0;i<list.length;i++){
        	      html+='<div class="overflow-hidden txt-l weight500 pt-3 pb-5">'
        	          +'<div class="zi-hei" style="line-height:17px;">'
        	          + '<i class="zi-bai">' + list[i].nickname + '</i> 在'+list[i].createdate+'参与了该活动！</div></div>';
        	     }
        	    
        	     fypage++;
        	  }
        	   $('#ajaxgmdiv').html(html);
        	 },"json");
        }
        

    </script>
    <style>
        .hang25 {
            height: 25px;
            line-height: 25px;
        }
        .img-100 img{
         width: 100%
        }

        /*排行版三角形*/
        .arrow {
            width: 0px;
            height: 0px;
            border-width: 15px;
            border-style: solid;
            border-color: #ec5254 transparent transparent #ec5254;
        }

        .button_group1 {
            width: 2000px;
            display: table-cell;
        }

        .btn-360hui {
            background-color: #e9ecef;
            color: #67757e;
        }

        .btn-360hui:hover {
            background-color: #f8f9fa;
            color: #27b66a;
        }

        .btn-360hui:active {
            background-color: #f8f9fa;
            color: #27b66a;
        }

        .pr-2 {
            padding-right: 2px;
        }


        .sc-hong {
            background-color: #ec5254;
        }

        .zi-sc-hong{
            color: #ec5254;
        }

        .btn-sc-hong {
            background-color: #ec5254;
        }

        .btn-sc-hong:hover {
            background-color: #d94c4e;
        }

        .bg-hei-6 {
            background-color: rgba(30, 30, 30, 0.6);
        }
    </style>
</head>
<body class="cmp640 lock">
<main>
    <c:if test="${not empty com.ewmurl}">
      <c:if test="${com.ewmxs==0}"> 
      <%@ include file="/webcom/focus-page.jsp" %>
      </c:if>
    </c:if> 
    <!--弹出层排行榜-->
    <div class="fullscreen cmp640 bg-hei-5 display-none lock pb-10" id="phb_tanchu">
        <div class="position-r overflow-hidden width-10">
            <a href="javascript:phb_xiaoshi()">
                <div class="width-10 overflow-hidden" style="height:1000px;"></div>
            </a>

            <div class="position-a width-7 position-r overflow-hidden sc-hong div-group-10 border-radius5"
                 style="top:7%;left:15%;height: 400px;overflow: auto;">
                <div class="position-a hang50 overflow-hidden sc-hong width-10"
                     style="top: 0px; left: 0px;border-radius: 5px 5px 0px 0px;">
                    <div class="pt-10">
                        <div class="hang40 width-5 maring-a bj-hong1 txt-c zi-bai weight500 line-height40"
                             style="border-radius: 50px;"><font size="3">砍价排行榜</font></div>
                    </div>
                </div>
                <a href="javascript:phb_xiaoshi()">
                    <div class="position-a img-wh50 zi-bai txt-r div-group-10" style="top: 0px; right: 0px;">
                        <i class="fa fa-close fa-1dx"></i>
                    </div>
                </a>

                <div class="pt-50 weight500 zi-bai overflow-hidden" style="height:375px;overflow: auto;">
                    <font size="2" id="ajaxgmdiv">

                    </font>
                </div>
            </div>
        </div>
    </div>
    <!--结束-->

    <div class="width-10 position-r">
        <c:if test="${not empty slide}">
            <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
                <ul>
                    <c:forEach items="${slide}" var="bean">
                        <li>
                            <a href="${bean.url}">
                                <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                            </a>
                        </li>
                    </c:forEach>
                </ul>

            </div>

            <script>
                $(function () {
                    new Swipe(document.getElementById('banner_box'), {
                        speed: 500,
                        auto: 3000,
                        callback: function () {
                            var lis = $(this.element).next("ol").children();
                            lis.removeClass("on").eq(this.index).addClass("on");
                        }
                    });
                });
            </script>
        </c:if>

        <div class="position-a" style="bottom: 0px; left: 0px;">
            <img src="${ctx}/mvccol/img/fgyd.png" class="width-10">
        </div>
    </div>

    <div class="width-10 div-group-10 pt-40 hang60">
        <font size="2">
            <div class="pull-left col-12 bg-hei-6 position-r" style="border-radius: 50px;">
                <div class="position-r hang25 sc-hong zi-bai" style="border-radius: 50px;width:${bl}%">
                    <div class="pull-left pl-5 hang25 overflow-hidden"><font size="2"><fmt:formatNumber value='${entity.lowprice}' pattern="0.0#"/>元</font>
                    </div>
                    <div class="position-a position-r" style="top:-28px;right:-5px;">
                        <div class="sc-hong zi-bai overflow-hidden hang25"
                             style="padding-left:5px;padding-right:5px;border-radius: 5px 5px 0px 5px;">
                            <font size="1"><fmt:formatNumber value='${entity.price}' pattern="0.0#"/>元</font>
                        </div>
                        <div class="position-a" style="bottom:-11px;right:0px;">
                            <div class="zi-sc-hong">
                                <font size="4"><i class="fa fa-caret-down"></i></font>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="position-a pr-5 zi-bai" style="top: 0px; right: 0px;">
                    <div class="pull-right hang25 overflow-hidden">
                        <font size="2"><fmt:formatNumber value='${entity.price}' pattern="0.0#"/>元</font>
                    </div>
                </div>
            </div>
        </font>
    </div>

    <div class="pt-25 pb-25 div-group-10 overflow-hidden">
        <div class="col-6" onclick="yd()">
            <div class="width-9 pull-left hang40 maring-a btn-cheng zi-bai txt-c"
                 style="border-radius: 50px;line-height: 40px;">
                <font size="3">
                    我要发起砍价
                </font>
            </div>
        </div>
        <div class="col-6">
            <div class="width-9 pull-right hang40 maring-a bg-hei-6 zi-hui txt-c"
                 style="border-radius: 50px; line-height: 40px;text-decoration: line-through;">
                <font size="3">
                    为好友砍价
                </font>
            </div>
        </div>
    </div>


    <div class="overflow-hidden pt-5 clear">
        <div class="sc-hong" style="height:3px;"></div>
        <div class="pt-2">
            <font size="2">
                <div class="pull-left sc-hong hang30 pl-10 pr-10 zi-bai weight500" style="line-height:32px;">
                    产品介绍 
                </div>
                <div class="arrow pull-left"></div>
            </font>
        </div>
    </div>
    <div class="border-radius5 div-group-10 pt-20 clear img-100">
        ${entity.content}
    </div>
    <div class="hang60 clear"></div>
    
    <!--底部button-->
    <div class=" button_foot cmp640 shadow-wai weight500" style="bottom:0px;">
        <div class="button_group1">
            <a href="${ctx}/suc/totalactivity!web.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-home"></div>
                    </font>
                    <div class=" pt-3">
                        <font size="1">
                            活动首页
                        </font>
                    </div>
                </div>
            </a>
        </div>
        <div class="button_group1">
            <a href="javascript:phb_xianshi()">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-signal"></div>
                    </font>
                    <div class=" pt-3">
                        <font size="1">
                           砍价排行榜
                        </font>
                    </div>
                </div>
            </a>
        </div> 
        <div class=" button_group1">
            <a href="${ctx}/suc/activity!webydlb.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-gift"></div>
                    </font>
                    <div class=" pt-3">
                        <font size="1">
                            参与的活动
                        </font>
                    </div>
                </div>
            </a>
        </div>
        <div class=" button_group1">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5"
            onclick="window.location.href='${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}'">
                <font size="4">
                    <div class="fa fa-money"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        我的卡卷
                    </font>
                </div>
            </div>
        </div>
        <div class=" button_group1">
            <a href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-user"></div>
                    </font>
                    <div class=" pt-3">
                        <font size="1">
                            个人中心
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
</main>

<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&&lscode=${lscode}', submitData,

                    function (json) { 
                        if (json.state == 0) {
                            var text='分享成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                          swal({
                                text: text,
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }  
                    }, "json");
     
     }
</script> 
<script>
gmlb();
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
            check_task();

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
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</body>
</html>