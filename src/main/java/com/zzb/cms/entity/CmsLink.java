/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.cms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 
 * 
 * @createdAt 2016年3月11日
 */
@Entity
public class CmsLink extends BaseEntity<CmsLink> {
	private String colSym;// 栏目代号
	private String colTitle;// 栏目标
	private String category;// 链接分类
	private String title;// 标题
	private String url;// 链接地址
	private String background;// 背景图
	private String width;// 宽度
	private String height;// 高度
	private String status;// 状态
	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	public String getColSym() {
		return colSym;
	}

	public void setColSym(String colSym) {
		this.colSym = colSym;
	}

	public String getColTitle() {
		return colTitle;
	}

	public void setColTitle(String colTitle) {
		this.colTitle = colTitle;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getBackground() {
		return background;
	}

	public void setBackground(String background) {
		this.background = background;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(columnDefinition = "text")
	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	@Column(name = "[lineNo]")
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
