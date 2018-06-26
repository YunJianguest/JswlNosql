//热门搜索
$(function(){
$(".pbody a:gt(14)").hide();
$(".refresh").toggle(
  function(){
	$(".pbody a:gt(14)").show();
	$(".pbody a:lt(15)").hide();
  },
  function(){
	$(".pbody a:gt(14)").hide();
	$(".pbody a:lt(15)").show();
   }
  );	   
});

//lglindex显示和隐藏
$(document).ready(function(){ 
  $(".lglindex li").each(function(n,value){if((n+1)%5==0){$(this).find('a').addClass('no_line');}});
  $(".more-category a").toggle(
  function () {
	 $(this).html('收起分类<i class="up"></i>');	 
    $(".hid").show();
  },
  function () {
	  $(this).html('更多分类<i class="down"></i>');
    $(".hid").hide();
  }
);
});

function openShutManager(oSourceObj,oTargetObj,shutAble,oOpenTip,oShutTip){
var sourceObj = typeof oSourceObj == "string" ? document.getElementById(oSourceObj) : oSourceObj;
var targetObj = typeof oTargetObj == "string" ? document.getElementById(oTargetObj) : oTargetObj;
var openTip = oOpenTip || "";
var shutTip = oShutTip || "";
if(targetObj.style.display!="none"){
   if(shutAble) return;
   targetObj.style.display="none";
   if(openTip  &&  shutTip){
    sourceObj.innerHTML = shutTip; 
   }
} else {
   targetObj.style.display="block";
   if(openTip  &&  shutTip){
    sourceObj.innerHTML = openTip; 
   }
}
}

function selectTag1(showContent,selfObj){
	// 操作标签
	var tag = document.getElementById("selectTag1").getElementsByTagName("li");
	var taglength = tag.length;
	for(i=0; i<taglength; i++){
		tag[i].className = "";
	}
	selfObj.parentNode.className = "selectTag";
	// 操作内容
	for(i=0; j=document.getElementById("tagContent"+i); i++){
		j.style.display = "none";
	}
	document.getElementById(showContent).style.display = "block";
}
function selectTag2(showContent,selfObj){
	// 操作标签
	var tag = document.getElementById("selectTag2").getElementsByTagName("li");
	var taglength = tag.length;
	for(i=0; i<taglength; i++){
		tag[i].className = "";
	}
	selfObj.parentNode.className = "selectTag";
	// 操作内容
	for(i=0; j=document.getElementById("tagContentB"+i); i++){
		j.style.display = "none";
	}
	document.getElementById(showContent).style.display = "block";
}


function on_submit() {
	  if ($.trim($("#saytext").val())==""){
		  alert('评论不能为空哟，赶快说点什么吧!');
		  return false;
	  }
}

tyMap = window.tyMap || {};
function tyViaJs(locationId) {
    var _f = undefined;
    var _fconv = 'tyMap[\"' + locationId + '\"]';
    try {
        _f = eval(_fconv);
        if (_f != undefined) {
            _f()
        }
    } catch(e) {}
}
function tyLoader(closetag) {
    var tyTest = null,
    tyTestPos = document.getElementsByTagName("span");
    for (var i = 0; i < tyTestPos.length; i++) {
        if (tyTestPos[i].className == "tyTestPos") {
            tyTest = tyTestPos[i];
            break
        }
    }
    if (tyTest == null) return;
    if (!closetag) {
        document.write("<span id=tyTestPos_" + tyTest.id + " style=display:none>");
        tyViaJs(tyTest.id);
        return
    }
    document.write("</span>");
    var real = document.getElementById("tyTestPos_" + tyTest.id);
    for (var i = 0; i < real.childNodes.length; i++) {
        var node = real.childNodes[i];
        if (node.tagName == "SCRIPT" && /closetag/.test(node.className)) continue;
        tyTest.parentNode.insertBefore(node, tyTest);
        i--
    }
    tyTest.parentNode.removeChild(tyTest);
    real.parentNode.removeChild(real)
}
tyMap['1'] = function() {
//document.writeln("<script type=\"text\/javascript\">BAIDU_CLB_M_fillSlot(\"829817\");<\/script>");
document.writeln("<script type=\"text/javascript\" src=\"../dup.baidustatic.com/js/zm.js\"></script>");
//document.writeln("<div id=\"baidu_dup_829817\"></div>");
//document.writeln("<script type=\"text/javascript\">(BAIDU_DUP=window.BAIDU_DUP||[]).push([\'fillAsync\',\'829817\',\'baidu_dup_829817\']);</script>");

document.writeln("<a href=\"../sj1.3987.com_3A801/down/tongyizhushou.3987.apk\" id=\"downfile_hits\" data=\"17607\" target=\"_blank\" class=\"tuiguan_img\"><img src=\"statics/wap_skin/zs.jpg\" alt=\"统一安卓助手\" /></a>");

};
tyMap['2'] = function() {
//document.writeln("<script type=\"text\/javascript\">BAIDU_CLB_M_fillSlot(\"829822\");<\/script>");
document.writeln("<div id=\"baidu_dup_829822\"></div>");
document.writeln("<script type=\"text/javascript\">(BAIDU_DUP=window.BAIDU_DUP||[]).push([\'fillAsync\',\'829822\',\'baidu_dup_829822\']);</script>");
   
};



