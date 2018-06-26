/**
 * 
 *获取 date 日期前 daysBefore 天的日期
 * @param {Object} date : js 中 Date 对象
 * @param {Object} daysBefore ：数字
*/
function getCertainDateStr(date, daysBefore){
	var tempDate = new Date(date.getTime());
	tempDate.setDate(tempDate.getDate() - daysBefore);
	return tempDate.getFullYear() + "-" + getTwoDigits(tempDate.getMonth() + 1) + "-" + getTwoDigits(tempDate.getDate())
}


/**
 * 获取 日期时间字符串
 * @param {Object} date	格式:{"date":29,"day":3,"hours":0,"minutes":1,"month":7,"seconds":42,"time":1346169702000,"timezoneOffset":-480,"year":112}
 * return 日期字符串 	格式:2012-8-29 18:07:27
 */
function getDateTimeStr(date){
	return getDateStr(date) + " " + getTimeStr(date);
}
function getTimeStr(date){
	return getTwoDigits(date.hours)+":"+getTwoDigits(date.minutes)+":"+getTwoDigits(date.seconds);
}
function getDateStr(date){
	alert(date.year);
	return (date.year + 1900) + "-" + getTwoDigits(date.month+1) + "-" + getTwoDigits(date.date);
}
/*9-->09*/
function getTwoDigits(num){
	if(num < 10){
		num = "0" + num;
	}
	return num;
}

Date.prototype.format =function(format)
{
var o = {
"M+" : this.getMonth()+1, //month
"d+" : this.getDate(), //day
"h+" : this.getHours(), //hour
"m+" : this.getMinutes(), //minute
"s+" : this.getSeconds(), //second
"q+" : Math.floor((this.getMonth()+3)/3), //quarter
"S" : this.getMilliseconds() //millisecond
}
if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
(this.getFullYear()+"").substr(4- RegExp.$1.length));
for(var k in o)if(new RegExp("("+ k +")").test(format))
format = format.replace(RegExp.$1,
RegExp.$1.length==1? o[k] :
("00"+ o[k]).substr((""+ o[k]).length));
return format;
};

