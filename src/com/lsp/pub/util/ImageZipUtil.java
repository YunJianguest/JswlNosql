package com.lsp.pub.util;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
/**
 * 工具
 * @author lsp 
 *   
 */
public class ImageZipUtil
{
  private int _$3;
  private int _$2;
  private String _$1 = null;

  public void setT(String paramString)
  {
    this._$1 = paramString;
  }

  public void setWideth(int paramInt)
  {
    this._$3 = paramInt;
  }

  public int getWideth()
  {
    return this._$3;
  }

  public void setHeight(int paramInt)
  {
    this._$2 = paramInt;
  }

  public String imageZipProce(String paramString, int paramInt1, int paramInt2, float paramFloat)
  {
    if (paramString == null)
      return null;
    String str1 = null;
    try
    {
      File localFile = new File(paramString);
      if (!localFile.exists())
        return null;
      BufferedImage localBufferedImage1 = ImageIO.read(localFile);
      int i = 0;
      int j = 0;
      int k = localBufferedImage1.getHeight(null);
      int m = localBufferedImage1.getWidth(null);
      if ((m > paramInt1) || (k > paramInt2))
      {
        double d = 0.0D;
        if (m >= k)
          d = m / paramInt1;
        else if (k > m)
          d = k / paramInt2;
        i = (int)(m / d);
        j = (int)(k / d);
        BufferedImage localBufferedImage2 = new BufferedImage(i, j, 1);
        localBufferedImage2.getGraphics().drawImage(localBufferedImage1, 0, 0, i, j, null);
        String str2 = paramString.substring(0, paramString.indexOf('.'));
        str1 = str2 + paramString.substring(str2.length());
        FileOutputStream localFileOutputStream = new FileOutputStream(str1);
        JPEGImageEncoder localJPEGImageEncoder = JPEGCodec.createJPEGEncoder(localFileOutputStream);
        JPEGEncodeParam localJPEGEncodeParam = JPEGCodec.getDefaultJPEGEncodeParam(localBufferedImage2);
        localJPEGEncodeParam.setQuality(paramFloat, true);
        localJPEGImageEncoder.encode(localBufferedImage2, localJPEGEncodeParam);
        localFileOutputStream.close();
        localBufferedImage1.flush();
      }
    }
    catch (FileNotFoundException localFileNotFoundException)
    {
      localFileNotFoundException.printStackTrace();
    }
    catch (IOException localIOException)
    {
      localIOException.printStackTrace();
    }
    return str1;
  }
}

/* Location:           D:\tool\RBT\WEB-INF\classes\
 * Qualified Name:     com.rbt.common.util.ImageZipUtil
 * JD-Core Version:    0.6.1
 */