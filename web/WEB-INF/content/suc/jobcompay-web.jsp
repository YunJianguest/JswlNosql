<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
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
    <title>首页</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <!--mt轮播-->
    <script src="${ctx}/mvccol/js/mtlb.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <!--结束-->
    <style>
        .bk {
            width: 90px;
            height: 65px;
        }
        .line-height32 {
            line-height: 32px;
        }
        .line-bottom-red {
            border-bottom: 3px solid red;
            color: red;
        }
    </style>
    <script>
          var fypage=0;
          var state=0;
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
                state=$(this).attr('id');
                ajaxweb();
                fypage=0;
            })
        })
          
          function ajaxweb() {//加载
           $('#deliver').hide();
            var submitData = { 
            };
            var url='${ctx}/suc/jobcompay!ajaxzr.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            if(state==1){
              url='${ctx}/suc/jobcompay!ajaxzx.action?custid=${custid}&lscode=${lscode}&fypage='+fypage;
            }
            $.post(url, submitData,
                    function (json) {
                        var list = ''; 
                        if (json.state == '0') {
                            var js = json.plist;
                            if(js!=null){
                             for (var i = 0; i < js.length; i++) { 
                                list +='<div class="line-bottom-92 div-group-5 pl-10 pr-10 overflow-hidden position-r hang80" onclick="supplydetail(\''+js[i]._id+'\')">'
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
                            } 
                            
                            js=json.carlist;
                            if(js!=null){
                             for (var i=0;i<js.length;i++) { 
                                list +='<div class="line-bottom-92 div-group-5 pl-10 pr-10 overflow-hidden position-r hang80" onclick="cardetail(\''+js[i]._id+'\')">'
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
                            }
                           
                            js=json.clist;
                            if(js!=null){
                            for(var i = 0; i < js.length; i++){
                                list +='<div class="line-bottom-92 div-group-5 pl-10 pr-10 overflow-hidden position-r" onclick="employdetail(\''+js[i]._id+'\')">'
                                     +'<div class="col-2 display-none"><div class="mt-25 clear pr-5">'
                                     +'<div class="img-wh20 bg-bai-5 maring-a txt-c" onclick="check(this)" style="border: solid #45c01a 2px;" id="'+js[i]._id+'">'
                                     +'<font size="1">'
                                     +'<i class="fa  zi-green display-none" style="line-height:16px;"></i>'
                                     +'</font></div></div></div>'
                                     +'<div class="col-12">'
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
                            } 
                            js=json.slist;
                            if(js!=null){
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
        function  check(v){
         if($(v).find('i').hasClass('fa-check')){
           $(v).find('i').removeClass('fa-check');
            var  ids='';
            $(".img-wh20").each(function(){
            if($(this).find('i').hasClass('fa-check')){
              ids+=$(this).attr('id')+",";
            } 
           });
           if(ids==''){
           $('#deliver').hide();
           }
          }else{
           $('#deliver').show();
           $(v).find('i').addClass('fa-check');
          
         } 
        }
        function  deliver(){ 
          var  ids=''; 
          $(".img-wh20").each(function(){
            if($(this).find('i').hasClass('fa-check')){
              ids+=$(this).attr('id')+",";
            } 
          });
           alert(ids);
           if(ids==''){
             alert('请先选择公司');
           }
            var submitData = {
                lscomid:ids, 
            };
            $.post('${ctx}/suc/jobcompay!putin.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("投放成功！");
                        }else if(json.state==2){
                            alert("您还没有简历，请先去创建一份属于自己的简历！");
                        }else{
                            alert("投放异常！");
                        }
                    }, "json");
           
        }
        
        function supplydetail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!supplyDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        }
        function cardetail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!carDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        }
        function seekdetail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!seekersDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        }
        function employdetail(id) { 
             window.location.href = "${ctx}/suc/jobcompay!employDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
             
        }
         
    </script>
</head>
<body>
<main class="cmp640">

      <c:if test="${not empty slide}">
        <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
            <ul>
                <c:forEach items="${slide}" var="bean">
                  <li> 
                        <c:if test="${empty bean.mp4url}">
                         <a href="${bean.url}">
                            <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                         </a>
                        </c:if>
                        <c:if test="${not empty bean.mp4url}">
                          <iframe frameborder="0" width="500" height="375" src="${bean.mp4url}" allowfullscreen></iframe>
                        </c:if>
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
                  $('#banner_box').find('iframe').load(function(){
                  var mainwidth =$(document.body).width();
                  var mainheight=mainwidth*9/16;
                  $(this).width(mainwidth);
                  $(this).height(mainheight);
                 });
            });
        </script>
    </c:if>

     <c:if test="${not empty typelist}">
	<div class="page--index export  pb-15" >
    	<div class="hero-gallery js-flickity pb-5" data-js-module="hero-gallery">
            <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                <div class="width-10">
                    <div class="overflow-hidden border-radius5"> 
           				<c:forEach items="${typelist}" var="bean"  begin="0" end="7">
                         <c:if test="${not empty bean.url}">
                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'"> 
                                <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                     <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.title}</div>
                         </div>
                       </c:if>
                      <c:if test="${empty bean.url}"> 
                         <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                               <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                    <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.title}</div>
                         </div>
                     </c:if>
                     </c:forEach>
            		</div> 
                </div>
            </div>
             <c:if test="${fn:length(typelist)>8}">
             <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                <div class="width-10">
                    <div class="overflow-hidden border-radius5"> 
           				<c:forEach items="${typelist}" var="bean"  begin="8" end="15">
                         <c:if test="${not empty bean.url}">
                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'"> 
                                <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                    <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.title}</div>
                         </div>
                       </c:if>
                      <c:if test="${empty bean.url}"> 
                         <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                               <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                    <img src="${filehttp }${bean.picurl}" width="100%" height="100%"></img> 
                                </div>
                                <div class="txt-c size12 zi-hei mt-5 width-10">${bean.title}</div>
                         </div>
                     </c:if>
                     </c:forEach>
            		</div> 
                </div>
            </div>
            </c:if>
    	</div>
	</div> 
	</c:if>

    <div class="hang7 bg-hui-92 clear"></div>
    <font size="2">
        <div class="cmp640 position-r" style=" z-index:3;">
            <div class="hang40 bg-bai pt-5 weight100 yListr2 zi-hui-tq">
                <li class="button_group1 hang30 line-height32 txt-c line-bottom line-bottom-red" id="0">
                    热门
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-bottom" id="1">
                    新入
                </li>
                
            </div>
        </div>
    </font>
    <div id="ajaxdiv"></div>  
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp" %>
<div class=" button_foot bg-bai zi-hui shadow-wai cmp640 display-none"  style="z-index: 2;" id="deliver">
    <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5 button_group1" onclick="deliver()">
            <div class="hang40 line-height40 zi-bai btn-cheng width-9_5 weight500 txt-c maring-a border-radius3">
                确认投递
            </div>
    </div>
</div> 
<script> 
ajaxweb();
    wx.config({
        debug: false,
        appId: '${token.appid}',
        timestamp: '${token.timestamp}',
        nonceStr: '${token.noncestr}',
        signature: '${token.signature}',
        jsApiList: [ 'checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems'
        ]
    });
    wx.ready(function(){
        var share={
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