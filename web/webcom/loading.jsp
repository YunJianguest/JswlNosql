<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<main class="cmp640">
<!--页面加载时的页面开始-->
 <div class="fullscreen cmp640 bg-hei-8 display-none" id="tanchu">
     <div class="txt-c zi-lan-tq position-r img1">
          <div class="position-a width-10" style="top:40%">
                <i class="fa fa-refresh fa-spin05 fa-1dx"></i>
                <div class="pt-10">
                    您查看的页面正在赶来的途中...
                </div>
          </div>
     </div>
 </div>
<!--页面加载时的页面结束-->
</main>
 
<script>
        function loadinghide() {
            $('#tanchu').hide();
        }
        function loadingshow() {
            $('#tanchu').show();
        }
</script>
    <style>
        .bg-bai-3 {
            background-color: rgba(225, 225, 225, 0.3);
        }
        .fa-spin05 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }
    </style>
<script type="text/javascript">
    <!--
    var winWidth = 0;
    var winHeight = 0;
    function findDimensions() //函数：获取尺寸
    {
//获取窗口宽度
        if (window.innerWidth)
            winWidth = window.innerWidth;
        else if ((document.body) && (document.body.clientWidth))
            winWidth = document.body.clientWidth;
//获取窗口高度
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
//通过深入Document内部对body进行检测，获取窗口大小
        if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
            winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
        }
 
    }
    findDimensions();
    //调用函数，获取数值
    window.onresize = findDimensions;
    //-->
</script>
<script>
    $(".img1").css("height", winHeight + "px");
</script>
 