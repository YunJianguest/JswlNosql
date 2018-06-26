(function() {

	var input = document.querySelector('.excelInput');
	var types = [".xlsx"];
	var mpiArr = []; 
	var index = 0; 
    
	input.onchange = function () { 
	  var file = this.files[0]; 
	  var fileName = file.name;
	  var imgSize = file.size;
	  var type = $(input).attr('dat');
	  alert(fileName);
	   
	  if(!checkFileType(fileName)) {
	    alert("文件类型必须为jpg/jpeg/gif/png");
	    return;
	  }
	    if(imgSize > 10*1024*1024) { //大于2M
	    	alert("请上传小于10M的文件");
	    return;
	    }
	    
	     $.post("excel!importExp.action",
	            	{
	            	  file:file,
	       			  name:fileName,
	       			  size:imgSize,
	       			  type:type
	                },
	                function (data) { 
	                }
	            );
	      
	         
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
	function  removeimg(v){ 
		$(v).parent().parent().remove();
	}
})();