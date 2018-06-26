package com.lsp.pub.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.net.ssl.SSLContext;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.shop.entiy.ComMain;
import com.lsp.suc.entity.Comunit;
import com.lsp.weixin.entity.RedpackBean;
import com.lsp.weixin.entity.Transfers;
import com.lsp.weixin.entity.WxPayConfig;
/**
 * 工具
 * @author lsp 
 *   
 */
public class WxhbUtil {
 
	public int transfers(String fromUser,String toUser,String orderno,String money,String remark,Long comid,String rzname) {

	
		MongoDbUtil mongoDbUtil = new MongoDbUtil();
		int m=Integer.parseInt(BaseDecimal.round(BaseDecimal.multiplication(money, "100"),0));

		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		if(m<=0||StringUtils.isEmpty(fromUser)){
			
			return 1;	
		}
		Comunit wxToUser=GetAllFunc.wxTouser.get(toUser);
		WxPayConfig wxconfig=new WxPayConfig();
		if(wxToUser.getQx()==0){
			
			return 2;
		}else if(wxToUser.getQx()==1){
			wxconfig=GetAllFunc.wxPay.get(toUser);
		}else if(wxToUser.getQx()==2){//父类结算
			ComMain commain=GetAllFunc.comToUser.get(toUser);
			
			toUser=commain.getToUser();
			wxToUser=GetAllFunc.wxTouser.get(toUser);
			wxconfig=GetAllFunc.wxPay.get(toUser);
		}
		
        UUIDGenerator uuid=new   UUIDGenerator();
        Transfers bean = new Transfers();
        bean.set_id(orderno);
        bean.setMch_appid(wxToUser.getAppid());
        bean.setMchid(wxconfig.getPartner());
        bean.setDevice_info("");
        bean.setNonce_str(uuid.getNextValue());  
        bean.setPartner_trade_no(wxconfig.getPartner()+new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())+new Random().nextInt(10));  
        
        bean.setOpenid(fromUser);  
        bean.setCheck_name("FORCE_CHECK");
        bean.setRe_user_name(rzname);
        bean.setAmount(m);
        bean.setDesc(remark);
        bean.setComid(comid);
        bean.setClient_ip(SysConfig.getProperty("ip_addr"));  
     
        
      //把请求参数打包成数组
        SortedMap<Object,Object> sParaTemp = new TreeMap<Object,Object>(); 
        sParaTemp.put("amount", bean.getAmount());
        sParaTemp.put("check_name", bean.getCheck_name());
        sParaTemp.put("device_info", bean.getDevice_info());
        sParaTemp.put("desc", bean.getDesc());
        sParaTemp.put("mchid", bean.getMchid());
        sParaTemp.put("mch_appid", bean.getMch_appid());
        sParaTemp.put("nonce_str", bean.getNonce_str());
        sParaTemp.put("openid", bean.getOpenid());
        sParaTemp.put("partner_trade_no", bean.getPartner_trade_no());

        sParaTemp.put("re_user_name", bean.getRe_user_name());
        sParaTemp.put("spbill_create_ip", bean.getClient_ip());

       // String prestr = WxhbUtil.createLinkString(sPara); //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
       // String key = "&key="+wxconfig.getPartner_key(); //商户支付密钥
        String mysign =PayCommonUtil.createSign("UTF-8", sParaTemp,wxconfig.getPartner_key());
       // String mysign = WxhbUtil.sign(prestr, key, "utf-8").toUpperCase();
                
        bean.setSign(mysign);

