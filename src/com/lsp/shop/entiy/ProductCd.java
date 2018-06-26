package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 商品分类
 * @author lsp
 *
 */
public class ProductCd  extends ReflectionDBObject{
	/**
	 * 菜单名称
	 */
	private String cdname;
	/**
	 * 菜单链接
	 */
	private String cdurl;
	public String getCdname() {
		return cdname;
	}
	public void setCdname(String cdname) {
		this.cdname = cdname;
	}
	public String getCdurl() {
		return cdurl;
	}
	public void setCdurl(String cdurl) {
		this.cdurl = cdurl;
	}
	
}
