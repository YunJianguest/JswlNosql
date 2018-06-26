package com.lsp.pub.db;

import com.lsp.pub.entity.SequenceBean;
import org.springframework.stereotype.Component;
/**
 * 生成连续的表主键
 * @author lsp
 *
 */
@Component
public class MongoSequence
{
  private static String Table = "sequence";

  public Long currval(String name)
  {
    MongoDbUtil db = new MongoDbUtil();
    Long seqId = null;
    SequenceBean object = (SequenceBean)db.findOneById(Table, name, SequenceBean.class);
    if (object == null) {
      seqId = Long.valueOf(1L);
      object = new SequenceBean();
      object.set_id(name);
    } else {
      seqId = object.getSeqid();
    }
    object.setSeqid(Long.valueOf(seqId.longValue() + 1L));
    db.insertUpdate(Table, object);

    return seqId;
  }
}