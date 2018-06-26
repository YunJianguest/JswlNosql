package com.lsp.pub.util; 

import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.UUID;


/**
 * 工具
 * @author lsp 
 *   
 */
public class BaseDate {
	int year, month, day;
	java.util.Date dt;

	
	public BaseDate() {

	}



	/**
	 * 得到当前日期
	 *
	 * @return  返回当前日期
	 *
	 */
	public static String getDate() {
		
		java.text.SimpleDateFormat d = new java.text.SimpleDateFormat();
		d.applyPattern("yyyy-MM-dd");
		java.util.Date nowdate = new java.util.Date();
		return String.valueOf(d.format(nowdate));
	}
	/**
	 * 得到当前日期
	 *
	 * @return  返回当前日期
	 *
	 */
	public static String getDateTime() {
		
		java.text.SimpleDateFormat d = new java.text.SimpleDateFormat();
		d.applyPattern("yyyy-MM-dd HH:ss:mm");
		java.util.Date nowdate = new java.util.Date();
		return String.valueOf(d.format(nowdate));
	}
	
	/**
	 * 得到当前年份
	 *
	 * @return  返回当前年份 
	 *
	 */
	public static String getYear() {
		Calendar calendar=Calendar.getInstance();
		
		return String.valueOf(calendar.get(Calendar.YEAR));
	}
	/**
	 * 得到当前月份
	 *
	 * @return  返回当前月份 
	 *
	 */
	public static String getMonth() {
		Calendar calendar=Calendar.getInstance();
		return String.valueOf(calendar.get(Calendar.MONTH)+1);
	}
	
	public static String getDay() {
		return getDate().substring(8, 10);
	}
	


	/**
	 * 得到1970 年 1 月 1 日 00:00:00 GMT 以来此 Date 对象表示的毫秒数
	 * @return 返回自 1970 年 1 月 1 日 00:00:00 GMT 以来此 Date 对象表示的毫秒数
	 */

	public static String getTime() {

		java.util.Date date = new java.util.Date();
		java.sql.Time time;
		time = new Time(date.getTime());
		String strTime = time.toString();

		return strTime;
	}

	/**
	 * 
	 *  一天中的小时（24小时制）
	 * @return 返回一天中的小时
	 * 
	 */
	public static String getHour() {
		Calendar calendar=Calendar.getInstance();
		return String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
	
	}

	/**
	* 
	*  一小时中的分钟
	* @return 返回一小时中的分钟
	* 
	*/
	public static String getMinute() {
		Calendar calendar=Calendar.getInstance();
		return String.valueOf(calendar.get(Calendar.MINUTE));
	}


	/**
	 * 
	 *  一分钟中的秒
	 * @return 返回一分钟中的秒
	 * 
	 */
	public static String getSecond() {
		Calendar calendar=Calendar.getInstance();
		return String.valueOf(calendar.get(Calendar.SECOND));
	}
	
	
	/**
	 * 
	 * 得到指定月的上一个月的月份
	 * @param 月份
	 * @return 返回指定月的上一个月的月份
	 *
	 */
	public static String getUpMonth(String month) {
		
		try{
			int i = new Integer(month).intValue();
			
			if (i > 1)
				i--;
			else
				i = 12;
			return String.valueOf(i);
		
		} catch (Exception e) {
			return "err";
		}
	}
	
	/**
	 * 
	 * 得到指定年月的上一个月的年份
	 * @param 年份
	 * @param 月份
	 * @return 返回指定年月的上一个月的年份
	 *
	 */
	public static String getUpYear(String year,String month) {
		
		try{
			int i = new Integer(month).intValue();

			int getyear=new Integer(year).intValue();
			
			if (i==1)
			{
				getyear--;
			}
				
			return String.valueOf(getyear);
		
		} catch (Exception e) {
			return "err";
		}
	}
	
