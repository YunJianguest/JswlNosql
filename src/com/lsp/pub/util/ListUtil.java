package com.lsp.pub.util;

import java.util.Comparator;
import java.util.List;

import com.lsp.pub.entity.Fromuserfunc;
import com.mongodb.DBObject;
/**
 * 工具
 * @author lsp 
 *   
 */
public class ListUtil {

	/**
	 * 统计重复
	 * @param list
	 * @param code
	 * @param from
	 * @return
	 */
    public static int statisicalDuplicate(List<DBObject> list, String code,String from) {        
	        int i = 0;
	        for (DBObject dbObject : list) {
	        	if(dbObject.get(from).equals(code)){
	        		i++;
	        	}	
			}
	        return i;        
	 }
    /**
     * 去除重复
     * @param list
     * @param from
     * @return
     */
   public static  List<DBObject> removeDuplicate(List<DBObject>list, String from){
	   for  ( int  i  =   0 ; i<list.size()-1; i ++ )  {     
		      for  ( int  j  =  list.size()-1 ; j>i; j -- )  {     
		           if  (list.get(j).get(from).toString().equals(list.get(i).get(from).toString()))  {     
		              list.remove(j);     
		            }      
		        }      
		      }      
		    return list;
	     
   }
   /**
    * 判断是否存在
    * @param list
    * @param obj
    * @return
    */
   public static  boolean  isEmpty(List<Long>list,Long obj){  
	  for (int i = 0; i < list.size(); i++) {
		if((list.get(i)+"").equals(obj+"")){ 
			return true;
		}
	} 
	return false;
	   
   }
  /**
   * 冒泡排序
   * @param lsdb
   * @return
   */
  public  static  List<DBObject>sort(List<DBObject>lsdb,String property){
	  DBObject  db=null;
	  for (int i = 0; i < lsdb.size()-1; i++) {
		for (int j =0; j < lsdb.size()-1-i; j++) {
			if(Integer.parseInt(lsdb.get(j).get(property).toString())>Integer.parseInt(lsdb.get(j+1).get(property).toString())){
				db=lsdb.get(j);
				lsdb.add(j, lsdb.get(j+1));
				lsdb.add(j+1, db);
			}
		}
	}
	return lsdb;   
  }
	 
}
