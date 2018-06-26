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
    <title>TA的资料</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>  
          function upload(){ 
          var submitData = {
                id:'${entity._id}', 
	            }; 
		$.post('${ctx}/suc/dating!saveFoot.action?custid=${custid}&lscode=${lscode}', submitData, 
        	 function(json){ 
        	  if(json.state==0){ 
        	  }else{ 
        	  }
        	 },"json"); 
       }
       function  tc_show(txt){
         $('#tc_txt').html(txt);
         $('#yz_tc').show();
       }
       function  tc_hide(){ 
         $('#yz_tc').hide();
       }
 
    </script>
    <style>
        .pl-90 {
            padding-left: 90px;
        }

        .zi-fa82a5 {
            color: #fd6c8e
        }

        .p-l-r-1 {
            padding: 5px 2px 5px 2px;
        }

        .bottom-fa82a5 {
            background-color: rgba(234, 100, 131, 0.7);
        }

        .bottom-fa82a5:hover, .bottom-fa82a5:focus {
            background-color: rgba(234, 100, 131, 0.8);
        }

        .bottom-738ffa {
            background-color: rgba(115, 143, 250, 0.7);
        }

        .bottom-738ffa:hover, .bottom-738ffa:focus {
            background-color: rgba(115, 143, 250, 0.8);
        }

        .p-top-left-10 {
            top: 10px;
            left: 10px;
        }
        .hang35{
            height: 35px;;
            line-height: 35px;
        }
    </style>
