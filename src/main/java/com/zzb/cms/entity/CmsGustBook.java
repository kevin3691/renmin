package com.zzb.cms.entity;

import java.util.Date;

import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;
/**
 * 留言板
 * @author
 * @createdAt 2016年9月3日
 */
@Entity
public class CmsGustBook extends BaseEntity<CmsGustBook>{
	
	private String title;//留言标题
	private int messageBy;//留言人
	private String name;//留言人名称
	private Date messageAt;//留言时间
	private String messageContent;//留言内容
	private String mobile;//手机号码
	private String phone;//联系电话
	private String email;//邮箱地址
	private String gender;//性别
	private int display;//是否公开 0否 1是
	private int responseBy;//回复人
	private String responseName;//回复人名称
	private String responseContent;//回复内容
	private Date responseAt;//回复时间
	private String stts;//状态 1已回复 0未回复
	private String descr;//备注
	private RecordInfo recordInfo;
	
	public CmsGustBook() {}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getMessageBy() {
		return messageBy;
	}

	public void setMessageBy(int messageBy) {
		this.messageBy = messageBy;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getMessageAt() {
		return messageAt;
	}

	public void setMessageAt(Date messageAt) {
		this.messageAt = messageAt;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getDisplay() {
		return display;
	}

	public void setDisplay(int display) {
		this.display = display;
	}

	public int getResponseBy() {
		return responseBy;
	}

	public void setResponseBy(int responseBy) {
		this.responseBy = responseBy;
	}

	public String getResponseName() {
		return responseName;
	}

	public void setResponseName(String responseName) {
		this.responseName = responseName;
	}

	public String getResponseContent() {
		return responseContent;
	}

	public void setResponseContent(String responseContent) {
		this.responseContent = responseContent;
	}

	public Date getResponseAt() {
		return responseAt;
	}

	public void setResponseAt(Date responseAt) {
		this.responseAt = responseAt;
	}

	public String getStts() {
		return stts;
	}

	public void setStts(String stts) {
		this.stts = stts;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}



	

	
}
