
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>${entity.title }</title>
    <meta name="author" content="Alvaro Trigo Lopez"/>
    <meta name="description" content="fullPage full-screen sliders navigation widh dots."/>
    <meta name="keywords"
          content="fullpage,jquery,demo,screen,fullscreen,sliders navigation, horizontal navigation,horizontal,navigation,dots"/>
    <meta name="Resource-type" content="Document"/>
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
          name="viewport">

    <link href="${ctx }/scene/css/cmp_common_603.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/scene/css/style_0.css" rel="stylesheet">
    <link href="${ctx }/scene/css/wbs-css.css" rel="stylesheet" type="text/css">
    <link href="${ctx }/scene/css/font-awesome.min.css" rel="stylesheet"> 
    <link rel="stylesheet" type="text/css" href="${ctx }/scene/css/examples.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/scene/css/jquery.fullPage.css"/>
    <script src="${ctx }/scene/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${ctx }/scene/js/jquery.fullPage.js"></script>
    <link href="${ctx}/animo/animate-animo.css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/animo/animo.js"></script>
    <style>
        h1 {

            font-family: arial, helvetica;
            color: #fff;
            margin: 0;
        }

        .intro p {
            color: #fff;
        }

        .section {
            text-align: center;
        }

        #infoMenu li a {
            color: #fff;
        }

        #section2 h1 {
            color: #333;
        }

        .zi-jin2 {
            color: #c9b902;
        }

        .btn-hei-5 {
            background-color: rgba(30, 30, 30, 0.5);
        }

        .btn-hei-5:hover {
            background-color: rgba(30, 30, 30, 0.7);
        }

        .btn-hei-5:active {
            background-color: rgba(30, 30, 30, 0.7);
        }

        .btn-hei-8 {
            background-color: rgba(30, 30, 30, 0.9);
        }

        .btn-hei-8:hover {
            background-color: rgba(30, 30, 30, 0.9);
        }

        .btn-hei-8:active {
            background-color: rgba(30, 30, 30, 0.9);
        }
    </style>

    <script type="text/javascript">
    
        $(function () {
            $('#fullpage').fullpage({

                slidesNavigation: true,
                scrollingSpeed: 3000,
                afterLoad: function(anchorLink, index){
                 
      
                  <c:forEach items="${animalist}" var="list">
   var id='${list}';
   if($('#'+id).attr('animo_value').indexOf('spinner')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'), iterate: $('#'+id).attr('animo_iterate'),duration:$('#'+id).attr('animo_duration')});
 
   }
   if($('#'+id).attr('animo_value').indexOf('flip')==0){
    if($('#'+id).attr('animo_keep')==0){
        $('#'+id).animo({animation:$('#'+id).attr('animo_value'), keep:false});
      }else{
       $('#'+id).animo({animation:$('#'+id).attr('animo_value'), keep:true});
      }
   }
   
    if($('#'+id).attr('animo_value').indexOf('fade')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'), keep:$('#'+id).attr('animo_keep'),duration:$('#'+id).attr('animo_duration')});
 
   }
    
   if($('#'+id).attr('animo_value').indexOf('rotate')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'), degrees:$('#'+id).attr('animo_degrees')});
 
   }
   if($('#'+id).attr('animo_value').indexOf('bounce')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'),duration:$('#'+id).attr('animo_duration')});
 
   }
   if($('#'+id).attr('animo_value').indexOf('tada')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'),duration:$('#'+id).attr('animo_duration')});
 
   }
   </c:forEach>
                
                },
                afterSlideLoad: function (anchorLink, index, slideIndex, direction) {
                
                    if (index == 1 && direction == length) {

                    }
                }
            });
            setInterval(function () {
                $.fn.fullpage.moveSlideRight();
            }, 3000);

        });
        function startAnimation(v) {

            if (2 == 2) {
                $('#fullpage').fullpage({
                    slidesNavigation: true,
                    scrollingSpeed: 3000,
                    afterSlideLoad: function (anchorLink, index, slideIndex, direction) {
                        if (index == 1 && direction == length) {
                            alert(direction);
                            alert(length);
                        }
                    }
                });
                setInterval(function () {
                    $.fn.fullpage.moveSlideRight();
                }, 3000);
            } else {
                $('#fullpage').fullpage({

                    slidesNavigation: true,
                    scrollingSpeed: 3000,
                });
            }
        }
    </script>

