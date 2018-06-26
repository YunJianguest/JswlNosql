/**
*Ajax 唯一性校验

*create by gaojt 2010-07-28
*revised by 
**/	

	function checkName(value){ 

		pubValidField(tname,pname,fname,value,rname,rvalue,vspan);
	}
	
	function pubValidField(tableName,pagename,fieldName,fieldValue,ruleName,ruleValue,vspanName){
		var d, s = "";	
			d = new Date();
			s = d.getMilliseconds();
   		if(fieldValue == ""){
   			$("#"+vspanName).html("");
   			return;
   		} 
   		var vurl = "/MyNosql/pub/valid!validfield.action?aa="+s;
		var vpars = "tableName="+tableName+"&fieldName="+fieldName+"&fieldValue="+fieldValue+"&pagename="+pagename+"&ruleName="+ruleName+"&ruleValue="+ruleValue+"&vspanName="+vspanName;
		$.ajax({type: "GET", url: vurl,data: vpars,dataType: "json",complete:validFieldBack}); 
	}
	
	function validFieldBack(response){

		var rtext = response.responseText;
		var knvs = rtext.split("=");

		if(rtext.indexOf("already exist") > 0){
			$("#"+knvs[0]).val("");
			$("#"+knvs[1]).html("已经存在！");
			$("#"+knvs[0])[0].focus();
		}else{
			$("#"+knvs[1]).html("");
		}
	}
	
	function checkName1(value1){ 
		pubValidField1(tname1,fname1,pname1,value1,rules1,vspan1);
	}
	
	function pubValidField1(tableName,fieldName,pagename,fieldValue,validRule,vspanName){
   		var d, s = "";	
			d = new Date();
			s = d.getMilliseconds();
   		if(fieldValue == "") return;
   		var vurl1 = urlAdd+"/PubValidAction?ACTION=validField&aa="+s;
		var vpars1 = "tableName="+tableName+"&fieldName="+fieldName+"&fieldValue="+fieldValue+"&pagename="+pagename+"&validRule="+validRule+"&vspanName="+vspanName;
		$.ajax({type: "GET", url: vurl1,data: vpars1,dataType: "json",complete:validFieldBack1}); 
	}
	function validFieldBack1(response){
		var rtext = response.responseText;
		var knvs = rtext.split("=");
		if(rtext.indexOf("already exist") > 0){
			$("#"+knvs[0]).val("");
			$("#"+knvs[1]).html("已经存在！");
		}else{
			$("#"+knvs[1]).html("");
		
		}
	}
	
	
	
	

	