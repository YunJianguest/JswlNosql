package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Place extends ReflectionDBObject {
	/**
	 * 名字
	 */
	private String name;
	/**
	 * 地址
	 */
	private String address;

	/**
	 * id
	 */
	private String uid;
	/**
	 * 经纬度，经度在前，纬度在后
	 */
	private Double lat;
	private Double lng;

	private String telephone;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public Double getLat() {
		return lat;
	}

	public void setLat(Double lat) {
		this.lat = lat;
	}

	public Double getLng() {
		return lng;
	}

	public void setLng(Double lng) {
		this.lng = lng;
	}


	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String toString() {
		return "Place [name=" + name + ", address=" + address + ", uid=" + uid
				+ ", lat=" + lat + ", lng=" + lng + ", telephone=" + telephone
				+ "]";
	}
}
