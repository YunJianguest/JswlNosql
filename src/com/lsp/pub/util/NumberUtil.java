package com.lsp.pub.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NumberUtil {

	/**
	 * 判断字符串是否是数字(正则表达式)
	 * @param val
	 * @return
	 */
	public static boolean  isNumeric(String str){
		Pattern pattern = Pattern.compile("[0-9]*"); 
		   Matcher isNum = pattern.matcher(str);
		   if(!isNum.matches() ){
		       return false; 
		   } 
		   return true;  
	}
	
}
