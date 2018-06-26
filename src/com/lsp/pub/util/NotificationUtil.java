package com.lsp.pub.util;

import java.util.HashMap;
import java.util.Map;
 
import net.sf.json.JSONArray;

import com.lsp.android.entity.MessageInfo; 
import com.lsp.pub.upload.HttpURLConnectionUtils;

public class NotificationUtil {

	public static String  sendMessage(MessageInfo msg){ 
		if(msg==null){
			return null;
		}
		String url=SysConfig.getProperty("ip")+"/android/chat!printMessage.action";
		//String url="http://localhost:81/CcjhNosql//android/chat!printMessage.action";
		Map<String,Object> newsmap = new HashMap<String,Object>();
		newsmap.put("title", msg.getTitle());
		newsmap.put("summary", msg.getSummary());
		newsmap.put("picurl", msg.getPicurl());
		newsmap.put("url", msg.getUrl());
		newsmap.put("createdate", msg.getCreatedate());
		newsmap.put("custid", msg.getCustid());
		newsmap.put("fromUserid", msg.getFromUserid());
		newsmap.put("_id", msg.get_id());
		newsmap.put("type", msg.getType());
		newsmap.put("comname", msg.getComname());
		newsmap.put("lx", msg.getLx());
		newsmap.put("orderid", msg.getOrderid());
		newsmap.put("procount", msg.getProcount());
		newsmap.put("prostate", msg.getProstate());
		newsmap.put("protitle", msg.getProtitle());
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1); 
		String ret=null; 
		try {
			HttpURLConnectionUtils.GetHttpURLConnection(url);
			ret=HttpURLConnectionUtils.SendFiles(json,HttpURLConnectionUtils.CONN);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ret; 
	}
}
