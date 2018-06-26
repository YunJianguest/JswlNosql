package com.lsp.pub.entity;

/**
 * 资源管理
 * @author lsp 
 *   
 */
public class BaseSelect{
	/**
	 * 下拉选择value值
	 */
	private String key;
	/**
	 * 下拉选择显示值
	 */
	private String value;
	private String code;
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "BaseSelect [code=" + code + ", key=" + key + ", value=" + value
				+ "]";
	}
}
