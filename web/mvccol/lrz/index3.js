(function() {

	var input = document.querySelector('.cameraInput');
	var types = [".jpg",".jpeg",".gif",".png",".JPG",".JPEG",".PNG",".RAW"];
	var mpiArr = []; 
	var index = 0; 
    
	input.onchange = function () {
	  
	  var file = this.files[0];
	  var span = document.createElement('div');
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
	  document.querySelector('.pic-list').appendChild(span);  
  	 $('#jdt').show();
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
	                	 
	                		$('#jdt').hide(); 
	                        var rData =data;                        
	                        
	                        var img = document.createElement('img');
	                        
	                        var timestamp=new Date().getTime();
	                    	var idx = "img" + fileName.substring(0, fileName.indexOf(".")) + timestamp;
	                    	$(span).attr("class" ,"col-3 ");
	                    	$(span).attr("id" ,idx);
	                    	$(span).attr("name" ,rData.path);
	                    	var div1 = document.createElement('div');
	                    	$(div1).attr("class","img-wh60 position-r border-radius5 line-lu");
	                    	 
	                    	var divdel=document.createElement('div');
	                    	$(divdel).attr("class","position-a");
	                    	$(divdel).css("top","-7px");
	                    	$(divdel).css("right","-7px");
	                    	$(divdel).click(function(){
	                    		removeimg(divdel);
	                    	});
	                    	var adel=document.createElement('div');
	                    	$(adel).attr("href","#");
	                    	var imgdel=document.createElement('div');
	                    	$(imgdel).attr("class","img-wh20 txt-c zi-bai border-radius50 bg-cheng");
	                    	var fontdel=document.createElement('font');
	                    	$(fontdel).attr("size","2");
	                    	var idel=document.createElement('i');
	                    	$(idel).attr("class","fa fa-remove");
	                    	$(idel).css("line-height","22px");
	                    	fontdel.appendChild(idel);
	                    	imgdel.appendChild(fontdel);
	                    	adel.appendChild(imgdel);
	                    	divdel.appendChild(adel);
	                    	
	                    	 
	                    	
	                    	
	                        if(!rData.ret || rData.state != "0") {
	                        	     
	                        } else {
	                        	           
	              //用于上传完成后直接展示图片
	                        	var mpImg = new MegaPixImage(file);                        	
	                        	mpImg.render(img, {width: 50, height: 50,quality: 0.5 }); 
	                            mpiArr.push({"id":idx,"mpi":mpImg});
	                        	span.innerHTML = ""; 
	                        	$(img).attr("class","img-wh60 img-bj  maring-a border-radius5"); 
	                        	div1.appendChild(img);
	                        	div1.appendChild(divdel);

		                    	span.appendChild(div1); 
	                        }
	                    }
	            );
	        },"json", 1000);
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