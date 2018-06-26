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
    <title></title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script type="text/javascript" src="${ctx}/dwr/engine.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/util.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/interface/MsgService.js"></script>
    
    <script type="text/javascript" src="${ctx}/mvccol/js/dwr_error.js"></script>
    <script>
        var issend = true;
        var fypage =0;
        var xszf = "";
        var winheight=window.innerHeight;
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            } 
            issend = false;
            $.post('${ctx}/android/reply!ajaxdetail.action?custid=${custid}&lscode=${lscode}', {id:'${id}'},
                    function (json) {
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = v.length-1; i >=0 ; i--) {
                              if(v[i].location=="right"){
                                 xszf+='<div class="col-10 pt-25 clear">'
                                     +'<div class="col-2">'
                                     +'<div class="pr-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/'+v[i].picurl+');"></div>'
                                     +'</div></div>'
                                     +'<div class="col-10 position-r">'
                                     +'<div class="position-a" style=" left:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #ffffff;border-left: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-bai zi-hui-wx border-radius5 position-r pull-left">'
                                     +'<div>'+v[i].content+'</div>'
                                     +'</div></div></div>';
                              }else{
                                 xszf+='<div class="col-10 pt-25 pull-right clear">'
                                     +'<div class="col-10 position-r" style="right: 1px;">'
                                     +'<div class="position-a" style="right:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #45c01a;border-right: 15px solid transparent;"></div>'
                                     +'<div class="div-group-10 bg-green border-radius5 position-r pull-right zi-bai">'
                                     +'<div>'+v[i].content+'</div>'
                                     +'</div></div>'
                                     +'<div class="col-2"><div class="pl-10">'
                                     +'<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/'+v[i].picurl+');">'
                                     +'</div></div></div></div>';
                              }
                          }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        scrollmsg();
                        
                    }, "json")
        }
         function Init(){  
            dwr.engine.setActiveReverseAjax(true);
            //设置在页面关闭时，通知服务端销毁会话
            dwr.engine.setNotifyServerOnPageUnload(true)
            var custid ='${custid}';
            var lscode ='${lscode}';  
            MsgService.onPageLoad(custid,lscode,'${id}');
          }
            function sendmsg() {    
            var content =$('#msg').val();  
            var fromid ='${no}';    
            var msg = {  
                "content" : $('#msg').val(),  
                "fromUserid":fromid,
                "toUserid":'${ids}',
                "rid":'${id}',
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
                             $("input").focus(); 
                               
            } else {  
                alert("发送的内容不能为空！");  
            }  
        }     
        function delunfind(){
            var submitData = {
                rid:'${id}', 
            };
            $.post('${ctx}/android/reply!delunfind.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){ 
                         
                       } 
                    }, "json");
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
         window.login.notice(data.title,data.content,data.picurl);
        }
        function txMessage(data) {  
         window.login.notice(data.title,data.content,data.picurl);
        }
        function scrollmsg(){
         document.getElementById("ajaxdiv").scrollTop = document.getElementById("ajaxdiv").scrollHeight+window.innerHeight;
        } 
        function onscll(){ 
         $('#ajaxdiv').css('height',(winheight/2-47)+'px'); 
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
<body class="bg-hui"> 
<main class="cmp640" id="main"> 
    
    <div id="ajaxdiv" style="overflow:auto;">
     <c:if test="${not empty pro}">
       <div class="width-9 maring-a pt-20 overflow-hidden" id="scoid">
        <div class="bg-bai border-radius3">
            <div class="clear div-group-10 position-r hang70 border-radius5">
                <div class=" position-a">
                    <div class="img-bj img-wh50 border-radius3" style="background-image: url(${filehttp}/${pro.logo});"></div>
                </div>
                <div style="padding-left:60px;">
                    <font size="2">
                        <div class="zi-6 hang25 line-height25 weight500 sl">${pro.ptitle}</div>
                    </font>
                    <div class=" pull-left weight500 width-10">
                        <font size="1"> 
                            <div class=" hang25 width-10 line-height25 zi-6">
                                <div class="col-9 zi-hong">￥<fmt:formatNumber value='${pro.price}' pattern="0.0#"/></div>
                                <div class="col-3 txt-r zi-bbbbbb">正在查看</div>
                            </div>
                        </font>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </c:if>
    </div> 
    
    <!--bottom--> 
    <div style="height: 45px">
    </div>
    <div class="position-f shadow-wai zi-hui cmp640" style="border-radius: 0px 0px 10px 10px;bottom:0px; left: 0px;">

        <div class=" div-group-5 zi-hui overflow-hidden bg-bai">
            <div class="zi-hui txt-c weight100 pt-3">
                <div class="col-10 pr-5 zi-hong size14 weight500 ">
                    <input class="hang30 line-height30 width-10 pl-5 line-lu border-radius5 pr-5 zi-hui"
                           style="background-color: transparent" type="text" id="msg"
                           onfocus="onscll()" onblur="changescll()" >
                </div>
                <div class="col-2">
                    <font size="1">
                        <div class=" btn-green hang30 line-height30 zi-bai border-radius3" onclick="sendmsg()" id="btsend">发送</div>
                    </font>
                </div>
            </div>
        </div>

    </div>

</main>

</body>
<script>
Init();  
$('#ajaxdiv').css('height',(window.innerHeight-47)+'px');
delunfind();
ajaxjz();
</script>
</html>