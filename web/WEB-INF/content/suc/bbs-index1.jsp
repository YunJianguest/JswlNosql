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
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <!--点击小图现实大图css代码--> 
    <!--结束-->
    <!--滑动导航-->
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${contextPath}/app/js/swiper.min.js"></script>
    <link href="${contextPath}/app/css/swiper.min.css" rel="stylesheet" type="text/css">
    <%@ include file="/webcom/toast.jsp" %>
    <style>
        .fa-spin2 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .dhid {
            width: 60px ! important;
            margin-right: 7px ! important;
        }

        .yListr1 ul em.title {
            border-bottom: 3px solid #d63333;
            position: relative;
            color: #d63333;
        }

        .yListr2 .biankuang .div2 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .btn-lan-tq {
            background-color: #00a5e0;
        }

        .btn-lan-tq:hover, .btn-lan-tq:focus {
            background-color: #0092c7;
        }

        .width-50px {
            width: 50px;
        }

        .pl-3pr-3{
            padding-left: 3px;padding-right:2px;
        }

    </style>
    <!--导航结束-->
    <script>
        var subtype = '';
        var issend = true;
        var fypage = 0;
        function ft() {
            window.location.href = "${ctx}/suc/bbs!webadd.action?custid=${custid}&lscode=${lscode}&type=" + subtype;
        }
        function replace_em(str) {
            str = str.replace(/\[em_([0-9]*)\]/g, '<img src="${contextPath}/mvccol/qqFace/arclist/$1.gif" border="0" />');
            return str;
        }
        $(function () {
            $(".yListr1 ul em").click(function () {
                $(this).addClass("title ").siblings().removeClass("title");
                if ($(this).is('.title')) {
                    if ($(this).attr('id') == 'zx') {
                        subtype = 1;
                    } else if ($(this).attr('id') == 'zr') {
                        subtype = 2;
                    } else {
                        subtype = $(this).attr('id');
                    }
                    loadingshow();
                    ajaxjz(false, 0);
                    loadinghide();
                }
            })
        })
        function yuyin() {
            if ($("#tanchu-yuyin").is(":hidden")) {
                $("#tanchu-yuyin").show();
            } else {
                $("#tanchu-yuyin").hide();
            }
            $("#tanchu-tp").hide();
            $("#qqbq").hide();
            $("#tanchu-zhiding").hide();
            $("#tanchu-xuanshang").hide();
        }
        function tp() {
            if ($("#tanchu-tp").is(":hidden")) {
                $("#tanchu-tp").show();
            } else {
                $("#tanchu-tp").hide();
            }
            $("#tanchu-yuyin").hide();
            $("#qqbq").hide();
            $("#tanchu-zhiding").hide();
            $("#tanchu-xuanshang").hide();
        }
        function xuanshuang() {
            if ($("#tanchu-xuanshang").is(":hidden")) {
                $("#tanchu-xuanshang").show();
            } else {
                $("#tanchu-xuanshang").hide();
            }
            $("#tanchu-tp").hide();
            $("#qqbq").hide();
            $("#tanchu-zhiding").hide();
            $("#tanchu-yuyin").hide();
        }
        function zhiding() {
            if ($("#tanchu-zhiding").is(":hidden")) {
                $("#tanchu-zhiding").show();
            } else {
                $("#tanchu-zhiding").hide();
            }
            $("#tanchu-tp").hide();
            $("#qqbq").hide();
            $("#tanchu-yuyin").hide();
            $("#tanchu-xuanshang").hide();
        }
        function xuanshangcancel() {
            $("#tanchu-xuanshang").hide();
        }
        function details(id, fromUserid) {
            window.location.href = "${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&toUserid=" + fromUserid + "&bmtid=" + id;
        }
        function guanggaohide() {
            $('#tanchuguanggao').hide();
        }
    </script>
    <script>
        function ajaxjz(fag, fy) { 
            var submitData = {
                type: subtype
            };
            issend = false;
            $("#loading").show();
            $.post('${ctx}/suc/bbs!ajaxIndex.action?custid=${custid}&lscode=${lscode}&fypage=' + fy, submitData, function (json) {
                var xszf;
                if (fag) {
                    xszf = $('#ajaxdiv').html();
                } else {
                    xszf = '';
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<div class="position-r pt-5 pl-5 pr-5">'
                        + '<div class=" overflow-hidden pull-left" style="padding-left: 50px;">'
                        + '<div class="weight500 pt-10 sl pull-left zi-lan-tq">'
                        + '<font size="2"><div class="pull-left pr-5 pt-2">' + v[i].nikename + '</div>'
                        + '<div class="pull-left pr-5 pt-2">';
                        if(v[i].adminstate==0||v[i].adminstate==null){
                        	xszf+='<div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">';
                             
                        	 if (v[i].level != null) {
                                 xszf += '<font size="1"><i class="pr-5">LV</i><i>' + v[i].level + '</i></font></div></div>';
                             } else {
                                 xszf += '<font size="1"><i class="pr-5">LV</i><i>0</i></font></div></div>';
                             }
                        
                        	
                        } 
                       
                        if(v[i].activity ==1){
                        xszf += '<div class="pull-left pr-5 pt-2">'
                             +'<div class="pl-5 pr-5 weight100 zi-bai btn-hong" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">'
                             +'<font size="1">悬赏</i></font></div></div>';
                        }
                         if(v[i].stick==1){
                        xszf += '<div class="pull-left pr-5 pt-2">'
                             +'<div class="pl-5 pr-5 weight100 zi-bai btn-hong" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">'
                             +'<font size="1">置顶</i></font></div></div>';
                        }
                        xszf+='</font></div>'
                        + '<div class="zi-6 clear"><div class="pt-9 pull-left weight500">'
                        + '<font size="2"><i>' + v[i].createdate + '</i>';
//                        if (v[i].reading == null) {
//                            xszf += '<i class="pl-10">浏览<i>0</i></i>';
//                        } else {
//                            xszf += '<i class="pl-10">浏览<i>' + v[i].reading + '</i></i>';
//                        }
                        xszf += '</font></div></div></div>'
                        + ''
                        + '<div class="position-a img-wh50 pl-5" style="top:15px; left:0px;">';
                        var content = replace_em(v[i].content);
                        if (v[i].headimgurl != null) {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${filehttp}/' + v[i].headimgurl + ')"></div>'
                        } else {
                        	if(v[i].adminstate==1){
                       		 xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${ctx}/img/admin.jpg)"></div>'
                        	}else{
                       		 xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>'
                       	  }
                        }
                        xszf += '</div><div class="clear pt-15" onclick="details(' + v[i]._id + ',\'' + v[i].fromUserid + '\')">';
                        xszf += '<div class="weight500 width-10 qjhh zi-6 hang-sl-4" style="line-height:20px;">'
                        + '<font size="2">' + content + '</font></div></div>';
                        if (v[i].voice != null) {
                            xszf += '<div class="clear pt-15 zi-hui-tq"><div class="hang30 pl-5 pr-5 border-radius3 width-3 overflow-hidden line-lu">'
                            + '<div class="img-wh18 pull-left pt-4"><img src="${ctx}/mvccol/img/bbs2/yuyin.gif" width="100%"></div>'
                            + '<div class="pull-right weight500"> <div style="line-height: 30px;"><font size="1"> 10s </font></div></div></div></div>';
                        }
                        xszf += '</div><div class="div-group-5 pb-15"><div id="thumbs" class="overflow-hidden">';
                        var picurl = v[i].picurls;
                        if (picurl!=null) {
                            for (var j = 0; j <3; j++) {
                                if (picurl[j]!=''&&typeof(picurl[j])!="undefined") {
                                   if(j==2&picurl.length>3){
                                     xszf += '<i class="col-6 pt-2"><a href="javascript:details(' + v[i]._id + ',\'' + v[i].fromUserid + '\')" class="pull-left position-r" style="background-image:url(${filehttp}' + picurl[j] + ')"><div class="position-a"style="right: 0px; top:0px;"><div class="bg-hei-8 txt-c zi-bai overflow-hidden pr-5 pl-5" style=" height:20px;line-height:20px;"><font size="1"><i class="pr-5">'+(picurl.length-1)+'</i>张</font></div></div></a></i>';
                                   }else{
                                     xszf += '<i class="col-6 pt-2"><a href="javascript:details(' + v[i]._id + ',\'' + v[i].fromUserid + '\')" class="pull-left position-r" style="background-image:url(${filehttp}' + picurl[j] + ')"></a></i>';
                                   }
                                }
                            }
                        }
                        xszf += '</div></div><div class="pl-5 pr-5">';
                        if (v[i].address != null) {
                            xszf += '<font size="1"><div class="zi-lan-tq pt-10 pb-10 weight500">'
                            + '<i class="">' + v[i].address + '</i></div></font>';
                        }
                        xszf += '<div class=" bg-bai zi-hui cmp640"><font size="2">'
                        + '<div class="col-3 line-right">';
                        if (v[i].exceptional != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">' + v[i].exceptional + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3 line-right">';
                        if (v[i].reading !== null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-eye pr-5"></i>览<i class="pl-2">' + v[i].reading + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-eye pr-5"></i>览<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3 line-right" onclick="submint('+v[i]._id+',\''+v[i].fromUserid+'\')">';
                        if (v[i].commentcount != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">' + v[i].commentcount + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3">';
                        if (v[i].praise != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"  onclick="spraise('+v[i]._id+',this)"><i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">' + v[i].praise + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"  onclick="spraise('+v[i]._id+',this)"><i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div></font></div></div>'
                        + '<div class="pt-10 clear"><div class="pt-8 bg-hui-tx"></div></div>';
                    }
                    fypage++;
                } else {
                }
                issend = true;
                $('#ajaxdiv').html(xszf);
                $("#loading").hide();
            }, "json");
        }
        function ajaxstick() {
            var submitData = {};
            $.post('${ctx}/suc/bbs!ajaxstick.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {
                var xszf = '';
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<div class="position-r pt-5 pl-5 pr-5">'
                        + '<div class=" overflow-hidden pull-left" style="padding-left: 50px;">'
                        + '<div class="weight500 pt-10 sl pull-left zi-lan-tq">'
                        + '<font size="2"><div class="pull-left pr-5 pt-2">' +v[i].bbs.nikename+ '</div>';
                         if (v[i].bbs.level!=null) {
                            xszf += '<div class="pull-left pr-5 pt-2"><div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;"><font size="1"><i class="pr-5">LV</i><i>' + v[i].bbs.level + '</i></font></div></div>';
                        } else {
                            xszf += '<div class="pull-left pr-5 pt-2"><div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;"><font size="1"><i class="pr-5">LV</i><i>1</i></font></div></div>';
                        }
                        if(v[i].bbs.activity == 1){
                        xszf += '<div class="pull-left pr-5 pt-2">'
                             +'<div class="pl-5 pr-5 weight100 zi-bai btn-hong" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">'
                             +'<font size="1">悬赏</i></font></div></div>';
                        }
                        xszf += '<div class="pull-left pr-5 pt-2">'
                        + '<div class="pl-3pr-3 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">'
                        + '<font size="1"><i class="fa fa-arrow-up" style="line-height:14px;"></i></font></div></div></font></div>' 
                        + '<div class="zi-6 clear"><div class="pt-9 pull-left weight500">'
                        + '<font size="2"><i>' + v[i].bbs.createdate + '</i>';
                        xszf += '</font></div></div></div>'
                        + '<div class="position-a img-wh50 pl-5" style="top:15px; left:0px;">';
                        var content = replace_em(v[i].bbs.content);
                        if (v[i].bbs.headimgurl != null) {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${filehttp}/' + v[i].bbs.headimgurl + ')"></div>'
                        } else {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>'
                        }
                        xszf += '</div><div class="clear pt-15" onclick="details(' + v[i].bbs._id + ',\'' + v[i].bbs.fromUserid + '\')">'
                        + '<div class="size12 weight500 zi-6 width-10 qjhh hang-sl-4" style="line-height: 20px;">'
                        + '<font size="2">' + content + '</font></div></div>';
                        if (v[i].bbs.voice != null) {
                            xszf += '<div class="clear pt-10"><div class="hang30 pl-5 pr-5 border-radius3 width-3 overflow-hidden line-lu">'
                            + '<div class="img-wh18 pull-left pt-4"><img src="${ctx}/mvccol/img/bbs2/yuyin.gif" width="100%"></div>'
                            + '<div class="pull-right zi-6 weight500"> <div style="line-height: 30px;"><font size="1"> 10s </font></div></div></div></div>';
                        }
                        xszf += '</div><div class="div-group-5 pt-10"><div id="thumbs" class="overflow-hidden">';
                        var picurl = v[i].bbs.picurls;
                        if (picurl != null) {
                            for (var j = 0; j < picurl.length; j++) {
                                 if(j==2&picurl.length>3){
                                     xszf += '<i class="col-6 pt-2"><a href="javascript:details(' + v[i].bbs._id + ',\'' + v[i].bbs.fromUserid + '\')" class="pull-left position-r" style="background-image:url(${filehttp}' + picurl[j] + ')"><div class="position-a"style="right: 0px; top:0px;"><div class="bg-hei-8 txt-c zi-bai overflow-hidden pr-5 pl-5" style=" height:20px;line-height:20px;"><font size="1"><i class="pr-5">'+(picurl.length-1)+'</i>张</font></div></div></a></i>';
                                   }else{
                                     xszf += '<i class="col-6 pt-2"><a href="javascript:details(' + v[i].bbs._id + ',\'' + v[i].bbs.fromUserid + '\')" class="pull-left position-r" style="background-image:url(${filehttp}' + picurl[j] + ')"></a></i>';
                                   }
                            }
                        }
                        xszf += '</div></div><div class="pl-5 pr-5">';
                        if (v[i].bbs.address != null) {
                            xszf += '<font size="1"><div class="zi-lan-tq pt-10 weight500">'
                            + '<i class="">' + v[i].bbs.address + '</i></div></font>';
                        }
                            xszf += '</div><div class=" bg-bai zi-hui cmp640"><font size="2">'
                        + '<div class="col-3 line-right">';
                        if (v[i].bbs.exceptional != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">' + v[i].bbs.exceptional + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3 line-right">';
                        if (v[i].bbs.reading !== null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-eye pr-5"></i>览<i class="pl-2">' + v[i].bbs.reading + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-eye pr-5"></i>览<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3 line-right" onclick="submint('+v[i].bbs._id+',\''+v[i].bbs.fromUserid+'\')">';
                        if (v[i].bbs.commentcount != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">' + v[i].bbs.commentcount + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3">';
                        if (v[i].bbs.praise != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"  onclick="spraise('+v[i].bbs._id+',this)"><i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">' + v[i].bbs.praise + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"  onclick="spraise('+v[i].bbs._id+',this)"><i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div></font></div></div>'
                        +'<div class="pt-10 clear"><div class="pt-8 bg-hui-tx"></div></div>';
                    }
                } else {
                }
                $('#ajaxstickdiv').html(xszf);
            }, "json");
        }
          function  spraise(id,thi){ 
         var submitData = {
    	        bmtid:id,
	            };  
       $.post('${ctx}/suc/bbs!bbspraiseAdd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 function(json){ 
        	  if(json.state==0){  
        	  var html='<i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">'+(json.value)+'</i>'; 
        	  $(thi).html(html);  
        	  }else if(json.state==3){
        	    alert("请先登录！");
        	  }else if(json.state==2){
        	    alert("已经赞过！");
        	  }else{
        	    alert("点赞失败！");
        	  }
        	 },"json");
    }
    var id=0;
    var toUserid='';
      function  submint(bmtid,toUserid){ 
         id=bmtid;  
         $("#inputsub").show();
         $("#comcontent").focus().val($("#comcontent").val());
        }
      function submitcommentchild(){
         if($("#comcontent").val()=="说点什么"||$("#comcontent").val().length<1){
          alert("评论内容不能为空");
          return;
         }  
          var submitData = {
    	        bmtid:id,
    	        content:$("#comcontent").val(),
	            }; 
         $.post('${ctx}/suc/bbs!ajaxAddcomment.action?custid=${custid}&lscode=${lscode}', submitData,
        	 function(json){
        	  if(json.state==0){ 
        	     var text='评论成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                            noty({text: text,type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                            afterClose: function() {
                               details(id,toUserid);
                            } // 关闭之后
                          },}); 
        	    
        	  }else{
        	   alert("发表失败！");
        	  }
        	 },"json");
        }
         function submintcancel() {
            $("#inputsub").hide();
        }
    </script>
