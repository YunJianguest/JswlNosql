package com.lsp.dwr;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;

 
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.lsp.pub.util.SysConfig;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class UploadServer {
	
	/** 
     * @param uploadImage 圖片文件流 
     * @param uploadFile 需要用简单的文本文件，如：.txt文件，不然上传会出乱码 
     * @param color 
     * @return 
     */  
    public BufferedImage uploadFiles(BufferedImage uploadImage,  
            String uploadFile, String color) {  
        // uploadImage = scaleToSize(uploadImage);  
        // uploadImage =grafitiTextOnImage(uploadImage, uploadFile, color);  
        return uploadImage;  
    }  
   
  
    private BufferedImage scaleToSize(BufferedImage uploadImage) {  
        AffineTransform atx = new AffineTransform();  
        atx  
                .scale(200d / uploadImage.getWidth(), 200d / uploadImage  
                        .getHeight());  
        AffineTransformOp atfOp = new AffineTransformOp(atx,  
                AffineTransformOp.TYPE_BILINEAR);  
        uploadImage = atfOp.filter(uploadImage, null);  
        return uploadImage;  
    }  
  
    private BufferedImage grafitiTextOnImage(BufferedImage uploadImage,  
            String uploadFile, String color) {  
        if (uploadFile.length() < 200) {  
            uploadFile += uploadFile + " ";  
        }  
        Graphics2D g2d = uploadImage.createGraphics();  
        for (int row = 0; row < 10; row++) {  
            String output = "";  
            if (uploadFile.length() > (row + 1) * 20) {  
                output += uploadFile.substring(row * 20, (row + 1) * 20);  
            } else {  
                output = uploadFile.substring(row * 20);  
            }  
            g2d.setFont(new Font("SansSerif", Font.BOLD, 16));  
            g2d.setColor(Color.blue);  
            g2d.drawString(output, 5, (row + 1) * 20);  
        }  
        return uploadImage;  
    } 
    public String getYearMonthDay() {
		Date localDate = new Date();
		SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat(
				"yyyyMMdd");
		return localSimpleDateFormat.format(localDate);
	}
}
