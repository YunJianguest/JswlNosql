package com.lsp.email.entity;


import javax.mail.*;  
/**
 * 资源管理
 * @author lsp 
 *   
 */   
public class MyAuthenticator extends Authenticator{  
   String userName=null;  
   String password=null;  
      
   public MyAuthenticator(){  
   }  
   public MyAuthenticator(String username, String password) {   
       this.userName = username;   
       this.password = password;   
   }   
   protected PasswordAuthentication getPasswordAuthentication(){  
       return new PasswordAuthentication(userName, password);  
   }  
}  