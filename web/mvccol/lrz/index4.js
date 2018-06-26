   var types = [".jpg",".jpeg",".gif",".png",".JPG",".JPEG",".PNG",".RAW"];     
   function  uploadImg(v){ 
      var input =v;
      
      var mpiArr = []; 
      var index = 0; 
	  var file = input.files[0]; 
	  var fileName = file.name;
	  var imgSize = file.size;
	  if(!checkFileType(fileName)) {
		  alert(fileName);
	    //alert("文件类型必须为jpg/jpeg/gif/png");
	    return;
	  }
	    if(imgSize > 10*1024*1024) { //大于2M
	    	alert("请上传小于10M的文件");
	    return;
	    } 
	    load('上传中'); 
	    lrz(file, {
	        before: function() {
	        	
	        },
	        fail: function(err) {
	            //console.error(err);
	        },
	        always: function() {
	        },
	        width: 300
	        },
	        
	        function (results) {
	        setTimeout(function () {
	            $.post(
	            	"lrzimg!imginput.action",
	            	{
	                    imgBase64:results.base64,
	                    imgSize: results.base64.length, // 校验用，防止未完整接收
	                    imgName: fileName, 
	                },
	                function (data) {  
	                        $(input).attr('path',data.path); 
	                        upload();
	                    }
	            );
	        },"json", 1000);
	        }
	     );
    }
	 
	 

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
	function  removeimg(v){ 
		$(v).parent().parent().remove();
	} 