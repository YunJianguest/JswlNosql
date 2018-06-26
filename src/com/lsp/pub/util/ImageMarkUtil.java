package com.lsp.pub.util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
/**
 * 工具
 * @author lsp 
 *   
 */
public class ImageMarkUtil
{
  public void markImageByIcon(String paramString1, String paramString2, String paramString3, Integer paramInteger1, float paramFloat, Integer paramInteger2, Integer paramInteger3)
  {
    FileOutputStream localFileOutputStream = null;
    try
    {
      BufferedImage localBufferedImage1 = ImageIO.read(new File(paramString2));
      BufferedImage localBufferedImage2 = new BufferedImage(localBufferedImage1.getWidth(null), localBufferedImage1.getHeight(null), 1);
      Graphics2D localGraphics2D = localBufferedImage2.createGraphics();
      localGraphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
      localGraphics2D.drawImage(localBufferedImage1.getScaledInstance(localBufferedImage1.getWidth(null), localBufferedImage1.getHeight(null), 4), 0, 0, null);
      if (null != paramInteger1)
        localGraphics2D.rotate(Math.toRadians(paramInteger1.intValue()), localBufferedImage2.getWidth() / 2.0D, localBufferedImage2.getHeight() / 2.0D);
      String str = PropertiesUtil.getRootpath();
      ImageIcon localImageIcon1 = new ImageIcon(str + paramString1);
      Image localImage1 = localImageIcon1.getImage();
      float f = paramFloat;
      localGraphics2D.setComposite(AlphaComposite.getInstance(10, f));
      ImageIcon localImageIcon2 = new ImageIcon(paramString2);
      Image localImage2 = localImageIcon2.getImage();
      int i = localImage2.getWidth(null);
      int j = localImage2.getHeight(null);
      localGraphics2D.drawImage(localImage1, (int)(i * (paramInteger2.intValue() / 100.0F)), (int)(j * paramInteger3.intValue() / 100.0F), null);
      localGraphics2D.setComposite(AlphaComposite.getInstance(3));
      localGraphics2D.dispose();
      localFileOutputStream = new FileOutputStream(paramString3);
      ImageIO.write(localBufferedImage2, "JPG", localFileOutputStream);
    }
    catch (Exception localException2)
    {
      localException2.printStackTrace();
    }
    finally
    {
      try
      {
        if (null != localFileOutputStream)
          localFileOutputStream.close();
      }
      catch (Exception localException4)
      {
        localException4.printStackTrace();
      }
    }
  }

  public void markByText(String paramString1, String paramString2, String paramString3, Integer paramInteger1, float paramFloat, Integer paramInteger2, Integer paramInteger3, Integer paramInteger4)
  {
	  //FileOutputStream localObject1 = null;
    FileOutputStream localFileOutputStream = null;
    try
    {
      BufferedImage localBufferedImage1 = ImageIO.read(new File(paramString2));
      BufferedImage localBufferedImage2 = new BufferedImage(localBufferedImage1.getWidth(null), localBufferedImage1.getHeight(null), 1);
      Graphics2D localGraphics2D = localBufferedImage2.createGraphics();
      localGraphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
      localGraphics2D.drawImage(localBufferedImage1.getScaledInstance(localBufferedImage1.getWidth(null), localBufferedImage1.getHeight(null), 4), 0, 0, null);
      if (null != paramInteger1)
        localGraphics2D.rotate(Math.toRadians(paramInteger1.intValue()), localBufferedImage2.getWidth() / 2.0D, localBufferedImage2.getHeight() / 2.0D);
      localGraphics2D.setColor(Color.black);
      localGraphics2D.setFont(new Font("宋体", 1, paramInteger4.intValue()));
      float f = paramFloat;
      localGraphics2D.setComposite(AlphaComposite.getInstance(10, f));
      ImageIcon localImageIcon = new ImageIcon(paramString2);
      Image localImage = localImageIcon.getImage();
      int i = localImage.getWidth(null);
      int j = localImage.getHeight(null);
      localGraphics2D.drawString(paramString1, i * (paramInteger2.intValue() / 100.0F), j * paramInteger3.intValue() / 100.0F);
      localGraphics2D.dispose();
      localFileOutputStream = new FileOutputStream(paramString3);
      ImageIO.write(localBufferedImage2, "JPG", localFileOutputStream);
    }
    catch (Exception localException3)
    {
      localException3.printStackTrace();
    }
    finally
    {
      try
      {
        if (null != localFileOutputStream)
          //localObject1.close();
        localFileOutputStream.close();
      }
      catch (Exception localException6)
      {
        localException6.printStackTrace();
      }
      try
      {
        if (null != localFileOutputStream)
          localFileOutputStream.close();
      }
      catch (Exception localException7)
      {
        localException7.printStackTrace();
      }
    }
  }
  public void markByText(String type,String paramString1, String paramString2, String paramString3, Integer paramInteger1, float paramFloat, Integer paramInteger2, Integer paramInteger3, Integer paramInteger4)
  {
	  //FileOutputStream localObject1 = null;
    FileOutputStream localFileOutputStream = null;
    try
    {
      BufferedImage localBufferedImage1 = ImageIO.read(new File(paramString2));
      BufferedImage localBufferedImage2 = new BufferedImage(localBufferedImage1.getWidth(null), localBufferedImage1.getHeight(null), 1);
      Graphics2D localGraphics2D = localBufferedImage2.createGraphics();
      localGraphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
      localGraphics2D.drawImage(localBufferedImage1.getScaledInstance(localBufferedImage1.getWidth(null), localBufferedImage1.getHeight(null), 4), 0, 0, null);
      if (null != paramInteger1)
        localGraphics2D.rotate(Math.toRadians(paramInteger1.intValue()), localBufferedImage2.getWidth() / 2.0D, localBufferedImage2.getHeight() / 2.0D);
      localGraphics2D.setColor(Color.black);
      localGraphics2D.setFont(new Font("宋体", 1, paramInteger4.intValue()));
      float f = paramFloat;
      localGraphics2D.setComposite(AlphaComposite.getInstance(10, f));
      ImageIcon localImageIcon = new ImageIcon(paramString2);
      Image localImage = localImageIcon.getImage();
      int i = localImage.getWidth(null);
      int j = localImage.getHeight(null);
      localGraphics2D.drawString(paramString1, i * (paramInteger2.intValue() / 100.0F), j * paramInteger3.intValue() / 100.0F);
      localGraphics2D.dispose();
      localFileOutputStream = new FileOutputStream(paramString3);
      ImageIO.write(localBufferedImage2, type, localFileOutputStream);
    }
    catch (Exception localException3)
    {
      localException3.printStackTrace();
    }
    finally
    {
      try
      {
        if (null != localFileOutputStream)
          //localObject1.close();
        localFileOutputStream.close();
      }
      catch (Exception localException6)
      {
        localException6.printStackTrace();
      }
      try
      {
        if (null != localFileOutputStream)
          localFileOutputStream.close();
      }
      catch (Exception localException7)
      {
        localException7.printStackTrace();
      }
    }
  }
}

/* Location:           D:\tool\RBT\WEB-INF\classes\
 * Qualified Name:     com.rbt.common.util.ImageMarkUtil
 * JD-Core Version:    0.6.1
 */