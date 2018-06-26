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
    <title>${title}</title>
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
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx }/mvccol/js/mtlb.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <style>

        .line-left-2 {
            border-left: solid 2px #f2f2f2
        }

        .line-left-1 {
            border-left: solid 1px #f2f2f2
        }

        .line-right-2 {
            border-right: 2px solid #f2f2f2;
        }

        .line-right-1 {
            border-right: 1px solid #f2f2f2;
        }

        .line-top-2 {
            border-top: 2px solid #f2f2f2;
        }

        .line-bottom-2 {
            border-bottom: 2px solid #f2f2f2;
        } 

        .bg-huang {
            background: #f3bc48;
        }

        .bg-zong {
            background: #630601
        }

        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }

        .border-radius5s {
            border-radius: 5px 5px 0 0;
        }

        .txt-line-through {
            text-decoration: line-through;
        }

        .line-left-green {
            border-left: 5px solid #45c01a;
        }

        .sc-hong {
            background-color: #ec5254
        }

        .hang-sl-2 {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
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
        
    </style>
    <script>
        
        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
        function fl_xiaoshi() {
            $('#fl_tanchu').hide();
        }
        function fl_xianshi() {
            $('#fl_tanchu').show();
        }
        $(function () {
            $(".yListr3 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
            })
        })
    </script>
    <script>
        var issend = true;
        var fypage = 0;
        var xszf = "";
        var type = "";
        var lx = "";
        var sel = "";
        function ajaxjz() {//加载
            if (!issend) {
                return;
            }
            var submitData = {
                "cid": '${entity._id}',
                "lx": lx,
                "sel": sel
            };
            issend = false;
            $('#loading').show();
            $.post('${ctx}/shop/shop!ajaxweb.action?custid=${custid}&agid=${agid}&fypage=' + fypage, submitData,
                    function (json) {
                        var xszfleft = $('#ajaxdivleft').html();
                        var xszfright = $('#ajaxdivright').html();
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                if (i & 1 != 0) {
                                    xszfleft+='<div class="width-10 overflow-hidden zi-6 line-bottom-2">'
                                            +'<div class="position-r" onclick="window.location.href=\'${ctx}/shop/shop!shopproduct.action?custid=${custid}&agid=${agid}&lscode=${lscode}&pid=' + v[i]._id + '\'"><img src="${filehttp}'+v[i].logo +'" class="width-10">'
                                          
                                            +'<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                            +'<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                            +'<font size="1"><i class="pr-5">已售:</i>'+v[i].gmnum+'<i class="pl-5">件</i></font>'
                                            +'</div></div></div>'
                                            +'<div class="col-12 div-group-5 zi-6 bg-bai weight500">'
                                            +'<font size="2">';
                                            if('${isAgent}'=='ok'){
                                            xszfleft+='<div class="col-9 zi-hong hang30 line-height30">￥'+v[i].price.toFixed(1)+' 提成:'+(v[i].price.toFixed(2)-v[i].dlprice.toFixed(2)).toFixed(1)+'￥</div>';
                                            }else{
                                            xszfleft+='<div class="col-9 zi-hong hang30 line-height30">￥'+v[i].price.toFixed(2)+'</div>';
                                            } 
                                            xszfleft+='<font size="1">'
                                            +'<div class="col-3 txt-r zi-hong zi-hong pr-5">'
                                            +'<div class="img-wh30 pull-right txt-c bg-hong border-radius50 zi-bai" onclick="showspec('+v[i]._id+',\''+v[i].ptitle+'\',\''+v[i].logo+'\','+v[i].price+','+v[i].num+')"><i class="fa line-height30 fa-1dx fa-shopping-cart"></i>'
                                            +'</div></div></font>'
                                            +'<div class="clear pt-7 pb-3 sl">'+v[i].ptitle+'</div>'
                                            +'</font>'
                                            +'<font size="1">'
                                            +'<div class="clear zi-hui-tq pb-3 line-height20 weight100 sl">'
                                            +v[i].summary
                                            +'</div></font></div></div>'; 
                       
                                } else {
                                   xszfright+='<div class="width-10 overflow-hidden zi-6 line-bottom-2">'
                                            +'<div class="position-r" onclick="window.location.href=\'${ctx}/shop/shop!shopproduct.action?custid=${custid}&agid=${agid}&lscode=${lscode}&pid=' + v[i]._id + '\'">'
                                            +'<img src="${filehttp}'+v[i].logo +'" class="width-10">'
                                            
                                            +'<div class="position-a width-10 bg-hei-8" style="bottom: 0px; right:0px;">'
                                            +'<div class="pull-right zi-bai div-group-5 txt-c zi-bai weight500">'
                                            +'<font size="1"><i class="pr-5">已售:</i>'+v[i].gmnum+'<i class="pl-5">件</i></font>'
                                            +'</div></div></div>'
                                            +'<div class="col-12 div-group-5 zi-6 bg-bai weight500">'
                                            +'<font size="2">';
                                            if('${isAgent}'=='ok'){
                                            xszfright+='<div class="col-9 zi-hong hang30 line-height30">￥'+v[i].price.toFixed(1)+' 提成:'+(v[i].price.toFixed(2)-v[i].dlprice.toFixed(2)).toFixed(1)+'￥</div>';
                                            }else{
                                            xszfright+='<div class="col-9 zi-hong hang30 line-height30">￥'+v[i].price.toFixed(2)+'</div>';
                                            }   
                                            xszfright+='<font size="1">'
                                            +'<div class="col-3 txt-r zi-hong zi-hong pr-5">'
                                            +'<div class="img-wh30 pull-right txt-c bg-hong border-radius50 zi-bai" onclick="showspec('+v[i]._id+',\''+v[i].ptitle+'\',\''+v[i].logo+'\','+v[i].price+','+v[i].num+')"><i class="fa line-height30 fa-1dx fa-shopping-cart"></i></div>'
                                            +'</div></font>'
                                            +'<div class="clear pt-7 pb-3 sl">'+v[i].ptitle+'</div></font>'
                                            +'<font size="1">'
                                            +'<div class="clear zi-hui-tq pb-3 line-height20 weight100 sl">'
                                            +v[i].summary
                                            +'</div></font></div></div>'; 
                          
                                }
                            }
                            fypage++;
                            $('#ajaxdivleft').html(xszfleft);
                            $('#ajaxdivright').html(xszfright);  
                        } else {
                        }
                        $('#loading').hide();
                        issend = true;
                    }, "json")
        }
       
        function fxsel(v) {
            $('#fl_tanchu').hide();
            lx = v;
            fypage = 0;
            $('#ajaxdivleft').html('');
            $('#ajaxdivright').html('');
            ajaxjz();
        }
        function ajaxsel() {
            sel = $('#sel').val().replace('搜索', '');
            fypage = 0;
            $('#ajaxdivleft').html('');
            $('#ajaxdivright').html('');
            ajaxjz();
        }
        var spec='';
        var price=0;
        var pid=-1;
        var speclist='';
        var num=-1;
        var pprice=0;
        function gwc(v,count,id) {

            var submitData = {
                pid: id,
                spec:v,
                count:count,
                price:pprice
            };
            jQuery.post('${ctx}/shop/shop!ajaxshopcarsave.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) { 
                             iosOverlay({ 
        			        text:'加入成功！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/check.png" 
	                     }); 
                        } else { 
                        
                            iosOverlay({ 
        			        text:'加入失败！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     }); 
                        }
                    }, "json");
        }
        function setspec(){ 
        if(num<=0){
          alert('库存已完！');
         return;
        } 
        if(speclist!=''){ 
         if(spec==''){
           alert("请选择规格");
           return;
         }
        }else{ 
         if(spec==''){
         spec="默认";
         }
        } 
       
        var count=$("#quantity").val();
      
         gwc(spec,count,pid);
         gmcs=gmcs-count;
         var pp=$('#spes-price').val();
         if(gmcs>0){
         $("#quantity").val(1);
         $("#totalPrice").html("Y"+parseFloat(pp).toFixed(2)+"元"); 
         }else{
         $("#quantity").val(0);
         $("#totalPrice").html("0元"); 
         }
         hidespec(); 
        }
        function showspec(id,title,logo,price,count){ 
         getgmcs(id);
         pid=id;
         num=count; 
         $('#spes-title').html(title);
         $('#spes-img').css('background-image','url(${filehttp}'+logo+')');
         $('#spes-price').val(price.toFixed(2));
         $("#totalPrice").html("Y"+price.toFixed(2)+"元"); 
         $('#quantity').val(1);
         $('#specs').show();
        }
        function hidespec(){
         $('#specs').hide();
        }
        function getgmcs(id) {

            var submitData = {
                 id:id
            };
            jQuery.post('${ctx}/shop/shop!ajaxrestriction.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
                    function (json) { 
                        if (json.state == 0) {
                            var list=json.list; 
                            var html='';
                            speclist=list;
                              for(var i=0;i<list.length;i++){
                                html+='<li class="pt-10 pr-10 col-3" onclick="setspes(this,\''+list[i].title+'\','+list[i].price+')">'
                                    +'<div class="div3 txt-c zi-hui-wx line-lu border-radius3 hang25 line-height25" >'
                                    +list[i].title
                                    +'</div></li>';
                             
                              } 
                              $('#spes-list').html(html);
                              gmcs=json.value;
                        } else {
                            
                        }
                    }, "json");
        }
        function setspes(v,txt,p){ 
         $(v).addClass("zhiding").siblings().removeClass("zhiding");
         spec=txt; 
          if(p>0){ 
             pprice=p;
             var Num = parseFloat(p)*parseInt($("#quantity").val());  
             $("#totalPrice").html("Y"+Num.toFixed(2)+"元");
             price=Num;
           }
        }
    </script>
    <style>
        .border-radius5s {
            border-radius: 5px 5px 0 0;
        }
        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }
        .bg-zong {
            background: #630601
        }
        .shadow-wai1 {
            box-shadow: 0px 0px 0px rgba(255, 255, 255, .5), /*左边阴影*/ 1px 0px 10px rgba(140, 140, 140, .5), /*右边阴影*/ 0 -1px 5px rgba(140, 140, 140, .5), /*顶部阴影*/ 0 1px 5px rgba(140, 140, 140, .5); /*底边阴影*/
        }
        .line-left-green {
            border-left: 5px solid #ec5254;
        }
        .sc-hong {
            background-color: #ec5254
        }
        .line-height35 {
            line-height: 35px;
        }
        .line-bottom-dddddd {
            border-bottom: 1px solid #dddddd;
        }

        .line-top-dddddd {
            border-top: 1px solid #dddddd;
        }

        .line-left-dddddd {
            border-left: 1px solid #dddddd;
        }

        .line-right-dddddd {
            border-right: 1px solid #dddddd;
        }

        .bg-f5f5f9 {
            background-color: #f5f5f9;
        }

        .zi-6b6b6b {
            color: #6b6b6b
        }

        .line-height22 {
            line-height: 22px;
        }
    </style>
