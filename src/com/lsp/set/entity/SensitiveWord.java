package com.lsp.set.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 敏感词管理
 * @author lsp
 *
 */
public class SensitiveWord extends ReflectionDBObject{

	private String word;
	private String title;
	private String sort;

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	} 
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
}
