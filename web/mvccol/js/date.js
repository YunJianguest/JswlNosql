var getDate=function (v)
{
	var enddate=v;
	var s=enddate.split(" ");
	var s1=s[0].split("-");
	var s2=s[1].split(":");
	var oInputYear=s1[0];
	
	var oInputMonth=s1[1];

	var oInputDay=s1[2];
	var oInputHour=s2[0];
	var oInputMin=s2[1];
	var oInSeconds=s2[2];
	
	//Download by http://www.codefans.net
	//var oBtn=document.getElementById('go');
	//var oBtn2=document.getElementById('go2');
	
	var oTxtDay=document.getElementById('day');
	var oTxtHour=document.getElementById('hour');
	var oTxtMin=document.getElementById('min');
	var oTxtSec=document.getElementById('sec');
	
	//var oTxtTarget=document.getElementById('target').getElementsByTagName('strong')[0];
	
	var timer=null;
	timer=setInterval(updateTime, 1000);
	updateTime();
		//oTxtTarget.innerHTML=oInputYear.value+"年"+oInputMonth.value+"月"+oInputDay.value+"日";
	
	
	function fillZero(num, digit)
	{
		var str=''+num;
		
		while(str.length<digit)
		{
			str='0'+str;
		}
		
		return str;
	}
	
	function updateTime()
	{
		var oDateEnd=new Date();
		var oDateNow=new Date();
		
		var iRemain=0;
		
		var iDay=0;
		var iHour=0;
		var iMin=0;
		var iSec=0;
		
		oDateEnd.setFullYear(parseInt(oInputYear));
		oDateEnd.setMonth(parseInt(oInputMonth)-1);
		oDateEnd.setDate(parseInt(oInputDay));
		oDateEnd.setHours(parseInt(oInputHour));
		oDateEnd.setMinutes(parseInt(oInputMin));
		oDateEnd.setSeconds(parseInt(oInSeconds));
		
		iRemain=(oDateEnd.getTime()-oDateNow.getTime())/1000;
		
		if(iRemain<=0)
		{
			clearInterval(timer);
			iRemain=0;
			
		}
		
		iDay=parseInt(iRemain/86400);
		iRemain%=86400;
		
		iHour=parseInt(iRemain/3600);
		iRemain%=3600;
		
		iMin=parseInt(iRemain/60);
		iRemain%=60;
		
		iSec=iRemain;
		
		oTxtDay.innerHTML=fillZero(iDay,2);
		oTxtHour.innerHTML=fillZero(iHour,2);
		oTxtMin.innerHTML=fillZero(iMin,2);
		oTxtSec.innerHTML=fillZero(iSec,2);
		
		
	}
	
	var t=null;
	var alpha=0;
	var bShow=true;
	setInterval(function (){
		if(bShow)
		{
			startMove(100);
		}
		else
		{
			startMove(0);
		}
		
		bShow=!bShow;
		
		function startMove(iTarget)
		{
			if(t)clearInterval(t);
			t=setInterval(function (){
				doMove(iTarget);
			}, 30);
		}
		
		function doMove(iTarget)
		{
			var iSpeed=0;
			if(alpha<iTarget)
			{
				iSpeed=2;
			}
			else
			{
				iSpeed=-2;
			}
			
			if(alpha==iTarget)
			{
				clearInterval(t);
				t=null;
				
				if(iTarget==100)
				{
					startMove(0);
				}
			}
			else
			{
				alpha+=iSpeed;
				
				
			}
		}
	}, 2000);
	 
};