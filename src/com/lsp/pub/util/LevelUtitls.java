package com.lsp.pub.util;
/**
 * 等级计算类
 * @author lsp
 *
 */
public class LevelUtitls {

	/**
	 * 
	 * 根据总经验计算当前等级
	 * @param exp
	 * @param level
	 * @return
	 */
	public static int  getLevel(int exp){  
		//升级所需经验
		int exps=500;
		int level=0;
	    while (exp-exps>=0) {
	    	exps+=level*level*500; 
	    	exp-=exps;
	    	level+=1;
		} 
		return level;
	}
	/**
	 * 计算当前等级所需要的经验
	 * @param level
	 * @return
	 */
	public static int  getNeedExp(int level){
		int  exp=level*level*500+500; 
		return exp;
	};
	/**
	 * 根据当前经验和当前等级计算等级
	 * @param exp
	 * @param level
	 * @return
	 */
	public static int  getLevel(int exp,int level){
		int  exps=level*level*500+500;
		if(exp-exps>0){
			level+=1;
		}
		return level;
		
	}
	/**
	 * 根据经验和当前等级计算是否升级
	 * @return
	 */
	public static boolean isUpLevel(int exp,int level){
		int  exps=level*level*500+500;
		if(exp>=exps){
			return true;
		}
		
		return false;
		
	}
	/**
	 * 计算总积分
	 * @return
	 */
	public static int  jfcalculate(int jf,int count){
		return jf*count;
	}
}
