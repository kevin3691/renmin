package com.zzb.comm.entity;

import java.util.Date;

import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class CommNoti extends BaseEntity<CommNoti>{
	private String title;// 标题 
	private String descr;// 备注
	private int targetPersonId;//目标人Id
	private String targetPersonName;// 目标人姓名
	private int targetOrgId;// 目标人单位ID
	private String targetOrgName;// 目标人单位姓名
	private String category;// 消息|通知|提醒
	private int refnum;//模块Id
	private String stts;//已读|未读
	private String source;//来源，一般存模块名称
	private Date receiveAt;// 读取时间
	private String url;//地址
	private int isDel;//0未删除  1已删除
	private RecordInfo recordInfo;
	
	public int getIsDel() {
		return isDel;
	}
	public void setIsDel(int isDel) {
		this.isDel = isDel;
	}
	public String getStts() {
		return stts;
	}
	public void setStts(String stts) {
		this.stts = stts;
	}
	public int getRefnum() {
		return refnum;
	}
	public void setRefnum(int refnum) {
		this.refnum = refnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public int getTargetPersonId() {
		return targetPersonId;
	}
	public void setTargetPersonId(int targetPersonId) {
		this.targetPersonId = targetPersonId;
	}
	public String getTargetPersonName() {
		return targetPersonName;
	}
	public void setTargetPersonName(String targetPersonName) {
		this.targetPersonName = targetPersonName;
	}
	public int getTargetOrgId() {
		return targetOrgId;
	}
	public void setTargetOrgId(int targetOrgId) {
		this.targetOrgId = targetOrgId;
	}
	public String getTargetOrgName() {
		return targetOrgName;
	}
	public void setTargetOrgName(String targetOrgName) {
		this.targetOrgName = targetOrgName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Date getReceiveAt() {
		return receiveAt;
	}
	public void setReceiveAt(Date receiveAt) {
		this.receiveAt = receiveAt;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public RecordInfo getRecordInfo() {
		return recordInfo;
	}
	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

}
