<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>

  <meta charset="UTF-8">

  <title>${entity.title}</title>

    <link rel="stylesheet" href="${ctx }/mvccol/css/chat_style.css" media="screen" type="text/css" />
    <script src="${ctx }/cmp/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/CcjhNosql/cmp/js/iscroll.js"></script>  
     <script type="text/javascript" src="${ctx}/mvccol/js/chat.js"></script>  
    <script type="text/javascript"  
        src="${ctx }/dwr/engine.js"></script>  
    <script type="text/javascript"  
        src="${ctx }/dwr/util.js"></script>  
    <script type="text/javascript"  
        src="${ctx }/dwr/interface/ChatService.js"></script>
        
         <script type="text/javascript">  
        function send() {  
            var time = new Date();  
            var content = dwr.util.getValue("content");  
            var name = dwr.util.getValue("userName");  
            var info = encodeURI(encodeURI(name + " 说:\n" + content));  
            var msg = {  
                "msg" : info,  
                "insdate" : time  
            };  
            dwr.util.setValue("content", "");  
            if (!!content) {  
               
                ChatService.sendMessage(msg);  
               
      
            } else {  
                alert("发送的内容不能为空！");  
            }  
        }  
        function showMessage(data) {  
            var message = decodeURI(decodeURI(data.msg));  
           // var text = dwr.util.getValue("info"); 
            var html='<li class="left_li" autofocus="autofocus">'+data.insdate+'\n'+message+'</li>';
             $('#chat_text').append(html); 
             
             $('#chat_text').scrollTop = $('#chat_text').scrollHeight;
           // if (!!text) { 
           
               // dwr.util.setValue("info", text + "\n" + data.insdate + "  " + message);  
          //  } else {  
          //      dwr.util.setValue("info", data.insdate + "  " + message);  
         //  }  
        }  
    </script>  
    <script type="text/javascript">  
        window.onload = Init()  
        function Init() {  
         dwr.engine.setActiveReverseAjax(true);
         //设置在页面关闭时，通知服务端销毁会话
         dwr.engine.setNotifyServerOnPageUnload(true)
          var tag ='${toUser}';
          var room ='${entity._id}';
          var from='${fromUser}';    //自定义一个标签(房间号)
            ChatService.onPageLoad(tag,room,from); 
            alert("页面初始化加载成功啦");  
        }  
    </script>   
</head>

<body onload="dwr.engine.setActiveReverseAjax(true);">
  <input type="hidden" id="roomid" value="${entity._id}"/>
  <input type="hidden" id="type"/>
  <input type="hidden" id="touserid"/>
  <input type="hidden" id="fromuserid" value="${fromUser}"/>
  <input type="hidden" id="toUser" value="${toUser}"/>
  <div id="convo" data-from="Sonu Joshi">  
<div class="chat-thread" id="chat_text">
	<li class="left_li">Are we meeting today?</li>
	<li class="right_li">I was thinking after lunch, I have a meeting in the morning</li>
</div>
</div>
  <input type="text" id="userName" />  
   
   <div style="margin-bottom: 10px; height: 10%">  
            <input id="msg" type="text" style="height: 45px; width: 74%"  onkeypress="Chat.keySendMsg(event)"><input  
                type="button" value="发送" style="height: 48px; width: 25%"  
                onclick="Chat.sendMsg();">  
  </div>  
</body>
</html>