</head>
<body>

<div id="fullpage" class="cmp640">
    <c:if test="${not empty scenelist}">
      <c:forEach  items="${scenelist}" var="bean"> 
         <div class="section" style="background-image:url(${osshttp}/${bean.picurl}); background-size:100% auto">
            <c:if test="${not empty bean.spritlist}">
            <c:forEach items="${bean.spritlist}" var="beanchild">
             <c:if test="${beanchild.type=='1'}">
             <a href="${beanchild.url}"> 
             <div style="float:left; background-color:#${beanchild.style.color};width:48.5%;height:${beanchild.style.height}px;
              margin-left:1%;border-radius:${beanchild.style.radius}px;
              background-image:url(${osshttp}/${beanchild.picurl}); background-size:100% auto"
               animo_value="${beanchild.anima.value}" animo_time="${beanchild.anima.duration}" animo_iterate="${beanchild.anima.iterate}"
               animo_duration="${beanchild.anima.duration}" animo_keep="${beanchild.anima.keep}"  id="${beanchild.anima._id}"
               style_margin_top="${beanchild.style.margintop}">${beanchild.title}</div>
             </a>
             
             </c:if>
             <c:if test="${beanchild.type=='0'}">
             <a href="${beanchild.url}"> 
             <div style="background-color:#${beanchild.style.color};width:${beanchild.style.width}px;height:${beanchild.style.height}px;
              margin-left:${beanchild.style.marginleft}%; margin-top:${beanchild.style.margintop}px;border-radius:${beanchild.style.radius}px;
              z-index:${beanchild.sort };position:absolute;background-image:url(${osshttp}/${beanchild.picurl}); background-size:100% auto"
               animo_value="${beanchild.anima.value}" animo_time="${beanchild.anima.duration}" animo_iterate="${beanchild.anima.iterate}"
               animo_duration="${beanchild.anima.duration}" animo_keep="${beanchild.anima.keep}"  id="${beanchild.anima._id}"
               style_margin_top="${beanchild.style.margintop}">${beanchild.title}</div>
             </a>
              </c:if>
            </c:forEach>
           </c:if>
           
       </div>
      </c:forEach>
    </c:if>
   

</div>
<c:if test="${not empty entity.mp3}">
<!--献花button与音乐button-->
<div class="position-f cmp640" style="top:0px; left:0px;z-index:1111"> 
    <!--音乐播放器-->
    <a href="javascript:bf();" class="mscBtn" id="audioBtn" style="cursor:pointer;">
        <div id="bfid"  style="margin-left:${mp3.marginleft}%;margin-top:${mp3.margintop}%;color:#${mp3.color}">
            <span class="fa-stack fa-lg">
                <i class="fa fa-circle-o fa-stack-2x fa-spin"></i>
                <i class="fa fa-music fa-stack-1x fa-spin pr-5"></i>
            </span>
        </div>
    </a>
</div>
 
<!--评论button3 自适应-->
  
</div>

<audio id="bgMusic" src="${entity.mp3 }" autoplay="autoplay"></audio>

<!--音乐播放js-->
<script>
    var music = document.getElementById("bgMusic");
    $("#audioBtn").click(function () {
        if (music.paused) {
            music.play();
            $("#audioBtn").removeClass("pause").addClass("play");
        } else {
            music.pause();
            $("#audioBtn").removeClass("play").addClass("pause");
        }
    });
</script>
</c:if>
<script>
    var isplay = false;
    function bf() {
        if (!isplay) {
            $("#bfid span i").removeClass("fa-spin");
            isplay = true;
        } else {
            $("#bfid span i").addClass("fa-spin");
            isplay = false;
        }
    }
