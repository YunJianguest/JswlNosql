package com.lsp.pub.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
 
/**
 * 工具
 * @author lsp 
 *   
 */
public class DateFormat
{
	public static String getDate(Date date){
		SimpleDateFormat dateformat1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return dateformat1.format(date);
	}
	public static String getDatenoss(Date date){
		SimpleDateFormat dateformat1=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return dateformat1.format(date);
	}
	 
	public static String getDateXml(Date date){
		SimpleDateFormat dateformat1=new SimpleDateFormat("yyyyMMddHHmmss");
		return dateformat1.format(date);
	}
	public static String getDate(){
		SimpleDateFormat dateformat1=new SimpleDateFormat("yyyyMMdd");
		return dateformat1.format(new Date());
	}
	public static String getSampleDate(Date date){
		SimpleDateFormat dateformat1=new SimpleDateFormat("yyyy-MM-dd");
		return dateformat1.format(date);
	}
	public static Date StringToDate(String date) throws ParseException {
		
		SimpleDateFormat dateformat1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
			
		return dateformat1.parse(date);
			
		

}
	public static String[] sss=new String[]{"EEE MMM dd HH:mm:ss zzz yyyy","yyyy-MM-dd HH:mm:ss","yyyy-MM-dd HH:mm","yyyy-MM-dd HH","yyyy-MM-dd"};

	public static Date getFormat(String date) {
		for (int i = 0; i < sss.length; i++) {
			SimpleDateFormat dateformat1=new SimpleDateFormat(sss[i],Locale.US);
			
				try {
					return dateformat1.parse(date);
				} catch (ParseException e) {
				}
			
		}
//		throw new Exception();
		return null;
	}
	public static Date getFormat2(String date) throws Exception{
		
			SimpleDateFormat dateformat1=new SimpleDateFormat(sss[2],Locale.US);
			
				try {
					return dateformat1.parse(date);
				} catch (ParseException e) {
				}
			
		
//		throw new Exception();
		return null;
	}
	public static void main(String[] args) {
		try {
			System.out.println(DateFormat.getFormat("2009-09-16"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}