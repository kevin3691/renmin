package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class CarInfo extends BaseEntity<CarInfo> {


	private int sqrId ;
	private String sqr;

	private String cardNo;
	private int carId;
	private float baoyangfeiyong;
	private float qitafeiyong;
	private Date starttime;
	private Date finishtime;
	private String baoyangchangjia;
	private String type;
	private String changjiadizhi;
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

	public float getBaoyangfeiyong() {
		return baoyangfeiyong;
	}

	public void setBaoyangfeiyong(float baoyangfeiyong) {
		this.baoyangfeiyong = baoyangfeiyong;
	}

	public float getQitafeiyong() {
		return qitafeiyong;
	}

	public void setQitafeiyong(float qitafeiyong) {
		this.qitafeiyong = qitafeiyong;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getFinishtime() {
		return finishtime;
	}

	public void setFinishtime(Date finishtime) {
		this.finishtime = finishtime;
	}

	public String getBaoyangchangjia() {
		return baoyangchangjia;
	}

	public void setBaoyangchangjia(String baoyangchangjia) {
		this.baoyangchangjia = baoyangchangjia;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getChangjiadizhi() {
		return changjiadizhi;
	}

	public void setChangjiadizhi(String changjiadizhi) {
		this.changjiadizhi = changjiadizhi;
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