</head>
<body class="bg-bai">
<main class="cmp640" id="section1">
    <div class="position-r overflow-hidden clear" style="height:150px;">
        <img src="${ctx}/mvccol/img/bbs2/xingkong.jpg" width="100%">
        <div class="position-a width-10 cmp640 bg-hei-5"
             style="height:150px;top: 0px;">
        </div>
        <div class="position-a width-10 cmp640" style="top:20px;left: 0px;">
            <div class="position-r">
                <div class="pl-15 position-a">
                    <div class=" pt-3 img-wh90 position-r border-radius5"
                         style="background-color:  rgba(255, 255, 255, 0.7)">
                        <c:if test="${not empty share.fximg}">
                            <div class="img-wh80 border-radius5 maring-a img-bj position-r overflow-hidden"
                                 style="background-image: url(${filehttp}/${share.fximg});width: 84px;height: 84px;">
                            </div>
                        </c:if>
                        <c:if test="${empty share.fximg}">
                            <div class="img-wh80 border-radius5 maring-a img-bj position-r overflow-hidden"
                                 style="background-image: url(${ctx}/mvccol/img/bbs2/beijing.jpg);width: 84px;height: 84px;">
                            </div>
                        </c:if>
                    </div>
                    <div class="position-a display-none" style="bottom: 0px;left:15px;">
                        <div class="bg-cheng " style="width:80px; height: 15px;"></div>
                    </div>
                </div>
                <div class="zi-bai " style="padding-left:115px;height:80px;">
                    <div class="weight500 pt-5">
                        <font size="4">
                            <div class="width-5 maring-a clear sl pull-left">${share.fxtitle}</div>
                        </font>
                    </div>
                    <div class="pt-7 weight100 clear">
                        <font size="2"><i class="pr-10">话题${bbscount}</i><i>关注${bbsll}</i></font>
                    </div>
                    <div class="pt-7">
                        <div class="pull-left">
                            <font size="1">
                                <div class="pl-5 pr-5 weight100 border-radius3"
                                     style="height:18px; line-height:20px;background-color: #f8a963;">
                                    <i>LV</i><i>${user.level}</i>
                                </div>
                            </font>
                        </div>
                    </div>
                    <div class="clear pt-7">
                        <div class="border-radius5 overflow-hidden bg-bai-5" style="width:100px;height: 4px;">
                            <div class="bg-green border-radius5" style="width:${user.expbl}px;height:4px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${user.isadmin==true}">
            <div class="position-a" style="right:5px;top:10px;">
                <a href="#">
                    <div class="pb-15">
                        <div class="hang20 border-radius3 pl-5 pr-5 btn-lan-tq zi-bai weight500">
                            <font size="1">
                                <i class="fa fa-cog fa-spin" style="line-height:22px;"></i><i class="pl-5">管理</i>
                            </font>
                        </div>
                    </div>
                </a>
            </div>
        </c:if>
        <!--改进后的导航可以左右滑动-->
        <div class="overflow-hidden pt-9 width-10 weight500 bg-hei-8 position-a cmp640"
             style="bottom:0px; left:0px;height:28px; line-height:16px;">
            <font size="2">
                <div class="yListr1 clear width-10 swiper-container pl-5 pr-5">
                    <ul class="swiper-wrapper">
                        <em class="swiper-slide links_tt txt-c dhid" id="zx"><a class="zi-hui"
                                                                                      href="#">最新</a></em>
                        <em class="swiper-slide links_tt txt-c dhid" id="zr"><a class="zi-hui" href="#">最热</a></em>
                        <c:if test="${not empty bbstype }">
                            <c:forEach items="${bbstype}" var="bean">
                                <em class="swiper-slide txt-c dhid" id="${bean.type}"><a class="zi-hui"href="#">${bean.title}</a></em>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </font>
        </div>
        <!--改进后的导航可以左右滑动-->
    </div>
    <!--中部广告-->
    <c:if test="${not empty advlist}">
    <div class="width-10 clear position-r" id="tanchuguanggao">
        <div id="banner_box" class="box_swipe">
            <ul>
                <c:forEach items="${advlist}" var="bean">
                    <li><a href="${bean.url}">
                        <img src="${filehttp}${bean.picurl}"
                             alt="${bean.title }" style="width: 100%;"/> </a></li>
                </c:forEach>
            </ul>
        </div>
        <a href="javascript:guanggaohide()">
            <div class="position-a zi-green pl-10 pb-10" style="top:3px; right:3px;">
                <div class="img-wh18 txt-c border-radius50 bg-bai">
                    <font size="2">
                        <i class="fa fa-remove weight500" style="line-height:20px;"></i>
                    </font>
                </div>
            </div>
        </a>
    </div>
    <script>
        $(function () {
            new Swipe(document.getElementById('banner_box'), {
                speed: 500,
                auto: 3000,
                callback: function () {
                    var lis = $(this.element).next("ol").children();
                    lis.removeClass("on").eq(this.index).addClass("on");
                }
            });
        });
    </script> 
    </c:if>
    <c:if test="${empty advlist }">
     <div class="width-10 clear position-r display-none" id="tanchuguanggao">
        <div class="bg-hui"></div>
        <a href="${ctx}/suc/advertising!webadd.action?custid=${custid}&lscode=${lscode}">
            <img src="${ctx}/mvccol/img/bbs2/guanggaoyulan.jpg" width="100%">
        </a>
         <a href="javascript:guanggaohide()">
            <div class="position-a zi-green pl-10 pb-10" style="top:3px; right:3px;">
                <div class="img-wh18 txt-c border-radius50 bg-bai">
                    <font size="2">
                        <i class="fa fa-remove weight500" style="line-height:20px;"></i>
                    </font>
                </div>
            </div>
        </a>
    </div>
    </c:if>
    <!-- 置顶开始 -->
    <div id="ajaxstickdiv"></div>
    <!-- 置顶结束 -->
    <div id="ajaxdiv"></div>
    <div class="width-10 txt-c zi-hui-wx div-group-10 display-none" id="loading">
        <i class="fa fa-spinner fa-1dx fa-spin2"></i>
    </div>
      <%@include file="/webcom/foot.jsp" %>