	/**
	 * 
	 * 得到当前月的下一个月的月份
	 * @return 返回当前月的下一个月的月份
	 *
	 */
	public static String getDownMonth() {
		int i = new Integer(getMonth()).intValue();
		if (i ==12)
			i = 1;
		else
			i++;
		return String.valueOf(i);
	}
	/**
	 * 
	 * 得到当前月的下一个月的月份
	 * @return 返回当前月的下一个月的月份
	 *
	 */
	public static String getUpMonth() {
		int i = new Integer(getMonth()).intValue();
		if (i > 1)
			i--;
		else
			i = 12;
		return String.valueOf(i);
	}
	
	/**
	 * 
	 *  得到指定月的下一个月的月份  
	 * @param 月份
	 * @return 返回指定月的下一个月的月份
	 *
	 */
	public static String getDownMonth(String month) {
		try{
			int i = new Integer(month).intValue();
			if (i == 12)
				i = 1;
			else
				i++;
			return String.valueOf(i);
		} catch (Exception e) {
			return "err";
		}
	}

	/**
	 * 
	 * 得到指定年月的下一个月的年份
	 * @param 年份
	 * @param 月份
	 * @return 返回指定年月的下一个月的年份
	 *
	 */
	public static String getDownYear(String year,String month) {
		
		try{
			int i = new Integer(month).intValue();

			int getyear=new Integer(year).intValue();
			
			if (i==12)
			{
				getyear++;
			}
				
			return String.valueOf(getyear);
		
		} catch (Exception e) {
			return "err";
		}
	}
	
	
	/**
	 * 
	 * 得到指定日期 相差天数的新日期 
	 * 
	 * @param   int    相差的天数
	 * @return  String 新日期
	 * 
	 */

	public static String RelativeDate(String sourceDate, int Days) {
 
	   java.text.SimpleDateFormat d = new java.text.SimpleDateFormat();
			d.applyPattern("yyyy-MM-dd");

		GregorianCalendar cal = new GregorianCalendar();
 		
		java.sql.Date date = null;
		date = java.sql.Date.valueOf(sourceDate);
	 
		cal.setTime(date);
		cal.add(GregorianCalendar.DATE, Days);
           
		return d.format(cal.getTime());       
	}
	/**
	 * 
	 * 得到指定日期 相差天数的新日期 
	 * 
	 * @param   int    相差的天数
	 * @return  String 新日期
	 * 
	 */

	public static java.util.Date getDay(java.util.Date sourceDate, int Days) {
 
		Calendar theCa = Calendar.getInstance();
		theCa.setTime(sourceDate);
		theCa.add(theCa.DATE, Days);
		java.util.Date date = theCa.getTime();
		return date;
	}
	/**
	 * 
	 * 得到指定日期 相差天数的新日期 
	 * 
	 * @param   int    相差的天数
	 * @return  String 新日期
	 * 
	 */

	public static java.util.Date addMinute(java.util.Date sourceDate, int minites) {
 
		Calendar theCa = Calendar.getInstance();
		theCa.setTime(sourceDate);
		theCa.add(theCa.MINUTE, minites);
		java.util.Date date = theCa.getTime();
		return date;
	}
	/**
	 * 
	 * 得到当前日期 相差天数的新日期 
	 * 
	 * @param   int    相差的天数
	 * @return  String 新日期
	 * 
	 */

	public static String RelativeDate(int Days) {

	   java.text.SimpleDateFormat d = new java.text.SimpleDateFormat();
			d.applyPattern("yyyy-MM-dd");

		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(new java.util.Date());
		cal.add(GregorianCalendar.DATE, Days);
		
		return d.format(cal.getTime());       
	}
	/**
	 * 
	 * 2日期相差分钟
	 * 
	 * @param   date firstDate  (必须为 yyyy-mm-dd 形式)
	 * @param   date secondDate (必须为 yyyy-mm-dd 形式)
	 * @return  String 返回同一年内2个日期之间的相差天数
	 * 
	 */

