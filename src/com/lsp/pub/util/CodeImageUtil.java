package com.lsp.pub.util;
 

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.font.FontRenderContext;
import java.awt.geom.AffineTransform;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;
import org.jbarcode.JBarcode;
import org.jbarcode.encode.Code39Encoder;
import org.jbarcode.encode.EAN13Encoder;
import org.jbarcode.paint.BaseLineTextPainter;
import org.jbarcode.paint.EAN13TextPainter;
import org.jbarcode.paint.WideRatioCodedPainter;
import org.jbarcode.paint.WidthCodedPainter;
import org.jbarcode.util.ImageUtil;

import sun.misc.BASE64Decoder;

 
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.mongodb.DBObject;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
/**
 * 工具
 * @author lsp 
 *   
 */
public class CodeImageUtil {
	private static final int BLACK = 0xFF000000;
	   private static final int WHITE = 0xFFFFFFFF;
	/**
	 * 二维码生成
	 * @param content  要生成地址
	 * @param path 存放路径
	 * @param type 图片类型  png  gif
	 * @param width 
	 * @param height 
	 */
	   public  static void QRcodeToImage(String content,String path,String type,int width,int height){
		   try {
			   File file1 = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+ path+"."+type);
			    
			     MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
			     
			     Map hints = new HashMap();
			     hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			     hints.put(EncodeHintType.MARGIN, 1);
			     BitMatrix bitMatrix = multiFormatWriter.encode(content, BarcodeFormat.QR_CODE, width, height,hints);
			    
			     CodeImageUtil.writeToFile(bitMatrix, type, file1);
			     
			 } catch (Exception e) {
			     e.printStackTrace();
			 }
		}
	
	/**
	 * Code-39 Ascall 编码
	 * @param str
	 * @param path
	 * @param width
	 * @param height
	 */
	public  static void code39Encoder(String str,String path,int width,int height){
		try  
	    {  
	      JBarcode localJBarcode = new JBarcode(Code39Encoder.getInstance(), WidthCodedPainter.getInstance(), BaseLineTextPainter.getInstance());  

	      localJBarcode.setEncoder(Code39Encoder.getInstance());  
	      localJBarcode.setPainter(WideRatioCodedPainter.getInstance());  
	      localJBarcode.setTextPainter(BaseLineTextPainter.getInstance());  
	      localJBarcode.setShowCheckDigit(false);  
	      localJBarcode.setCheckDigit(false);
	      BufferedImage localBufferedImage = localJBarcode.createBarcode(str);
	     
	      saveToPNG(localBufferedImage, path,width,height);  
	  
	    }  
	    catch (Exception localException)  
	    {  
	      localException.printStackTrace();  
	    }  
	}
	
	
	  
	  static void saveToJPEG(BufferedImage paramBufferedImage, String paramString,int width,int height)  
	  {  
	    saveToFile(paramBufferedImage, paramString, "jpeg",width,height);  
	  }  
	  
	  static void saveToPNG(BufferedImage paramBufferedImage, String paramString,int width,int height)  
	  {  
	    saveToFile(paramBufferedImage, paramString, "png",width,height);  
	  }  
	  
	  static void saveToGIF(BufferedImage paramBufferedImage, String paramString,int width,int height)  
	  {  
	    saveToFile(paramBufferedImage, paramString, "gif",width,height);  
	  }  
	  
	  static void saveToFile(BufferedImage paramBufferedImage, String paramString1, String paramString2,int width,int height)  
	  {  
	    try  
	    {  
	      FileOutputStream localFileOutputStream = new FileOutputStream(SysConfig.getProperty("filePath")+"/uploads/txm/"+paramString1+".png");  
	      ImageUtil.encodeAndWrite(paramBufferedImage, paramString2, localFileOutputStream, width, height);  
	      localFileOutputStream.close();  
	    }  
	    catch (Exception localException)  
	    {  
	      localException.printStackTrace();  
	    }  
	  }  
	  public static void writeToFile(BitMatrix matrix, String format, File file)
		       throws IOException {
		     BufferedImage image = toBufferedImage(matrix);
		     if (!ImageIO.write(image, format, file)) {
		       throw new IOException("Could not write an image of format " + format + " to " + file);
		     }
		   }
		 
		   
		   public static void writeToStream(BitMatrix matrix, String format, OutputStream stream)
		       throws IOException {
		     BufferedImage image = toBufferedImage(matrix);
		     if (!ImageIO.write(image, format, stream)) {
		       throw new IOException("Could not write an image of format " + format);
		     }
		   }
		   public static BufferedImage toBufferedImage(BitMatrix matrix) {
			     int width = matrix.getWidth();
			     int height = matrix.getHeight();
			     BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			     for (int x = 0; x < width; x++) {
			       for (int y = 0; y < height; y++) {
			         image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE);
			       }
			     }
			     return image;
			   }
		   public static void createImage(String str,Font font,File outFile,int width,int height) throws Exception{

			 //获取font的样式应用在str上的整个矩形

			   Rectangle2D r=font.getStringBounds(str, new FontRenderContext(AffineTransform.getScaleInstance(1, 1),false,false));

			   int unitHeight=(int)Math.floor(r.getHeight());//获取单个字符的高度

			 //获取整个str用了font样式的宽度这里用四舍五入后+1保证宽度绝对能容纳这个字符串作为图片的宽度

			   

			 //创建图片

			   BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_BGR);

			   Graphics g=image.getGraphics();

			   g.setColor(Color.WHITE);

			   g.fillRect(0, 0, width, height);//先用白色填充整张图片,也就是背景

			   g.setColor(Color.black);//在换成黑色

			   g.setFont(font);//设置画笔字体

			   g.drawString(str, 10, font.getSize()-8);//画出字符串

			   g.dispose();

			   ImageIO.write(image, "png", outFile);//输出png图片

			 }
		    public static void xPic(Long comid,String fromUser,String no,String province,String city,String tp){//横向处理图片  
		    	try
		        {
		    
		    	
		    	String dbimg=SysConfig.getProperty("filePath")+"/cmp/img/mb.jpg";
		    	
		          //读取第一张图片
		          File fileOne = new File(dbimg);
		          BufferedImage ImageOne = ImageIO.read(fileOne);
		          int width = ImageOne.getWidth();//图片宽度
		          int height = ImageOne.getHeight();//图片高度
		          //从图片中读取RGB
		          int[] ImageArrayOne = new int[width*height];
		          ImageArrayOne = ImageOne.getRGB(0,0,width,height,ImageArrayOne,0,width);
		        //生成新图片
		          BufferedImage ImageNew = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		          ImageNew.setRGB(0,0,width,height,ImageArrayOne,0,width);
		        //企业底板
		          File fileCom = new File(SysConfig.getProperty("filePath")+"/cmp/img/com_"+comid+".png");
		          if(!fileCom.exists()){
		        	  fileCom = new File(SysConfig.getProperty("filePath")+"/cmp/img/com_138.png");
		          }
		          BufferedImage ImageCom = ImageIO.read(fileCom);
		          int widthCom = ImageCom.getWidth();//图片宽度
		          int heightCom  = ImageCom.getHeight();//图片高度
		          int[] ImageArrayCom = new int[widthCom*heightCom];
		          ImageArrayCom = ImageCom.getRGB(0,0,widthCom,heightCom,ImageArrayCom,0,widthCom);
		          ImageNew.setRGB(0,0,widthCom,heightCom,ImageArrayCom,0,widthCom);//设置左半部分的RGB
		          
		          //广告底板
		          File fileGg = new File(SysConfig.getProperty("filePath")+"/cmp/img/"+province+"-"+city+".jpg");
		          if(!fileGg.exists()){
		        	  fileGg = new File(SysConfig.getProperty("filePath")+"/cmp/img/cmp_gg.jpg");
		          }
		        
		          BufferedImage ImageGg = ImageIO.read(fileGg);
		          int widthGg = ImageGg.getWidth();//图片宽度
		          int heightGg  = ImageGg.getHeight();//图片高度
		          int[] ImageArrayGg = new int[widthGg*heightGg];
		          ImageArrayGg = ImageGg.getRGB(0,0,widthGg,heightGg,ImageArrayGg,0,widthGg);
		          ImageNew.setRGB(0,2375,widthGg,heightGg,ImageArrayGg,0,widthGg);//设置左半部分的RGB
		          
		          //00880
		          File file3 = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+fromUser+"-no"+".png");
		          BufferedImage Image3 = ImageIO.read(file3);
		          int width3 = Image3.getWidth();
		          int height3 = Image3.getHeight();
		          int[] ImageArray3 = new int[width3*height3];
		          ImageArray3 = Image3.getRGB(0,0,width3,height3,ImageArray3,0,width3);
		          ImageNew.setRGB(615,2155,width3,height3,ImageArray3,0,width3);
		          

		          //第一张二维码
		          File fileTwo = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+fromUser+"-"+comid+"-ewm"+".png");
		          BufferedImage ImageTwo = ImageIO.read(fileTwo);
		          int widthTwo = ImageTwo.getWidth();
		          int heightTwo = ImageTwo.getHeight();
		          int[] ImageArrayTwo = new int[widthTwo*heightTwo];
		          ImageArrayTwo = ImageTwo.getRGB(0,0,widthTwo,heightTwo,ImageArrayTwo,0,widthTwo);
		          ImageNew.setRGB(108,269,widthTwo,heightTwo,ImageArrayTwo,0,widthTwo);
		          
		          //第二张二维码
		          File fileCmp = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+fromUser+"-138-ewm"+".png");
		          BufferedImage ImageCmp = ImageIO.read(fileCmp);
		          int widthCmp = ImageCmp.getWidth();
		          int heightCmp = ImageCmp.getHeight();
		          int[] ImageArrayCmp = new int[widthCmp*heightCmp];
		          ImageArrayCmp = ImageCmp.getRGB(0,0,widthTwo,heightCmp,ImageArrayCmp,0,widthCmp);
		          ImageNew.setRGB(123,1432,widthCmp,heightCmp,ImageArrayCmp,0,widthCmp);
		          
		          int[] x1={0,940,1186,1432,1678,1924,2171};
		          String[] nos=no.split("");
		          for(int i=1;i<nos.length;i++){
		        	  File filesz1 = new File(SysConfig.getProperty("filePath")+"/cmp/img/dz"+nos[i]+".gif");
			          BufferedImage Imagesz1 = ImageIO.read(filesz1);
			          int widthsz1 = Imagesz1.getWidth();
			          int heightsz1 = Imagesz1.getHeight();
			          int[] ImageArraysz1 = new int[widthsz1*heightsz1];
			          ImageArraysz1 = Imagesz1.getRGB(0,0,widthsz1,heightsz1,ImageArraysz1,0,widthsz1);
			          ImageNew.setRGB(x1[i],680,widthsz1,heightsz1,ImageArraysz1,0,widthsz1);
			       
		          }
		          
		          File outFile = new File(SysConfig.getProperty("filePath")+tp);
		          ImageIO.write(ImageNew, "jpg", outFile);//写图片

		        }
		        catch(Exception e)
		        {
		          e.printStackTrace();
		        }
		    } 
		    /**
		     * 个性打印发送
		     * @param comid
		     * @param fromUser
		     * @param no
		     * @param user
		     */
		    public static void xPic(Long comid,String mblj,String zt,String fromUser,String no,String province,String city,String tp){//横向处理图片  
		    	try
		        {
		    
		    	
		    	String dbimg=SysConfig.getProperty("filePath")+"/cmp/img/mb.jpg";
		    	
		          //读取第一张图片
		          File fileOne = new File(dbimg);
		          BufferedImage ImageOne = ImageIO.read(fileOne);
		          int width = ImageOne.getWidth();//图片宽度
		          int height = ImageOne.getHeight();//图片高度
		          //从图片中读取RGB
		          int[] ImageArrayOne = new int[width*height];
		          ImageArrayOne = ImageOne.getRGB(0,0,width,height,ImageArrayOne,0,width);
		        //生成新图片
		          BufferedImage ImageNew = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		          ImageNew.setRGB(0,0,width,height,ImageArrayOne,0,width);
		        //企业底板
		          File fileCom = new File(SysConfig.getProperty("filePath")+mblj);
		          
		          BufferedImage ImageCom = ImageIO.read(fileCom);
		          int widthCom = ImageCom.getWidth();//图片宽度
		          int heightCom  = ImageCom.getHeight();//图片高度
		          int[] ImageArrayCom = new int[widthCom*heightCom];
		          ImageArrayCom = ImageCom.getRGB(0,0,widthCom,heightCom,ImageArrayCom,0,widthCom);
		          ImageNew.setRGB(0,0,widthCom,heightCom,ImageArrayCom,0,widthCom);//设置左半部分的RGB
		          
		          //广告底板
		          File fileGg = new File(SysConfig.getProperty("filePath")+"/cmp/img/"+province+"-"+city+".jpg");
		          if(!fileGg.exists()){
		        	  fileGg = new File(SysConfig.getProperty("filePath")+"/cmp/img/cmp_gg.jpg");
		          }
		        
		          BufferedImage ImageGg = ImageIO.read(fileGg);
		          int widthGg = ImageGg.getWidth();//图片宽度
		          int heightGg  = ImageGg.getHeight();//图片高度
		          int[] ImageArrayGg = new int[widthGg*heightGg];
		          ImageArrayGg = ImageGg.getRGB(0,0,widthGg,heightGg,ImageArrayGg,0,widthGg);
		          ImageNew.setRGB(0,2375,widthGg,heightGg,ImageArrayGg,0,widthGg);//设置左半部分的RGB
		          
		          //00880
		          File file3 = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+fromUser+"-no"+".png");
		          BufferedImage Image3 = ImageIO.read(file3);
		          int width3 = Image3.getWidth();
		          int height3 = Image3.getHeight();
		          int[] ImageArray3 = new int[width3*height3];
		          ImageArray3 = Image3.getRGB(0,0,width3,height3,ImageArray3,0,width3);
		          ImageNew.setRGB(615,2155,width3,height3,ImageArray3,0,width3);
		          

		          //第一张二维码
		          File fileTwo = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+fromUser+"-"+comid+"-ewm"+".png");
		          BufferedImage ImageTwo = ImageIO.read(fileTwo);
		          int widthTwo = ImageTwo.getWidth();
		          int heightTwo = ImageTwo.getHeight();
		          int[] ImageArrayTwo = new int[widthTwo*heightTwo];
		          ImageArrayTwo = ImageTwo.getRGB(0,0,widthTwo,heightTwo,ImageArrayTwo,0,widthTwo);
		          ImageNew.setRGB(108,269,widthTwo,heightTwo,ImageArrayTwo,0,widthTwo);
		          
		          //第二张二维码
		          File fileCmp = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/"+fromUser+"-138-ewm"+".png");
		          BufferedImage ImageCmp = ImageIO.read(fileCmp);
		          int widthCmp = ImageCmp.getWidth();
		          int heightCmp = ImageCmp.getHeight();
		          int[] ImageArrayCmp = new int[widthCmp*heightCmp];
		          ImageArrayCmp = ImageCmp.getRGB(0,0,widthTwo,heightCmp,ImageArrayCmp,0,widthCmp);
		          ImageNew.setRGB(123,1432,widthCmp,heightCmp,ImageArrayCmp,0,widthCmp);
		          
		          int[] x1={0,940,1186,1432,1678,1924,2171};
		          String[] nos=no.split("");
		          for(int i=1;i<nos.length;i++){
		        	  File filesz1 = new File(SysConfig.getProperty("filePath")+"/cmp/img/"+zt+nos[i]+".gif");
			          BufferedImage Imagesz1 = ImageIO.read(filesz1);
			          int widthsz1 = Imagesz1.getWidth();
			          int heightsz1 = Imagesz1.getHeight();
			          int[] ImageArraysz1 = new int[widthsz1*heightsz1];
			          ImageArraysz1 = Imagesz1.getRGB(0,0,widthsz1,heightsz1,ImageArraysz1,0,widthsz1);
			          ImageNew.setRGB(x1[i],680,widthsz1,heightsz1,ImageArraysz1,0,widthsz1);
			       
		          }
		          
		          File outFile = new File(SysConfig.getProperty("filePath")+tp);
		          ImageIO.write(ImageNew, "jpg", outFile);//写图片

		        }
		        catch(Exception e)
		        {
		          e.printStackTrace();
		        }
		    } 
		    public static void nuochePic(Long comid,int css,String logo){//横向处理图片  
		    	if(StringUtils.isEmpty(logo)){
		    		return;
		    	}
		    	if(css==0){
		    		return;
		    	}
		    	try
		        {
		    	String dbimg=SysConfig.getProperty("filePath")+"/cmp/img/ty_"+css+".png";
		    	
		          //读取第一张图片
		          File fileOne = new File(dbimg);
		          BufferedImage ImageOne = ImageIO.read(fileOne);
		          int width = ImageOne.getWidth();//图片宽度
		          int height = ImageOne.getHeight();//图片高度
		          //从图片中读取RGB
		          int[] ImageArrayOne = new int[width*height];
		          ImageArrayOne = ImageOne.getRGB(0,0,width,height,ImageArrayOne,0,width);
		        //生成新图片
		          BufferedImage ImageNew = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		          ImageNew.setRGB(0,0,width,height,ImageArrayOne,0,width);
		        
		          
		          //广告底板
		          File fileGg = new File(SysConfig.getProperty("filePath")+"/uploads/company/"+logo);
		          
		        
		          BufferedImage ImageGg = ImageIO.read(fileGg);
		          int widthGg = ImageGg.getWidth();//图片宽度
		          int heightGg  = ImageGg.getHeight();//图片高度
		          int[] ImageArrayGg = new int[widthGg*heightGg];
		          ImageArrayGg = ImageGg.getRGB(0,0,widthGg,heightGg,ImageArrayGg,0,widthGg);
		          ImageNew.setRGB(2165,260,250,250,ImageArrayGg,0,widthGg);//设置左半部分的RGB
		          
		         
		          
		          File outFile = new File(SysConfig.getProperty("filePath")+"/cmp/img/com_"+comid+".png");
		          ImageIO.write(ImageNew, "png", outFile);//写图片

		        }
		        catch(Exception e)
		        {
		          e.printStackTrace();
		        }
		    }
		    /**
		     * 生成商家制造ai
		     * @param comid
		     * @param fromUser
		     * @param no
		     * @param user
		     */
		    public static void aiPic(Long comid){//横向处理图片  
		    	try
		        {
		    
		    	
		    	String dbimg=SysConfig.getProperty("filePath")+"/cmp/img/cmp-aidb.jpg";
		    	
		          //读取第一张图片
		          File fileOne = new File(dbimg);
		          BufferedImage ImageOne = ImageIO.read(fileOne);
		          int width = ImageOne.getWidth();//图片宽度
		          int height = ImageOne.getHeight();//图片高度
		          //从图片中读取RGB
		          int[] ImageArrayOne = new int[width*height];
		          ImageArrayOne = ImageOne.getRGB(0,0,width,height,ImageArrayOne,0,width);
		        //生成新图片
		          BufferedImage ImageNew = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		          ImageNew.setRGB(0,0,width,height,ImageArrayOne,0,width);
		        //企业底板
		          File fileCom = new File(SysConfig.getProperty("filePath")+"/cmp/img/com_"+comid+".png");
		          if(!fileCom.exists()){
		        	  fileCom = new File(SysConfig.getProperty("filePath")+"/cmp/img/com_138.png");
		          }
		          BufferedImage ImageCom = ImageIO.read(fileCom);
		          int widthCom = ImageCom.getWidth();//图片宽度
		          int heightCom  = ImageCom.getHeight();//图片高度
		          int[] ImageArrayCom = new int[widthCom*heightCom];
		          ImageArrayCom = ImageCom.getRGB(0,0,widthCom,heightCom,ImageArrayCom,0,widthCom);
		          ImageNew.setRGB(0,0,widthCom,heightCom,ImageArrayCom,0,widthCom);//设置左半部分的RGB

		          //第一张二维码
		          File fileTwo = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/cmpnuoche700-"+comid+".jpg");
		          BufferedImage ImageTwo = ImageIO.read(fileTwo);
		          int widthTwo = ImageTwo.getWidth();
		          int heightTwo = ImageTwo.getHeight();
		          int[] ImageArrayTwo = new int[widthTwo*heightTwo];
		          ImageArrayTwo = ImageTwo.getRGB(0,0,widthTwo,heightTwo,ImageArrayTwo,0,widthTwo);
		          ImageNew.setRGB(108,269,widthTwo,heightTwo,ImageArrayTwo,0,widthTwo);
//		          
		          File filesz1 = new File(SysConfig.getProperty("filePath")+"/cmp/img/cmp-aino.jpg");
		          BufferedImage Imagesz1 = ImageIO.read(filesz1);
		          int widthsz1 = Imagesz1.getWidth();
		          int heightsz1 = Imagesz1.getHeight();
		          int[] ImageArraysz1 = new int[widthsz1*heightsz1];
		          ImageArraysz1 = Imagesz1.getRGB(0,0,widthsz1,heightsz1,ImageArraysz1,0,widthsz1);
		          ImageNew.setRGB(940,680,widthsz1,heightsz1,ImageArraysz1,0,widthsz1);
		          
		          File outFile = new File(SysConfig.getProperty("filePath")+"/uploads/ewm/aiprint-"+comid+".jpg");
		          ImageIO.write(ImageNew, "jpg", outFile);//写图片

		        }
		        catch(Exception e)
		        {
		          e.printStackTrace();
		        }
		    } 
		    public static File base64StringToImage(String base64String,String path){   
		    	File w2 = new File(SysConfig.getProperty("filePath")+path);//可以是jpg,png,gif格式    
		        try {    
		        	
		        	String start = "base64,";
		        	int contentStartIndex = base64String.indexOf(start) + start.length();
		        	BASE64Decoder decoder = new sun.misc.BASE64Decoder();  
		        	
		        	byte[] bytes1 = decoder.decodeBuffer(base64String.substring(contentStartIndex));                  
		            ByteArrayInputStream bais = new ByteArrayInputStream(bytes1);    
		            BufferedImage bi1 =ImageIO.read(bais);    

		            
		            ImageIO.write(bi1, "jpg", w2);//不管输出什么格式图片，此处不需改动    
		        } catch (IOException e) {    
		            e.printStackTrace();    
		        }   
		        return w2;
		    }  
		    /**
		      * 图片压缩
		      * @param iuputname  图片地址
		      * @param outputname  压缩后存储地址
		      * @param newWidth  宽带
		      * @param newHeight 高度
		      * @return
		      */
		     public static File compressPic(File file,String outputname,int newWidth,int newHeight) {   
		         try {   
		             //获得源文件   
		            
		             Image img = ImageIO.read(file);   
		             // 判断图片格式是否正确   
		             if (img.getWidth(null) == -1) {  
		                  
		                 return null;   
		             } else {   
		               
		                BufferedImage tag = new BufferedImage((int) newWidth, (int) newHeight, BufferedImage.TYPE_INT_RGB);   
		                  
		                /* 
		                 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 
		                 * 优先级比速度高 生成的图片质量比较好 但速度慢 
		                 */   
		                tag.getGraphics().drawImage(img.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH), 0, 0, null);  
		                FileOutputStream out = new FileOutputStream(outputname);  
		                // JPEGImageEncoder可适用于其他图片类型的转换   
		                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);   
		                encoder.encode(tag);   
		                out.close();   
		             }   
		         } catch (IOException ex) {   
		             ex.printStackTrace();   
		         }   
		         return file;   
		    }   
		 
}

