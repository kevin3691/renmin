package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class CarUse extends BaseEntity<CarUse> {


	private int sqrId ;
	private String sqr;
	private int orgId;
	private String org;
	private String cardNo;
	private int carId;
	private Date chucheriqi;
	private Date huancheriqi;
	private int chengcherenshu;
	private String reason;

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

	public Date getChucheriqi() {
		return chucheriqi;
	}

	public void setChucheriqi(Date chucheriqi) {
		this.chucheriqi = chucheriqi;
	}

	public Date getHuancheriqi() {
		return huancheriqi;
	}

	public void setHuancheriqi(Date huancheriqi) {
		this.huancheriqi = huancheriqi;
	}

	public int getChengcherenshu() {
		return chengcherenshu;
	}

	public void setChengcherenshu(int chengcherenshu) {
		this.chengcherenshu = chengcherenshu;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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
