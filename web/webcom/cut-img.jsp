<%@ page contentType="text/html;charset=UTF-8"%>
 <style>
        #clipArea {
            margin-top: 90px;
            margin-left: auto;
            margin-right: auto;
            /*width: 300px;*/
            height: 300px;
        }

        #file,
        #clipBtn {
            width: 100%;
            height: 100%;
        }

        #view {
            width: 80px;
            height: 80px;
        }

        .beijing-tm {
            filter: alpha(opacity=0);
            -moz-opacity: 0;
            -khtml-opacity: 0;
            opacity: 0;
        }
    </style>
    <!--截图插件代码结束-->
<div class="fullscreen bg-hei-8 display-none" style="height: 100%;" id="cut_pic">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">上传图片</i>
                    </div>
                    <a href="javascript:cut_pic_hide()">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <div class="pl-10 pr-10 overflow-auto position-r" style="height:450px;">

                    <div id="clipArea" class="bg-hei-5"></div>

                    <div class="position-a display-none" style="top:5px; left:10px;">
                        <div id="view" class=" border-radius5"></div>
                    </div>

                </div>
                <div class="div-group-10 line-top">
                    <div class="width-10 maring-a clear zi-bai weight500 hang40">
                        <div class="pull-left pr-5 width-5 position-r overflow-hidden">
                            <div class="btn-lan hang40 txt-c line-height40 weight500 border-radius3">选取图片</div>
                            <input class="position-a beijing-tm width-10" style="top: 0px;left: 0px;" type="file" id="file"
                                   value="上传图片">
                        </div>
                        <div class="pull-right pl-5 width-5" id="cut_ok">
                            <div class="btn-lan hang40 txt-c line-height40 weight500 border-radius3" id="clipBtn">截取上传</div>
                        </div>
                    </div>
                </div>



            </div>
        </div>

    </div>
</div> 
<script src="${ctx }/app/js/iscroll-zoom.js"></script>
<script src="${ctx }/app/js/hammer.js"></script>
<script src="${ctx }/app/js/jquery.photoClip.js"></script> 
<script>
var cid='';
function pz(id,w,h,tag){
     cid=id;
     $("#clipArea").photoClip({
	    width: w,
	    height: h,
	    file: "#file",
	    view: "#view",
	    ok: "#cut_ok",
	    outputType:"png",
	    loadStart: function () {
	        console.log("照片读取中");
	    },
	    loadComplete: function () {
	        console.log("照片读取完成");
	    },
	    clipFinish: function (dataURL) {
	    	upimage(dataURL,tag);
	    	$('#clipArea').html('');  
	    	return;
	    }
	});

	$('#cut_pic').show();
}
function upimage(baseurl,tag) {
    var submitData = {
    		baseurl: baseurl
    };
    $.post('${ctx}/web/webajax!upimage.action?toUser=${toUser}', submitData,
    	function (json) {
        	if(json.state==0){
        		if(tag){
        		$("#"+cid).val($("#"+cid).val()+","+json.path);  
        		}else{
        		$("#"+cid).val(json.path);  
        		}
        		$('#cut_pic').hide();
        		return;
        	}
        },"json")
} 
function cut_pic_hide(){ 
    	$('#cut_pic').hide();
    	$('#clipArea').html('');
    }
</script>