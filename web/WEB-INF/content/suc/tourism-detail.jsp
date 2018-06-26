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
    <title>${title }</title>
    <!-- Resource style -->
    <script type="text/javascript" src="/CcjhNosql/cmp/js/jquery-1.8.3.js"></script>
    <link href="${ctx }/cmp/css/cmp_common_603.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/cmp/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/cmp/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/cmp/css/style_0.css" rel="stylesheet">
    <link href="${ctx }/mvccol/css/wbs-css.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx }/cmp/js/main.js"></script>
    <script type="text/javascript" src="/CcjhNosql/cmp/js/iscroll.js"></script>   
    <link rel="stylesheet" href="${ctx}/wwz/css/bbsmain.css" />
    <link rel="stylesheet" href="${ctx}/wwz/css/bbsdialog.css" /> 
    <!-- Resource style -->
    <script type="text/javascript" src="${ctx}/wwz/js/bbspics.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbsinput.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbsmain.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbsdialog.js"></script>
    <script type="text/javascript" src="${ctx}/wwz/js/bbshelper.js"></script>
    <script type="text/javascript" src="${ctx }/cmp/js/swipe.js"></script>
    
     
    <script>
        $(function () {
            new Swipe(document.getElementById('banner_box'), {
                speed: 500,
                auto: 3000,
                callback: function () {
                
                }
            });
        });
      
    </script>
    
    <script>
 
function xz_title(){
	$('#seldiv').show();
}
function gb(){
	$('#seldiv').hide();
}  

function praiseTrends(thi,flag,trendsid) {
		 
		$.post('${ctx}/wwz/bbs!trendspraise.action?toUser=${toUser}&fromUser=${fromUser}&type=${type}&trendsid='+trendsid+"&flag="+flag, function(res) {
			 
			if (res.length>0) {
				$(thi).find('label').html(res);
				if(flag){
				    $(thi).find('span').removeClass('zi-lu');
					$(thi).find('span').addClass('zi-hui'); 
					
					$(thi).attr('onclick','praiseTrends(this,false,'+ trendsid +');');
				}else{
				    $(thi).find('span').removeClass('zi-hui');
					$(thi).find('span').addClass('zi-lu');
				   
					$(thi).attr('onclick','praiseTrends(this,true,'+ trendsid +');');
				}
			}else {
				alert("请求失败...","1000");
			}
		});
	} 
</script>
<script>
        $(document).ready(function () {

            var _objscroll = {
                win: $(window),
                doc: $(document),
                gotopdiv: $('#gotop')
            };

            _objscroll.win.scroll(function () {
                if (_objscroll.win.scrollTop() > _objscroll.win.height()) {
                    _objscroll.gotopdiv.show();
                } else {
                    _objscroll.gotopdiv.hide();
                }

            });

            _objscroll.gotopdiv.click(function () {
                _objscroll.win.scrollTop(0);
                return false;

            });

        });
        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }
        
  function gettype(ths){
    if(ths.checked==true){
     type+=ths.value+",";
    }
  } 
  function xiaoshi2() {
    $('#tanchu2').hide();
  }
 function fb(){
 $('#fb').show();
 }
 function submit(){
     var  submitdata={
       wid:'${entity._id}',
       type:'tourism',
       context:$("#context").val(),
       picurl:$("#picucl").val()
    }
    $.post("${ctx}/suc/tourism!savecomment.action?toUser=${toUser}&fromUser=${fromUser}",submitdata,function(v){
     location.reload();
    });
     //$('#form_1').attr("action","${ctx}/suc/tourism!savecomment.action?toUser=${toUser}&fromUser=${fromUser}");
 	  
 	
 	// $('#form_1').submit(); 
 }
 function showImg(img){
   $("#picurl").val(img);
    var html="";
    var imgs=img.split(",");
    for ( var i = 0; i < imgs.length; i++) {
		html+='<div class="img-bj pull-left  mr-10  border-radius5" style="background-image: url(${osshttp}'+imgs[i]+');width:70px; height:70px;"></div>';
	}
  $("#photos").html(html);
  $("#photos").show();
   
 }
 
</script>

</head>
<body class="cmp640"> 

