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
	                        var rData =data;                        
	                        
	                        var img = document.createElement('img');
	                        
	                        var timestamp=new Date().getTime();
	                    	var idx = "img" + fileName.substring(0, fileName.indexOf(".")) + timestamp;
	                    	$(span).attr("class" ,"col-3 pt-10");
	                    	$(span).attr("id" ,idx);
	                    	$(span).attr("name" ,rData.path);
	                    	var div1 = document.createElement('div');
	                    	$(div1).attr("class","img-wh55 maring-a");
	                    	var div2=document.createElement('div');
	                    	$(div2).attr("class","position-r");
	                     
	                    	var divdel2=document.createElement('div');
	                    	$(divdel2).attr("class","position-a");
	                    	$(divdel2).css("top","-6px");
	                    	$(divdel2).css("right","-7px");
	                    	$(divdel2).click(function(){
	                    		removeimg(div2);
	                    	});
	                    	
	                    	
	                    	var adel=document.createElement('a');
	                    	$(adel).attr("href","#");
	                    	
	                    	var imgdel=document.createElement('div');
	                    	$(imgdel).attr("class","img-wh20 txt-c zi-bai border-radius50 bg-zong");
	                    	var fontdel=document.createElement('font');
	                    	$(fontdel).attr("size","2");
	                    	var idel=document.createElement('i');
	                    	$(idel).attr("class","fa fa-remove");
	                    	$(idel).css("line-height","21px");
	                    	fontdel.appendChild(idel);
	                    	imgdel.appendChild(fontdel);
	                    	adel.appendChild(imgdel);
	                    	divdel2.appendChild(adel);
	                    	
	                    	div1.appendChild(div2); 
	                    	
	                        if(!rData.ret || rData.state != "0") {
	                        	     
	                        } else {
	                        	           
	              //用于上传完成后直接展示图片
	                        	var mpImg = new MegaPixImage(file);                        	
	                        	mpImg.render(img, {width: 55, height: 55,quality: 0.5 }); 
	                            mpiArr.push({"id":idx,"mpi":mpImg});
	                        	span.innerHTML = ""; 
	                        	$(img).attr("class","img-wh55 img-bj maring-a border-radius3"); 
	                        	 
	                        	div2.appendChild(img);
		                    	div2.appendChild(divdel2);
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