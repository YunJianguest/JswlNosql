package com.lsp.pub.util;

import java.util.List;

import com.mongodb.DBObject;

/**
 * dbobject工具类
 * @author lsp
 *
 */
public class DBobjectUtil {

	/**
	 * 判断list是否包含某元素
	 * @param lsdb集合
	 * @param db元素
	 * @param value凭证
	 * @return
	 */
	public static boolean contains(List<DBObject> list,DBObject db,String value){
		boolean bl=false;
		for (DBObject dbObject : list) {
			if(dbObject.get(value).toString().equals(db.get(value).toString())){
				bl=true;
				break;
			}
		}
		return bl; 
	}
}