</head>
<body class="lock" style="background-color: #f0f0f0">
<main class="cmp640 pl-5 pr-5">
    <font size="2">
      <div class="hang90 overflow-hidden bg-bai width-10 position-r clear" style="border-bottom: 1px dashed #f0f0f0;">
            <div class="pull-left bg-hui-tx txt-c img-wh70 overflow-hidden position-a p-top-left-10 position-r">
                
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
        <div class="hang7"></div>
        <!--用户是会员时显示电话和微信号  不是会员时显示按钮，点击按钮弹出不是会员提示框引导其开通会员   此处有问题请及时沟通-->
       
        <c:if test="${member==1}">
         
          <div class="col-4 pr-5">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-photo pr-5 zi-lan-tq"></i>相册
            </div>
         </div>
         <c:if test="${not empty entity.tel}">
           <div class="col-4 pr-5">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-phone pr-5 zi-fa82a5"></i><font size="1"class="weight500">${entity.tel}</font>
            </div>
           </div>
         </c:if> 
         <c:if test="${empty entity.tel}">
           <div class="col-4 pr-5">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-phone pr-5 zi-fa82a5"></i>暂无信息
            </div>
           </div>
         </c:if>
         <c:if test="${not empty entity.qq}">
           <div class="col-4">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-weixin pr-5 zi-cheng"></i><font size="1"class="weight500">${entity.qq}</font>
            </div>
           </div>
             
         </c:if>
          <c:if test="${empty entity.qq}">
          <div class="col-4">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-weixin pr-5 zi-cheng"></i>暂无信息
            </div>
         </div> 
         </c:if>
        
        </c:if>
        <c:if test="${member==0}"> 
           <div class="col-4 pr-5" onclick="tc_show('由于您还不是VIP用户，不可以直接查看相册！您可以先给她打个招呼！')">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-photo pr-5 zi-lan-tq"></i>相册
            </div>
          </div>
          <div class="col-4 pr-5" onclick="tc_show('由于您还不是VIP用户，不可以直接查看手机号码！您可以先给她打个招呼！')">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-phone pr-5 zi-fa82a5"></i>手机号码
            </div>
          </div>
          <div class="col-4" onclick="tc_show('由于您还不是VIP用户，不可以直接查看微信！您可以先给她打个招呼！')">
            <div class="hang40 line-height40 bg-bai txt-c zi-6 border-radius3"><i
                    class="fa fa-weixin pr-5 zi-cheng"></i>微信/QQ
            </div>
          </div> 
        </c:if>  
        <c:if test="${not empty photo}">
        
         <c:if test="${member==1}"> 
         <div class="clear hang7"></div>
        <div class="hang40 bg-bai line-height40 weight500 zi-hui-wx pl-5 pr-5 line-bottom-92">
            相册
        </div>
          <div class="p-l-r-1 bg-bai pt-10 overflow-hidden">
            <c:forEach items="${photo}" var="bean"> 
            <div class="col-3 p-l-r-1 position-r">
                <div class="img-wh70 photo maring-a img-bj border-radius3"style="background-image: url(${filehttp}/${bean.picurl})" data-src="${filehttp}/${bean.picurl}"></div>
            </div>
            </c:forEach>  
          </div>
          </c:if>
         </c:if>
     
        <div class="clear hang7"></div>
        <div class="hang40 bg-bai line-height40 weight500 zi-hui-wx pl-5 pr-5 line-bottom-92">
            联系方式
        </div>
        <c:if test="${member==0}">
         <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">QQ</div>
            <div class="pull-right zi-hui-wx" onclick="tc_show('由于您还不是VIP用户，不可以直接查看QQ！您可以先给她打个招呼！')">查看QQ</div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">手机</div>
            <div class="pull-right zi-hui-wx" onclick="tc_show('由于您还不是VIP用户，不可以直接查看手机！您可以先给她打个招呼！')">查看手机</div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">微信</div>
            <div class="pull-right zi-hui-wx" onclick="tc_show('由于您还不是VIP用户，不可以直接查看微信！您可以先给她打个招呼！')">查看微信</div>
        </div>
        </c:if>
        <c:if test="${member==1}">
         <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">QQ</div>
            <c:if test="${not empty entity.qq}">
            <div class="pull-right zi-hui-wx">${entity.qq}</div>
            </c:if>
            <c:if test="${empty entity.qq}">
            <div class="pull-right zi-hui-wx">暂无信息</div>
            </c:if>
            
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">手机</div>
            <c:if test="${not empty entity.tel }">
            <div class="pull-right zi-hui-wx">${entity.tel}</div>
            </c:if>
            <c:if test="${empty entity.tel }">
            <div class="pull-right zi-hui-wx">暂无信息</div>
            </c:if>
            
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">微信</div>
            <c:if test="${not empty entity.wx}">
            <div class="pull-right zi-hui-wx">${entity.wx}</div>
            </c:if>
            <c:if test="${empty entity.wx}">
            <div class="pull-right zi-hui-wx">暂无信息</div>
            </c:if>
            
        </div>
        </c:if>
       
        <div class="hang7"></div>
        <div class="hang40 bg-bai line-height40 weight500 zi-hui-wx pl-5 pr-5 line-bottom-92">
            个人空间
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">最近上线时间</div>
            <div class="pull-right zi-hui-wx">仅VIP可见</div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">交友目的</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.purpose}">${entity.purpose}</c:if><c:if test="${empty entity.purpose}">暂无信息</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">恋爱观念</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.concept}">${entity.concept}</c:if><c:if test="${empty entity.concept}">暂无信息</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">首次见面希望</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.firstmeet}">${entity.firstmeet}</c:if><c:if test="${empty entity.firstmeet}">暂无信息</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">喜欢约会的地点</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.likeDatingSite}">${entity.likeDatingSite}</c:if><c:if test="${empty entity.likeDatingSite}">暂无信息</c:if></div>
        </div>
        <div class="hang7"></div>
        <div class="hang40 bg-bai line-height40 weight500 zi-hui-wx pl-5 pr-5 line-bottom-92">
            基本资料
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">昵称</div>
            <div class="pull-right zi-hui-wx">${entity.nickname}</div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">性别</div>
            <div class="pull-right zi-hui-wx"><c:if test="${entity.sex==1}">男</c:if><c:if test="${entity.sex==2}">女</c:if><c:if test="${entity.sex==0}">未知</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">年龄</div>
            <div class="pull-right zi-hui-wx">${entity.age}岁</div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">居住地</div>
            <div class="pull-right zi-hui-wx">${entity.province}-${entity.city}<c:if test="${not empty entity.county}">-${entity.county}</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">身高</div>
            <div class="pull-right zi-hui-wx"><c:if test="${entity.height>0}">${entity.height}cm</c:if><c:if test="${entity.height==0}">暂无信息</c:if></div>
        </div>
        <div class="hang7"></div>
        <div class="hang40 bg-bai line-height40 weight500 zi-hui-wx pl-5 pr-5 line-bottom-92">
            详细资料
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">学历</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.record}"><c:if test="${entity.record==0}">高中</c:if><c:if test="${entity.record==1}">技校</c:if><c:if test="${entity.record==2}">中专</c:if><c:if test="${entity.record==3}">本科</c:if><c:if test="${entity.record==4}">硕士</c:if><c:if test="${entity.record==5}">博士</c:if></c:if><c:if test="${empty entity.record}">暂无信息</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">职业</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.professional}">${entity.professional}</c:if><c:if test="${empty entity.professional}">暂无信息</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">生日</div>
            <div class="pull-right zi-hui-wx"><c:if test="${not empty entity.birthday}">${entity.birthday}</c:if><c:if test="${empty entity.birthday}">暂无信息</c:if></div>
        </div>
        <div class="hang40 bg-bai line-height40 weight500 zi-6 pl-10 pr-10 clear line-bottom-92">
            <div class="pull-left">体重</div>
            <div class="pull-right zi-hui-wx"><c:if test="${entity.weight>0}">${entity.weight}kg</c:if><c:if test="${entity.weight==0}">暂无信息</c:if></div>
        </div>


        <div class="txt-c zi-6 hang40 line-height40">@2017同城交友</div>
    </font>

