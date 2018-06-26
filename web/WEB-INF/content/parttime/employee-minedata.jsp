<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>信息录取</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .btn-26bd93 {
            background-color: #26bd93;
        }

        .btn-26bd93:hover {
            background-color: #21a883;
        }
    </style>
    <script>
    function ajaxsave(){
    	   var submitData = { 
    			  tel:$('#tel').val(), 
    			  name:$('#name').val(), 
    			  idcard:$('#idcard').val(), 
    			  wxid:$('#wxid').val(), 
    			  tel:$('#tel').val(),  
    	  };
    	  $.post('${ctx}/parttime/mission!ajaxSaveMine.action?custid=${custid}&lscode=${lscode}', submitData, function(json) { 
    	   if(json.state==0){
    		   alert('修改成功');
    		   
    	   }else{
    		   alert('修改失败');
    	   }
    	  }, "json")
    	  ps_show('inszc');
    	}
    </script>
</head>
<body class="cmp640">
<main>
    <!--必填否则无法领取佣金薪水-->
    <div class="line-bottom overflow-hidden weight500 pl-10 pr-10">
        <div class="pull-left hang50 line-height50 zi-6">
            真实姓名<i class="zi-hui weight100 pl-5 size10">(必填)</i>
        </div>
        <div class=" pull-right hang50">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="name"
                   value="${entity.name}"
                   onfocus="if(this.value=='${entity.name}'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='${entity.name}'){this.value='${entity.name}';this.style.color='#aaa';}"/>
        </div>
    </div>

    <div class="line-bottom overflow-hidden weight500 pl-10 pr-10">
        <div class="pull-left hang50 line-height50 zi-6">
            手机号<i class="zi-hui weight100 pl-5 size10">(必填)</i>
        </div>
        <div class=" pull-right hang50">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="tel"
                   value="${entity.tel}"
                   onfocus="if(this.value=='${entity.tel}'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='${entity.tel}'){this.value='${entity.idcard}';this.style.color='#aaa';}"/>
        </div>
    </div>

    <div class="overflow-hidden weight500 pl-10 pr-10">
        <div class="pull-left hang50 line-height50 zi-6">
            身份证号码<i class="zi-hui weight100 pl-5 size10">(必填)</i>
        </div>
        <div class=" pull-right hang50">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="idcard"
                   value="${entity.idcard}"
                   onfocus="if(this.value=='${entity.idcard}'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='${entity.idcard}'){this.value='${entity.idcard}';this.style.color='#aaa';}"/>
        </div>
    </div>

    <div class="hang10 bg-hui-92"></div>

    <div class="line-bottom overflow-hidden weight500">
        <div class="pull-left pl-10 hang50 line-height50 zi-6">
            微信帐号<i class="zi-hui weight100 pl-5 size10">(选填)</i>
        </div>
        <div class=" pull-right hang50 pr-10">
            <input class="width-10 size12 txt-r zi-hui weight500 hang50 line-height50" type="text" id="wxid"
                   value="${entity.wxid}"
                   onfocus="if(this.value=='${entity.wxid}'){this.value=''};this.style.color='#666666';"
                   onblur="if(this.value==''||this.value=='${entity.wxid}'){this.value='${entity.wxid}';this.style.color='#aaa';}"/>
        </div>
    </div> 
    <div class="clear mt-30" onclick="ajaxsave()">
         <div class="width-9_5 maring-a btn-26bd93 zi-bai div-group-10 maring-a size14 txt-c weight500 border-radius3 lock">
                完成
         </div>
    </div> 
</main>
<%@include file="/webcom/mission-foot.jsp"%>
</body>
</html>