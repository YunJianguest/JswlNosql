<%@ page contentType="text/html;charset=UTF-8"%>	

<!--截图-->
<div class="position-f bg-hei-5 width-10 cmp640 display-none" style="height:100%;z-index: 1100;top: 0px;left: 0px;" id="jttanchu">



    <div id="clipArea"class="bg-hei-5"></div>


    <div class="pt-15">
        <div class="col-6 pl-5 pr-5">
            <div class="border-radius5 pt-2 position-r txt-c zi-bai btn-green hang40 line-height40 weight500">
                <i >选择图片</i>
                <input class="position-a beijing-tm"style="top: 0px;left: 0px;" type="file" id="file" value="上传图片" >
            </div>
        </div>
        <div class="col-6 pl-5 pr-5">
            <div id="clipBtn" class="border-radius5 pt-2 txt-c zi-bai btn-green hang40 line-height40 weight500">
                截取图片
            </div>
        </div>
       <!--  <div class="col-4 pl-5 pr-5">
            <div  onclick="gb()" class="border-radius5 pt-2 txt-c zi-bai btn-green hang40 line-height40 weight500">
                确认上传
            </div> -->
        </div>
        
        <div class="position-f cmp640"style="top:15px; left:15px;">
        <div id="view"class="display-none border-radius5"></div>
    </div>



    <!--点击关闭按钮-->
    <a href="javascript:gb()">
        <div class="position-f cmp640"style="left:0px; top:0px;">

            <i class="fa fa-remove zi-bai fa-1dx pull-right pr-10 pt-10"></i>
        </div>
    </a>
        
    </div>

 
<!--结束-->

    <style>
        #clipArea {
            margin-top:120px;
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

        .beijing-tm{
            filter:alpha(opacity=0);  -moz-opacity:0;  -khtml-opacity: 0;  opacity: 0;
        }
    </style>
    <!--截图插件代码结束-->
       <script src="${ctx}/app/js/iscroll-zoom.js"></script>
     <script src="${ctx}/app/js/hammer.js"></script>
     <script src="${ctx}/app/js/jquery.photoClip.js"></script>
  <script>
var cid='';
var vid='';
function pz(id,w,h,tag,v){ 
    cid=id;
    vid=v; 
	$('#jttanchu').show();
	$("#clipArea").photoClip({
	    width: w,
	    height: h,
	    file: "#file",
	    view: "#view",
	    ok: "#clipBtn", 
	    loadStart: function () {
	        console.log("照片读取中");
	    },
	    loadComplete: function () {
	        console.log("照片读取完成");
	    },
	    clipFinish: function (dataURL) {
	    	upimage(dataURL,tag);
	    	//$('#clipArea').html('');
	    	gb();
	    }
	});
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
        		$("#"+vid).find('img').attr('src','${filehttp}/'+json.path);
        		$("#"+vid).removeClass('div-group-15');
        		}
        		
        		
        		$('#jqpic').hide();
        	}
        },"json")
  
} 
function gb(){
    	$('#jttanchu').hide(); 
    	$('#clipArea').html('');
    	
    } 

</script>
<script>
    //document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
  /*  $("#clipArea").photoClip({
        width: 200,
        height: 200,
        file: "#file",
        view: "#view",
        ok: "#clipBtn",
        loadStart: function () {
            console.log("照片读取中");
        },
        loadComplete: function () {
            console.log("照片读取完成");
        },
        clipFinish: function (dataURL) {
            console.log(dataURL);
            
        }
    });*/
</script>

