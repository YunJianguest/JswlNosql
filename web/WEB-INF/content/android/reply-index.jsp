<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
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
    <title>和${entity.name}的聊天</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script type="text/javascript" src="${ctx}/dwr/engine.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/util.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/interface/MsgService.js"></script>
    
    <script type="text/javascript" src="${ctx}/mvccol/js/dwr_error.js"></script>
    <%@ include file="/webcom/toast.jsp" %> 
    <script>
        var issend = true;
        var fypage =0;
        var xszf = "";
        var kfid;
        var rid='';
        var winheight=window.innerHeight;
        var useragent = navigator.userAgent;
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            } 
            issend = false;
            $.post('${ctx}/android/permissions!ajaxweb.action?custid=${custid}&lscode=${lscode}', null,
                    function (json) {
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.value;
                            for (var i = 0; i < v.length; i++) {
                              if(v[i].isleft){
                                 xszf+='<div class="col-10 pt-25 clear">'
                                     +'<div class="col-2">'
                                     +'<div class="pr-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(img/touxiang.jpg);"></div>'
                                     +'</div></div>'
                                     +'<div class="col-10 position-r">'
                                     +'<div class="position-a" style=" left:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #ffffff;border-left: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-bai zi-hui-wx border-radius5 position-r pull-left">'
                                     +'<div>离开进口料件卡拉离开进口料件卡拉离开进口料件卡拉离开进口料件卡拉离开进口料件卡拉</div>'
                                     +'</div></div></div>';
                              }else{
                                 xszf+='<div class="col-10 pt-25 pull-right clear">'
                                     +'<div class="col-10 position-r" style="right: 1px;">'
                                     +'<div class="position-a" style="right:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #45c01a;border-right: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-green border-radius5 position-r pull-right zi-bai">'
                                     +'<div>离开进口</div>'
                                     +'</div></div>'
                                     +'<div class="col-2"><div class="pl-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(img/touxiang.jpg);">'
                                     +'</div></div></div></div>';
                              }
                          }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
         function send() {
            var msg=$('#msg').val();
            if(msg.length==0){
             alert('消息内容不能为空！');
             return;
            }
            var submitData = {
                id:'${id}',
                msg:msg,
                kfid:kfid
            };
            $.post('${ctx}/android/reply!ajaxsaveshopmsg.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){
                     var html=$('#ajaxdiv').html();
                       html+='<div class="col-10 pt-25 pull-right clear">'
                                     +'<div class="col-10 position-r" style="right: 1px;">'
                                     +'<div class="position-a" style="right:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #45c01a;border-right: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-green border-radius5 position-r pull-right zi-bai">'
                                     +'<div>'+msg+'</div>'
                                     +'</div></div>'
                                     +'<div class="col-2"><div class="pl-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/'+json.headimgurl+');">'
                                     +'</div></div></div></div>';
                             $('#ajaxdiv').html(html);
                             $('#msg').val('');
                             scrollmsg(); 
                             $("input").focus();       
                       } 
                    }, "json");
        }
        function getservice(){
            var submitData = {
                id:'${id}', 
            };
            $.post('${ctx}/android/reply!ajaxallotservice.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){ 
                           kfid=json.no;
                           
                           noty({text: '客服'+json.nickname+'为您服务',type:'alert', layout: "top", timeout: 2000,callback: { // 回调函数
                                              afterClose: function() {
                              createReply();   
                            } // 关闭之后
                           },});
                       }else{
                            $('#btsend').html('留言'); 
                            noty({text: "暂时没有客服在线，请稍后再试或者直接留言！",type:'alert', layout: "top", timeout: 2000,callback: { // 回调函数
                                              afterClose: function() {
                                 
                              } // 关闭之后
                            },});
                       } 
                    }, "json");
        }
         function createReply(){
            var ids='${no}';
            ids+=','+kfid;
            
            var submitData = { 
              ids:ids,
              pid:'${pid}'
            };
            $.post('${ctx}/android/reply!ajaxreplyadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {   
                     if(json.state==0){ 
                         rid=json.value;  
                         Init(); 
                       } 
                    }, "json");
        }
         function sendmsg() {  
            var time = new Date();  
            var content =$('#msg').val();  
            var fromid ='${no}';    
            var msg = {  
                "content" : $('#msg').val(),  
                "fromUserid":fromid,
                "toUserid":kfid+",",
                "rid":rid,
                "custid":'${custid}'  
            };     
            if (content.length>0) {    
                MsgService.sendMessage(msg);
                  var html=$('#ajaxdiv').html();
                       html+='<div class="col-10 pt-25 pull-right clear">'
                                     +'<div class="col-10 position-r" style="right: 1px;">'
                                     +'<div class="position-a" style="right:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #45c01a;border-right: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-green border-radius5 position-r pull-right zi-bai">'
                                     +'<div>'+content+'</div>'
                                     +'</div></div>'
                                     +'<div class="col-2"><div class="pl-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/${headimgurl});">'
                                     +'</div></div></div></div>';
                             $('#ajaxdiv').html(html);
                             $('#msg').val(''); 
                             scrollmsg();
                             if(useragent.match(/iPhone/i)=="iPhone"){   
                                }else{
                                    $("input").focus();    
                                }  
                              
            } else {  
                alert("发送的内容不能为空！");  
            }  
        }  
        function showMessage(data) {  
           var message = decodeURI(decodeURI(data.title));  
            // var text = dwr.util.getValue("info");
            var xszf=$('#ajaxdiv').html(); 
             xszf+='<div class="col-10 pt-25 clear">'
                                     +'<div class="col-2">'
                                     +'<div class="pr-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/'+data.picurl+');"></div>'
                                     +'</div></div>'
                                     +'<div class="col-10 position-r">'
                                     +'<div class="position-a" style=" left:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #ffffff;border-left: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-bai zi-hui-wx border-radius5 position-r pull-left">'
                                     +'<div>'+data.content+'</div>'
                                     +'</div></div></div>';
         $('#ajaxdiv').html(xszf);
         scrollmsg();
        }  
       function Init(){  
          if(rid!=''){
            $('#btsend').attr('onClick','sendmsg()');
            dwr.engine.setActiveReverseAjax(true); 
            dwr.engine.setNotifyServerOnPageUnload(true)
            var custid ='${custid}';
            var lscode ='${lscode}';  
            MsgService.onPageLoad(custid,lscode,rid);
          }       
        } 
       function scrollmsg(){
         document.getElementById("ajaxdiv").scrollTop = document.getElementById("ajaxdiv").scrollHeight+window.innerHeight; 
        } 
        function onscll(){  
          if(useragent.match(/iPhone/i)=="iPhone"){
            
          }else{
           $('#ajaxdiv').css('height',(winheight/2-47)+'px');
          }  
          scrollmsg();
        } 
        function changescll(){  
         $('#ajaxdiv').css('height',(winheight-47)+'px'); 
         scrollmsg();
        } 
        window.onresize = function(){
         if($("input").is(":focus")&&window.innerHeight==winheight){
          changescll();
          $("input").blur();
         }
        }
    </script>
</head>
<body class="bg-hui" onload="dwr.engine.setActiveReverseAjax(true);">
<main class="cmp640"> 
    <div id="ajaxdiv" style="overflow: auto;">
    </div> 
    <!--bottom-->
    <div style="height: 45px;">
    </div>
    <div class="position-f shadow-wai zi-hui cmp640" style="border-radius: 0px 0px 10px 10px;bottom:0px; left: 0px;">

        <div class=" div-group-5 zi-hui overflow-hidden bg-bai">
            <div class="zi-hui txt-c weight100 pt-3">
                <div class="col-10 pr-5 zi-hong size14 weight500 ">
                    <input class="hang30 line-height30 width-10 pl-5 line-lu border-radius5 pr-5 zi-hui"
                           style="background-color: transparent" type="text" id="msg"
                           onfocus="onscll()" onblur="changescll()"/>
                </div>
                <div class="col-2">
                    <font size="1">
                        <div class=" btn-green hang30 line-height30 zi-bai border-radius3" onclick="send()" id="btsend">发送</div>
                    </font>
                </div>
            </div>
        </div>

    </div>

</main>

</body>
<script>
getservice();
$('#ajaxdiv').css('height',(window.innerHeight-47)+'px');
</script> 
</html>