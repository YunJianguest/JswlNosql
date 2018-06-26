    Date.prototype.format = function (format) {  
    	/*var year=format.year+1900;
    	var month=format.month+1;
    	var day=format.day+1;
    	var hours=format.hours;
    	var minutes=format.minutes;
    	var seconds=format.seconds;
    	format=year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;*/
    	 
    	var date = new Date(format.time);
    	var month=date.getMonth()+1;
    	var day=date.getDate();
    	var hours=date.getHours();
    	var min=date.getMinutes();
    	var seconds=date.getSeconds(); 
    	if(month<10){
    	   month="0"+month;
    	}
    	if(min<10){
    		min="0"+min;
     	}
    	if(day<10){
    		day="0"+day;
     	}
    	if(hours<10){
    		hours="0"+hours;
     	}
    	if(seconds<10){
    		seconds="0"+seconds;
     	}
    	format = date.getFullYear() + '-' + month+ '-' + day+" "+hours
    	       +":"+min+':'+seconds;

        return format;  
    }  
       
  