	public static int getDateMinis(Date one,Date two) {
		int m=0;
		long diff = one.getTime() - two.getTime();
		long days = diff / (1000 * 60 );
		return (int)days;
	}
	/**
	 * 
	 * 得到同一年内2个日期之间的相差天数
	 * 
	 * @param   String firstDate  (必须为 yyyy-mm-dd 形式)
	 * @param   String secondDate (必须为 yyyy-mm-dd 形式)
	 * @return  String 返回同一年内2个日期之间的相差天数
	 * 
	 */

	public static String getDatesChange(String firstDate,String secondDate) {
		
		String sign="";
		int firstDays=0,secondDays=0;
		java.util.Date dateOne=null,dateTwo=null;

		
	   java.text.SimpleDateFormat d = new java.text.SimpleDateFormat();
			d.applyPattern("yyyy-MM-dd");
		try {
			GregorianCalendar cal = new GregorianCalendar();
			
			dateOne=d.parse(firstDate);
			cal.setTime(dateOne);
			firstDays=cal.get(GregorianCalendar.DAY_OF_YEAR);
			
	
			dateTwo=d.parse(secondDate);
			cal.setTime(dateTwo);
			secondDays=cal.get(GregorianCalendar.DAY_OF_YEAR);

			sign=String.valueOf(StrictMath.abs(firstDays-secondDays));  
		
		} catch (ParseException e) {
			sign="err";
			e.printStackTrace();
		}
		
		return  sign;  
	}
	
	/**
	 * 数据类型校验 
	 * 
	 * @param   需校验 的数据
	 * @return  boolean 校验后的结果 
	 *          true--正确 false--错误
	 */

