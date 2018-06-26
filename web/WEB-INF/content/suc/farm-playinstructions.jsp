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
    <title>玩法说明</title>
   <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>  
    
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <style>
        .hdbtx {
            border-radius: 0 50px 0 50px;
            background-color: #ce3535;
            width: 25%;
        }
    </style>
    <script>
    function  show_hdxx(){
      $('.hdxx').show();
      $('.wfsm').hide();
      $('.jxsz').hide();
      $('.hdxx_img').find('img').attr('src','${ctx}/img/farm/hdxx2.png');
      $('.wfsm_img').find('img').attr('src','${ctx}/img/farm/wfsm1.png');
      $('.jxsz_img').find('img').attr('src','${ctx}/img/farm/jpsz1.png'); 
      
    }
    function  show_wfsm(){
       $('.hdxx').hide();
       $('.wfsm').show();
       $('.jxsz').hide();
       $('.hdxx_img').find('img').attr('src','${ctx}/img/farm/hdxx1.png');
       $('.wfsm_img').find('img').attr('src','${ctx}/img/farm/wfsm2.png');
       $('.jxsz_img').find('img').attr('src','${ctx}/img/farm/jpsz1.png');
    }
    function  show_jxsz(){
        $('.hdxx').hide();
        $('.wfsm').hide();
        $('.jxsz').show();
        $('.hdxx_img').find('img').attr('src','${ctx}/img/farm/hdxx1.png');
        $('.wfsm_img').find('img').attr('src','${ctx}/img/farm/wfsm1.png');
        $('.jxsz_img').find('img').attr('src','${ctx}/img/farm/jpsz2.png');
    }
    </script>
</head>
<body class="lock" style="background-color: #8eb936;">
<main class="cmp640">
    <div class="width-10 position-r">
        <img class="width-10" src="${ctx}/img/farm/wfsm-banner.png">
    </div>
    <div class="width-9_5 pt-15 pb-10 overflow-hidden clear maring-a">
        <div class="col-4">
            <div class="width-9 maring-a hdxx_img" onclick="show_hdxx()">
                <img src="${ctx}/img/farm/hdxx2.png" class="width-10"> 
            </div>
        </div>
        <div class="col-4">
            <div class="width-9 maring-a wfsm_img" onclick="show_wfsm()">
                <img src="${ctx}/img/farm/wfsm1.png" class="width-10"> 
            </div>
        </div>
        <div class="col-4">
            <div class="width-9 maring-a jxsz_img" onclick="show_jxsz()">
                <img src="${ctx}/img/farm/jpsz1.png" class="width-10"> 
            </div>
        </div>
    </div>
    <div class="width-9_5 maring-a div-group-10 pt-20 border-radius5 bg-bai overflow-auto zi-hui-wx"
         style="height: 260px;">

        <!--每个A标签里面包含的信息都是一个单独的使用点击上方图片切换-->
       
          <!--活动信息-->
        <div class="hang20 line-height20 zi-bai txt-c hdbtx hdxx"><font size="1">活动时间</font>
        </div>
        <div class="hang30 mt-10 mb-10 line-height30 zi-hui-wx hdxx">
            <fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${entity.startdate}'/> 至 <fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${entity.enddate}'/>
        </div>

        <div class="hang20 line-height20 zi-bai txt-c hdbtx hdxx"><font size="1">兑换时间</font>
        </div>
        <div class="hang30 mt-10 mb-10 line-height30 zi-hui-wx hdxx">
            <fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${entity.startdjdate}'/> 至 <fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${entity.enddjdate}'/>
        </div>
        <c:if test="${not empty entity.sponsors}">
         <div class="hang20 line-height20 zi-bai txt-c hdbtx hdxx" ><font size="1">赞助商</font>
         </div>
         <div class="hang30 mt-10 mb-10 line-height30 zi-hui-wx hdxx">
            ${entity.sponsors}
         </div>
        </c:if>
        <c:if test="${not empty entity.operators }">
        <div class="hang20 line-height20 zi-bai txt-c hdbtx hdxx"><font size="1">运营单位</font>
        </div>
        <div class="hang30 mt-10 mb-10 line-height30 zi-hui-wx hdxx">
              ${entity.operators }
        </div>
        </c:if>
        
        <!--玩法说明-->
        <div class="hang20 line-height20 zi-bai txt-c hdbtx wfsm"><font size="1">玩法说明</font>
        </div>
        <div class=" mt-10 mb-10 line-height20 zi-hui-wx wfsm">
            ${entity.content}
           
        </div>
 
        <div class="hang20 line-height20 zi-bai txt-c hdbtx clear jxsz"><font size="1">奖项设置</font>
        </div>
        <div class=" mt-15 mb-15 line-height20 zi-hui-wx jxsz">
             ${entity.awardsshow}
        </div>
 

    </div>
</main>

<script> 
show_hdxx(); 
</script>
</body>
</html>