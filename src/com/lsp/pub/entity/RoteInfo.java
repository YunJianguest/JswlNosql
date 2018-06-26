package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 规则
 * @author lsp
 *
 */
public class RoteInfo extends ReflectionDBObject{
 
	private Double lon;
	private Double lat;
	
	public Double getLon() {
		return lon;
	}
	public void setLon(Double lon) {
		this.lon = lon;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}

 	
}

 
