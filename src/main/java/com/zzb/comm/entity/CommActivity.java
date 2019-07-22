package com.zzb.comm.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;

@Entity
public class CommActivity extends BaseEntity<CommActivity> {
	private String applyTo;
	private int refNum;
	private String category;// 活动分类
	private String actSym;// 活动数据字典分类代号
	private String subCategory;// 活动数据字典分类,子类
	private String title;// 活动标题
	private String contactPerson;// 联系人
	private String contactPhone;// 联系电话
	private int actorId;// 执行人ID
	private String actorName;// 执行人姓名
	private Date actAt;// 活动时间
	private String yesNo;// 是否通过(是|否)
	private String yesNoDescr;//
	private Date limitStartAt;// 办理期限起
	private Date limitEndAt;// 办理期限止
	private String stts;// 状态
	private String isMust;// 是否必须
	private String descr;// 备注

	public String getApplyTo() {
		return applyTo;
	}

	public void setApplyTo(String applyTo) {
		this.applyTo = applyTo;
	}

	public int getRefNum() {
		return refNum;
	}

	public void setRefNum(int refNum) {
		this.refNum = refNum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getActSym() {
		return actSym;
	}

	public void setActSym(String actSym) {
		this.actSym = actSym;
	}

	public String getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public int getActorId() {
		return actorId;
	}

	public void setActorId(int actorId) {
		this.actorId = actorId;
	}

	public String getActorName() {
		return actorName;
	}

	public void setActorName(String actorName) {
		this.actorName = actorName;
	}

	public Date getActAt() {
		return actAt;
	}

	public void setActAt(Date actAt) {
		this.actAt = actAt;
	}

	public String getYesNo() {
		return yesNo;
	}

	public void setYesNo(String yesNo) {
		this.yesNo = yesNo;
	}

	@Column(columnDefinition = "text")
	public String getYesNoDescr() {
		return yesNoDescr;
	}

	public void setYesNoDescr(String yesNoDescr) {
		this.yesNoDescr = yesNoDescr;
	}

	public Date getLimitStartAt() {
		return limitStartAt;
	}

	public void setLimitStartAt(Date limitStartAt) {
		this.limitStartAt = limitStartAt;
	}

	public Date getLimitEndAt() {
		return limitEndAt;
	}

	public void setLimitEndAt(Date limitEndAt) {
		this.limitEndAt = limitEndAt;
	}

	public String getStts() {
		return stts;
	}

	public void setStts(String stts) {
		this.stts = stts;
	}

	public String getIsMust() {
		return isMust;
	}

	public void setIsMust(String isMust) {
		this.isMust = isMust;
	}

	@Column(columnDefinition = "text")
	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

}
