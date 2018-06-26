package com.lsp.email.util;  
import java.util.Properties; 
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart; 

import com.lsp.email.entity.Email;

public class EmailUtils {

	/**
	 * 创建邮件
	 * @param session
	 * @param emailInfo
	 * @return
	 * @throws AddressException
	 * @throws MessagingException
	 */
	public static MimeMessage  createSimpleMail(Session session,Email emailInfo) throws AddressException, MessagingException{
		  MimeMessage message = new MimeMessage(session);
		  //指明邮件的发件人
		  message.setFrom(new InternetAddress(emailInfo.getFromAddress()));
		  //指明邮件的收件人，
		  message.setRecipient(Message.RecipientType.TO, new InternetAddress(emailInfo.getToAddress()));
		  //邮件的标题
		  message.setSubject(emailInfo.getSubject());
		  //邮件的文本内容
		  message.setContent(emailInfo.getContent(), emailInfo.getType());
		  //返回创建好的邮件对象
		return message; 
	}
	/**
	 * 发送邮件
	 * @return
	 * @throws MessagingException 
	 * @throws AddressException 
	 */
	public  static  boolean  sendEmail(Email emailInfo) throws AddressException, MessagingException{
		  Properties prop = new Properties();
		  prop.setProperty("mail.host", emailInfo.getHost());
		  prop.setProperty("mail.transport.protocol", emailInfo.getHostType());
		  prop.setProperty("mail.smtp.auth", "true");
		  //使用JavaMail发送邮件的5个步骤
		  //1、创建session
		  Session session = Session.getInstance(prop);
		  //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
		  session.setDebug(true);
		  //2、通过session得到transport对象
		  Transport ts = session.getTransport();
		  //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
		  ts.connect(emailInfo.getHost(),emailInfo.getUserName(), emailInfo.getPassword());
		    //4、创建邮件
		  Message message = createSimpleMail(session,emailInfo);
		  //5、发送邮件
		  ts.sendMessage(message, message.getAllRecipients());
		  ts.close();
		return false;
		
	}
    /**
     * 创建html 邮件
     * @param session
     * @param emailInfo
     * @return
     * @throws Exception
     */
	public static MimeMessage createHtmlMail(Session session, Email emailInfo) throws Exception {
		    //创建邮件
		    MimeMessage message = new MimeMessage(session);
		    // 设置邮件的基本信息
		    //发件人
		    message.setFrom(new InternetAddress(emailInfo.getFromAddress()));
		    //收件人
		    message.setRecipient(Message.RecipientType.TO, new InternetAddress(emailInfo.getToAddress()));
		    //邮件标题
		    message.setSubject(emailInfo.getSubject());
		
		    // 准备邮件数据
		    // 准备邮件正文数据
		    MimeBodyPart text = new MimeBodyPart();
		    text.setContent(emailInfo.getContent(), "text/html;charset=UTF-8"); 
		    // 描述数据关系
		    MimeMultipart mm = new MimeMultipart();
		    mm.addBodyPart(text); 
		    mm.setSubType("related");
		 
		    message.setContent(mm);
		    message.saveChanges();
		         
		    //返回创建好的邮件
		   return message;
	   }
	/**
	 * 发送Html邮件
	 * @return
	 * @throws Exception 
	 */
	public  static  boolean  sendHtmlEmail(Email emailInfo) throws Exception{
		  Properties prop = new Properties();
		  prop.setProperty("mail.host", emailInfo.getHost());
		  prop.setProperty("mail.transport.protocol", emailInfo.getHostType());
		  prop.setProperty("mail.smtp.auth", "true");
		  //使用JavaMail发送邮件的5个步骤
		  //1、创建session
		  Session session = Session.getInstance(prop);
		  //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
		  session.setDebug(true);
		  //2、通过session得到transport对象
		  Transport ts = session.getTransport();
		  //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
		  ts.connect(emailInfo.getHost(),emailInfo.getUserName(), emailInfo.getPassword());
		    //4、创建邮件
		  Message message = createHtmlMail(session,emailInfo);
		  //5、发送邮件
		  ts.sendMessage(message, message.getAllRecipients());
		  ts.close();
		return false;
		
	}
		 
}
