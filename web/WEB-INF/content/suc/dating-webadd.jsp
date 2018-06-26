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
    <title>资料修改</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script> 
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css"/>
    <!--App自定义的css--> 
    <link href="${ctx}/mvccol/mui-css/mui.picker.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/>
    
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <script>
    
         var total=0;
         var remoney=0;
         var jfdh=0;
         var loading;
          function  loading(){
        var opts = {
		lines: 13, // The number of lines to draw
		length: 6, // The length of each line
		width: 3, // The line thickness
		radius: 8, // The radius of the inner circle
		corners: 1, // Corner roundness (0..1)
		rotate: 0, // The rotation offset
		color: '#FFF', // #rgb or #rrggbb
		speed: 1, // Rounds per second
		trail: 60, // Afterglow percentage
		shadow: false, // Whether to render a shadow
		hwaccel: false, // Whether to use hardware acceleration
		className: 'spinner', // The CSS class to assign to the spinner
		zIndex: 2e9, // The z-index (defaults to 2000000000)
		top: 'auto', // Top position relative to parent in px
		left: 'auto' // Left position relative to parent in px
	}; 
	   var target = document.createElement("div");
	   document.body.appendChild(target);
	   var spinner = new Spinner(opts).spin(target);
	  loading=iosOverlay({
		text: "加载中", 
		spinner: spinner
	   });
     }
    
        var u_city='${entity.city}';
        var u_concept='';
        var u_constellation='';
        var u_firstmeet='';
        var u_height='';
        var u_income='';
        var u_likeDatingSite=''; 
        var u_weight=''; 
        var u_record=''; 
        var u_purpose='';
        var u_province='${entity.province}';
        var u_professional='';
        var u_marriage=''; 
        var u_birthday='';
        var u_county='${entity.county}';
        var u_qqState='';
        var u_wxState='';
        var u_telState='';
        var u_age='${entity.age}';
        var u_sex='${entity.sex}';
        function submit(){  
		   var u_nickname=$('#nickname').val().replace('${user.nickname}','');
		   var u_tel=$('#tel').val().replace('请填写你的手机号',''); 
           var u_qq=$('#qq').val().replace('请填写你的QQ','');
           var u_wx=$('#wx').val().replace('请填写你的微信号',''); 
		   if(u_nickname==''){
		      u_nickname='';
		   }
		   if(u_sex==''){
		    alert('请选择性别');
		    return;
		   }
		   if(u_age==''){
		    alert('请选择年龄');
		    return;
		   }
		   if(u_province==''){
		    alert('请选择地址');
		    return;
		   }
		  
		   if(u_tel!=''){
		       var regu = /^[1][0-9]{10}$/;
               var re = new RegExp(regu);
               if (!re.test(u_tel)) {
               alert("请输入正确手机号码");
              return
             }  
		   }
		   var submitData = {
    	         nickname:u_nickname,
    	         age:u_age,
    	         province:u_province,
    	         city:u_city,
    	         county:u_county,
    	         birthday:u_birthday,
    	         marriage:u_marriage,
    	         professional:u_professional,
    	         purpose:u_purpose,
    	         qq:u_qq,
    	         record:u_record,
    	         tel:u_tel,
    	         weight:u_weight,
    	         wx:u_wx,
    	         likeDatingSite:u_likeDatingSite,
    	         income:u_income,
    	         height:u_height,
    	         firstmeet:u_firstmeet,
    	         constellation:u_constellation,
    	         concept:u_concept,
    	         telState:u_telState,
    	         wxState:u_wxState,
    	         qqState:u_qqState,
    	         sex:u_sex 
	            }; 
		$.post('${ctx}/suc/dating!ajaxwebadd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){ 
        	  if(json.state==0){
        	     if($('#headimgurl').val().length>0){
        	          $.post('${ctx}/suc/dating!updateHeadimg.action?custid=${custid}&lscode=${lscode}', {picurl:$('#headimgurl').val()},
        	 
        	         function(json){ 
        	          if(json.state==0){ 
        	            alert('保存信息成功！请等待头像审核');
        	           window.location.href='${ctx}/suc/dating!personalcenter.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}';
        	        }else{ 
        	          alert('保存信息成功！头像上传异常！');
        	        }
        	      },"json");
        	     }else{
        	     alert('保存信息成功！');
        	     } 
        	     window.location.href='${ctx}/suc/dating!personalcenter.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}';
        	  }else{ 
        	   alert('保存信息失败！');
        	  }
        	 },"json");
        	 
    }
    </script>
    <style>
        .zi-fa82a5 {
            color: #fa82a5;
        }
         .zi-9b9b9b {
            color: #9b9b9b;
        }
        .bottom-fa82a5 {
            background-color: rgba(234, 100, 131, 0.7);
        }
        .bottom-fa82a5:hover, .bottom-fa82a5:focus {
            background-color: rgba(234, 100, 131, 0.8);
        }
    </style>