document.writeln("<script type=\"text\/javascript\">");
document.writeln("var _bdhmProtocol = ((\"https:\" == document.location.protocol) ? \" https:\/\/\" : \" ..//default.htm\");");
document.writeln("document.write(unescape(\"%3Cscript src=\'\" + _bdhmProtocol + \"hm.baidu.com\/h.js%3F7c89fa54aa27c2a0169fc6d6448626f3\' type=\'text\/javascript\'%3E%3C\/script%3E\"));");
document.writeln("<\/script>");


//sj.3987
document.writeln("<script type=\"text/javascript\">");
document.writeln("var _bdhmProtocol = ((\"https:\" == document.location.protocol) ? \" https://\" : \" http://\");");
document.writeln("document.write(unescape(\"%3Cscript src=\'\" + _bdhmProtocol + \"hm.baidu.com/h.js%3F9b524955406a08dd541488f9d67e0868\' type=\'text/javascript\'%3E%3C/script%3E\"));");
document.writeln("</script>");

//焦点图
$(function () {
    var lmk123 = {
        com: function (con) {
            var t, imgArr = [], $lmk = $('#foucsBox'), $imgUl = $lmk.find('ul.imgCon'), $titleDiv = $lmk.find('div.showTitle'), $foucsDiv = $lmk.find('div.foucs'), $rlBtn = $lmk.find('.foucsButton'), $rBtn = $lmk.find('.rBtn'), $lBtn = $lmk.find('.lBtn'), config = {
                len: $imgUl.find('li').length,
                //自动滚动时间，默认两千毫秒（一秒等于一千毫秒）
                timeo: 5000,
                //宽，默认
                wid: 320,
                //高，默认
                hei: 124
            }, i = 0, autoChange = function () {
                $imgUl.animate({ marginLeft: '-' + i * config.wid + 'px' }, function () {
                    $foucsDiv.find('span:eq(' + i + ')').addClass('f').siblings().removeClass('f');
                    $rBtn.find('img').replaceWith(imgArr[(i === config.len - 1) ? 0 : (i + 1)]);
                    $lBtn.find('img').length !== 0 ? $lBtn.find('img:eq(0)').replaceWith(imgArr[(i === 0) ? (config.len - 1) : (i - 1)]) : $lBtn.append(imgArr[(i === 0) ? (config.len - 1) : (i - 1)]);
                    i += 1;
                    i = i === config.len ? 0 : i;
                });
            };
            $imgUl.find('img').each(function (inde, ele) {
                imgArr[inde] = new Image();
                imgArr[inde].src = $(this).attr('src');
            });
            $imgUl.css('width', config.len * config.wid);
            $foucsDiv.html(function () {
                var i, s = '';
                for (i = 0; i < config.len; i += 1) {
                    s += '<span ' + (i === 0 ? 'class="f"' : '') + '></span>';
                }
                return s;
            });
            $rBtn.find('img').replaceWith(imgArr[(i === config.len - 1) ? 0 : (i + 1)]);
            $lBtn.find('img').length !== 0 ? $lBtn.find('img:eq(0)').replaceWith(imgArr[(i === 0) ? (config.len - 1) : (i - 1)]) : $lBtn.append(imgArr[(i === 0) ? (config.len - 1) : (i - 1)]);
            t = setInterval(autoChange, config.timeo);
            $lmk.mouseenter(function () { clearInterval(t); }).mouseleave(function () { t = setInterval(autoChange, config.timeo); });
            $rlBtn.hover(function () {
                $(this).addClass('btnHover');
            }, function () {
                $(this).removeClass('btnHover');
            }).click(function () {
                i = $foucsDiv.find('span.f').index();
                if ($(this).is('.lBtn')) {
                    i = (i === 0) ? (config.len - 1) : (i - 1);
                } else {
                    i = (i === config.len - 1) ? 0 : (i + 1);
                }
                autoChange();
            });
            $foucsDiv.find('span').click(function () {
                i = $(this).index();
                autoChange();
            });
        }
    };
    //执行开始
    lmk123.com();
});

