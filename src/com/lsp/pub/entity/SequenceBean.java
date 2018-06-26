package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class SequenceBean extends ReflectionDBObject
{
  private Long seqid;

  public Long getSeqid()
  {
    return this.seqid;
  }

  public void setSeqid(Long seqid) {
    this.seqid = seqid;
  }
}