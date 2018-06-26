var fileInput=function(v,l) {

	var input =document.querySelector('.'+v);
	var types = [".jpg",".jpeg",".gif",".png",".JPG",".JPEG",".PNG",".RAW"];
	var mpiArr = []; 
	var index = 0; 
    
	input.onchange = function () { 
	  var file = this.files[0]; 
	  var fileName = file.name;
	  var imgSize = file.size;
	  if(!checkFileType(fileName)) {
	    alert("文件类型必须为jpg/jpeg/gif/png");
	    return;
	  }
	  if(imgSize > 10*1024*1024) { //大于2M
	    	alert("请上传小于10M的文件");
	    return;
	  }
	  
	  var base64='';
	  var reader=new FileReader();
	  reader.readAsDataURL(file);
	  reader.onload=function(){
	  base64=this.result; 
	  };
	  
	        setTimeout(function () { 
	            $.post( 
	            	"http://www.pskjyf.com/suc/lrzimg!imginput.action",
	            	{
	                    imgBase64:base64,
	                    imgSize: base64.length, // 校验用，防止未完整接收
	                    imgName: fileName, 
	                },
	                function (data) {
	                	   $("#"+l).val(data.path);
	                    }
	            );
	        },"json", 1000);
	     
	};

	 

	String.prototype.endWith=function(str){
	  if(str==null||str==""||this.length==0||str.length>this.length)
	     return false;
	  if(this.substring(this.length-str.length)==str)
	     return true;
	  else
	     return false;
	  return true;
	 }

	function checkFileType(name) {
	  var flag = false;
	  $.each(types,function(index,value) {
	    if(name.endWith(value)) {
	      flag = true;
	    }
	  })
	  return flag;
	}
	 
};