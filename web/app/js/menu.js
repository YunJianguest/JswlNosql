$(function () {
	
	if($("#errorMessage").val() !="") {
		alert($("#errorMessage").val());
	}
	
    $('#navbar').click(function () {
   	$("#nav").css({top:"0px"});  
    if($("#nav").css("left") == "0px")  
    {  
      $('#nav').hide();
  	$("#nav").css("left","1px");
      $('#header').css("left","0px");
      $('#wrapper').css("left","0px"); 
      
    }  
    else  
    {  
      	  $('#nav').show();
      	$("#nav").css("left","0px");
      	 $('#header').css("left","40%");
          $('#wrapper').css("left","40%"); 
    }  
        
  });
});  


function menuClose() {
	 $('#nav').hide();
	  	$("#nav").css("left","1px");
	      $('#header').css("left","0px");
	      $('#wrapper').css("left","0px"); 
}