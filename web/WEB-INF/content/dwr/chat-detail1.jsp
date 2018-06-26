<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>聊天页面首页</title>
    <!-- Resource style -->
    <script src="${ctx}/cmp/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/cmp/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/cmp/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/cmp/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/cmp/css/style_0.css" rel="stylesheet"> 
    <!-- Resource style -->
    <link href="${ctx}/cmp/css/time.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/cmp/js/date.js"></script>
    <script type="text/javascript" src="${ctx}/cmp/js/iscroll.js"></script>
    <script type="text/javascript" src="${ctx}/cmp/js/swipe.js"></script>
    <script type="text/javascript" src="${ctx}/mvccol/js/chat.js"></script>  
     
    
    <script type="text/javascript"  
        src="${ctx}/dwr/engine.js"></script>  
    <script type="text/javascript"  
        src="${ctx}/dwr/util.js"></script>  
    <script type="text/javascript"  
        src="${ctx}/dwr/interface/ChatService.js"></script>
    <script type="text/javascript" src="${ctx}/mvccol/js/dwr_error.js"></script> 
    <script type="text/javascript">
    var showtime=true;
    var adverInterval; 
        window.onload = Init()  
        function Init() {  
         dwr.engine.setActiveReverseAjax(true);
         //设置在页面关闭时，通知服务端销毁会话
         dwr.engine.setNotifyServerOnPageUnload(true)
          var tag ='${toUser}';
          var room ='${entity._id}';    //自定义一个标签(房间号)
          ChatService.onPageLoad(tag,room); 
          adverInterval=setInterval(ChangeTime,60000);
        } 
        function ChangeTime(){
        if(showtime==false){
         showtime=true;
         }
        } 
    </script>       
        
    <style>
        .top-btn:hover {
            border-bottom: 2px solid limegreen;
        }
    </style>
</head>
<body onload="dwr.engine.setActiveReverseAjax(true);" class="bg-hui-92">
<main class="cmp640" >

  <input type="hidden" id="roomid" value="${entity._id}"/>
  <input type="hidden" id="type"/>
  <input type="hidden" id="touserid"/>
  <input type="hidden" id="touserimg"/>
  <input type="hidden" id="fromuserid"/>
  <input type="hidden" id="fromuserimg"/>
  <input type="hidden" id="toUser" value="${toUser}"/>
    <div class="zi-hui cmp640 border-radius5" style="top:0px; left: 0px;z-index:2;">
        <div class="zi-hui position-r width-10 overflow-hidden bg-cheng"
             style="height:200px; right: 0px;border-radius: 10px 10px 0px 0px;">

            <img src="img/600x1200.jpg" style="width:100%;">

        </div>

        <div class="position-a div-group-5 width-10" style="top: 0px;left:0px;border-radius: 10px 10px 0px 0px;">
            <div class="pt-25">
                <div class="img-wh80 img-bj border-radius50 maring-a"
                     style="background-image: url(img/bangbi1.png);border:3px solid #ffffff">
                </div>
            </div>

            <div class=" size16 txt-c zi-bai pt-10 weight500">网络名称显示</div>
            <div class=" size14 sl txt-c zi-bai pt-5 weight500">
                <font size="0.8">
                    1076631795@qq.com
                </font>
            </div>

        </div>

    </div>
<input type="text" id="userName"  value="输入..."/>  
    <!--<div class="hang60" style="height:200px;"></div>-->

    <div class="pt-15 txt-c zi-hui weight500" id="ShowTime">今天是周二</div>
    
    

   <div id="chat_text" ></div>
    <!--bottom-->
    
    <div class="hang80 clear"></div>
    <div class="position-f shadow-wai zi-hui cmp640" style="border-radius: 0px 0px 10px 10px;bottom:0px; left: 0px;">

        <div class=" div-group-5 zi-hui overflow-hidden">

            
                <div class="zi-hui txt-c weight100 pt-3 pb-5">
              
                    
                        <div  class="col-10 pl-5 pr-5 zi-hong size16 weight500 ">
                            <input id="msg" class="width-10 pl-10 line-lu border-radius5 pr-10 zi-hui"
                                   style="height: 33px;background-color: transparent" type="text"
                                   value="输入名字..." onfocus="javascript:if(this.value=='输入...')this.value='';">
                        </div>
                   
                    <div class="col-2"style="padding-top: 1px;">
                        <a href="javascript:void(0)">
                            <div  class=" btn-cheng pt-7 pb-5 zi-bai border-radius3" onclick="Chat.sendMsg();">发送</div>
                        
                    </div>
                </div>
            
        </div>

    </div>

</main>

</body>
</html>