</script>
<!--结束-->

<!--数字现实加一-->
<script type="text/javascript">
    (function ($) {
        $.extend({
            tipsBox: function (options) {
                options = $.extend({
                    obj: null,  //jq对象，要在那个html标签上显示
                    str: "+1",  //字符串，要显示的内容;也可以传一段html，如: "<b style='font-family:Microsoft YaHei;'>+1</b>"
                    startSize: "12px",  //动画开始的文字大小
                    endSize: "30px",    //动画结束的文字大小
                    interval: 600,  //动画时间间隔
                    color: "red",    //文字颜色
                    callback: function () { }    //回调函数
                }, options);
                $("body").append("<span class='num'>" + options.str + "</span>");
                var box = $(".num");
                var left = options.obj.offset().left + options.obj.width() / 2;
                var top = options.obj.offset().top - options.obj.height();
                box.css({
                    "position": "absolute",
                    "left": left + "px",
                    "top": top + "px",
                    "z-index": 9999,
                    "font-size": options.startSize,
                    "line-height": options.endSize,
                    "color": options.color
                });
                box.animate({
                    "font-size": options.endSize,
                    "opacity": "0",
                    "top": top - parseInt(options.endSize) + "px"
                }, options.interval, function () {
                    box.remove();
                    options.callback();
                });
            }
        });
    })(jQuery);

    function niceIn(prop){
        prop.find('i').addClass('niceIn');
        setTimeout(function(){
            prop.find('i').removeClass('niceIn');
        },1000);
    }
    $(function () {
        $("#ggio").click(function () {
            $.tipsBox({
                obj: $(this),
                str: "+1",
                callback: function () {
                }
            });
            niceIn($(this));
        });
    });
</script>
<script type="text/javascript"> 
 var  bgheight=document.body.clientHeight;
</script>
<script type="text/javascript">

$(function(){  
   <c:forEach items="${animalist}" var="list">
   var id='${list}'; 
   //alert(bgheight);
   //alert($('#'+id).attr('style_margin_top')+'px');
   // $('#'+id).attr('margin-top',$('#'+id).attr('style_margin_top')*bgheight/100+'px');
   if($('#'+id).attr('animo_value').indexOf('spinner')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'), iterate: $('#'+id).attr('animo_iterate'),duration:$('#'+id).attr('animo_duration')});
 
   }
   if($('#'+id).attr('animo_value').indexOf('flip')==0){ 
      if($('#'+id).attr('animo_keep')==0){
        $('#'+id).animo({animation:$('#'+id).attr('animo_value'), keep:false});
      }else{
       $('#'+id).animo({animation:$('#'+id).attr('animo_value'), keep:true});
      }
    
   }
   
    if($('#'+id).attr('animo_value').indexOf('fade')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'), keep:$('#'+id).attr('animo_keep'),duration:$('#'+id).attr('animo_duration')});
 
   }
    
   if($('#'+id).attr('animo_value').indexOf('rotate')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'), degrees:$('#'+id).attr('animo_degrees')});
 
   }
   if($('#'+id).attr('animo_value').indexOf('bounce')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'),duration:$('#'+id).attr('animo_duration')});
 
   }
   if($('#'+id).attr('animo_value').indexOf('tada')==0){
    $('#'+id).animo({animation:$('#'+id).attr('animo_value'),duration:$('#'+id).attr('animo_duration')});
 
   }
   </c:forEach>
    
    
    
    
    
  // $('.fp-tableCell').each(function(i,n){
       
    //  $(n).children().each(function(v,r){
    //  alert($(r).attr('animo_value'));
    //  });
     
   //  $(this).children().animo({animation:$(this).attr('animo_value'), iterate: $(this).attr('animo_iterate')});
   
  // $('#audioBtn').animo("fadeOutUp", { duration: 1});
  //});
 
});
 


</script>
</body>
</html>