package com.lsp.pub.util;

 
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.mongodb.DBObject;
/**
 * 工具
 * @author lsp 
 *   
 */
public class ExportExcel {

	
	public static HSSFWorkbook export(List<Map<String, Object>> list,String[] header,String[] body,String title) {  
        HSSFWorkbook wb = new HSSFWorkbook();  
        HSSFSheet sheet = wb.createSheet(title);  
        HSSFRow row = sheet.createRow((int) 0);  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
  
        for (int i = 0; i < header.length; i++) {  
            HSSFCell cell = row.createCell((short) i);  
            cell.setCellValue(header[i]);  
            cell.setCellStyle(style);  
            sheet.autoSizeColumn((short) i);  
         // sheet.SetColumnWidth(i, 100 * 256);  
        }  
  
        for (int i = 0; i < list.size(); i++) {  
            row = sheet.createRow(i + 1);  
            Map<String, Object> student = list.get(i);  
            for(int j=0;j<body.length;j++){
            	if(student.get(body[j])==null){
            		row.createCell((short)j).setCellValue("");  
            	}else{
            		row.createCell((short)j).setCellValue(student.get(body[j]).toString());  
            	}
            	
            }
            
           
        }  
        return wb;  
    }  
	public static HSSFWorkbook exportByMongo(List<DBObject> list,String[] header,String[] body,String title) {  
        HSSFWorkbook wb = new HSSFWorkbook();  
        HSSFSheet sheet = wb.createSheet(title);  
        HSSFRow row = sheet.createRow((int) 0);  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
  
        for (int i = 0; i < header.length; i++) {  
            HSSFCell cell = row.createCell((short) i);  
            cell.setCellValue(header[i]);  
            cell.setCellStyle(style);  
            sheet.autoSizeColumn((short) i);  
         // sheet.SetColumnWidth(i, 100 * 256);  
        }  
  
        for (int i = 0; i < list.size(); i++) {  
            row = sheet.createRow(i + 1);  
            DBObject student = list.get(i);  
            for(int j=0;j<body.length;j++){
            	if(student.get(body[j])==null){
            		row.createCell((short)j).setCellValue("");  
            	}else{
            		row.createCell((short)j).setCellValue(student.get(body[j]).toString());  
            	}
            	
            }
            
           
        }  
        return wb;  
    }  
}