</main>
<%@include file="/webcom/return-top.jsp" %>
<div class="clear hang50"></div>
<%@ include file="/webcom/bbs-foot.jsp" %>
<!--浮动广告条-->
<c:if test="${ not empty floatadv}">
    <div class="position-f cmp640" id="tanchuguanggaof" style="top: 0px;left: 0px;z-index: 1000;">
        <div class="bg-hei-8 position-r div-group-5 overflow-hidden">
            <a href="#">
                <div class="img-wh30 border-radius3 pull-left overflow-hidden">
                    <img src="img/cmp_logo.png" class="width-10">
                </div>
                <div class="hang30 pl-10 pull-left" style="line-height: 32px;">
                    <font size="2">
                        <i class="zi-bai">联系我们为您提供更多的服务！</i>
                    </font>
                </div>
                <a href="#">
                    <div class="pull-left pl-15 pt-5">
                        <div class="zi-bai maring-a pl-10 pr-10 hang20 txt-c btn-green border-radius3 weight500 zi-bai"
                             style="line-height: 22px;">
                            <font size="1">
                                立即查看
                            </font>
                        </div>
                    </div>
                </a>
            </a>
            <a href="javascript:xiaoshiguanggaof()">
                <div class="position-a pt-10 pr-5" style="right:0px;top:0px;">
                    <div class="img-wh20 border-radius50 bg-bai txt-c">
                        <font size="2">
                            <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
