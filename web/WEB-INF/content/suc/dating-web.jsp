<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>  
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
    <title>缘分</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css"/>
    <link href="${ctx}/mvccol/mui-css/mui.picker.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/mui-css/mui.poppicker.css" rel="stylesheet"/>
    <style>
          .bottom-bai-hq {
            background-color: #ffffff;
        }

        .bottom-bai-hq:hover, .bottom-bai-hq:focus {
            color: #fa82a5;
        }

        .border-bottom-d9d9d9 {
            border-bottom: 1px solid #ccc;
        }

        .pl-80 {
            padding-left: 80px;
        }

        .p-top-left-10 {
            top: 10px;
            left: 10px;
        }

        .line-fa82a5 {
            border: solid 1px #fa82a5;
            color: #fa82a5;
            line-height: 23px;
        }

        .line-9b9b9b {
            border: solid 1px #9b9b9b;
            color: #9b9b9b;
            line-height: 23px;
        }

        .border-radius50px {
            border-radius: 50px;
        }
        .hang15{
            height: 15px;
            line-height: 17px;
        }
        .mui-btn-blue{
         background-color: rgba(234, 100, 131, 0.8);
         border-color: rgba(234, 100, 131, 0.8);
        }
    .img-w60-h75 {
            width: 60px;
            height: 75px;
        }

        .hang95 {
            height: 95px;
        }

        .hang35 {
            height: 35px;
        }
        .line-height35{
            line-height: 35px;
        }
    </style>
    <script>
     
         var loading;
         function  load(){
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
    
        var issend = true;
        var fypage =0;
        var xszf = ""; 
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            }
             
            var submitData = {  
            };
            issend = false;  
            load();  
            $.post('${ctx}/suc/dating!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        loading.hide();
                        var xszf =$('#ajaxdiv').html(); 
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {   
                                if(v[i].sex==2){
                                  xszf+='<div class="hang95 overflow-hidden bg-bai width-10 position-r border-bottom-d9d9d9">'
                                      +'<div class="pull-left img-w60-h75 img-bj position-a p-top-left-10" onclick="detail(\''+v[i]._id+'\')" style="background-image:url(${filehttp}/'+v[i].headimgurl+')">'
                                      +'</div>'
                                      +'<div class="pt-10 pr-10 width-10 pl-80">'
                                      +'<div class="col-8 zi-hei-tq" onclick="detail(\''+v[i]._id+'\')">'
                                      +'<div class="sl hang25 line-height25 weight500 size16">'+v[i].nickname+'</div>'
                                      +'<div class="hang25 line-height25 zi-hui-wx size14 weight500 sl pt-5" onclick="detail(\''+v[i]._id+'\')">'
                                      +' <font size="1">'
                                      +'<div class="hang15 zi-bai bj-lan2 pl-5 pr-5 pull-left">♀&nbsp'+v[i].age+'岁</div>';
                                      if(v[i].height>0){
                                       xszf+='<div class="hang15 zi-bai bj-hong2 pl-5 pr-5 pull-left ml-5">'+v[i].height+'cm</div>';
                                      } 
                                      xszf+='</font></div>'
                                      +'<div class="hang25 line-height25 zi-hui-wx size14 weight500 sl" onclick="detail(\''+v[i]._id+'\')">'+v[i].province+'&nbsp'+v[i].city+'</div>'
                                      +'</div>'
                                      +'<div class="col-4 sl pt-20">';
                                      if(v[i].msgState==0){
                                      xszf+='<div class="hang35 pl-10 pr-10 size12 txt-c pull-right line-fa82a5 border-radius50px weight500" onclick="sendMsg('+v[i].no+')">'
                                      +'<i class="fa fa-magic line-height35 pr-5"></i>打招呼 </div>';
                                      }else{
                                       xszf+='<div class="hang35 pl-10 pr-10 size12 txt-c pull-right line-9b9b9b border-radius50px weight500" onclick="sendMsg('+v[i].no+')">'
                                      +'<i class="fa fa-magic line-height35 pr-5"></i>打招呼 </div>';
                                      } 
                                      xszf+='</div></div></div>';
                                }else{
                                xszf+='<div class="hang95 overflow-hidden bg-bai width-10 position-r border-bottom-d9d9d9">'
                                    +'<div class="pull-left img-w60-h75 position-a p-top-left-10 img-bj" onclick="detail(\''+v[i]._id+'\')"style="background-image:url(${filehttp}/'+v[i].headimgurl+')">'
                                    +'</div>'
                                    +'<div class="pt-10 pr-10 width-10 pl-80">'
                                    +'<div class="col-8 zi-hei-tq" onclick="detail(\''+v[i]._id+'\')">'
                                    +'<div class="sl hang25 line-height25 weight500 size16">'+v[i].nickname+'</div>'
                                    +'<div class="hang25 line-height25 zi-hui-wx size14 weight500 sl pt-5" onclick="detail(\''+v[i]._id+'\')">'
                                    +'<font size="1">'
                                    +'<div class="hang15 zi-bai bj-lan3 pl-5 pr-5 pull-left">♂&nbsp'+v[i].age+'岁</div>';
                                    if(v[i].height>0){
                                       xszf+='<div class="hang15 zi-bai bj-hong2 pl-5 pr-5 pull-left ml-5">'+v[i].height+'cm</div>';
                                      }   
                                    xszf+='</font></div>'
                                    +'<div class="hang25 line-height25 zi-hui-wx size14 weight500 sl" onclick="detail(\''+v[i]._id+'\')">'+v[i].province+'&nbsp'+v[i].city+'</div>'
                                    +'</div>'
                                    +'<div class="col-4 sl pt-20">';
                                    if(v[i].msgState==0){
                                     xszf+='<div class="hang35 pl-10 pr-10 size12 txt-c pull-right line-fa82a5 border-radius50px weight500" onclick="sendMsg('+v[i].no+')">'
                                      +'<i class="fa fa-magic line-height30 pr-5"></i>打招呼 </div>';
                                     }else{
                                      xszf+='<div class="hang35 pl-10 pr-10 size12 txt-c pull-right line-9b9b9b border-radius50px weight500" onclick="sendMsg('+v[i].no+')">'
                                      +'<i class="fa fa-magic line-height30 pr-5"></i>打招呼 </div>';
                                     } 
                                    xszf+='</div></div></div>';
                                }
                    
                        
                            }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
        function detail(id){
         window.location.href='${ctx}/suc/dating!detail.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}&id='+id;
        }
        function sendMsg(id){
         if (typeof(id) =="undefined"){
            return; 
          }
         window.location.href='${ctx}/suc/dating!chat.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}&id='+id;
        }
        function refreshData(){
        $('#ajaxdiv').html('');
        fypage=0;
        ajaxjz();
        }
        function saveLoc(lat,lon) {  
            var submitData = { 
              lat:lat,
              lon:lon 
            }; 
            $.post('${ctx}/suc/dating!saveLoc.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) { 
                         if(json.value==0){
                         }
                    }, "json");
        }
        
       function getLoc(){
    	wx.getLocation({
    	    success: function (res) { 
    			saveLoc(res.latitude,res.longitude); 
    			getAdress(res.latitude,res.longitude);
    	    }
    	});
      }
     
     function getAdress(lat,lon){ 
         var submitData = { 
           location:lat+","+lon,
           key:'NMABZ-B5LC6-GYKSH-MGW5N-IXOUT-NVFT6',
           get_poi:0, 
            };
          submitData.output="jsonp";   
        $.ajax({
           type:'post',
           dataType:'jsonp',
           data:submitData, 
           url:'http://apis.map.qq.com/ws/geocoder/v1/?',
           success:function(json){
           $('#city').html(json.result.address_component.city);  
          },
          error : function(err){alert(JSON.stringify(err))}
        });    
    } 
   
    </script>
