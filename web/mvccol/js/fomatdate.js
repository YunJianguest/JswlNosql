    Date.prototype.format = function (format) {  
    	/*var year=format.year+1900;
    	var month=format.month+1;
    	var day=format.day+1;
    	var hours=format.hours;
    	var minutes=format.minutes;
    	var seconds=format.seconds;
    	format=year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;*/
    	 
    	var date = new Date(format.time); 
    	format = date.getFullYear() + '-' + (date.getMonth()+1)+ '-' + date.getDate();

        return format;  
    }  
       
  