</c:if>
<!--底部输入框-->
<div class="position-f width-10 pr-5 bg-bai pt-7 pb-5 shadow-wai cmp640 display-none" style="z-index: 2;bottom: 0px;left: 0px;" id="inputsub">
    <div class="hang30 col-1 txt-c zi-hui-tq" id="qqface">
            <i class="fa fa-smile-o fa-1dx" style="line-height: 30px;"></i>
    </div>
    <div class="hang30 pt-5 bg-bai col-7 line-lu border-radius5">
        <input id="comcontent" class="width-10 pl-5 pr-5 zi-hui-tq border-radius5" style="line-height:20px;height:22px;" type="text"
               name=""
               placeholder="说点什么">
    </div>
    <font class="weight500" size="2"> 
            <div class=" col-2 overflow-hidden zi-bai" onclick="submintcancel()">
                <div class="hang30 txt-c btn-hong width-9 maring-a border-radius3" style="line-height:32px;">
                    取消
                </div>
            </div>
            <div class=" col-2 overflow-hidden zi-bai" onclick="submitcommentchild()">
                <div class="hang30 txt-c btn-green width-9 maring-a border-radius3" style="line-height:32px;">
                    发送
                </div>
            </div>
    </font>
    <div class="clear div-group-5 display-none " id="qqbq">
        <div class="zi-bai bg-cheng weight500 hang30">
            <i style="font-size: 20px;">表情放置处</i>
        </div>
    </div>
