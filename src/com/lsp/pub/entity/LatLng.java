package com.lsp.pub.entity;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class LatLng {
	public LatLng(double lat,double lng){
		this.lat=lat;
		this.lng=lng;
	}
	/**
	 * 返回纬度值（以度为单位）
	 */

	private double lat;
	/**
	 * 返回经度值（以度为单位）
	 */
	private double lng;
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
}
