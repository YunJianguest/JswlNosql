package com.lsp.pub.util;
 
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.xml.sax.InputSource;

import com.lsp.weixin.entity.WeixinRequest;
import com.lsp.weixin.entity.WxContext;
/**
 * 工具
 * @author lsp 
 *   
 */
public class ParseXml {

	/**
	 * 解析xml格式的字符串
	 * 
	 * @param xmlDoc
	 * @return
	 */
	public static WeixinRequest getElements(String xmlDoc) { 
		StringReader read = new StringReader(xmlDoc);
		// 创建一个新的字符串
		// 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		InputSource source = new InputSource(read);
		// 创建一个新的SAXBuilder
		SAXBuilder sb = new SAXBuilder();
		WeixinRequest weixin = new WeixinRequest();// 构造大对象
		try {
			sb.setFeature(
					"http://apache.org/xml/features/nonvalidating/load-external-dtd",
					false);
			// 通过输入源构造一个Document
			Document doc = sb.build(source);
			// 取的根元素
			Element root = doc.getRootElement();
			
			weixin.setToUser(root.getChildText("ToUserName"));
			weixin.setFromUser(root.getChildText("FromUserName"));
			System.out.println(root.getChildText("CreateTime"));
			weixin.setCreateTime(new Date(Long.parseLong(root.getChildText("CreateTime"))*1000L));
			weixin.setMsgType(root.getChildText("MsgType"));
			weixin.setContent(root.getChildText("Content"));
			weixin.setPicUrl(root.getChildText("PicUrl"));
			if(root.getChildText("Location_X")!=null){
				weixin.setLocation_X(Double.parseDouble(root.getChildText("Location_X")));
				weixin.setLocation_Y(Double.parseDouble(root.getChildText("Location_Y")));
			}
			if(root.getChildText("Recognition")!=null){
				weixin.setContent(root.getChildText("Recognition"));
			}
			
			weixin.setTitle(root.getChildText("Title"));
			weixin.setDescription(root.getChildText("Description"));
			if(root.getChildText("MsgId")!=null){
				weixin.setMsgId(Long.parseLong(root.getChildText("MsgId")));
			}
			
			weixin.setUrl(root.getChildText("Url"));
			weixin.setEvent(root.getChildText("Event"));
			weixin.setEventKey(root.getChildText("EventKey"));
			if(root.getChildText("Latitude")!=null){
				weixin.setLocation_X(Double.parseDouble(root.getChildText("Latitude")));
				weixin.setLocation_Y(Double.parseDouble(root.getChildText("Longitude")));
			}
		} catch (JDOMException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		}
		return weixin;
	}
	/**
	 * 解析xml格式的字符串
	 * 
	 * @param xmlDoc
	 * @return
	 */
	public static String getAddress(String xmlDoc) {
		String re=null;
		StringReader read = new StringReader(xmlDoc);
		// 创建一个新的字符串
		// 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		InputSource source = new InputSource(read);
		// 创建一个新的SAXBuilder
		SAXBuilder sb = new SAXBuilder();
		WeixinRequest weixin = new WeixinRequest();// 构造大对象
		try {
			sb.setFeature(
					"http://apache.org/xml/features/nonvalidating/load-external-dtd",
					false);
			// 通过输入源构造一个Document
			Document doc = sb.build(source);
			// 取的根元素
			Element root = doc.getRootElement();
			Element result=root.getChild("result");
			
			 re=result.getChildText("formatted_address");
			
		} catch (JDOMException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		}
		return re;
	}

	 
    /*将XML Document转换为字符串的方法*/
    public static String toXML(Document xmlDoc, String encoding) throws IOException
    {
        ByteArrayOutputStream byteRep = new ByteArrayOutputStream();
        Format format = Format.getPrettyFormat();
        format.setEncoding(encoding);
  
        XMLOutputter docWriter = new XMLOutputter(format);
        docWriter.output(xmlDoc, byteRep);

        return byteRep.toString(encoding);
    }
 
   
    /**
	 * 解析xml格式的字符串
	 * 
	 * @param xmlDoc
	 * @return
	 */
	public static WxContext xmlToTuwen(String xmlDoc) {
		StringReader read = new StringReader(xmlDoc);
		// 创建一个新的字符串
		// 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
		InputSource source = new InputSource(read);
		// 创建一个新的SAXBuilder
		SAXBuilder sb = new SAXBuilder();
		WxContext tuwen = new WxContext();// 构造大对象
		try {
			sb.setFeature(
					"http://apache.org/xml/features/nonvalidating/load-external-dtd",
					false);
			// 通过输入源构造一个Document
			Document doc = sb.build(source);
			// 取的根元素
			Element root = doc.getRootElement();
		
			Element item = root.getChild("item");
			Element display = item.getChild("display");
			tuwen.setTitle(display.getChildText("title"));
			tuwen.setUrl(display.getChildText("url"));
			tuwen.setPicurl(display.getChildText("imglink"));
			try {
				tuwen.setInsdate(DateFormat.getFormat(display.getChildText("date")));
			} catch (Exception e) {
				
			}
			//tuwen.setYdl(ydl);
			System.err.println(root.toString()+"=========="+display.getChildText("date"));
			
		} catch (JDOMException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		}
		return tuwen;
	}
	 
}

