package com.lsp.pub.upload;

import java.util.HashMap;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class ResumableInfoStorage
{
  private static ResumableInfoStorage sInstance;
  private HashMap<String, ResumableInfo> mMap = new HashMap<String, ResumableInfo>();

  public static synchronized ResumableInfoStorage getInstance()
  {
    if (sInstance == null) {
      sInstance = new ResumableInfoStorage();
    }
    return sInstance;
  }

  public synchronized ResumableInfo get(int resumableChunkSize, long resumableTotalSize, String resumableIdentifier, String resumableFilename, String resumableRelativePath, String resumableFilePath)
  {
    ResumableInfo info = (ResumableInfo)this.mMap.get(resumableIdentifier);

    if (info == null) {
      info = new ResumableInfo();

      info.resumableChunkSize = resumableChunkSize;
      info.resumableTotalSize = resumableTotalSize;
      info.resumableIdentifier = resumableIdentifier;
      info.resumableFilename = resumableFilename;
      info.resumableRelativePath = resumableRelativePath;
      info.resumableFilePath = resumableFilePath;

      this.mMap.put(resumableIdentifier, info);
    }
    return info;
  }

  public void remove(ResumableInfo info)
  {
    this.mMap.remove(info.resumableIdentifier);
  }
}