package com.lsp.pub.db;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
/**
 * 资源管理
 * @author lsp 
 *   
 */
@Component
public class Sequence
{
  private Log log = LogFactory.getLog(Sequence.class);
  private JdbcTemplate jdbcTemplate;

  @Autowired
  public void setJdbcTemplate(JdbcTemplate jdbcTemplate)
  {
    this.jdbcTemplate = jdbcTemplate;
  }

  public Long currval(String seqName) {
    Long seqId = null;
    String sqlCurrval = "SELECT currval('" + seqName + "')";
    seqId = Long.valueOf(this.jdbcTemplate.queryForLong(sqlCurrval));
    this.log.debug("get an sequence id=" + seqId.longValue());
    return seqId;
  }

  public Long nextval(String seqName)
  {
    Long seqId = null;
    String sqlNextval = "SELECT nextval('" + seqName + "')";
    seqId = Long.valueOf(this.jdbcTemplate.queryForLong(sqlNextval));
    this.log.debug("get an sequence id=" + seqId.longValue());
    return seqId;
  }
}