</div>
<!--点击小图弹出大图代码-->
<script src="${ctx}/app/js/touchTouch.jquery.js"></script>
<script src="${contextPath}/mvccol/qqFace/js/jquery.qqFace1.js"></script>
<script>
    $(function () { 
        $('#thumbs a').touchTouch();
    });
    $(function(){
	$('#qqface').qqFace({
		id : 'facebox', 
		assign:'comcontent', 
		path:'${contextPath}/mvccol/qqFace/arclist/'	//表情存放的路径
	});
	$(".sub_btn").click(function(){
		var str = $("#saytext").val();
		$("#show").html(replace_em(str));
	});
});
</script>
<!--点击小图弹出大图代码结束-->
<!--限制textarea框字数代码-->
<script language="JavaScript">
    function textCounter(field, countfield, maxlimit) {
        // 函数，3个参数，表单名字，表单域积分素名，限制字符；
        if (field.value.length > maxlimit)
        //如果积分素区字符数大于最大字符数，按照最大字符数截断；
            field.value = field.value.substring(0, maxlimit);
        else
        //在记数区文本框内显示剩余的字符数；
            countfield.value = maxlimit - field.value.length;
    }
</script>
<!--滑动导航-->
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        slidesPerView: 5,
        paginationClickable: true,
        spaceBetween: 30,
        freeMode: true
    });