$(document).ready(function(){
	$("ul.wapli li .item").hover(
	  function () {
		$(this).addClass("item-hover");
	  },
	  function () {
		$(this).removeClass("item-hover");
	  }
	);

});
$(document).ready(function(){
	$("ul.cat_li li .line").hover(
	  function () {
		$(this).addClass("line-hover");
	  },
	  function () {
		$(this).removeClass("line-hover");
	  }
	);

});
$(document).ready(function(){
	$(".ft-handle li").hover(
	  function () {
		$(this).addClass("li-hover");
	  },
	  function () {
		$(this).removeClass("li-hover");
	  }
	);

});


//内页展开收起效果
if($('.intro-box-txt').height()>250){
	  $('.intro-box-txt').css({height:'250px',overflow:'hidden'});
	  $('#showmore_intro').show().find('a').text('[展开]');
	  $('#ico').addClass("ico");
  };
  function showAllIntro(){
	  $('.intro-box-txt').css({height:'auto',overflow:'auto'});
	  $('#showmore_intro a').text('[收起]');
	  $('#ico').addClass("ico2");
	   $('#ico').removeClass("ico");
  };
  function hideIntro(){
	  $('.intro-box-txt').css({height:'140px',overflow:'hidden'});
	  $('#showmore_intro a').text('[展开]');
	  $('#ico').addClass("ico");
	  $('#ico').removeClass("ico2");
  };
  $('#showmore_intro a').bind('click',function(){
	  if($('.intro-box-txt').height()<=250){
		  showAllIntro();
	  } else {
		  hideIntro();
	  }
  });

//统计下载
$('#downfile_hits').live('click',function(){
var downid = $("#downfile_hits").attr('data');
  $.ajax({
   type: "POST",
   url: "api.php@op=down_hits",
   data:'id='+downid
});
});


//查看更多评论
$('#more_now').live('click',function(){
var commentid=$('#commentid').val();
var old_page=$('#add-content').attr('class');
var page = parseInt(old_page) + 1;
var new_page = page.toString();
 $.ajax({
  type: 'GET',
  url: "api.php",
  data: {op:'add_more',page: new_page,commentid:"'"+commentid+"'"},
  dataType: 'json',
  success: function(data) {
  if (data == '') {
	  alert("没有更多的数据!");
  } else {
	var out = '';
	$.each(data, function(k, v) {
		var div='';
		if(k%2==0){
			div="<div class='lists gap'>";
		}else{
			div="<div class='lists'>";
		}
		if(v.adminreply!=''){
			areply="<div class='xbreply clearfix'><font color='#009900'>小编回复：</font>"+v.adminreply+"</div>";
			out +=div+'<p class="yk">['+v.username+']'+v.creat_at+'</p><p>'+v.content+areply+'</div>';
		}else{
			out +=div+'<p class="yk">['+v.username+']'+v.creat_at+'</p><p>'+v.content+'</div>';
		}
		
	});
	$("#add-content").removeClass(old_page);
	$("#add-content").addClass(new_page);
	$("#add-content").before(out);
  }
  }
});
return false;
});
