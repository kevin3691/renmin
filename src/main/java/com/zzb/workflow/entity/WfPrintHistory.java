package com.zzb.workflow.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 实体 打印记录
 * 
 * 
 * @CreatedAt 2016年8月1日
 *
 */
@Entity
public class WfPrintHistory extends BaseEntity<WfPrintHistory> {
	private String category;// 类别
	private String applyTo;// 依附于表名
	private int refNum;// 依附于表ID
	private String title;// 标题
	private Date printAt;// 打印时间
	private String printBy;// 打印人
	private int pages;// 页数
	private String html;// 打印内容
	private String descr;// 备注
	private RecordInfo recordInfo;

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getPrintAt() {
		return printAt;
	}

	public void setPrintAt(Date printAt) {
		this.printAt = printAt;
	}

	public String getPrintBy() {
		return printBy;
	}

	public void setPrintBy(String printBy) {
		this.printBy = printBy;
	}

	public int getPages() {
		return pages;
	}

	public void setPages(int pages) {
		this.pages = pages;
	}
	
	@Column(columnDefinition = "text")
	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	@Column(columnDefinition = "text")
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
