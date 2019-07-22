package com.zzb.comm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class CommForm extends BaseEntity<CommForm> {
	private String category;// 类别
	private String name;// 标题
	private String descr;// 备注
	private String html;// 代码
	private int isActive;// 有效状态
	private RecordInfo recordInfo;

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(columnDefinition = "text")
	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	@Column(columnDefinition = "text")
	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

}