<div class="hang40"></div> 
  <main class="cmp640">
    <div class="hang30 bg-cheng"></div>
    <img src="${osshttp}${entity.picurl}" width="100%">

    <div class="bg-hei-8 size12 zi-bai div-group-5">
        <div class="size16 weight500">${entity.title }</div>
        <div class="size10 weight100 pt-5">${entity.summary}</div>
        <div class="display-none pt-5" id="tanchu-content">${entity.context}</div>
    </div>

    <div class="hang40 bg-cheng zi-bai size12  pl-5 pr-5">
        <div class="pull-left">
            热点评论
        </div>
        <a href="javascript:bf()">
            <div class="pull-right">
                查看景点详情
                <i class="fa fa-chevron-down pl-5 " id="bfid"></i>
                <i class="fa fa-chevron-up pl-5 display-none" id="ztid"></i>

            </div>

        </a>
    </div>

  <c:forEach items="${detailList}" var="bean">
    <div class="div-group-5 pt-5  overflow-hidden line-bottom">
        <div class="pl-5 pt-5 col-2 ">
            <div class="touxiang t50 " style="border-radius: 50%;">
           
                <img claas="" src="img/touxiang.jpg">
            
            </div>
        </div>
        <diiv class="col-10 size14 mt-10 ">
            <div class="col-12">
                <div class="div-group-5">
                
                    <div class="size14 sl width-3">${bean.name}</div>

                    <div class="size12 zi-hui pull-left"><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/></div>
                    <div class="size12 pull-right pr-5">
                       
                    </div> 
                    <div class="zi-hei pt-5 clear">
                       ${bean.context}
                    </div>

                    <div class="col-12 pl-10 pt-10 pb-10">
                       
                    <c:if test="${bean.picurl!=null}">
							<figure data-count="${fn:length(bean.picurl)}张图片" style="z-index:0;">
								<div>
									<c:forEach items="${bean.picurl}" var="picbean">
									<img src="${ctx}/${picbean}" data-src="${ip}/${picbean}" data-gid="${bean._id}"
														onload="preViewImg(this, event);" style="with:70px;height: 70px" />
									</c:forEach>
								</div>
							</figure>
					</c:if>
                    </div>

                </div>
            </div>
        </diiv>
    </div>
</c:forEach>



<div class="hang50"></div>
    <div class=" button_foot shadow-wai hang50 bg-bai cmp640">
        <div class="div-group-5">
            <a href="javascript:fb()">
       <span class="col-12 zi-hong size12 weight500">
          <input class="width-10 pl-10 hang30 line-lu border-radius3 zi-hui" style="height: 38px;" type="text" name=""
                 value="请输入您所要评论的内容" onfocus="javascript:if(this.value=='请输入您所要评论的内容')this.value='';">
       </span>
            </a>

        </div>
    </div>


    <!--Pop layer-->
    <div class="fullscreen cmp640" id="fb" style="display: none;">
       <form id="form_1">
        <input value="${entity._id}" name="wid" style="display: none;" />
        <input id="picurl" name="picurl" style="display: none;" />
        <div class=" div-group-5">
            <div class=" div-group-10  overflow-hidden bg-bai border-radius3">
                <div class="col-12 ">
                  
                        <textarea placeholder="请输入您所要评论的正文" rows="5" class="form-control" name="context" id="context"></textarea>
                 
                </div>
                <div class=" pt-5  clear">
                    
                    <a href="javascript:pz()">
                        <i class="fa fa-photo fa-1dx pr-20 zi-hui"></i>
                    </a>
                    <a href="javascript:submit()">
                        <div class="btn-lu hang30 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3">
                            发布
                        </div>
                    </a>
                    <a href="javascript:xiaoshi2()">
                        <div class="btn-lan hang30 mr-10 zi-bai txt-c size14 weight500 pull-right col-2 border-radius3">
                            退出
                        </div>
                    </a>
                </div>
 
                <div class="col-12" id="photos" style="display: none;">
                     
                </div>
 

            </div>
               </form>
        </div>
    </div>

</main>

  
  
  
 
 
<script type="text/javascript">
var mediaId="";
		wx.config({
		    debug: false,
		    appId: '${token.appid}', 
		    timestamp: '${token.timestamp}', 
		    nonceStr: '${token.noncestr}', 
		    signature: '${token.signature}',
		    jsApiList: [ 'onMenuShareTimeline',
		                 'onMenuShareAppMessage',
		                 'onMenuShareQQ',
		                 'onMenuShareWeibo',
		                 'chooseImage',
		                 'previewImage',
		                 'uploadImage',
		                 'downloadImage'
		                 ] 
		});

		wx.ready(function(){
			var share={
					title: '${fx.fxtitle}', // 分享标题
				    desc: '${fx.fxsummary}', // 分享描述
				    link: '${fx.fxurl}', // 分享链接
				    imgUrl: '${osshttp}${fx.fximg}', // 分享图标
				    success: function () { 
				      
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
		// 5 图片接口
		  // 5.1 拍照、本地选图
		  
		  function pz(){
			 
			  wx.chooseImage({
			
			      success: function (res) {
			    	var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			    	syncUpload(localIds);
			    	
			    	
			      }
			    }); 
		  }
		  var syncUpload = function(localIds){
			  var localId = localIds.pop();
			  wx.uploadImage({
			    localId: localId,
			    isShowProgressTips: 1,
			    success: function (res) {
			      var serverId = res.serverId; // 返回图片的服务器端ID
			      //其他对serverId做处理的代码
			      mediaId=mediaId+","+serverId;
			      if(localIds.length > 0){
			        syncUpload(localIds);
			      }else{
			    	  save(mediaId); 
			      }
			    }
			  });
			};
		 
		  function save(mediaId){
			  
				if (mediaId == '') {
					alert("请选择上传照片 ");
					return;
				}
					var submitData = {
							mediaId:mediaId
					};
					$.post('${ctx}/wwz/wwzajax!saveimgtoss.action?toUser=${toUser}&tzadmin=1', submitData,
						function(data) {
							if (confirm('请耐心等待,我们工作人员将及时处理')) {
								wx.closeWindow();	
		    				}
		    				
		    				showImg(data.imgurl);
						},
						"json")
			}

</script>
</body>
</html>