package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class FinanceCash extends BaseEntity<FinanceCash> {


	private String sqr;
	private int sqrId;
	private Date sqrq;
	private String org;
	private int orgId;
	private String type;
	private String payment;
	private String reason;
	private float total;
	private int paper;
	private float minus;
	private float realpay;
	private String title;
	private int status;


	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	public String getSqr() {
		return sqr;
	}

	public void setSqr(String sqr) {
		this.sqr = sqr;
	}

	public int getSqrId() {
		return sqrId;
	}

	public void setSqrId(int sqrId) {
		this.sqrId = sqrId;
	}

	public Date getSqrq() {
		return sqrq;
	}

	public void setSqrq(Date sqrq) {
		this.sqrq = sqrq;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public int getOrgId() {
		return orgId;
	}

	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public int getPaper() {
		return paper;
	}

	public void setPaper(int paper) {
		this.paper = paper;
	}

	public float getMinus() {
		return minus;
	}

	public void setMinus(float minus) {
		this.minus = minus;
	}

	public float getRealpay() {
		return realpay;
	}

	public void setRealpay(float realpay) {
		this.realpay = realpay;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
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
