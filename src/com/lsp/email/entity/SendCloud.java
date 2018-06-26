package com.lsp.email.entity;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeBodyPart;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import com.lsp.pub.util.SysConfig;
 
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class SendCloud {
	
	/**
	 * WEBAPI 普通发送, 带附件
	 * @throws ClientProtocolException
	 * @throws IOException
	 * @throws MessagingException 
	 */
	public static void send_common_with_attachment(String email,String tp,String imgurl,String no) throws ClientProtocolException, IOException, MessagingException {

	    final String url = "http://sendcloud.sohu.com/webapi/mail.send.json";

	    final String apiUser = "chemingpian";
	    final String apiKey = "RkCjEaaDa931lYIi";
	   
	    HttpPost httpPost = new HttpPost(url);
	    HttpClient httpclient = new DefaultHttpClient();

	    // 涉及到附件上传, 需要使用 MultipartEntity
	    MultipartEntity entity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE, null, Charset.forName("UTF-8"));
	    entity.addPart("api_user", new StringBody(apiUser, Charset.forName("UTF-8")));
	    entity.addPart("api_key", new StringBody(apiKey, Charset.forName("UTF-8")));
	    entity.addPart("to", new StringBody(email, Charset.forName("UTF-8")));
	    entity.addPart("from", new StringBody("chemingpian@mail.chemingpian.com", Charset.forName("UTF-8")));
	    entity.addPart("replyto", new StringBody("chemingpian@vip.qq.com", Charset.forName("UTF-8")));
	    
	    entity.addPart("fromname", new StringBody("车名片", Charset.forName("UTF-8")));
	    entity.addPart("subject", new StringBody("车名片用户，请查看附件打印", Charset.forName("UTF-8")));
	    String body=SendCloud.userDy(no, imgurl);
	    entity.addPart("html", new StringBody(body, Charset.forName("UTF-8")));
	   // entity.addPart("html", new StringBody("亲爱的车名片用户您好！您可以直接拷贝一下图片。到附件复印店选择白卡纸进行打印 。有任何问题请关注微信公众号《车名片》<div style=\"background: url("+imgurl+"); width:2498px; height:3504px; border:1px solid #e9e9e9; border-bottom-width: 0;\">", Charset.forName("UTF-8")));
	   
	       /*JavaMail API不限制信息只为文本,任何形式的信息都可能作茧自缚MimeMessage的一部分.
	        * 除了文本信息,作为文件附件包含在电子邮件信息的一部分是很普遍的.
	        * JavaMail API通过使用DataHandler对象,提供一个允许我们包含非文本BodyPart对象的简便方法.*/
	   
	    entity.addPart("resp_email_id", new StringBody("true"));

	    // 添加附件
	    File file = new File(tp);
	    FileBody attachment = new FileBody(file, "application/octet-stream", "UTF-8");
	    entity.addPart("files", attachment);

	    // 添加附件, 文件流形式
	    // File file = new File("/path/file");
	    // String attachName = "attach.txt";
	    // InputStreamBody is = new InputStreamBody(new FileInputStream(file),
	    // attachName);
	    // entity.addPart("files", is);

	    httpPost.setEntity(entity);

	    HttpResponse response = httpclient.execute(httpPost);
	    // 处理响应
	    if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
	        // 正常返回, 解析返回数据
	        System.out.println(EntityUtils.toString(response.getEntity()));
	    } else {
	        System.err.println("error");
	    }
	    httpPost.releaseConnection();
	}
	/**
	 * WEBAPI 普通发送, 带附件
	 * @throws ClientProtocolException
	 * @throws IOException
	 * @throws MessagingException 
	 */
	public static void send_companyai(String email,String tp,String imgurl,String jhurl,String ncurl) throws ClientProtocolException, IOException, MessagingException {

	    final String url = "http://sendcloud.sohu.com/webapi/mail.send.json";

	    final String apiUser = "chemingpian";
	    final String apiKey = "RkCjEaaDa931lYIi";
	   
	    HttpPost httpPost = new HttpPost(url);
	    HttpClient httpclient = new DefaultHttpClient();

	    // 涉及到附件上传, 需要使用 MultipartEntity
	    MultipartEntity entity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE, null, Charset.forName("UTF-8"));
	    entity.addPart("api_user", new StringBody(apiUser, Charset.forName("UTF-8")));
	    entity.addPart("api_key", new StringBody(apiKey, Charset.forName("UTF-8")));
	    entity.addPart("to", new StringBody(email, Charset.forName("UTF-8")));
	    entity.addPart("from", new StringBody("chemingpian@mail.chemingpian.com", Charset.forName("UTF-8")));
	    entity.addPart("replyto", new StringBody("chemingpian@vip.qq.com", Charset.forName("UTF-8")));
	    
	    entity.addPart("fromname", new StringBody("车名片", Charset.forName("UTF-8")));
	    entity.addPart("subject", new StringBody("车名片合作用户，请查看AI附件进行设计", Charset.forName("UTF-8")));

	    String body=SendCloud.PjString(imgurl, jhurl, ncurl);
	    entity.addPart("html", new StringBody(body, Charset.forName("UTF-8")));
	   
	       /*JavaMail API不限制信息只为文本,任何形式的信息都可能作茧自缚MimeMessage的一部分.
	        * 除了文本信息,作为文件附件包含在电子邮件信息的一部分是很普遍的.
	        * JavaMail API通过使用DataHandler对象,提供一个允许我们包含非文本BodyPart对象的简便方法.*/
	   
	    entity.addPart("resp_email_id", new StringBody("true"));

	    // 添加附件
	    File file = new File(tp);
	    FileBody attachment = new FileBody(file, "application/octet-stream", "UTF-8");
	    entity.addPart("files", attachment);

	    // 添加附件, 文件流形式
	    // File file = new File("/path/file");
	    // String attachName = "attach.txt";
	    // InputStreamBody is = new InputStreamBody(new FileInputStream(file),
	    // attachName);
	    // entity.addPart("files", is);

	    httpPost.setEntity(entity);

	    HttpResponse response = httpclient.execute(httpPost);
	    // 处理响应
	    if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
	        // 正常返回, 解析返回数据
	        System.out.println(EntityUtils.toString(response.getEntity()));
	    } else {
	        System.err.println("error");
	    }
	    httpPost.releaseConnection();
	}
	
	/**
	 * 
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public static void send_template_with_attachment(String title,String fjurl,String email,String template_id) throws ClientProtocolException, IOException {

	    final String url = "http://sendcloud.sohu.com/webapi/mail.send_template.json";

	    final String apiUser = "chemingpian";
	    final String apiKey = "RkCjEaaDa931lYIi";

	    List<A> dataList = new ArrayList<A>();
	    dataList.add(new A(email, "gaojiangt", "1000"));
	  

	    final String vars = convert(dataList);

	    HttpClient httpclient = new DefaultHttpClient();
	    HttpPost httpost = new HttpPost(url);

	    // 涉及到附件上传, 需要使用 MultipartEntity
	    MultipartEntity entity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE, null, Charset.forName("UTF-8"));
	    entity.addPart("api_user", new StringBody(apiUser, Charset.forName("UTF-8")));
	    entity.addPart("api_key", new StringBody(apiKey, Charset.forName("UTF-8")));
	    entity.addPart("substitution_vars", new StringBody(vars, Charset.forName("UTF-8")));
	    entity.addPart("template_invoke_name", new StringBody(template_id, Charset.forName("UTF-8")));
	    entity.addPart("from", new StringBody("chemingpian@mail.chemingpian.com", Charset.forName("UTF-8")));
	    entity.addPart("replyto", new StringBody("chemingpian@vip.qq.com", Charset.forName("UTF-8")));
	    
	    entity.addPart("fromname", new StringBody("车名片", Charset.forName("UTF-8")));
	 
	    entity.addPart("subject", new StringBody(title, Charset.forName("UTF-8")));
	    entity.addPart("resp_email_id", new StringBody("true"));

	    // 添加附件
	    File file = new File(fjurl);
	    FileBody attachment = new FileBody(file, "application/octet-stream", "UTF-8");
	    entity.addPart("files", attachment);

	 

	    httpost.setEntity(entity);

	    HttpResponse response = httpclient.execute(httpost);
	    // 处理响应
	    if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
	        // 正常返回, 解析返回数据
	        System.out.println(EntityUtils.toString(response.getEntity()));
	    } else {
	        System.err.println("error");
	    }
	    httpost.releaseConnection();
	}
	
	public static String convert(List<A> dataList) {

	    JSONObject ret = new JSONObject();

	    JSONArray to = new JSONArray();

	    JSONArray names = new JSONArray();
	    JSONArray moneys = new JSONArray();

	    for (A a : dataList) {
	        to.put(a.address);
	        names.put(a.name);
	        moneys.put(a.money);
	    }

	    JSONObject sub = new JSONObject();
	    sub.put("%name%", names);
	    sub.put("%money%", moneys);

	    ret.put("to", to);
	    ret.put("sub", sub);

	    return ret.toString();
	}
	private static String PjString(String imgurl,String jhurl,String ncurl){
		String re="<body><div> <div style=\"background-color:#90b721;font-family:sans-serif;line-height:180%;color:#FFF;margin:0px;font-size:16px;padding:10px\" align=\"left\" >"+
	
       "<img src=\"http://www.chemingpian.com/MyNosql/img/cmplogod.png\" style=\"height: 35px;position: absolute\" ><span style=\"padding-left:75px\">全国最靠谱的挪车平台</span>"+
       "</div>    <div style=\"border:1px solid #90b721;font-family:sans-serif;font-size:14px;margin:0px;background-color:#fff;line-height:20px;padding:15px\" align=\"left\" >"+
       
        "<div style=\"font-size:16px;font-weight:bolder;\">亲爱的车名片用户：</div>"+
        "<div style=\"font-size:14px;line-height:180%\">您的【微信挪车卡】↓&nbsp;如下&nbsp;↓</div>"+
        "<div><img src=\""+imgurl+"\" style=\"width: 100% \"></div>"+
   
        "<div style=\"font-size:16px;line-height:180%\">1.开通挪车链接：<br>"+jhurl+"</div>"+
        "<div style=\"font-size:14px;line-height:180%\">（可以生成个性二维码 如草料二维码:"+
         "   <a href=\"http://cli.im\" target=\"_blank\">http://cli.im</a>）</div><br>"+
        "<div style=\"font-size:16px;line-height:180%\">2.微信挪车链接：<br>"+ncurl+"</div>"+
        "<div style=\"font-size:14px;line-height:180%\">（复制链接地址，可以在微信菜单中使用）</div><br>"+
       " <div style=\"font-size:16px;line-height:180%\">3.下载模板文件：<br><a href=\""+imgurl+"\" target=\"_blank\">"+imgurl+"</a></div><br>"+
       
        "<div style=\"border-bottom:1px dashed #ccc;font-size:14px;margin: 10px\">&nbsp;&nbsp;12:26&nbsp;&nbsp;---车名片</div>"+
       " <br>"+
       " <div style=\"font-size:14px\">此邮件为系统自动发出的邮件，请勿直接回复。</div>"+
       "</div></div></body>";
		return re;
	}
	private static String userDy(String no,String ncimg){
		String re="<div align=\"left\" style=\"background-color:#90b721;font-family:sans-serif;line-height:180%;color:#FFF;margin:0px;font-size:16px;padding:10px\"><img src=\"http://www.chemingpian.com/MyNosql/cmp/img/cmplogod.png\" style=\"height: 35px;position: absolute\" /><span style=\"padding-left:75px\">全国最靠谱的挪车平台</span></div>"+
				"<div align=\"left\" style=\"border:1px solid #90b721;font-family:sans-serif;font-size:14px;margin:0px;background-color:#fff;line-height:20px;padding:15px\">"+
				"<div style=\"font-size:16px;font-weight:bolder;\">亲爱的车名片<span style=\"color:#90b721 \">【"+no+"】</span>用户：</div>"+
				"<div style=\"font-size:14px;line-height:180%\">您的【微信挪车卡】&darr;&nbsp;如下&nbsp;&darr;</div>"+
				"<div><img src=\""+ncimg+"\" style=\"width: 100% \" /></div>&nbsp;"+
				"<div style=\"width: 100%;text-align: center\">"+
				"<div style=\"font-size:16px;font-weight:bold;width:50%;float: left\"><img src=\"http://www.chemingpian.com/MyNosql/cmp/img/cmpewm.jpg\" style=\"width: 180px \" /></div>"+

				"<div style=\"font-size:16px;font-weight:bold;width: 40%;float: left;text-align: left;line-height: 12px;color: #ff7e00\">"+
				"<p style=\"color:#90b721 \">1.车辆违法查询</p>"+
				"<b>2.车辆限号提醒</b>"+

				"<p style=\"color:#90b721 \">3.车辆年审提醒</p>"+
				"<b>4.驾照销分提醒</b>"+

				"<p style=\"color:#90b721 \">5.驾照年检提醒</p>"+
				"<b>6.保险到期提醒</b></div>"+

				"<div style=\"clear: both\">&nbsp;</div>"+

				"<div style=\"font-size:16px;font-weight:bold; \">关注【车名片】微信，享更多服务！</div></div>"+

				"<div style=\"text-align: center\">"+
				"<div style=\"font-size:16px;line-height:180%\">&nbsp;</div></div>"+

				"<div style=\"border-bottom:1px dashed #ccc;font-size:14px;margin: 10px\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;---车名片</div>"+
				"</div>";
		return re;
	}
	

	private static String userString(String imgurl){
		String re="<body><div> <div style=\"background-color:#90b721;font-family:sans-serif;line-height:180%;color:#FFF;margin:0px;font-size:16px;padding:10px\" align=\"left\" >"+
	
       "<img src=\"http://www.chemingpian.com/MyNosql/img/cmplogod.png\" style=\"height: 35px;position: absolute\" ><span style=\"padding-left:75px\">全国最靠谱的挪车平台</span>"+
       "</div>    <div style=\"border:1px solid #90b721;font-family:sans-serif;font-size:14px;margin:0px;background-color:#fff;line-height:20px;padding:15px\" align=\"left\" >"+
       
        "<div style=\"font-size:16px;font-weight:bolder;\">亲爱的车名片用户：</div>"+
        "<div style=\"font-size:14px;line-height:180%\">您的【微信挪车卡】↓&nbsp;如下&nbsp;↓</div>"+
        "<div><img src=\""+imgurl+"\" style=\"width: 100% \"></div>"+
   

       
        "<div style=\"border-bottom:1px dashed #ccc;font-size:14px;margin: 10px\">&nbsp;&nbsp;12:26&nbsp;&nbsp;---车名片</div>"+
       " <br>"+
       " <div style=\"font-size:14px\">此邮件为系统自动发出的邮件，请勿直接回复。</div>"+
       "</div></div></body>";
		return re;
	}
	 public static void main(String[] args) throws Exception{
		 SendCloud.send_common_with_attachment("280714118@qq.com",SysConfig.getProperty("filePath")+"/uploads/ewm/oypimjjCog0oUv9KfUYV-rSjsQk4-print.jpg","http://www.chemingpian.com/MyNosql/uploads/ewm/oypimjjCog0oUv9KfUYV-rSjsQk4-print.jpg","000091");
		// SendCloud.send_template_with_attachment("上传个性模板",SysConfig.getProperty("filePath")+"/cmp/sjmb.rar","280714118@qq.com","printcmp");
//		 String fj=SysConfig.getProperty("filePath")+"/cmp/ai-help.zip";
//		SendCloud.send_companyai("280714118@qq.com",fj,SysConfig.getProperty("ip")+"/uploads/ewm/aiprint-"+253+".jpg","","");
	 }
}