package com.lsp.pub.util; 
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.lang.StringUtils;

/**
 * 工具
 * @author lsp 
 *   
 */

public class DateUtil 
{
	/**
     * 字符串转日期（精确到秒）
     * @param str
     * @return
     * @throws Exception
     */
    public static Date str2DateTime(String str)
    {
        Date date = null;
        try
        {
        	if (!StringUtils.isNotEmpty(str))
    			date = DateUtil.toDate(str, "yyyy-MM-dd HH:mm:ss");
        }catch (Exception e)
        {
        	
        }
        return date;

    }
    /*
	 * @return  返回当前0点日期
	 *
	 */
	public static Date getStartDate(String str) throws Exception{
		
		str=str+" 00:00:00";
		 Date date = null;
	        try
	        {
	        	if (!StringUtils.isNotEmpty(str))
	    			date = DateUtil.toDate(str, "yyyy-MM-dd HH:mm:ss");
	        }catch (Exception e)
	        {
	        	
	        }
	        return date;
	}
	/*
	 * @return  返回当前0点日期
	 *
	 */
	public static Date getEndDate(String str) throws Exception{
		
		str=str+" 24:00:00";
		 Date date = null;
	        try
	        {
	        	if (!StringUtils.isNotEmpty(str))
	    			date = DateUtil.toDate(str, "yyyy-MM-dd HH:mm:ss");
	        }catch (Exception e)
	        {
	        	
	        }
	        return date;
	}
    /**
	 * 
	 * 得到指定时间 相差分钟的新时间
	 * 
	 * @param   int    相差的小时
	 * @return  String 新日期
	 * 
	 */

	public static Date addMinute(Date sourceDate, int minu) {
 
		Calendar cal=Calendar.getInstance();	 
		cal.setTime(sourceDate);
		cal.add(GregorianCalendar.MINUTE, minu);
           
		return cal.getTime();       
	}
    /**
	 * 
	 * 得到指定时间 相差天数的新时间
	 * 
	 * @param   int    相差的小时
	 * @return  String 新日期
	 * 
	 */

	public static Date addHour(Date sourceDate, int hour) {
 
		Calendar cal=Calendar.getInstance();	 
		cal.setTime(sourceDate);
		cal.add(GregorianCalendar.HOUR, hour);
           
		return cal.getTime();       
	}
	/**
	 * 得到指定时间 相差天数的新时间
	 * @param sourceDate
	 * @param day
	 * @return
	 */
	public static Date addDay(Date sourceDate, int day) {
	 
			Calendar cal=Calendar.getInstance();	 
			cal.setTime(sourceDate);
			cal.add(GregorianCalendar.DATE, day);
	           
			return cal.getTime();       
	 } 
    /**
     * 按指定格式将字符串转换为日期对象
     * @param dateStr
     * @param format
     * @return
     * @throws Exception
     */
    public static Date toDate(String dateStr, String format) throws Exception
    {
        if (StringUtils.isEmpty(dateStr))
            return null;
        DateFormat df = new SimpleDateFormat(format);
            return df.parse(dateStr);
    }
    
    /**
     * 日期（精确到秒）转字符串
     * 
     * @param date
     * @return
     */
    public static String dateTime2Str(Date date) {
        String str = "";
        if (null != date) {
            str = DateUtil.toChar(date, "yyyy-MM-dd HH:mm:ss");
        }
        return str;
    }
    
