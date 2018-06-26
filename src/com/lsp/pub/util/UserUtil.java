package com.lsp.pub.util;

import java.util.Date;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
/**
 * 工具
 * @author lsp 
 *   
 */
public class UserUtil {
	/**
	 * 生成唯一用户ID
	 * @return
	 */
	public static String getFromUser(String toUser){
		
		if(StringUtils.isNotEmpty(toUser)){
			String fromUser=toUser+"-fromUser-"+DateFormat.getDateXml(new Date())+MathUtil.getMathRandom(1000);
			return fromUser;
		}else{
			String fromUser="toUser-fromUser-"+DateFormat.getDateXml(new Date())+MathUtil.getMathRandom(1000);
			return fromUser;
		}
	 
	 	
	}
	/**
	 * 生成管理员ID
	 */
    public static String getToUser(){
	 	String fromUser="toUser-"+DateFormat.getDateXml(new Date())+MathUtil.getMathRandom(1000);
		return fromUser;
	  	
	}
    /**
     * 生成用户身份编码
     */
    public static  Long  createUserNo(Long id){
       Long  Id=id+10000; 
       return  Id;
    }
    /**
     * 生成随机VIP
     * @param length
     * @return
     */
    public static  String  createVipNo(int length){
    	Random rm = new Random();
    	double pross = (1 + rm.nextDouble()) * Math.pow(10, length); 
        return  String.valueOf(pross).substring(1,length+1); 
    }

}
