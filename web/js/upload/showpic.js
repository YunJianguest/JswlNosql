//显示图片预览DIV
function showpicture(name) {

	var pathvalue = "";
	pathvalue = document.getElementById(name).value;
	if(pathvalue=="")
	{
	 alert("没有可以预览的图片！");
	}
	else
	{
	 var len=pathvalue.length;
	 var endstring=pathvalue.substring(len-1,len);
	 if(endstring==",")//用户判断，如果上传的图片串最后一个字符带有','的话，先去掉','，在进行处理；
	 {
	    pathvalue=pathvalue.substring(0,len-1);
	 }
	var divappends = "";
	var arrypaht = pathvalue.split(",");
	for (var i = 0; i < arrypaht.length; i++) {
		divappends += "<li><a href='/MyNosql"+ arrypaht[i].toString() +"' target='_blank'><img src='/MyNosql" + arrypaht[i].toString() + "' onload='if(this.width>350){this.width = 350;}' border='0'/></a></li>";
	}
	if (divappends != "") {
		document.getElementById("displaypicture").style.display = "block";
	}
	document.getElementById("rollList").innerHTML = divappends;
	}
}

function scall(){
 $("#displaypicture").css("top",document.documentElement.scrollTop+100);
}
window.onscroll=scall;
//关闭图片预览DIV
function closeshow() {
	document.getElementById("displaypicture").style.display = "none";
}

//图片显示效果JS开始
var $id = function (id) {
	return document.getElementById(id);
};
var scrollHori = {locked:0, vector:0, start:function (thiso) {
	if (scrollHori.locked == 0) {
		if (thiso.id == "rollLeft" && $id("rollBox").scrollLeft != 0) {
			scrollHori.vector = -20;
			scrollHori.scroll();
		}
		if (thiso.id == "rollRight" && $id("rollBox").scrollLeft != ($id("rollList").offsetWidth - $id("rollBox").offsetWidth)) {
			scrollHori.vector =20;
			scrollHori.scroll();
		}
	}
}, scroll:function () {
	var step = 0;
	var size = $id("rollList").offsetWidth / $id("rollList").getElementsByTagName("li").length;
	play = setInterval(function () {
		if (size > step) {
			$id("rollBox").scrollLeft += scrollHori.vector;
			step += Math.abs(scrollHori.vector);
			scrollHori.locked = 1;
		} else {
			scrollHori.stop();
		}
	}, 20);
}, stop:function () {
	if (window.play) {
		clearInterval(window.play);
		scrollHori.locked = 0;
	}
}};
//////////////////////图片显示效果JS结束