        Map<String, String> rets = WxhbUtil.sendtransfers(bean,wxconfig.getCertLocalPath(),wxconfig.getPartner()); 
        System.err.println(rets.toString());
       
        
        if(rets.get("result_code").equals("SUCCESS")){
        	bean.setState(0);
 
        }else{
        	
        	bean.setDesc(bean.getDesc()+"-"+rets.get("err_code")+"==="+rets.get("err_code_des"));
        	return 4;
        }
        bean.setToUser(toUser);
        bean.setInsdate(new Date());
        mongoDbUtil.insertUpdate(PubConstants.WENXIN_REFUND, bean);
        return 0;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> sendredpack(RedpackBean entity,String path,String mch_id) {
		
		
		StringBuffer resultXml=new StringBuffer();

		resultXml.append("<xml>")
			.append("<sign><![CDATA[").append(entity.getSign()).append("]]></sign>")
			
			.append("<mch_billno><![CDATA[").append(entity.getMch_billno()).append("]]></mch_billno>")
			.append("<mch_id><![CDATA[").append(entity.getMch_id()).append("]]></mch_id>")
			.append("<wxappid><![CDATA[").append(entity.getWxappid()).append("]]></wxappid>")
			.append("<send_name><![CDATA[").append(entity.getSend_name()).append("]]></send_name>")
			.append("<re_openid><![CDATA[").append(entity.getRe_openid()).append("]]></re_openid>")
			.append("<total_amount><![CDATA[").append(entity.getTotal_amount()).append("]]></total_amount>")
			.append("<total_num><![CDATA[").append(entity.getTotal_num()).append("]]></total_num>")
			.append("<wishing><![CDATA[").append(entity.getWishing()).append("]]></wishing>")
			.append("<client_ip><![CDATA[").append(entity.getClient_ip()).append("]]></client_ip>")
			.append("<act_name><![CDATA[").append(entity.getAct_name()).append("]]></act_name>")
			.append("<remark><![CDATA[").append(entity.getRemark()).append("]]></remark>")
			.append("<nonce_str><![CDATA[").append(entity.getNonce_str()).append("]]></nonce_str>")
			.append("</xml>");
		
		Map<String, String> re = null;
		try {
			re = WxhbUtil.sendpost(resultXml.toString(),path,mch_id,"https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return re;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> gethbinfo(HashMap<String,String> entity,String path,String mch_id) {
		
		
		StringBuffer resultXml=new StringBuffer();

		resultXml.append("<xml>")
			.append("<sign><![CDATA[").append(entity.get("sign")).append("]]></sign>")
			.append("<mch_billno><![CDATA[").append(entity.get("mch_billno")).append("]]></mch_billno>")
			.append("<mch_id><![CDATA[").append(entity.get("mch_id")).append("]]></mch_id>")
			.append("<appid><![CDATA[").append(entity.get("appid")).append("]]></appid>")
			.append("<bill_type><![CDATA[").append(entity.get("bill_type")).append("]]></bill_type> ")
			.append("<nonce_str><![CDATA[").append(entity.get("nonce_str")).append("]]></nonce_str>")
			.append("</xml>");
			
			
		
		Map<String, String> re = null;
		try {
			re = WxhbUtil.sendpost(resultXml.toString(),path,mch_id,"https://api.mch.weixin.qq.com/mmpaymkttransfers/gethbinfo");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return re;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> sendtransfers(Transfers entity,String path,String mch_id) {
		
		
		StringBuffer resultXml=new StringBuffer();

		resultXml.append("<xml>")
			.append("<mch_appid><![CDATA[").append(entity.getMch_appid()).append("]]></mch_appid>")
			
			.append("<mchid><![CDATA[").append(entity.getMchid()).append("]]></mchid>")
			.append("<nonce_str><![CDATA[").append(entity.getNonce_str()).append("]]></nonce_str>")
			.append("<partner_trade_no><![CDATA[").append(entity.getPartner_trade_no()).append("]]></partner_trade_no>")
			.append("<openid><![CDATA[").append(entity.getOpenid()).append("]]></openid>")
			.append("<check_name><![CDATA[").append(entity.getCheck_name()).append("]]></check_name>")
			.append("<re_user_name><![CDATA[").append(entity.getRe_user_name()).append("]]></re_user_name>")
			.append("<amount><![CDATA[").append(entity.getAmount()).append("]]></amount>")
			.append("<desc><![CDATA[").append(entity.getDesc()).append("]]></desc>")
			.append("<spbill_create_ip><![CDATA[").append(entity.getClient_ip()).append("]]></spbill_create_ip>")
			
			.append("<sign><![CDATA[").append(entity.getSign()).append("]]></sign>")
			.append("</xml>");
		
		Map<String, String> re = null;
		try {
			re = WxhbUtil.sendpost(resultXml.toString(),path,mch_id,"https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return re;
	}
	
	public  static Map<String, String> sendpost (String xml,String path,String mch_id,String url) throws Exception {
       
        KeyStore keyStore  = KeyStore.getInstance("PKCS12");
        FileInputStream instream = new FileInputStream(new File(path)); //此处为证书所放的绝对路径
        Map<String, String> map = new HashMap<String, String>();       
                try {
                    keyStore.load(instream, mch_id.toCharArray());
                } finally {
                    instream.close();
                }


                // Trust own CA and all self-signed certs
                SSLContext sslcontext = SSLContexts.custom()
                        .loadKeyMaterial(keyStore, mch_id.toCharArray())
                        .build();
                // Allow TLSv1 protocol only
                SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                        sslcontext,
                        new String[] { "TLSv1" },
                        null,
                        SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
                CloseableHttpClient httpclient = HttpClients.custom()
                        .setSSLSocketFactory(sslsf)
                        .build();
                
                try {


                    HttpPost httpPost = new HttpPost(url);
                    
                    StringEntity  reqEntity  = new StringEntity(xml, "utf-8");
                    
                    // 设置类型 
                    reqEntity.setContentType("application/x-www-form-urlencoded"); 
                    
                    httpPost.setEntity(reqEntity);
         

                    CloseableHttpResponse response = httpclient.execute(httpPost);
                    try {
                        HttpEntity entity = response.getEntity();
                        System.out.println(response.getStatusLine());
                        if (entity != null) {


                    // 从request中取得输入流
                    InputStream inputStream = entity.getContent();
                    
                    
                    // 读取输入流
                    SAXReader reader = new SAXReader();
                    Document document = reader.read(inputStream);
                    // 得到xml根元素
                    Element root = document.getRootElement();
                    // 得到根元素的所有子节点
                    List<Element> elementList = root.elements();


                    // 遍历所有子节点
                    for (Element e : elementList)
                    	map.put(e.getName(), e.getText());


                    // 释放资源
                    inputStream.close();
                    inputStream = null;


                        }
                        EntityUtils.consume(entity);
                    } finally {
                        response.close();
                    }
                } finally {
                    httpclient.close();
                }
                return map;
    }
	public static void main(String[] args) throws Exception{  
		
    }  
	/** 
     * 除去数组中的空值和签名参数
     * @param sArray 签名参数组
     * @return 去掉空值与签名参数后的新签名参数组
     */
    public static Map<String, String> paraFilter(Map<String, String> sArray) {


        Map<String, String> result = new HashMap<String, String>();


        if (sArray == null || sArray.size() <= 0) {
            return result;
        }


        for (String key : sArray.keySet()) {
            String value = sArray.get(key);
            if (value == null || value.equals("") || key.equalsIgnoreCase("sign")
                || key.equalsIgnoreCase("sign_type")) {
                continue;
            }
            result.put(key, value);
        }


        return result;
    }
    /** 
     * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public static String createLinkString(Map<String, String> params) {


        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);


        String prestr = "";


        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = params.get(key);


            if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
                prestr = prestr + key + "=" + value;
            } else {
                prestr = prestr + key + "=" + value + "&";
            }
        }


        return prestr;
    }
	
	 /**
     * 签名字符串
     * @param text 需要签名的字符串
     * @param key 密钥
     * @param input_charset 编码格式
     * @return 签名结果
     */
    public static String sign(String text, String key, String input_charset) {
    	text = text + key;
        return DigestUtils.md5Hex(getContentBytes(text, input_charset));
    }
    /**
     * @param content
     * @param charset
     * @return
     * @throws SignatureException
     * @throws UnsupportedEncodingException 
     */
    private static byte[] getContentBytes(String content, String charset) {
        if (charset == null || "".equals(charset)) {
            return content.getBytes();
        }
        try {
            return content.getBytes(charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
        }
    }

	/** 
     * 将摘要信息转换成MD5编码 
     * @param message 摘要信息 
     * @return MD5编码之后的字符串 
     */  
    public static String md5Encode(String message){  
        return Encode("MD5",message);  
    }  
    /** 
     * 将摘要信息转换成SHA编码 
     * @param message 摘要信息 
     * @return SHA编码之后的字符串 
     */  
    public static String shaEncode(String message){  
        return Encode("SHA",message);  
    }  
    /** 
     * 将摘要信息转换成SHA-256编码 
     * @param message 摘要信息 
     * @return SHA-256编码之后的字符串 
     */  
    public static String sha256Encode(String message){  
        return Encode("SHA-256",message);  
    }  
    /** 
     * 将摘要信息转换成SHA-512编码 
     * @param message 摘要信息 
     * @return SHA-512编码之后的字符串 
     */  
    public static String sha512Encode(String message){  
        return Encode("SHA-512",message);  
    }  
    /** 
     * 将摘要信息转换为相应的编码 
     * @param code 编码类型 
     * @param message 摘要信息 
     * @return 相应的编码字符串 
     */  
    private static String Encode(String code,String message){  
    	MessageDigest crypt;
    	String signature ="";
    	try {
			crypt = MessageDigest.getInstance("SHA-1");
		
			crypt.reset();
			crypt.update(message.toString().getBytes("UTF-8"));
		
			 signature = byteToHex(crypt.digest());
    	 } catch (Exception e) {
        	 System.out.println("发送POST请求出现异常！" + e);
        	 e.printStackTrace();
         }
		return signature;
					
    }  
	private static String byteToHex(final byte[] hash) {
		        Formatter formatter = new Formatter();
		        for (byte b : hash)
		        {
		            formatter.format("%02x", b);
		        }
		        String result = formatter.toString();
		        formatter.close();
		        return result;
	}
 
}