    /**
     * 按指定的格式将日期对象转换为字符串
     * 
     * @param date
     * @param format
     * @return
     */
    public static String toChar(Date date, String format) {
        if (date == null)
            return null;
        DateFormat df = new SimpleDateFormat(format);
        return df.format(date);
    }
    
    
    /**
     * 获取当前时间前十分钟
     * @param format
     * @return
     */
    public static Date getBeforeTenMinutes()  {
		 Date d=new Date();  
		 d.setMinutes(d.getMinutes()-10); 
		 return d; 
	    }
    /**
     * 获取当前时间一小时前的时间
     * @param format
     * @return
     */
    public static Date getBeforeAnHours()  {
		 Date d=new Date(); 
		 d.setHours(d.getHours()-1); 
		 return d; 
	    }
    /**
     * 获取当前时间一小时后的时间
     * @param format
     * @return
     */
    public static Date getNextAnHours()  {
		 Date d=new Date(); 
		 d.setHours(d.getHours()+1); 
		 return d; 
	    }
//    public static void main(String [] args){
//    	String src="Tue Feb 26 08:48:41 CST 2013";
//    	System.out.println(DateUtil.toDate(src, "yyyy-mm-dd").toString());
//    }
    
    
    
    public static final String getWeekOfDate(Date date){
		String[] weekDays = {"日", "一", "二", "三", "四", "五", "六"};
        Calendar cal = Calendar.getInstance();
       
        cal.setTime(date);

        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;

        return weekDays[w];
	}
    
  /**
   * 获得当天0点时间
   * @return
   */
    public static Date getTimesmorning(){
       Calendar cal = Calendar.getInstance();
       cal.set(Calendar.HOUR_OF_DAY, 0);
       cal.set(Calendar.SECOND, 0);
       cal.set(Calendar.MINUTE, 0);
       cal.set(Calendar.MILLISECOND, 0); 
       return  cal.getTime();
    }
    /**
     * 获得昨天0点时间
     * @return
     */
      public static Date getYesterdayTimesmorning(){
         Calendar cal = Calendar.getInstance();
         cal.set(Calendar.HOUR_OF_DAY, 0);
         cal.set(Calendar.SECOND, 0);
         cal.set(Calendar.MINUTE, 0);
         cal.set(Calendar.MILLISECOND, 0);
         cal.add(Calendar.HOUR_OF_DAY, -1);
         return  cal.getTime();
      }

	/**
	 * 获得当天24点时间
	 * 
	 * @return
	 */
	public static Date getTimesnight() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 24);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}
   /**
    * 获得昨天24点时间
    * @return
    */
  public static Date getYesterdayTimesnight(){
   Calendar cal = Calendar.getInstance();
   cal.set(Calendar.HOUR_OF_DAY, 24);
   cal.set(Calendar.SECOND, 0);
   cal.set(Calendar.MINUTE, 0);
   cal.set(Calendar.MILLISECOND, 0);
   cal.add(Calendar.HOUR_OF_DAY, -1);
   return cal.getTime();
   }
   /**
    * 判断预定时间是否到当前时间
    * @param d
    * @return
    */
   public static boolean checkbig(Date d){
	   boolean bl=false;
	   Date  a=new Date();
	   if(a.getTime()<d.getTime()){
		   bl=true;
	   }
	   return bl;
   }
   /**
    * 判断预定时间是否到当前时间
    * @param d
    * @return
    */
   public static boolean checksimal(Date d){
	   boolean bl=false;
	   Date  a=new Date();
	   if(a.getTime()>d.getTime()){
		   bl=true;
	   }
	   return bl;
   }
   /**
    * 获取本月第一天
    */
   public static Date getfirstday(){
	   Calendar   cal_1=Calendar.getInstance();//获取当前日期
       cal_1.add(Calendar.MONTH, -1);
       cal_1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天 
       return cal_1.getTime();
   }
   /**
    * 获取本月最后一天
    */
   public static Date getlastday(){
	   Calendar cale = Calendar.getInstance();  
       cale.set(Calendar.DAY_OF_MONTH,0);//设置为1号,当前日期既为本月第一天
       return cale.getTime();   
   }
   /**
    * 计算两个时间差
    * @param date1
    * @param date2
    * @return
    */
   public static Long  getTimeDifference(Date date1,Date date2){
	  return date1.getTime()-date2.getTime();    
   }
     
    
}