</head>
<body class="lock">
<main class="cmp640">
    <div class="hang40 line-height40 pl-10 pr-10 zi-bai line-bottom cmp640 position-f" style="left:0px;top: 0px;z-index: 10; background-color: #fd6c8e">
        <div class="pull-left zi-bai"id="showCityPicker">
            <div class="pull-left pt-5 pr-5">
                <div class="img-wh30 bg-bai border-radius50 overflow-hidden"><img src="${filehttp}/${user.headimgurl}" class="width-10"></div>
            </div>
            <div class="pull-left" id="city">请选择</div>
        </div>
        <div class="pull-right zi-bai"onclick="window.location.href='${ctx}/suc/dating!condition.action?custid=${custid}&datingid=${datingid}&lscode=${lscode}'">
            <i class="">征友条件</i><i class="fa fa-chevron-right pl-5"></i>
        </div>
    </div>
    <div class="hang40"></div>
    <div id="ajaxdiv"></div> 
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/dating-foot.jsp" %>
<%@ include file="/webcom/websocket.jsp" %> 
 

<!--MUIjs-->
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<script src="${ctx}/mvccol/mui-js/mui.picker.min.js"></script>

<script src="${ctx}/mvccol/mui-js/mui.poppicker.js"></script>

<script src="${ctx}/mvccol/mui-js/city.data.js" type="text/javascript" charset="utf-8"></script> 
<script> 
    (function ($, doc) { 
        $.init();
        $.ready(function () {

            var cityPicker2 = new $.PopPicker({
                layer: 2
            });
            cityPicker2.setData(cityData);
            var showCityPickerButton = doc.getElementById('showCityPicker'); 
            var city = doc.getElementById('city'); 
            showCityPickerButton.addEventListener('tap', function (event) {
                cityPicker2.show(function (items) {
                    city.innerHTML =(items[1] || {}).text;
                    refreshData();
                });
            }, false);
           
        			
        });   
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
</body>
<script type="text/javascript">  
    ajaxjz(); 
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            ajaxjz();
        }
    });
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
            'showMenuItems',
            'openLocation',
            'getLocation'
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
        getLoc();
    }); 
   //update 
</script>
</html>