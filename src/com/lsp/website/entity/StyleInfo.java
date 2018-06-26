package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 组件样式类
 * @author lsp
 *
 */
public class StyleInfo extends ReflectionDBObject{

	 private Integer  sort;
	 /**
	  * 模板
	  */
	 private String  mb;
	 /**
	  * 颜色
	  */
	 private String  color;
	 /**
	  * 大小
	  */
	 private String  width;
	 private String  height;
	 /**
	  * 位置
	  */
	 private String location;
	 /**
	  * 动画
	  */
	 private String animation;
	 /**
	  * 外边距
	  */
	 private String margin;
	 /**
	  * 左边距
	  */
	 private String marginleft;
	 /**
	  * 上边距
	  */
	 private String margintop;
	 /**
	  * 内边距
	  */
	 private String padding;
	 /**
	  * 背景颜色
	  * 
	  */
	 private String backgroundcolor;
	 private String radius; 
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getMb() {
		return mb;
	}
	public void setMb(String mb) {
		this.mb = mb;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getAnimation() {
		return animation;
	}
	public void setAnimation(String animation) {
		this.animation = animation;
	}
	public String getMargin() {
		return margin;
	}
	public void setMargin(String margin) {
		this.margin = margin;
	}
	public String getPadding() {
		return padding;
	}
	public void setPadding(String padding) {
		this.padding = padding;
	}
	public String getBackgroundcolor() {
		return backgroundcolor;
	}
	public void setBackgroundcolor(String backgroundcolor) {
		this.backgroundcolor = backgroundcolor;
	}
	public String getMarginleft() {
		return marginleft;
	}
	public void setMarginleft(String marginleft) {
		this.marginleft = marginleft;
	}
	public String getMargintop() {
		return margintop;
	}
	public void setMargintop(String margintop) {
		this.margintop = margintop;
	}
	public String getRadius() {
		return radius;
	}
	public void setRadius(String radius) {
		this.radius = radius;
	}
	
	 
}
