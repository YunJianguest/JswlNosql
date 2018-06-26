package com.lsp.pub.util;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.math.BigDecimal;
/**
 * 工具
 * @author lsp 
 *   
 */
public class BaseDecimal {
	//默认除法运算精度 
	private static final int DEF_DIV_SCALE = 6;
	//这个类不能实例化 
	private BaseDecimal() {
	}
	/** 
	 * 提供精确的加法运算。 
	 * @param v1 被加数 
	 * @param v2 加数 
	 * @return 两个参数的和 
	 */
	public static String add(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return String.valueOf(b1.add(b2));
	}
	/** 
	 * 提供精确的减法运算。 
	 * @param v1 被减数 
	 * @param v2 减数 
	 * @return 两个参数的差 
	 */
	public static String subtract(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return String.valueOf(b1.subtract(b2));
	}
	/** 
	 * 提供精确的乘法运算。 
	 * @param v1 被乘数 
	 * @param v2 乘数 
	 * @return 两个参数的积 
	 */
	public static String multiplication(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return String.valueOf(b1.multiply(b2));
	}
	/** 
	 * 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 
	 * 小数点以后6位，以后的数字四舍五入。 
	 * @param v1 被除数 
	 * @param v2 除数 
	 * @return 两个参数的商 
	 */
	public static String division(String v1, String v2) {
		return division(v1, v2, DEF_DIV_SCALE);
	}
	/** 
	
	 * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 
	 * 定精度，以后的数字四舍五入。 
	 * @param v1 被除数 
	 * @param v2 除数 
	 * @param scale 表示表示需要精确到小数点以后几位。 
	 * @return 两个参数的商 
	
	 */
	public static String division(String v1, String v2, int scale) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).toString();
	}
	/** 
	 * 提供精确的小数位四舍五入处理。
	 * @param v 需要四舍五入的数字 
	 * @param scale 小数点后保留几位 
	 * @return 四舍五入后的结果 
	 */
	public static String round(String v, int scale) {
		BigDecimal b = new BigDecimal(v);
		BigDecimal one = new BigDecimal("1");
		return String.valueOf(b.divide(one, scale, BigDecimal.ROUND_HALF_UP));
	}
	

	/**
	 * 供精确的小数位数,将多余的小数位数截取处理
	 * 
	 * @param  (String) instring 需格式化的字符串
	 * @param  (int)    scale   保留的小数个数
	 * @return 制定小数位数的字符串
	 */
	public static String decimal(String instring, int scale) {
		instring = instring.trim();
		BigDecimal b = new BigDecimal(instring);
		BigDecimal one = new BigDecimal("1");
		return String.valueOf(b.divide(one, scale, BigDecimal.ROUND_DOWN));
	}
	public static int getMod(int up, int down) {
		float result_float = up / down;
		int result_int = (int) result_float;
		result_int = result_float > result_int ? result_int + 1 : result_int;
		return result_int;
	}
    /** 
     * 计算地球上任意两点(经纬度)距离 
     *  
     * @param long1 
     *            第一点经度 
     * @param lat1 
     *            第一点纬度 
     * @param long2 
     *            第二点经度 
     * @param lat2 
     *            第二点纬度 
     * @return 返回距离 单位：米 
     */  
    public static double Distance(double long1, double lat1, double long2,  
            double lat2) {  
        double a, b, R;  
        R = 6378137; // 地球半径  
        lat1 = lat1 * Math.PI / 180.0;  
        lat2 = lat2 * Math.PI / 180.0;  
        a = lat1 - lat2;  
        b = (long1 - long2) * Math.PI / 180.0;  
        double d;  
        double sa2, sb2;  
        sa2 = Math.sin(a / 2.0);  
        sb2 = Math.sin(b / 2.0);  
        d = 2* R* Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(lat1)* Math.cos(lat2) * sb2 * sb2));  
        return d;  
    }
    /**
     * 距离优化
     * @param number米
     * @return（优化附近距离）
     */
    public static  String  mToKm(double number){ 
   	 String v="";
   	 if(number>10000){
   		 v="15km"; 
   	 }else if(number>8000&&number<=10000){
   		 v="10km";
   	 }else if(number>6000&&number<=8000){
   		 v="8km";
   	 }else if(number>5000&&number<=6000){
   		 v="6km";
   	 }else if(number>4500&&number<=5000){
   		 v="5km";
   	 }else if(number>4000&&number<=4500){
   		 v="4.5km";
   	 }else if(number>3500&&number<=4000){
   		 v="4km";
   	 }else if(number>3000&&number<=3500){
   		 v="3.5km";
   	 }else if(number>2500&&number<=3000){
   		 v="3km";
   	 }else if(number>2000&&number<=2500){
   		 v="2.5km";
   	 }else if(number>1800&&number<=2000){
   		 v="2km";
   	 }else if(number>1500&&number<=1800){
   		 v="1.8km";
   	 }else if(number>1200&&number<=1500){
   		 v="1.5km"; 
   	 }else if(number>1000&&number<=1200){
   		 v="1.2km";
   	 }else if(number>900&&number<=1000){
   		 v="1km";
   	 }else if(number>600&&number<=800){
   		 v="800m"; 
   	 }else if(number>400&&number<=600){
   		 v="600m";
   	 }else if(number>200&&number<=400){
   		 v="400m";
   	 }else if(number>100&&number<=200){
   		 v="200m";
   	 }else if(number<=100){
   		 v="100m";
   	 }      
       return v;
       
   }
   /**
    * 生成不重复的随机数
    * @param num随机数个数
    * @param length随机范围
    * @return
    */
    public static HashMap<String,Integer> getListRand(int num,int length){
    	if(num>length){
    		return null;
    	}
    	HashMap<String,Integer>map=new HashMap<>();
    	while (true) {
    		 Random rand = new Random();
    		 int value= rand.nextInt(length);
    	     map.put(value+"",  value);
    	     if(map.size()==num){
    	        	break;
    	      } 
		} 
    	
		return map; 
    }
}
