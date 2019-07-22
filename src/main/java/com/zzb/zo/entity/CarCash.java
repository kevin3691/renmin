package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;


@Entity
public class CarCash extends BaseEntity<CarCash> {


	private int sqrId ;
	private String sqr;
	private int orgId;
	private String org;
	private String cardNo;
	private int carId;
	private float youfei;
	private String type;
	private float jiayouliang;
	private float xingshilicheng;
	private float guolufei;
	private String guolufeitype;
	private float tingchefei;
	private float qitafeiyong;
	private float total;

	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	public int getSqrId() {
		return sqrId;
	}

	public void setSqrId(int sqrId) {
		this.sqrId = sqrId;
	}

	public String getSqr() {
		return sqr;
	}

	public void setSqr(String sqr) {
		this.sqr = sqr;
	}

	public int getOrgId() {
		return orgId;
	}

	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public int getCarId() {
		return carId;
	}

	public void setCarId(int carId) {
		this.carId = carId;
	}

	public float getYoufei() {
		return youfei;
	}

	public void setYoufei(float youfei) {
		this.youfei = youfei;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public float getJiayouliang() {
		return jiayouliang;
	}

	public void setJiayouliang(float jiayouliang) {
		this.jiayouliang = jiayouliang;
	}

	public float getXingshilicheng() {
		return xingshilicheng;
	}

	public void setXingshilicheng(float xingshilicheng) {
		this.xingshilicheng = xingshilicheng;
	}

	public float getGuolufei() {
		return guolufei;
	}

	public void setGuolufei(float guolufei) {
		this.guolufei = guolufei;
	}

	public String getGuolufeitype() {
		return guolufeitype;
	}

	public void setGuolufeitype(String guolufeitype) {
		this.guolufeitype = guolufeitype;
	}

	public float getTingchefei() {
		return tingchefei;
	}

	public void setTingchefei(float tingchefei) {
		this.tingchefei = tingchefei;
	}

	public float getQitafeiyong() {
		return qitafeiyong;
	}

	public void setQitafeiyong(float qitafeiyong) {
		this.qitafeiyong = qitafeiyong;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}
}