</main>


<!--点击发私信后提示框-->
<div class="fullscreen cmp640 bg-hei-5 lock display-none" id="yz_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:tc_hide()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class=" cmp640 position-f position-r" style="top:35%;left:0px;z-index: 99;">
             
            <div class="maring-a position-r border-radius3 div-group-10 bg-bai" style="width:290px;">
                <a href="javascript:tc_hide()">
                    <div class="position-a" style="right:-10px;top:-10px;z-index: 101;">
                        <div class="img-wh25 border-radius50 bg-hei-5 txt-c">
                            <font size="3">
                                <i class="fa fa-remove zi-bai" style="line-height:27px"></i>
                            </font>
                        </div>
                    </div>
                </a>

                <div class=" width-10 border-radius5 zi-hui-tq overflow-hidden">
                    <font size="2">
                        <div class="weight500">您好:</div>
                        <div class="weight500" style="line-height: 22px;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp尊敬的：<i
                                class="zi-fa82a5">${username} </i><i id="tc_txt"></i>
                        </div>
                    </font>
                </div>
                <div class="width-10 pt-15">
                    <div class="button_group1" onclick="window.location.href='${ctx}/suc/dating!chat.action?custid=${custid}&lscode=${lscode}&id=${entity.no}'">
                        <div class="width-9_5 maring-a border-radius3 bottom-738ffa zi-bai txt-c hang35 line-height35">
                            给她打个招呼
                        </div>
                    </div> 
                    <div class="button_group1" onclick="window.location.href='${ctx}/suc/dating!recharge.action?custid=${custid}&lscode=${lscode}'">
                        <div class="width-9_5 maring-a border-radius3 bottom-fa82a5 zi-bai txt-c hang35 line-height35">
                            开通VIP
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<!--点击事件提示框  弹出后经过很短时间就消失-->
<div class="position-f width-10 display-none" style="bottom:100px;left:0px;">
    <div class="zi-bai txt-c line-height25">
        <i class="bg-hei-5 div-group-10 border-radius5 line-height25">打招呼成功</i>
    </div>
</div>

<div class="hang70"></div>
<div class="position-f width-5 hang60" style="bottom:10px;left:25%;"> 
    <div class="col-12">
        <div class="clear maring-a border-radius50 txt-c img-wh60 zi-bai bottom-fa82a5" onclick="window.location.href='${ctx}/suc/dating!chat.action?custid=${custid}&lscode=${lscode}&id=${entity.no}'">
            <div class="hang30 pt-5"><i class="fa fa-magic line-height30"></i></div>
            <div class="hang20 line-height20 weight500"><font size="1">打招呼</font></div>
        </div>
    </div>
</div>
<script>
upload();
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
 
 var imgsSrc =[];
 function reviewImage(dsrc) {
	     wx.previewImage({
                current: dsrc, 
                urls: imgsSrc
            });
	   
 }
 $(".photo").each(function(){
  var dsrc = this.getAttribute("data-src"); 
  imgsSrc.push(dsrc);
  this.addEventListener("click", function(){
  reviewImage(dsrc);
  }, false); 
  });
 
 
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

</body>
</html>