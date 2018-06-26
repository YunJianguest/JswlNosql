<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>  
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
    <title>个人中心</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .pl-90 {
            padding-left: 90px;
        }
        .p-top-left-10 {
            top: 10px;
            left: 10px;
        }
        .hang45{
            height: 45px;
            line-height: 45px;
        }
    </style>
</head>
<body class="lock" style="background-color: #f0f0f0">
<main class="cmp640 ">
    <font size="2"> 
      <div class="hang90 overflow-hidden bg-bai width-10 position-r clear" style="border-bottom: 1px dashed #f0f0f0;">
            <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r">
                
                <c:if test="${empty entity.headimgurl}">
                <i class="fa fa-user-secret fa-3x zi-bai" style="line-height: 70px;"></i>
                <div class="position-a width-10" style="bottom: 0px;left: 0px;">
                    <div class="hang20 line-height20 bg-hei-5 zi-bai"><font size="1">点击上传</font></div>
                </div>
                </c:if>
                <c:if test="${not empty entity.headimgurl}">
                 <img src="${filehttp}/${entity.headimgurl}" class="width-10 border-radius3" onclick="previewImage('${filehttp}/${entity.headimgurl}')">
                </c:if> 
            </div>
            <div class="pt-10 pr-10 width-10 pl-90 weight500">
                <div class="hang25 line-height25 zi-hei-tq">
                    <div class="col-9 sl">${entity.nickname}，ID:${entity.no }</div>
                </div>
                <div class="hang20 line-height20 zi-hui-wx">
                    <div class="col-9 sl"><c:if test="${entity.age>0}">${entity.age}岁，</c:if>${entity.province}${entity.city}</div>
                </div>
                <font size="1">
                    <div class="hang25 pt-3 line-height25 zi-hui-wx ">
                        <c:if test="${entity.member==1}">
                          <div class="hang20 border-radius3 line-height20 zi-bai bg-hei-5 pl-5 pr-5 pull-left"style="background-color: #e3c06a"><i
                                class="fa fa-diamond line-height20"></i> VIP
                          </div>
                        </c:if>
                        <c:if test="${entity.member==0}">
                          <div class="hang20 border-radius3 line-height20 zi-bai bg-hei-5 pl-5 pr-5 pull-left"><i
                                class="fa fa-diamond line-height20"></i> VIP
                          </div>
                        </c:if>
                        <c:if test="${entity.member==2}">
                          <div class="hang20 border-radius3 line-height20 zi-bai bg-hei-5 pl-5 pr-5 pull-left"><i
                                class="fa fa-diamond line-height20"></i> VIP
                          </div>
                        </c:if>
                      
                        <div class="hang20 border-radius3 line-height20 zi-bai bg-hei-5 pl-5 pr-5 ml-5 pull-left"><i
                                class="fa fa-mobile-phone line-height20 pr-5"></i>手机认证
                        </div>
                    </div>
                </font>
            </div>
        </div>
        <div class="hang7 clear bg-hui-tx"></div> 
        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden" onclick="window.location.href='${ctx}/suc/dating!recharge.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class=" bg-cheng img-wh25 txt-c zi-bai overflow-hidden"style="background-color: #e3c06a">
                        <i class="fa fa-diamond line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    VIP包月
                </div>
                <div class="pull-right zi-hui">
                    <i class="pr-5 size10"><c:if test="${entity.member==0}">立即开通</c:if><c:if test="${entity.member==1}">到期时间:<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss ' value='${entity.endMemberDate}'/></c:if><c:if test="${entity.member==2}">会员过期（立即续费）</c:if></i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>

        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class=" img-wh25 txt-c zi-bai overflow-hidden"style="background-color: #f18753">
                        <i class="fa fa-heartbeat line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    我的缘币
                </div>
                <div class="pull-right zi-hui">
                    <i class="pr-5 size10">${entity.money}</i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>
        <div class="hang7 clear bg-hui-tx"></div>
        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden" onclick="window.location.href='${ctx}/suc/dating!webadd.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class="bj-lan2 img-wh25 txt-c zi-bai overflow-hidden">
                        <i class="fa fa-drivers-license-o line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    个人资料
                </div>
                <div class="pull-right zi-hui">
                    <i class="pr-5 size10"><c:if test="${empty entity.tel}">未完成</c:if><c:if test="${not empty entity.tel}">已完成</c:if></i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>
        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class=" bj-lan1 img-wh25 txt-c zi-bai overflow-hidden">
                        <i class="fa fa-photo line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    我的相册
                </div>
                <div class="pull-right zi-hui" onclick="window.location.href='${ctx}/suc/dating!photo.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
                    <i class="pr-5 size10">上传你的照片,才会被更多人看到！</i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>
        <div class="hang7 clear bg-hui-tx"></div>
        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class=" bj-cheng img-wh25 txt-c zi-bai overflow-hidden">
                        <i class="fa fa-pencil line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    征友条件
                </div>
                <div class="pull-right zi-hui" onclick="window.location.href='${ctx}/suc/dating!condition.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
                    <i class="pr-5 size10"><c:if test="${empty con}">未完成</c:if><c:if test="${not empty con}">已完成</c:if></i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>
        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden" onclick="window.location.href='${ctx}/suc/dating!foot.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class="bj-hong1 img-wh25 txt-c zi-bai overflow-hidden">
                        <i class="fa fa-paw line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    最近访客
                </div>
                <div class="pull-right zi-hui">
                    <i class="pr-5 size10"><font size="1">最近7天共有<i>${foot}人</i>访问过您</font></i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>
        <div class="hang7 clear bg-hui-tx"></div>
        <div class="hang45 bg-bai line-bottom-92 zi-6 pr-10 clear weight500 overflow-hidden" onclick="window.location.href='${ctx}/suc/dating!star.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
            <font size="2">
                <div class="pull-left div-group-10">
                    <div class="bj-lan1 img-wh25 txt-c zi-bai overflow-hidden">
                        <i class="fa fa-bookmark line-height25"></i>
                    </div>
                </div>
                <div class="pull-left">
                    任务中心
                </div>
                <div class="pull-right zi-hui">
                    <i class="pr-5 size10"><font size="1"></font></i><i class="fa fa-chevron-right hang45"></i>
                </div>
            </font>
        </div>
    
     

        <div class="txt-c zi-6 hang40 line-height40">@2017同城交友</div>
    </font>
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/dating-foot.jsp" %>
<script>
 function  check_task(){
       var submitData = {  
            };
            $.post('${ctx}/suc/dating!ajaxReward.action?custid=${custid}&lscode=${lscode}', submitData, 
                    function (json) { 
                        if (json.state == 0) {
                        
                        }  
                    }, "json"); 
     }
     function previewImage(imgUrl){
            wx.previewImage({
                current: imgUrl, 
                urls: [imgUrl]
            });
     }
</script>
</body>
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
</html>