</head>
<body class="lock" style="background-color: #f0f0f0">
<main class="cmp640"> 
<input  id="headimgurl"  type="hidden"/>
    <c:if test="${empty entity}">
         <!--内容-->
    <div class="width-9_5 maring-a">

        <div class="width-9 maring-a pt-20 pb-50">
            <img class="width-10" src="${ctx}/img/dating/data.png">
        </div>

        <div class="bg-bai border-radius5 position-r">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="position-a width-10" style="top: -40px;" onclick="pz('headimgurl','200','200',false,'logo')">
                <div class="img-wh80 border-radius50 overflow-hidden "
                     style=" margin:0px auto 0px auto;border: solid 3px #ffffff;" id="logo">
                    <img src="${filehttp}/${user.headimgurl}" class="width-10">
                </div>
            </div>
            <div class="hang40 clear"></div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    昵称
                </div>
                
                <div class="pull-right line-height40 pt-3">

                    <input class="zi-fa82a5 txt-r" style="background-color: transparent;height:35px;line-height:35px;"
                           type="text" 
                           id="nickname"
                           value="${user.nickname}"
                           onfocus="if(this.value=='请填写你的昵称'){this.value=''};this.style.color='#9b9b9b';"
                           onblur="if(this.value==''||this.value=='请填写你的昵称'){this.value='请填写你的昵称';this.style.color='#fa82a5';}">
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    性别
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_sex_button">
                        <i class="zi-fa82a5" id="setting_sex">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    年龄
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_age_button">
                        <i class="zi-fa82a5" id="setting_age">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    所在地
                </div>
                <div class="pull-right" id="showCityPicker3">
                    <div class="pull-left line-height40">
                        <i class="zi-fa82a5" id="province">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                    <div class="pull-left pl-10 line-height40">
                        <i class="zi-fa82a5" id="city">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                    <div class="pull-left pl-10 line-height40">
                        <i class="zi-fa82a5" id="county">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="width-9 maring-a pt-10 pb-10">
            <img class="width-10" src="${ctx}/img/dating/contact.png">
        </div>

        <div class="bg-bai border-radius5">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    QQ：<input class="zi-fa82a5 txt-l"
                              style="background-color: transparent;height:35px;line-height:35px;" type="text"
                              id="qq"
                              value="请填写你的QQ"
                              onfocus="if(this.value=='请填写你的QQ'){this.value=''};this.style.color='#9b9b9b';"
                              onblur="if(this.value==''||this.value=='请填写你的QQ'){this.value='请填写你的QQ';this.style.color='#fa82a5';}">
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_qq_button">
                        <i class="zi-fa82a5" id="setting_qq">公开</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    手机：<input class="zi-fa82a5 txt-l"
                              style="background-color: transparent;height:35px;line-height:35px;" type="text"
                              id="tel"
                              value="请填写你的手机号"
                              onfocus="if(this.value=='请填写你的手机号'){this.value=''};this.style.color='#9b9b9b';"
                              onblur="if(this.value==''||this.value=='请填写你的手机号'){this.value='请填写你的手机号';this.style.color='#fa82a5';}">
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_tel_button">
                        <i class="zi-fa82a5" id="setting_tel">公开</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    微信号：<input class="zi-fa82a5 txt-l"
                               style="background-color: transparent;height:35px;line-height:35px;" type="text"
                               id="wx"
                               value="请填写你的微信号"
                               onfocus="if(this.value=='请填写你的微信号'){this.value=''};this.style.color='#9b9b9b';"
                               onblur="if(this.value==''||this.value=='请填写你的微信号'){this.value='请填写你的微信号';this.style.color='#fa82a5';}">
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_wx_button">
                        <i class="zi-fa82a5" id="setting_wx">公开</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

        </div>


        <div class="width-9 maring-a pt-10 pb-10">
            <img class="width-10" src="${ctx}/img/dating/details.png">
        </div>

        <div class="bg-bai border-radius5">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    交友目的
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_purpose_button">
                        <i class="zi-fa82a5" id="setting_purpose">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    恋爱观念
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_concept_button">
                        <i class="zi-fa82a5" id="setting_concept">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    首次见面
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_firstmeet_button">
                        <i class="zi-fa82a5" id="setting_firstmeet">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    喜欢约会的地点
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_likeDatingSite_button">
                        <i class="zi-fa82a5" id="setting_likeDatingSite">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-bai border-radius5 mt-10">
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    身高
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_height_button">
                        <i class="zi-fa82a5" id="setting_height">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    婚姻状况
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_marriage_button">
                        <i class="zi-fa82a5" id="setting_marriage">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    收入范围
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_income_button">
                        <i class="zi-fa82a5" id="setting_income">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    学历
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_record_button">
                        <i class="zi-fa82a5" id="setting_record">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-bai border-radius5 mt-10">

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    职业
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_professional_button">
                        <i class="zi-fa82a5" id="setting_professional">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    体重
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_weight_button">
                        <i class="zi-fa82a5" id="setting_weight">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    星座
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_constellation_button">
                        <i class="zi-fa82a5" id="setting_constellation">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    生日
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40 " data-options='{"type":"date","beginYear":1940,"endYear":2020}' id="setting_birthday_button"> 
                        <i  class="zi-fa82a5" id="setting_birthday">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
        </div>

    </div>       
    </c:if>
    <c:if test="${not empty entity}">
         <!--内容-->
     <div class="width-9_5 maring-a">

        <div class="width-9 maring-a pt-20 pb-50">
            <img class="width-10" src="${ctx}/img/dating/data.png">
        </div>

        <div class="bg-bai border-radius5 position-r">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="position-a width-10" style="top: -40px;" onclick="pz('headimgurl','200','200',false,'logo')" >
                <div class="img-wh80 border-radius50 overflow-hidden "
                     style=" margin:0px auto 0px auto;border: solid 3px #ffffff;" id="logo">
                    <img src="${filehttp}/${entity.headimgurl}" class="width-10">
                </div>
            </div>
            <div class="hang40 clear"></div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    昵称
                </div>
                
                <div class="pull-right line-height40 pt-3">

                    <input class="zi-fa82a5 txt-r zi-9b9b9b" style="background-color: transparent;height:35px;line-height:35px;"
                           type="text" 
                           id="nickname"
                           value="${entity.nickname}"
                           onfocus="if(this.value=='请填写你的昵称'){this.value=''};this.style.color='#9b9b9b';"
                           onblur="if(this.value==''||this.value=='请填写你的昵称'){this.value='请填写你的昵称';this.style.color='#fa82a5';}">
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    性别
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_sex_button">
                        <i class="zi-9b9b9b" id="setting_sex"><c:if test="${entity.sex==1}">男</c:if><c:if test="${entity.sex==2}">女</c:if><c:if test="${entity.sex==0}">未知</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    年龄
                </div>
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_age_button">
                        <i class="zi-9b9b9b" id="setting_age">${entity.age}岁</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    所在地
                </div>
                <div class="pull-right" id="showCityPicker3">
                    <div class="pull-left line-height40">
                        <i class="zi-9b9b9b" id="province"><c:if test="${not empty entity.province }">${entity.province}</c:if><c:if test="${empty entity.province }">未知</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                    <div class="pull-left pl-10 line-height40">
                        <i class="zi-9b9b9b" id="city"><c:if test="${not empty entity.city }">${entity.city}</c:if><c:if test="${empty entity.city }">未知</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                    <div class="pull-left pl-10 line-height40">
                        <i class="zi-9b9b9b" id="county"><c:if test="${not empty entity.county}">${entity.county}</c:if><c:if test="${empty entity.county}">未知</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="width-9 maring-a pt-10 pb-10">
            <img class="width-10" src="${ctx}/img/dating/contact.png">
        </div>

        <div class="bg-bai border-radius5">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <c:if test="${empty entity.qq}">
                <div class="pull-left">
                    QQ：<input class="zi-fa82a5 txt-l"
                              style="background-color: transparent;height:35px;line-height:35px;" type="text"
                              id="qq"
                              value="请填写你的QQ"
                              onfocus="if(this.value=='请填写你的QQ'){this.value=''};this.style.color='#9b9b9b';"
                              onblur="if(this.value==''||this.value=='请填写你的QQ'){this.value='请填写你的QQ';this.style.color='#fa82a5';}">
                </div>
                </c:if>
                <c:if test="${not empty entity.qq}">
                <div class="pull-left">
                    QQ：<input class="zi-fa82a5 txt-l"
                              style="background-color: transparent;height:35px;line-height:35px;" type="text"
                              id="qq"
                              value="${entity.qq}"
                              onfocus="if(this.value=='请填写你的QQ'){this.value=''};this.style.color='#9b9b9b';"
                              onblur="if(this.value==''||this.value=='请填写你的QQ'){this.value='请填写你的QQ';this.style.color='#fa82a5';}">
                </div>
                </c:if>
                <c:if test="${empty entity.qqState}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_qq_button">
                        <i class="zi-fa82a5" id="setting_qq">公开</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.qqState}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_qq_button">
                        <i class="zi-9b9b9b" id="setting_qq"><c:if test="${entity.qqState==0}">公开</c:if><c:if test="${entity.qqState==1}">保密</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <c:if test="${empty entity.tel}">
                  <div class="pull-left">
                    手机：<input class="zi-fa82a5 txt-l"
                              style="background-color: transparent;height:35px;line-height:35px;" type="text"
                              id="tel"
                              value="请填写你的手机号"
                              onfocus="if(this.value=='请填写你的手机号'){this.value=''};this.style.color='#9b9b9b';"
                              onblur="if(this.value==''||this.value=='请填写你的手机号'){this.value='请填写你的手机号';this.style.color='#fa82a5';}">
                </div>
                </c:if>
                <c:if test="${not empty entity.tel}">
                  <div class="pull-left">
                    手机：<input class="zi-fa82a5 txt-l"
                              style="background-color: transparent;height:35px;line-height:35px;" type="text"
                              id="tel"
                              value="${entity.tel}"
                              onfocus="if(this.value=='请填写你的手机号'){this.value=''};this.style.color='#9b9b9b';"
                              onblur="if(this.value==''||this.value=='请填写你的手机号'){this.value='请填写你的手机号';this.style.color='#fa82a5';}">
                </div>
                </c:if>
                <c:if test="${empty entity.telState}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_tel_button">
                        <i class="zi-fa82a5" id="setting_tel">公开</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                 </div>
                </c:if>
                <c:if test="${not empty entity.telState}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_tel_button">
                        <i class="zi-9b9b9b" id="setting_tel"><c:if test="${entity.telState==0}">公开</c:if><c:if test="${entity.telState==1}">保密</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                 </div>
                </c:if>
               
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <c:if test="${empty entity.wx}">
                 <div class="pull-left">
                    微信号：<input class="zi-fa82a5 txt-l"
                               style="background-color: transparent;height:35px;line-height:35px;" type="text"
                               id="wx"
                               value="请填写你的微信号"
                               onfocus="if(this.value=='请填写你的微信号'){this.value=''};this.style.color='#9b9b9b';"
                               onblur="if(this.value==''||this.value=='请填写你的微信号'){this.value='请填写你的微信号';this.style.color='#fa82a5';}">
                </div>
                </c:if>
                <c:if test="${not empty entity.wx}">
                 <div class="pull-left">
                    微信号：<input class="zi-fa82a5 txt-l"
                               style="background-color: transparent;height:35px;line-height:35px;" type="text"
                               id="wx"
                               value="${entity.wx}"
                               onfocus="if(this.value=='请填写你的微信号'){this.value=''};this.style.color='#9b9b9b';"
                               onblur="if(this.value==''||this.value=='请填写你的微信号'){this.value='请填写你的微信号';this.style.color='#fa82a5';}">
                </div>
                </c:if>
                <c:if test="${empty entity.wxState}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_wx_button">
                        <i class="zi-fa82a5" id="setting_wx">公开</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                 </div>
                </c:if>
                 <c:if test="${not empty entity.wxState}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_wx_button">
                        <i class="zi-9b9b9b" id="setting_wx"><c:if test="${entity.wxState==0}">公开</c:if><c:if test="${entity.wxState==1}">保密</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                 </div>
                </c:if>
               
            </div>

        </div>


        <div class="width-9 maring-a pt-10 pb-10">
            <img class="width-10" src="${ctx}/img/dating/details.png">
        </div>

        <div class="bg-bai border-radius5">
            <!--下方循环列表 字体默认是红色选择之后变成灰色 弹出层使用mui-->
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    交友目的
                </div>
                <c:if test="${empty entity.purpose}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_purpose_button">
                        <i class="zi-fa82a5" id="setting_purpose">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.purpose}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_purpose_button">
                        <i class="zi-9b9b9b" id="setting_purpose">${entity.purpose}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    恋爱观念
                </div>
                <c:if test="${empty entity.concept}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_concept_button">
                        <i class="zi-fa82a5" id="setting_concept">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.concept}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_concept_button">
                        <i class="zi-9b9b9b" id="setting_concept">${entity.concept}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    首次见面
                </div>
                <c:if test="${empty entity.firstmeet}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_firstmeet_button">
                        <i class="zi-fa82a5" id="setting_firstmeet">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.firstmeet}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_firstmeet_button">
                        <i class="zi-9b9b9b" id="setting_firstmeet">${entity.firstmeet}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    喜欢约会的地点
                </div>
                <c:if test="${empty entity.likeDatingSite}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_likeDatingSite_button">
                        <i class="zi-fa82a5" id="setting_likeDatingSite">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.likeDatingSite}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_likeDatingSite_button">
                        <i class="zi-9b9b9b" id="setting_likeDatingSite">${entity.likeDatingSite }</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>
        </div>
        <div class="bg-bai border-radius5 mt-10">
            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    身高
                </div>
                <c:if test="${entity.height==0}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_height_button">
                        <i class="zi-fa82a5" id="setting_height">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                 <c:if test="${entity.height>0}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_height_button">
                        <i class="zi-9b9b9b" id="setting_height">${entity.height}cm</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    婚姻状况
                </div>
                
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_marriage_button">
                        <i class="zi-9b9b9b" id="setting_marriage"><c:if test="${entity.marriage==0}">未婚</c:if><c:if test="${entity.marriage==1}">已婚</c:if><c:if test="${entity.marriage==2}">离异</c:if><c:if test="${entity.marriage==3}">丧偶</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                
                
               
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    收入范围
                </div>
                <c:if test="${empty entity.income}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_income_button">
                        <i class="zi-fa82a5" id="setting_income">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.income}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_income_button">
                        <i class="zi-9b9b9b" id="setting_income"><c:if test="${entity.income==0}">2000元以下</c:if><c:if test="${entity.income==1}">2000-5000元</c:if><c:if test="${entity.income==2}">5000-10000元</c:if><c:if test="${entity.income==3}">10000元以上</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    学历
                </div>
                <c:if test="${empty entity.record}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_record_button">
                        <i class="zi-fa82a5" id="setting_record">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.record}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_record_button">
                        <i class="zi-9b9b9b" id="setting_record"><c:if test="${entity.record==0}">高中</c:if><c:if test="${entity.record==1}">技校</c:if><c:if test="${entity.record==2}">中专</c:if><c:if test="${entity.record==3}">本科</c:if><c:if test="${entity.record==4}">硕士</c:if><c:if test="${entity.record==5}">博士</c:if></i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>
        </div>
        <div class="bg-bai border-radius5 mt-10">

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    职业
                </div>
                <c:if test="${empty entity.professional}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_professional_button">
                        <i class="zi-fa82a5" id="setting_professional">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                 <c:if test="${not empty entity.professional}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_professional_button">
                        <i class="zi-9b9b9b" id="setting_professional">${entity.professional}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
               
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    体重
                </div>
                <c:if test="${entity.weight==0}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_weight_button">
                        <i class="zi-fa82a5" id="setting_weight">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${entity.weight>0}">
                 <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_weight_button">
                        <i class="zi-9b9b9b" id="setting_weight">${entity.weight}kg</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
               
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    星座
                </div>
                <c:if test="${empty entity.constellation}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_constellation_button">
                        <i class="zi-fa82a5" id="setting_constellation">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                 <c:if test="${not empty entity.constellation}">
                <div class="pull-right">
                    <div class="pull-left line-height40" id="setting_constellation_button">
                        <i class="zi-9b9b9b" id="setting_constellation">${entity.constellation}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>

            <div class="hang40 pl-10 pr-10 line-height40 line-bottom-92 zi-hui-wx">
                <div class="pull-left">
                    生日
                </div>
                <c:if test="${empty entity.birthday}">
                <div class="pull-right">
                    <div class="pull-left line-height40 " data-options='{"type":"date","beginYear":1940,"endYear":2020}' id="setting_birthday_button"> 
                        <i  class="zi-fa82a5" id="setting_birthday">请选择</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                <c:if test="${not empty entity.birthday}">
                <div class="pull-right">
                    <div class="pull-left line-height40 " data-options='{"type":"date","beginYear":1940,"endYear":2020}' id="setting_birthday_button"> 
                        <i  class="zi-9b9b9b" id="setting_birthday">${entity.birthday}</i><i class="pl-5 fa fa-caret-down line-height35"></i>
                    </div>
                </div>
                </c:if>
                
            </div>
        </div>

    </div>       
    </c:if>
    <div class="txt-c zi-6 hang40 line-height40">@2017同城交友</div>