</head>
<body class="cmp640 bg-hui-98 lock">
<main style="position: relative">
 <c:if test="${not empty agent}"> 
     <div class="hang40 overflow-hidden width-10 position-r  bg-hei-8">

        <div class="pull-left img-wh30 position-a" style="top: 5px;left: 10px;">
            <img src="${filehttp}/${agent.headimgurl}" class="width-10 border-radius3">
        </div>
        <div class=" pr-10 width-10" style="padding-left:50px;">
            <font size="2">
                <div class="line-height40 weight500 zi-bai pull-left pr-10">${agent.nickname}的小店</div>
                <div class="pull-right pt-10">
                <font size="1">
                    <div class="hang20 bg-cheng zi-bai border-radius3 pl-5 pr-5"><i
                            class="fa fa-diamond line-height20"></i><i
                            class="pl-3">店铺已认证</i></div></font>
                </div>
                <div class="pull-right pt-10 display-none">
                    <div class="hang20 bj-lan1 zi-bai border-radius3 pl-5 pr-5">询问店主</div>
                </div>
            </font>
        </div>
    </div>
  
 </c:if> 
 
    
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
        <div class="page--index export" style="margin-bottom: -2px">
            <div class="hero-gallery js-flickity pb-5" data-js-module="hero-gallery">
                <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                    <div class="width-10">
                        <div class="overflow-hidden border-radius5"> 
                            <c:forEach items="${typelist}" var="bean" begin="0" end="3">
                                <c:if test="${not empty bean.url}">
                                    <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'">
                                        <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50"style="background-color:#${bean.bgcolor}">
                                            <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                        </div>
                                        <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                                    </div>
                                </c:if>
                                <c:if test="${empty bean.url}">
                                    <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                                        <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                            <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                        </div>
                                        <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <c:if test="${fn:length(typelist)>4}">
                    <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                        <div class="width-10">
                            <div class="overflow-hidden border-radius5">
                                <c:forEach items="${typelist}" var="bean" begin="4" end="7">
                                    <c:if test="${not empty bean.url}">
                                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'">
                                            <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                                <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                            </div>
                                            <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty bean.url}">
                                        <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                                            <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                                <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                            </div>
                                            <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${fn:length(typelist)>8}">
                    <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                        <div class="width-10">
                            <div class="overflow-hidden border-radius5">
                                <c:forEach items="${typelist}" var="bean" begin="8" end="11">
                                    <c:if test="${not empty bean.url}">
                                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'">
                                            <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                                <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                            </div>
                                            <div class="txt-c size14 zi-hei mt-5 width-10">${bean.name}</div>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty bean.url}">
                                        <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                                            <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                                <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                            </div>
                                            <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${fn:length(typelist)>12}">
                    <div class="hero-gallery__cell hero-gallery__cell overflow-hidden">
                        <div class="width-10">
                            <div class="overflow-hidden border-radius5">
                                <c:forEach items="${typelist}" var="bean" begin="12" end="15">
                                    <c:if test="${not empty bean.url}">
                                        <div class="col-3 mt-10" onclick="window.location.href='${bean.url}'">
                                            <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                                <img src="${filehttp }${bean.picurl}" height="100%"></img>
                                            </div>
                                            <div class="txt-c size12 zi-hei mt-5 width-10">${bean.name}</div>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty bean.url}">
                                        <div class="col-3 mt-10" onclick="fxsel('${bean.type}')">
                                            <div class=" maring-a clear img-wh40 zi-bai txt-c overflow-hidden border-radius50" style="background-color:#${bean.bgcolor}">
                                                <img src="${filehttp}${bean.picurl}" height="100%"></img>
                                            </div>
                                            <div class="txt-c size14 zi-hei mt-5 width-10">${bean.name}</div>
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
    <div id="ajaxtg">
    </div>
    <font size="2">
        <div class="div-group-5 pt-5 pb-5 bg-hui-tx position-r">
            <div class="line-left-green"><i class="pl-10">推荐商品</i></div>
            <div class="position-a overflow-hidden"style="left:80px;top:0px;height:37px;line-height:37px;">
                <c:if test="${not empty roll}">
                    <%@ include file="/webcom/roll.jsp" %>
                </c:if>
            </div>
        </div>
    </font>
   
    <div class="line-top-2">
        <div class="col-6 line-right-1 line-left-1" id="ajaxdivright">
        </div>
        <div class="col-6 line-right-1 line-left-1"  id="ajaxdivleft">
        </div>
       
    </div>
    <div class="width-10 txt-c zi-hui-wx div-group-10 display-none clear" id="loading">
        <i class="fa fa-spinner fa-1dx fa-spin2"></i>
    </div>
    <%@include file="/webcom/foot.jsp" %>
    <div class="hang40"></div>
</main>
<%@include file="/webcom/return-top.jsp" %>
<div class="hang50 clear"></div>
<%@ include file="/webcom/shop-foot.jsp" %>
<%@ include file="/webcom/shop-spec3.jsp" %>  
<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&agid=${agid}&&lscode=${lscode}', submitData,

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
    ajaxjz();
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {
            ajaxjz();
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


<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}"> 
  <%@ include file="/webcom/focus-page1.jsp" %>
    
 </c:if>
</c:if>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if> 
<!--客服-->
    <div class="position-f img-wh35 txt-c bj-lan1 zi-bai border-radius50"style="bottom:60px; right: 3px;" onclick="window.location.href='${ctx}/android/reply!index.action?custid=${custid}&lscode=${lscode}&id=${entity._id}'">
        <i class="fa fa-commenting"style="line-height: 35px;"></i>
    </div>
<!--客服结束--> 
</body>
</html> 