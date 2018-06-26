package com.lsp.pub.util; 
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
 
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.PubConstants; 
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 

import freemarker.template.Configuration;
import freemarker.template.Template;
/**
 * 工具
 * @author lsp 
 *   
 */
public class FreeMarkertUtil {  
	  
    private Configuration config;  
  
    public Configuration getConfig() {  
        return config;  
    }  
    /** 
     * 注意：setEncoding这个方法一定要设置国家及其编码，不然在flt中的中文在生成html后会变成乱码 
     * @param filePath 文件路径 
     * @throws Exception 
     */  
    public  void init(String filePath) throws Exception {  
        config = new Configuration();  
        config.setDirectoryForTemplateLoading(new File(filePath));  
        config.setEncoding(Locale.CHINA, "utf-8");  
    }  
      
/** 
     * 通过flt文件用html文件展示课程数据 
     * @param filePath flt文件路径 
     * @param templateFile flt模板文件 
     * @param list 要生成html的集合数据 
     * @param charset flt生成数据的编码格式 
     * @param htmlFile 通过flt生成html的文件 
     * @throws Exception 
     */  
    public void showCourse( String templateFile, Map<String, Object> root, String htmlFile, String htmlName) throws Exception {  
    	String filePath=SysConfig.getProperty("filepath");
    	//Struts2Utils.getRequest().getContextPath();
    	init(filePath);  
        
        Template temp = getConfig().getTemplate(templateFile,"UTF-8");  
        creatDirs(filePath,htmlFile);
        deleteFile(filePath+"/"+htmlFile+htmlName);
        Writer out=new OutputStreamWriter(new FileOutputStream(filePath+"/"+htmlFile+htmlName), "UTF-8");  
        
        temp.process(root, out);  
    }  
    /**
     * 创建多级目录
     *
     * @param aParentDir String
     * @param aSubDir  以 / 开头
     * @return boolean 是否成功
     */
    public static boolean creatDirs(String aParentDir, String aSubDir)
    {
        File aFile = new File(aParentDir);
        if (aFile.exists())
        {
            File aSubFile = new File(aParentDir + aSubDir);
            if (!aSubFile.exists())
            {
                return aSubFile.mkdirs();
            }
            else
            {
                return true;
            }
        }
        else
        {
            return false;
        }
    }   
    /** 
     * 删除单个文件 
     * @param   sPath    被删除文件的文件名 
     * @return 单个文件删除成功返回true，否则返回false 
     */  
    public static boolean deleteFile(String sPath) {  
    	boolean flag = false;  
        File file = new File(sPath);  
        // 路径为文件且不为空则进行删除  
        if (file.isFile() && file.exists()) {  
            file.delete();  
            flag = true;  
        }  
        return flag;  
    } 
 
   
}  
