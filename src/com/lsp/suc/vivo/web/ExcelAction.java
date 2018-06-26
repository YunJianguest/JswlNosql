package com.lsp.suc.vivo.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.upload.HttpURLConnectionUtils;
import com.lsp.pub.upload.JsonUtil;
import com.lsp.pub.util.EncodeUtils;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.suc.vivo.entity.DjCode;
import com.lsp.suc.vivo.entity.LuckyEmployees;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.poi.hssf.usermodel.HSSFCell;  
import org.apache.poi.xssf.usermodel.XSSFCell;  
import org.apache.poi.xssf.usermodel.XSSFRow;  
import org.apache.poi.xssf.usermodel.XSSFSheet;  
import org.apache.poi.xssf.usermodel.XSSFWorkbook;  
/**
 * 文件上传
 * @author lsp 
 *   
 */
@Namespace("/suc/vivo")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "excel.action", type = "redirect") })
public class ExcelAction extends ActionSupport {
	/**
	 * 
	 */
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	private static final long serialVersionUID = -6784469775589971579L; 
	private List<File> image; // 上传的文件
	private List<String> imageFileName; // 文件名称
	private List<String> imageContentType; // 文件类型
	private String savePath;
	public  void importExp() throws Exception {  
		// 取得需要上传的文件数组
		String datatype=Struts2Utils.getParameter("datatype");
		List<File> files = getImage(); 
		if (files != null && files.size() > 0) {
		
			for (int i = 0; i < files.size(); i++) {
				if (datatype.equals("djcode")) {
					//串码
					FileInputStream fis = new FileInputStream(files.get(i));
					ArrayList<ArrayList<String>> arr=xlsx_reader(fis,0);
					
					for(int k=0;k<arr.size();k++){  
			            ArrayList<String> row=arr.get(k); 
			            DjCode code=new DjCode();
		                code.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_DJCODE));
		                code.setCreatedate(new Date());
		                code.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		                code.setCode(row.get(0));
			            baseDao.insert(PubConstants.SUC_VIVO_DJCODE, code);
			        }   
				}else if(datatype.equals("employees")) {
					//导购
					FileInputStream fis = new FileInputStream(files.get(i));
					ArrayList<ArrayList<String>> arr=xlsx_reader(fis,0,1,2);
					
					for(int k=0;k<arr.size();k++){  
			            ArrayList<String> row=arr.get(k);
			            System.out.println(row.size());
			            LuckyEmployees employees=new LuckyEmployees();
			            employees.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_EMPLOYEES));
		            	employees.setCreatedate(new Date());
		            	employees.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		            	employees.setName(row.get(0));
		            	employees.setTel(row.get(1));
		            	employees.setAddress(row.get(2)); 
			            baseDao.insert(PubConstants.SUC_VIVO_EMPLOYEES, employees);
			        }   
					
				}
				
				 
			}
			
			 
			 
		} 
		 String returnurl=Struts2Utils.getParameter("returnurl");
		 Struts2Utils.getRequest().getRequestDispatcher(returnurl).forward(Struts2Utils.getRequest(), Struts2Utils.getResponse());
		 
	}
 
    //*************xlsx文件读取函数************************  
    //excel_name为文件名，arg为需要查询的列号  
    //返回二维字符串数组  
    @SuppressWarnings({ "resource", "unused" })  
    public ArrayList<ArrayList<String>> xlsx_reader(FileInputStream is,int ... args) throws IOException {  
  
        //读取xlsx文件  
        XSSFWorkbook xssfWorkbook = null;   
        xssfWorkbook = new XSSFWorkbook(is);  
        
        if(xssfWorkbook==null){  
            System.out.println("未读取到内容,请检查路径！");  
            return null;  
        }  
          
        ArrayList<ArrayList<String>> ans=new ArrayList<ArrayList<String>>();  
        //遍历xlsx中的sheet  
        for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {  
            XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);  
            if (xssfSheet == null) {  
                continue;  
            }  
            // 对于每个sheet，读取其中的每一行  
            for (int rowNum = 0; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {  
                XSSFRow xssfRow = xssfSheet.getRow(rowNum);  
                if (xssfRow == null) continue;   
                ArrayList<String> curarr=new ArrayList<String>();  
                for(int columnNum = 0 ; columnNum<args.length ; columnNum++){  
                    XSSFCell cell = xssfRow.getCell(args[columnNum]);  
                      
                    curarr.add( Trim_str( getValue(cell) ) );  
                }  
                ans.add(curarr);  
            }  
        }  
        return ans;  
    }  
      
    //判断后缀为xlsx的excel文件的数据类  
    @SuppressWarnings("deprecation")  
    private static String getValue(XSSFCell xssfRow) {  
        if(xssfRow==null){  
            return "---";  
        }  
        if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {  
            return String.valueOf(xssfRow.getBooleanCellValue());  
        } else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {  
            double cur=xssfRow.getNumericCellValue();  
            long longVal = Math.round(cur);  
            Object inputValue = null;  
            if(Double.parseDouble(longVal + ".0") == cur)    
                    inputValue = longVal;    
            else    
                    inputValue = cur;   
            return String.valueOf(inputValue);  
        } else if(xssfRow.getCellType() == xssfRow.CELL_TYPE_BLANK || xssfRow.getCellType() == xssfRow.CELL_TYPE_ERROR){  
            return "---";  
        }  
        else {  
            return String.valueOf(xssfRow.getStringCellValue());  
        }  
    }  
      
    //判断后缀为xls的excel文件的数据类型  
    @SuppressWarnings("deprecation")  
    private static String getValue(HSSFCell hssfCell) {  
        if(hssfCell==null){  
            return "---";  
        }  
        if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {  
            return String.valueOf(hssfCell.getBooleanCellValue());  
        } else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {  
            double cur=hssfCell.getNumericCellValue();  
            long longVal = Math.round(cur);  
            Object inputValue = null;  
            if(Double.parseDouble(longVal + ".0") == cur)    
                    inputValue = longVal;    
            else    
                    inputValue = cur;   
            return String.valueOf(inputValue);  
        } else if(hssfCell.getCellType() == hssfCell.CELL_TYPE_BLANK || hssfCell.getCellType() == hssfCell.CELL_TYPE_ERROR){  
            return "---";  
        }  
        else {  
            return String.valueOf(hssfCell.getStringCellValue());  
        }  
    }  
      
  //字符串修剪  去除所有空白符号 ， 问号 ， 中文空格  
    static private String Trim_str(String str){  
        if(str==null)  
            return null;  
        return str.replaceAll("[\\s\\?]", "").replace("　", "");  
    }

	public List<File> getImage() {
		return image;
	}

	public void setImage(List<File> image) {
		this.image = image;
	}

	public List<String> getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(List<String> imageFileName) {
		this.imageFileName = imageFileName;
	}

	public List<String> getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(List<String> imageContentType) {
		this.imageContentType = imageContentType;
	}

//	 public static void main(String[] args) throws IOException  {  
//	        Excel_reader test= new Excel_reader();   
//	        ArrayList<ArrayList<String>> arr=test.xlsx_reader("/....../filename.xlsx",0,1,2,3,4,5);  //后面的参数代表需要输出哪些列，参数个数可以任意  
//	        for(int i=0;i<arr.size();i++){  
//	            ArrayList<String> row=arr.get(i);  
//	            for(int j=0;j<row.size();j++){  
//	                System.out.print(row.get(j)+" ");  
//	            }  
//	            System.out.println("");  
//	        }  
//	             
//	    }  
//	 
   
}