	public static boolean isDate(String str) {
		try {
			if ((str == null) || (str.equals(""))) {
				return false;

			} else {
				str = str.trim();
			}

			java.util.Date date = null;
			date = Date.valueOf(str);
			if (!str.equals(date.toString())) {
				return false;
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	

	/**
	 * 将字符串转换为时间.
	 *
	 * @param str 代表时间的字符串.
	 * @return --转换后的时间.str格式不对返回null.
	 *
	 */

	public static final java.sql.Timestamp stringToTime(String str) {
		if (str == null)
			return null;
		str = str.trim();
		java.text.SimpleDateFormat formatter =
			new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date tDate = null;
		try {
			tDate = formatter.parse(str);
		} catch (Exception e) {
		}
		if (tDate == null && str.indexOf(' ') < 0) {
			formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			try {
				tDate = formatter.parse(str);
			} catch (Exception e) {
			}
		}
		if (tDate == null)
			return null;
		java.sql.Timestamp timeStame = new java.sql.Timestamp(tDate.getTime());
		return timeStame;
	}

	/**
	 * 检查日期的相关值合法性.(三个之中有空值则不校验)
	 *
	 * @param (String)year  年 4位
	 * @param (String)month 月 2位
	 * @param (String)day   日 2位.
	 *
	 * @return (boolean)  true 合法  false 不合法.
	 *
	 */
	public static final boolean isDate(String year, String month, String day) {
		if (year.trim().length() == 0
			|| month.trim().length() == 0
			|| day.trim().length() == 0)
			return true;
		int y, m, d;
		try {
			y = Integer.parseInt(year);
			m = Integer.parseInt(month);
			d = Integer.parseInt(day);
		} catch (NumberFormatException e) {
			return false;
		}
		return isCalender(y, m, d);
	}
	/**
	 * 检查日期的相关值合法性.(三个之中有空值则不校验)
	 *
	 * @param (String)year  年 4位
	 * @param (String)month 月 2位
	 * @param (String)day   日 2位.
	 *
	 * @return (boolean)  true 合法  false 不合法.
	 *
	 */
	public static long  getDateCha(java.util.Date date, java.util.Date date2) {
		long s=date.getTime();
		long e=date2.getTime();
		return e-s;
	}
	
	/**
	 * 检查日期的相关值合法性.(三个之中有空值则不校验)
	 *
	 * @param (String)year 年 4位 (String)month (String)day.
	 * @param (允许最大日期) "nnnn-yy-mm" ,"0000-00-00" 不大于当前日期，"" 不校验
	 * @param (允许最小日期) "nnnn-yy-mm" ,"" 不校验
	 *
	 * @return (boolean)  true 合法  false 不合法.
	 *
	 */
	public static final boolean isDate(
		String year,
		String month,
		String day,
		String maxdate,
		String mindate) {
		if (!isDate(year, month, day)
			|| (!BaseDate.isDate(maxdate)
				&& !maxdate.equals("0000-00-00")
				&& !maxdate.trim().equals(""))
			|| (!BaseDate.isDate(mindate) && !mindate.trim().equals("")))
			return false;

		if (maxdate.equals("0000-00-00"))
			return (
				stringToTime(year + "-" + month + "-" + "01").before(
					new java.util.Date()));
		if (!maxdate.trim().equals(""))
			return (
				stringToTime(year + "-" + month + "-" + "01").before(
					stringToTime(maxdate)));
		if (!mindate.trim().equals(""))
			return (
				stringToTime(year + "-" + month + "-" + "01").after(
					stringToTime(mindate)));

		return true;
	}

	/**
	 * 检查时间的相关值合法性.
	 *
	 * @param (String)hour (String)minut (String)sec.
	 * @return (boolean)  true 合法  false 不合法.
	 *
	 */

	public static final boolean isTime(
		String hour,
		String minute,
		String secs) {
		int h, m, s;
		try {
			h = Integer.parseInt(hour);
			m = Integer.parseInt(minute);
			s = Integer.parseInt(secs);
		} catch (NumberFormatException e) {
			return false;
		}
		if (h < 0 || h > 23)
			return false;
		if (m < 0 || m > 59)
			return false;
		if (s < 0 || s > 59)
			return false;
		return true;
	}
	/**
	 * 根据输入的字符串解析出年月日和时分秒，并检查日期的有效性。
	 *
	 * @param  (String)  textStr --输入的字符串
	 * @return (boolean) true--成功   false--失败
	 *
	 */
	public static final boolean dateTextFieldParse(String textStr) {
		int index = textStr.indexOf(".");
		if (index > -1)
			textStr = textStr.substring(0, index);
		String year, month, day, hour, minute, second;
		int hypen1Index, hypen2Index, blankIndex, colon1Index, colon2Index;
		hypen1Index = textStr.indexOf("-");
		if (hypen1Index != -1) {
			hypen2Index = textStr.indexOf("-", hypen1Index + 1);
			if (hypen2Index != -1) {
				blankIndex = textStr.indexOf(" ");
				if (blankIndex != -1) {
					colon1Index = textStr.indexOf(":");
					if (colon1Index != -1) {
						colon2Index = textStr.indexOf(":", colon1Index + 1);
						if (colon2Index != -1) {
							//提取年月日和时分秒
							year = textStr.substring(0, hypen1Index);
							month =
								textStr.substring(hypen1Index + 1, hypen2Index);
							day =
								textStr.substring(hypen2Index + 1, blankIndex);
							hour =
								textStr.substring(blankIndex + 1, colon1Index);
							minute =
								textStr.substring(colon1Index + 1, colon2Index);
							second = textStr.substring(colon2Index + 1);
							if (isDate(year, month, day)) {
								if (isTime(hour, minute, second))
									return true;
								else
									return false;
							} else
								return false;
						} else
							return false;
					} else
						return false;
				} else //年月日
					{
					year = textStr.substring(0, hypen1Index);
					month = textStr.substring(hypen1Index + 1, hypen2Index);
					day = textStr.substring(hypen2Index + 1);
					if (isDate(year, month, day))
						return true;
					else
						return false;
				}
			} else
				return false;
		} else
			return false;
	}
	public static String getDateErrorMessage() {
		return ("\n  正确格式是：\n  (1) 年-月-日\n  (2) 年-月-日 一个空格 时(24小时制):分:秒\n  (3)年介于1900至4712之间\n   例如：2000-9-8 14:30:30");
	}

	/**
	 * 将传入的日期字符串表达式格式化
	 * 
	 */
	public static String tostanddate(String str) {
		str = str.trim();
		if (str.substring(6, 7).equals("-")) {
			str = str.substring(0, 5) + "0" + str.substring(5, str.length());
		}
		if (str.trim().length() < 10) {
			str = str.substring(0, 8) + "0" + str.substring(8, 9);
		}
		return str;
	}
	/**
	 * 将时间字符串增加月份(必须为 yyyy-mm-dd 形式).
	 *
	 * @param str 表示时间的字符串.
	 * @param movemonth 增加的月份   负值为减少月份.
	 * @return --转换后的时间字符串.str格式不对返回"".
	 *
	 */

	public static final String stringMoveMonth(String str, int movemonth) {
		if (!BaseDate.isDate(str))
			return "";
		int year = Integer.parseInt(str.substring(0, 4));
		int month = Integer.parseInt(str.substring(5, 7));
		int moveyear = Math.abs(movemonth);
		moveyear = (int) (moveyear / 12);
		if (movemonth > 0)
			year += moveyear;
		else
			year -= moveyear;

		int passmonth =
			Math.abs(movemonth) - 12 * (int) ((Math.abs(movemonth)) / 12);

		if (passmonth > 0) {
			if (movemonth > 0) {
				if ((movemonth + month) > 12) {
					year++;
					month = movemonth + month - 12;
				} else
					month = movemonth + month;
			} else {
				if (month > Math.abs(movemonth))
					month -= Math.abs(movemonth);
				else {
					year--;
					month = 12 + month + movemonth;
				}
			}
		}
		if (month > 9)
			return String.valueOf(year)
				+ str.substring(4, 5)
				+ String.valueOf(month)
				+ str.substring(7);
		else
			return String.valueOf(year)
				+ str.substring(4, 5)
				+ "0"
				+ String.valueOf(month)
				+ str.substring(7);
	}

	/**
	 * 将当前时间字符串增加月份(必须为 yyyy-mm-dd 形式).
	 *
	 * @param movemonth 增加的月份   负值为减少月份.
	 * @return --转换后的时间字符串.str格式不对返回"".
	 *
	 */

	public static final String stringMoveMonth(int movemonth) {
		return stringMoveMonth(BaseDate.getDate(), movemonth);
	}
	
//	检查年月日是否合法
	  private static boolean isCalender(int y, int m, int d) {
		  //时间值越界；
		  if ((y < 1900) || (y > 4712)) {
			  return false;
		  }
		  if ((m < 1) || (m > 12)) {
			  return false;
		  }
		  if ((d < 1) || (d > 31)) {
			  return false;
		  }
		  //判断天是否正确
		  switch (m) {
			  case 2 :
				  if (isLeapyear(y)) {
					  if (d > 29)
						  return false;
				  } else {
					  if (d > 28)
						  return false;
				  };
				  break;
			  case 4 :
			  case 6 :
			  case 9 :
			  case 11 :
				  if (d > 30)
					  return false;
				  break;
			  default :
				  return true;
		  }
		  return true;
	  }

	/**
	 * 判断给定的年份是否为闰年
	 *
	 * @param 年份
	 * @return 闰年 返回 true 否则返回 false 
	 *
	 */
	  private static boolean isLeapyear(int y) {
		  if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0))
			  return true; //是闰年;
		  else
			  return false;
	  }
	/**
	  * 得到当前月份的最后一天.
	  *
	  * @param  (String)  oldday.
	  * @return (String)  lastday.
	  *
	  */
	public static final String getNowLastDay() {
		return getLastDay(getDate());
	}
	public static final String getNowLastDay(String date) {
		return getLastDay(date);
	}
	/** 
		 * 得到某个月份的最后一天.
		 *
		 * @param  (String)  oldday.
		 * @return (String)  lastday.
		 *
		 */

		public static final String getLastDay(String oldday) {

			oldday = tostanddate(oldday);
			if (!isDate(oldday))
				return "error";

			int y = Integer.parseInt(oldday.substring(0, 4));
			int m = Integer.parseInt(oldday.substring(5, 7));
			int d = Integer.parseInt(oldday.substring(8, 10));

			switch (m) {
				case 2 :
					if (isLeap(y)) {
						d = 29;
					} else {
						d = 28;
					};
					break;
				case 4 :
				case 6 :
				case 9 :
				case 11 :
					d = 30;
					break;
				default :
					d = 31;
			}
			return oldday.substring(0, 8) + String.valueOf(d);
		}

	/*
	 *  判断是否闰年?
	 * 
	 */
	private final static boolean isLeap(int y) {
		if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0))
			return true; //是闰年;
		else
			return false;
	}
	/**
		 * 字符串补位
		 *
		 * @param  (int) weishu      －补位后的总位数
		 * @param  (String)num       --需补位的字符串
		 * @param  (String)addchar   --补位字符 (一位字符 空格为 " ")
		 * @param  (int) addloc      --补位位置(1..前补位  2..后补位)
		 * @return (String)          --补位后的字符串
		 *
		 */
		public static final String ForAddWord(
			int weishu,
			String num,
			String addchar,
			int addloc) {
			return ForAddWord(weishu, num, addchar, addloc, 0);
		}
		public static final String ForAddWord(
			int weishu,
			String num,
			String addchar,
			int addloc,
			int mode) {
			if (num.length() >= weishu)
				return num;
			int i = 0;
			int j = weishu - num.length();

			String BH = "";
			while (i < j) {
				BH += addchar;
				i++;
			}
			if (addloc < 2)
				return BH + num;
			else
				return num + BH;
		}
		
		public static final String getWeekOfDate(){
			String[] weekDays = {"日", "一", "二", "三", "四", "五", "六"};
	        Calendar cal = Calendar.getInstance();
	        java.util.Date nowdate = new java.util.Date();
	        cal.setTime(nowdate);

	        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
	        if (w < 0)
	            w = 0;

	        return weekDays[w];
		}
		 /**
	     * 获取当前日期是星期几<br>
	     * 
	     * @param dt
	     * @return 当前日期是星期几
	     */
	    public static String getWeekOfDate(java.util.Date dt) {
	        String[] weekDays = {"日", "一", "二", "三", "四", "五", "六"};
	        Calendar cal = Calendar.getInstance();
	        cal.setTime(dt);

	        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
	        if (w < 0)
	            w = 0;

	        return weekDays[w];
	    }
	    public static String[] chars = new String[] { "a", "b", "c", "d", "e", "f",  
            "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",  
            "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5",  
            "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I",  
            "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",  
            "W", "X", "Y", "Z" };  
  
  
	    public static String generateShortUuid() {  
	    	StringBuffer shortBuffer = new StringBuffer();  
	    	String uuid = UUID.randomUUID().toString().replace("-", "");  
	    	for (int i = 0; i < 8; i++) {  
	    		String str = uuid.substring(i * 4, i * 4 + 4);  
	    		int x = Integer.parseInt(str, 16);  
	    		shortBuffer.append(chars[x % 0x3E]);  
	    	}  
	    	return shortBuffer.toString();  
  
	    }  
	    public static String getUuid() {  
	    	
	    	return UUID.randomUUID().toString().replace("-", "");  
	    	
  
	    }  
	    public static String getDayUuid() {
	    	java.util.Date localDate = new java.util.Date();
			SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			return localSimpleDateFormat.format(localDate)+generateShortUuid();
		}
	    public static void main(String[] args) throws Exception {
	    	String year=BaseDate.getYear();
	    	String month=BaseDate.getMonth();
			for(int i=0;i<3;i++){
				year=BaseDate.getUpYear(year,month);
				month=BaseDate.getUpMonth(month);
				System.err.println(year+"-"+month);
			}
	    }
	
}