</script>
<!--滑动导航结束-->
<script>
    subtype='${type}';  
    if (subtype == '2') {
        $('#zr').addClass("title");
    } else if (subtype == '1'||subtype=='') {
        $('#zx').addClass("title");
    } else {
        $('#' + subtype).addClass("title");
    }
    $(function (){
        loadingshow();
        ajaxjz(false, 0);
        loadinghide();
        ajaxstick();
    });
</script>
<script>
    function  check_task(){
       var submitData = { 
                type:"bbsshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&&lscode=${lscode}', submitData,

                    function (json) { 
                        if (json.state == 0) {
                            var text='分享成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                          swal({
                                text: text,
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }  
                    }, "json");
     
     }
</script> 
<script type="text/javascript"> 
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) { 
            ajaxjz(true, fypage); 
        }
 });
wx.config({
    debug: false,
    appId: '${token.appid}', 
    timestamp: '${token.timestamp}', 
    nonceStr: '${token.noncestr}', 
    signature: '${token.signature}',
    jsApiList: [ 'checkJsApi',
                 'onMenuShareTimeline',
                 'onMenuShareAppMessage',
                 'onMenuShareQQ',
                 'onMenuShareWeibo',
                 'hideMenuItems',
                 'showMenuItems'
                 ] 
});
wx.ready(function(){ 
	var share={
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
<%@ include file="/webcom/loading.jsp" %>
<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}">
  <%@ include file="/webcom/focus-page.jsp" %>
 </c:if>
</c:if>
<c:if test="${com.zsjf>0}"> 
  <%@ include file="/webcom/jfts-page.jsp" %> 
</c:if>
</body>
</html>