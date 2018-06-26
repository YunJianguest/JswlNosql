<%@ page contentType="text/html;charset=UTF-8"%>
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
    <title>注 册</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/> 
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <style>

        .hang66 {
            height: 66px;;
        }

        .width1180 {
            width: 1180px;;
        }

        .width100px {
            width: 100px;
            height: 35px;
            line-height: 35px;
        }

        .shadow-wai1 {
            -webkit-box-shadow: 0 0 5px rgba(140, 140, 140, .5);
            -moz-box-shadow: 0 0 5px rgba(140, 140, 140, .5);
            box-shadow: 0 0 5px rgba(140, 140, 140, .5);
        }

        .color {
            width: 120px;
            height: 40px;
            line-height: 45px;
            color: #717171;
        }

        .btn-d {
            background-color: #26a9e1;
        }

        .btn-d:hover {
            border: solid 2px #26a9e1;
            background-color: #ffffff;
            color: #26a9e1;
            line-height: 31px;
        }

        .btn-t {
            border: solid 2px #26a9e1;
            color: #26a9e1;
        }

        .btn-t:hover {
            background-color: #26a9e1;
            color: #ffffff;
        }

        .btn-tb {
            border: solid 1px #ccc;
            color: #666666;
        }

        .btn-tb:hover {
            border: solid 1px #26a9e1;
            background-color: #26a9e1;
            color: #ffffff;
        }
    </style>
</head>
<body class="cmp640">
 
<div class="maring-a overflow-hidden clear" style="width: 300px;margin-top:120px;">

    <div class="line-lu overflow-hidden border-radius3">
        <font size="2">
            <a href="#">
                <input class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;" type="text"
                      placeholder="请输入邮箱" id="username"  
                       >
            </a>
        </font>
    </div>

    <div class="line-lu overflow-hidden border-radius3 mt-35">
        <font size="2">
            <a href="#">
                <label>
                  <input class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;" type="password"
                           id="password" name="password" class="txt_input"
                           placeholder="请输入密码" >
                </label>
            </a>
        </font>
    </div> 
    <a href="javascript:register()">
        <div class="txt-c mt-40 border-radius3 weight500 zi-bai btn-d" style="line-height:42px;height:42px;">
            <font class="size3">
                确认注册
            </font>
        </div>
    </a>

    
    

</div>


</body>
<script>
 function  register(){
         if(CheckMail($('#username').val())&&Checkmima($('#password').val())){
           var submitData = {
    	        name:$('#username').val(),
    	        password:$('#password').val() 
	            };  
       $.post('${ctx}/user/fromuser!ajaxregister.action?toUser=${toUser}&custid=${custid}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){ 
        	    window.location.href='${ctx}/user/fromuser!UserDetail.action?custid=${custid}&fromUserid='+json.value;  
        	   }else if(json.state==2){
        	    alert("用户名已存在");
        	  }
        	  
        	 },"json");
     
         
         };
       
     
    }
function CheckMail(mail) { 
 var filter  =/^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$/;
 if (filter.test(mail)) return true;
 else {
 alert('您的电子邮件格式不正确');
 return false;}
}
function Checkmima(password){
var pa=/[0-9|A-Z|a-z]{6,16}/;
if(pa.test(password)){
return true;
}else{
 alert('您输入的密码不规范，请输入，6-16位的字母或数字');
return false;
}
}
</script>
</html>