</main>
<div class="hang40"></div>
<div class="position-f width-10 hang40"style="bottom: 2px;left: 0px;">
    <!--没有打招呼时是红色打过招呼之后就是 bg-hei-5-->
    <div class="clear border-radius3 hang40 txt-c line-height40 zi-bai bottom-fa82a5 width-9_5 maring-a" onclick="submit()">
        确认保存
    </div>
</div>
 <%@include file="/webcom/cut-image.jsp"%>
<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.picker.min.js"></script>

<script src="${ctx}/mvccol/mui-js/mui.poppicker.js"></script>


<script src="${ctx}/mvccol/mui-js/city.data-3.js" type="text/javascript" charset="utf-8"></script>
<script>
    (function ($, doc) {
        loading();
        $.init();
        $.ready(function () {

            var cityPicker3 = new $.PopPicker({
                layer: 3
            });
            cityPicker3.setData(cityData3);
            var showCityPickerButton = doc.getElementById('showCityPicker3');
            var province = doc.getElementById('province');
            var city = doc.getElementById('city');
            var county = doc.getElementById('county');
            showCityPickerButton.addEventListener('tap', function (event) {
                cityPicker3.show(function (items) {
                    province.innerHTML =(items[0] || {}).text;
                    u_province=(items[0] || {}).text;
                    city.innerHTML=(items[1] || {}).text;
                    u_city=(items[1] || {}).text;
                    if (typeof((items[2] || {}).text) == "undefined") { 
                     county.innerHTML='';
                     u_county='';
                     }else{
                     county.innerHTML=(items[2] || {}).text;
                     u_county=(items[2] || {}).text;
                      if(u_province==u_city){
                        u_city=u_county;
                       }  
                     }
                    
                     city.setAttribute("class", "zi-9b9b9b");  
                     province.setAttribute("class", "zi-9b9b9b");  
                     county.setAttribute("class", "zi-9b9b9b");  
                    //返回 false 可以阻止选择框的关闭
                    
                    //return false;
                });
            }, false);
            
            var agePicker = new $.PopPicker();
					agePicker.setData([{
						value: '16',
						text: '16岁'
					}, {
						value: '17',
						text: '17岁'
					}, {
						value: '18',
						text: '18岁'
					}, {
						value: '19',
						text: '19岁'
					}, {
						value: '20',
						text: '20岁'
					}, {
						value: '21',
						text: '21岁'
					}, {
						value: '22',
						text: '22岁'
					}, {
						value: '23',
						text: '23岁'
					}, {
						value: '24',
						text: '24岁'
					}, {
						value: '25',
						text: '25岁'
					}, {
						value: '26',
						text: '26岁'
					}, {
						value: '27',
						text: '27岁'
					}, {
						value: '28',
						text: '28岁'
					}, {
						value: '29',
						text: '29岁'
					}, {
						value: '30',
						text: '30岁'
					}, {
						value: '31',
						text: '31岁'
					}, {
						value: '32',
						text: '32岁'
					}, {
						value: '33',
						text: '33岁'
					}, {
						value: '34',
						text: '34岁'
					}, {
						value: '35',
						text: '35岁'
					}, {
						value: '36',
						text: '36岁'
					}, {
						value: '37',
						text: '37岁'
					}, {
						value: '38',
						text: '38岁'
					}, {
						value: '39',
						text: '39岁'
					}, {
						value: '40',
						text: '40岁'
					}, {
						value: '41',
						text: '41岁'
					}, {
						value: '42',
						text: '42岁'
					}, {
						value: '43',
						text: '43岁'
					}, {
						value: '44',
						text: '44岁'
					}, {
						value: '45',
						text: '45岁'
					}, {
						value: '46',
						text: '46岁'
					}, {
						value: '47',
						text: '47岁'
					}, {
						value: '48',
						text: '48岁'
					}, {
						value: '49',
						text: '49岁'
					}, {
						value: '50',
						text: '50岁'
					}, {
						value: '51',
						text: '51岁'
					},{
						value: '52',
						text: '52岁'
					},{
						value: '53',
						text: '53岁'
					},{
						value: '54',
						text: '54岁'
					}, {
						value: '55',
						text: '55岁'
					}]);
					var setting_age_button = doc.getElementById('setting_age_button');
					var setting_age = doc.getElementById('setting_age');
					setting_age_button.addEventListener('tap', function(event) {
						agePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_age.innerText=items[0].text;
							u_age=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_age.setAttribute("class", "zi-9b9b9b");  
							
						});
					}, false);
					//身高
					var heightPicker = new $.PopPicker();
					heightPicker.setData([{
						value: '140',
						text: '140cm'
					}, {
						value: '141',
						text: '141cm'
					}, {
						value: '142',
						text: '142cm'
					}, {
						value: '143',
						text: '143cm'
					}, {
						value: '144',
						text: '144cm'
					}, {
						value: '145',
						text: '145cm'
					}, {
						value: '146',
						text: '146cm'
					}, {
						value: '147',
						text: '147cm'
					}, {
						value: '148',
						text: '148cm'
					}, {
						value: '149',
						text: '149cm'
					}, {
						value: '150',
						text: '150cm'
					}, {
						value: '151',
						text: '151cm'
					}, {
						value: '152',
						text: '152cm'
					}, {
						value: '153',
						text: '153cm'
					}, {
						value: '154',
						text: '154cm'
					}, {
						value: '155',
						text: '155cm'
					}, {
						value: '156',
						text: '156cm'
					}, {
						value: '157',
						text: '157cm'
					}, {
						value: '158',
						text: '158cm'
					}, {
						value: '159',
						text: '159cm'
					}, {
						value: '160',
						text: '160cm'
					}, {
						value: '161',
						text: '161cm'
					}, {
						value: '162',
						text: '162cm'
					}, {
						value: '163',
						text: '163cm'
					}, {
						value: '164',
						text: '164cm'
					}, {
						value: '165',
						text: '165cm'
					}, {
						value: '166',
						text: '166cm'
					}, {
						value: '167',
						text: '167cm'
					}, {
						value: '168',
						text: '168cm'
					}, {
						value: '169',
						text: '169cm'
					}, {
						value: '170',
						text: '170cm'
					}, {
						value: '171',
						text: '171cm'
					}, {
						value: '172',
						text: '172cm'
					}, {
						value: '173',
						text: '173cm'
					}, {
						value: '174',
						text: '174cm'
					}, {
						value: '175',
						text: '175cm'
					},{
						value: '176',
						text: '176cm'
					},{
						value: '177',
						text: '177cm'
					},{
						value: '178',
						text: '178cm'
					},{
						value: '179',
						text: '179cm'
					},{
						value: '180',
						text: '180cm'
					},{
						value: '181',
						text: '181cm'
					},{
						value: '182',
						text: '182cm'
					},{
						value: '183',
						text: '183cm'
					},{
						value: '184',
						text: '184cm'
					},{
						value: '185',
						text: '185cm'
					},{
						value: '186',
						text: '186cm'
					},{
						value: '187',
						text: '187cm'
					},{
						value: '188',
						text: '188cm'
					}, {
						value: '189',
						text: '189cm'
					}, {
						value: '190',
						text: '190cm'
					}, {
						value: '191',
						text: '191cm'
					}]);
					var setting_height_button = doc.getElementById('setting_height_button');
					var setting_height = doc.getElementById('setting_height');
					setting_height_button.addEventListener('tap', function(event) {
						heightPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_height.innerText=items[0].text;
							u_height=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_height.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					var qqPicker = new $.PopPicker();
					qqPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					var setting_qq_button = doc.getElementById('setting_qq_button');
					var setting_qq = doc.getElementById('setting_qq');
					setting_qq_button.addEventListener('tap', function(event) {
						qqPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_qq.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_qqState=items[0].value;
							//return false;
							setting_qq.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					var telPicker = new $.PopPicker();
					telPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					var setting_tel_button = doc.getElementById('setting_tel_button');
					var setting_tel = doc.getElementById('setting_tel');
					setting_tel_button.addEventListener('tap', function(event) {
						telPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_tel.innerText=items[0].text;
							u_telState=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_tel.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					var wxPicker = new $.PopPicker();
					wxPicker.setData([{
						value: '0',
						text: '公开'
					}, {
						value: '1',
						text: '保密'
					}]);
					var setting_wx_button = doc.getElementById('setting_wx_button');
					var setting_wx = doc.getElementById('setting_wx');
					setting_wx_button.addEventListener('tap', function(event) {
						wxPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_wx.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_wxState=items[0].value;
							//return false;
							setting_wx.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					 
					//交友目的
					var purposePicker = new $.PopPicker();
					purposePicker.setData([{
						value: '0',
						text: '结婚'
					}, {
						value: '1',
						text: '交友'
					}]);
					var setting_purpose_button = doc.getElementById('setting_purpose_button');
					var setting_purpose = doc.getElementById('setting_purpose');
					setting_purpose_button.addEventListener('tap', function(event) {
						purposePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_purpose.innerText=items[0].text;
							u_purpose=items[0].text;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_purpose.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//性别
					var sexPicker = new $.PopPicker();
					sexPicker.setData([{
						value: '1',
						text: '男'
					}, {
						value: '2',
						text: '女'
					}]);
					var setting_sex_button = doc.getElementById('setting_sex_button');
					var setting_sex = doc.getElementById('setting_sex');
					setting_sex_button.addEventListener('tap', function(event) {
						sexPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_sex.innerText=items[0].text;
							u_sex=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_sex.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//婚姻状态
					var marriagePicker = new $.PopPicker();
					marriagePicker.setData([{
						value: '0',
						text: '未婚'
					}, {
						value: '1',
						text: '已婚'
					}, {
						value: '2',
						text: '离异'
					}, {
						value: '3',
						text: '丧偶'
					}]);
					var setting_marriage_button = doc.getElementById('setting_marriage_button');
					var setting_marriage = doc.getElementById('setting_marriage');
					setting_marriage_button.addEventListener('tap', function(event) {
						marriagePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_marriage.innerText=items[0].text;
							u_marriage=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_marriage.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//收入状态
					var incomePicker = new $.PopPicker();
					incomePicker.setData([{
						value: '0',
						text: '2000元以下'
					}, {
						value: '1',
						text: '2000-5000元'
					}, {
						value: '2',
						text: '5000-10000元'
					}, {
						value: '3',
						text: '10000元以上'
					}]);
					var setting_income_button = doc.getElementById('setting_income_button');
					var setting_income = doc.getElementById('setting_income');
					setting_income_button.addEventListener('tap', function(event) {
						incomePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_income.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_income=items[0].value;
							//return false;
							setting_income.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//学历状态
					var recordPicker = new $.PopPicker();
					recordPicker.setData([{
						value: '0',
						text: '高中'
					}, {
						value: '1',
						text: '技校'
					}, {
						value: '2',
						text: '中专'
					}, {
						value: '3',
						text: '本科'
					}, {
						value: '4',
						text: '硕士'
					}, {
						value: '5',
						text: '博士'
					}]);
					var setting_record_button = doc.getElementById('setting_record_button');
					var setting_record = doc.getElementById('setting_record');
					setting_record_button.addEventListener('tap', function(event) {
						recordPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_record.innerText=items[0].text;
							u_record=items[0].value;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_record.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//职业状态
					var professionalPicker = new $.PopPicker();
					professionalPicker.setData([{
						value: '0',
						text: '各类专业、技术人员'
					}, {
						value: '1',
						text: '办事人员和有关人员'
					}, {
						value: '2',
						text: '商业工作人员'
					}, {
						value: '3',
						text: '服务性工作人员'
					}, {
						value: '4',
						text: '其他'
					}]);
					var setting_professional_button = doc.getElementById('setting_professional_button');
					var setting_professional = doc.getElementById('setting_professional');
					setting_professional_button.addEventListener('tap', function(event) {
						professionalPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_professional.innerText=items[0].text;
							u_professional=items[0].text;
							//返回 false 可以阻止选择框的关闭
							//return false;
							setting_professional.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//星座状态
					var constellationPicker = new $.PopPicker();
					constellationPicker.setData([{
						value: '0',
						text: '白羊座'
					}, {
						value: '1',
						text: '金牛座'
					}, {
						value: '2',
						text: '双子座'
					}, {
						value: '3',
						text: '巨蟹座'
					}, {
						value: '4',
						text: '狮子座'
					}, {
						value: '5',
						text: '处女座'
					}, {
						value: '6',
						text: '天秤座'
					}, {
						value: '7',
						text: '天蝎座'
					}, {
						value: '8',
						text: '射手座'
					}, {
						value: '9',
						text: '摩羯座'
					}, {
						value: '10',
						text: '水瓶座'
					}, {
						value: '11',
						text: '双鱼座'
					}]);
					var setting_constellation_button = doc.getElementById('setting_constellation_button');
					var setting_constellation = doc.getElementById('setting_constellation');
					setting_constellation_button.addEventListener('tap', function(event) {
						constellationPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_constellation.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_constellation=items[0].text;
							//return false;
							setting_constellation.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//生日
					var setting_birthday = doc.getElementById('setting_birthday');
				    var setting_birthday_button =doc.getElementById('setting_birthday_button'); 
					setting_birthday_button.addEventListener('tap', function() {
						var optionsJson = this.getAttribute('data-options') || '{}';
						var options = JSON.parse(optionsJson);
						var id = this.getAttribute('id');
						/*
						 * 首次显示时实例化组件
						 * 示例为了简洁，将 options 放在了按钮的 dom 上
						 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
						 */
						var birthdaypicker = new $.DtPicker(options);
						birthdaypicker.show(function(rs) {
							/*
							 * rs.value 拼合后的 value
							 * rs.text 拼合后的 text
							 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
							 * rs.m 月，用法同年
							 * rs.d 日，用法同年
							 * rs.h 时，用法同年
							 * rs.i 分（minutes 的第二个字母），用法同年
							 */
							setting_birthday.innerText =rs.text;
							u_birthday=rs.text;
							setting_birthday.setAttribute("class", "zi-9b9b9b");
							/* 
							 * 返回 false 可以阻止选择框的关闭
							 * return false;
							 */
							/*
							 * 释放组件资源，释放后将将不能再操作组件
							 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
							 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
							 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
							 */
							birthdaypicker.dispose();
						});
						
					}, false); 
					
					//恋爱观念
					var conceptPicker = new $.PopPicker();
					conceptPicker.setData([{
						value: '0',
						text: '慰藉型'
					}, {
						value: '1',
						text: '友情型'
					}, {
						value: '2',
						text: '理想型'
					}, {
						value: '3',
						text: '志趣型'
					}, {
						value: '4',
						text: '功利型'
					}, {
						value: '5',
						text: '情爱型'
					}]);
					var setting_concept_button = doc.getElementById('setting_concept_button');
					var setting_concept = doc.getElementById('setting_concept');
					setting_concept_button.addEventListener('tap', function(event) {
						conceptPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_concept.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_concept=items[0].text;
							//return false;
							setting_concept.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//首次见面
					var firstmeetPicker = new $.PopPicker();
					firstmeetPicker.setData([{
						value: '0',
						text: '学校'
					}, {
						value: '1',
						text: '网吧'
					}, {
						value: '2',
						text: '广场'
					}, {
						value: '3',
						text: '商场'
					}, {
						value: '4',
						text: '公园'
					}, {
						value: '5',
						text: '咖啡厅'
					}, {
						value: '6',
						text: '河边'
					}, {
						value: '7',
						text: '海边'
					}, {
						value: '8',
						text: '宾馆'
					}, {
						value: '9',
						text: '家'
					}]);
					var setting_firstmeet_button = doc.getElementById('setting_firstmeet_button');
					var setting_firstmeet = doc.getElementById('setting_firstmeet');
					setting_firstmeet_button.addEventListener('tap', function(event) {
						firstmeetPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_firstmeet.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_firstmeet=items[0].text;
							//return false;
							setting_firstmeet.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					//约会地点
					var likeDatingSitePicker = new $.PopPicker();
					likeDatingSitePicker.setData([{
						value: '0',
						text: '学校'
					}, {
						value: '1',
						text: '网吧'
					}, {
						value: '2',
						text: '广场'
					}, {
						value: '3',
						text: '商场'
					}, {
						value: '4',
						text: '公园'
					}, {
						value: '5',
						text: '咖啡厅'
					}, {
						value: '6',
						text: '河边'
					}, {
						value: '7',
						text: '海边'
					}, {
						value: '8',
						text: '宾馆'
					}, {
						value: '9',
						text: '家'
					}]);
					var setting_likeDatingSite_button = doc.getElementById('setting_likeDatingSite_button');
					var setting_likeDatingSite = doc.getElementById('setting_likeDatingSite');
					setting_likeDatingSite_button.addEventListener('tap', function(event) {
						likeDatingSitePicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_likeDatingSite.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_likeDatingSite=items[0].text;
							//return false;
							setting_likeDatingSite.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					//体重状态
					var weightPicker = new $.PopPicker();
					weightPicker.setData([{
						value: '30',
						text: '30kg'
					}, {
						value: '31',
						text: '30kg'
					}, {
						value: '32',
						text: '32kg'
					}, {
						value: '33',
						text: '33kg'
					}, {
						value: '34',
						text: '34kg'
					}, {
						value: '35',
						text: '35kg'
					}, {
						value: '36',
						text: '36kg'
					}, {
						value: '37',
						text: '37kg'
					}, {
						value: '38',
						text: '38kg'
					}, {
						value: '39',
						text: '39kg'
					}, {
						value: '40',
						text: '40kg'
					}, {
						value: '41',
						text: '41kg'
					}, {
						value: '42',
						text: '42kg'
					}, {
						value: '43',
						text: '43kg'
					}, {
						value: '44',
						text: '44kg'
					}, {
						value: '45',
						text: '45kg'
					}, {
						value: '46',
						text: '46kg'
					}, {
						value: '47',
						text: '47kg'
					}, {
						value: '48',
						text: '48kg'
					}, {
						value: '49',
						text: '49kg'
					}, {
						value: '50',
						text: '50kg'
					}, {
						value: '51',
						text: '51kg'
					}, {
						value: '52',
						text: '52kg'
					}, {
						value: '53',
						text: '53kg'
					}, {
						value: '54',
						text: '54kg'
					}, {
						value: '55',
						text: '55kg'
					}, {
						value: '56',
						text: '56kg'
					}, {
						value: '57',
						text: '57kg'
					}, {
						value: '58',
						text: '58kg'
					}, {
						value: '59',
						text: '59kg'
					}, {
						value: '60',
						text: '60kg'
					}, {
						value: '61',
						text: '61kg'
					}, {
						value: '62',
						text: '62kg'
					}, {
						value: '63',
						text: '63kg'
					}, {
						value: '64',
						text: '64kg'
					}, {
						value: '65',
						text: '65kg'
					}, {
						value: '66',
						text: '66kg'
					}, {
						value: '67',
						text: '67kg'
					}, {
						value: '68',
						text: '68kg'
					}, {
						value: '69',
						text: '69kg'
					}, {
						value: '70',
						text: '70kg'
					}, {
						value: '71',
						text: '71kg'
					}, {
						value: '72',
						text: '72kg'
					}, {
						value: '73',
						text: '73kg'
					}, {
						value: '74',
						text: '74kg'
					}, {
						value: '75',
						text: '75kg'
					}, {
						value: '76',
						text: '76kg'
					}, {
						value: '77',
						text: '77kg'
					}, {
						value: '78',
						text: '78kg'
					}, {
						value: '79',
						text: '79kg'
					}, {
						value: '80',
						text: '80kg'
					}, {
						value: '81',
						text: '81kg'
					}, {
						value: '82',
						text: '82kg'
					}, {
						value: '83',
						text: '83kg'
					}, {
						value: '84',
						text: '84kg'
					}, {
						value: '85',
						text: '85kg'
					}, {
						value: '86',
						text: '86kg'
					}, {
						value: '87',
						text: '87kg'
					}, {
						value: '88',
						text: '88kg'
					}, {
						value: '89',
						text: '89kg'
					}, {
						value: '90',
						text: '90kg'
					}, {
						value: '91',
						text: '91kg'
					}, {
						value: '92',
						text: '92kg'
					}, {
						value: '93',
						text: '93kg'
					}, {
						value: '94',
						text: '94kg'
					}, {
						value: '95',
						text: '95kg'
					}]);
					var setting_weight_button = doc.getElementById('setting_weight_button');
					var setting_weight = doc.getElementById('setting_weight');
					setting_weight_button.addEventListener('tap', function(event) {
						weightPicker.show(function(items) { 
							//setting_age.innerText = JSON.stringify(items[0]);
							setting_weight.innerText=items[0].text;
							//返回 false 可以阻止选择框的关闭
							u_weight=items[0].value;
							//return false;
							setting_weight.setAttribute("class", "zi-9b9b9b");
						});
					}, false);
					
					
        });
        loading.hide();
    })(mui, document);
    function  check_task(){
       var submitData = {  
            };
            $.post('${ctx}/suc/dating!ajaxReward.action?custid=${custid}&lscode=${lscode}', submitData, 
                    function (json) { 
                        if (json.state == 0) {
                        
                        }  
                    }, "json"); 
     }
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