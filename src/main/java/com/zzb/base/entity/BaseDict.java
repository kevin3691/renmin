package com.zzb.base.entity;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;

import com.zzb.core.baseclass.*;

@Entity
public class BaseDict extends BaseEntity<BaseDict> {
	private String title;// 标题
	private String sym;// 代号
	private String value;// 取值
	private String descr;// 备注
	private int isActive;// 状态
	private int lineNo;// 序号
	private BaseTree baseTree;
	private RecordInfo recordInfo;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSym() {
		return sym;
	}

	public void setSym(String sym) {
		this.sym = sym;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(columnDefinition = "text")
	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	@Column(name = "[lineNo]")
	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	@Embedded
	public BaseTree getBaseTree() {
		// 如果为null时初始化并为其赋值
		baseTree = baseTree != null ? baseTree : new BaseTree();
		setBaseTree(baseTree);
		return baseTree;
	}

	public void setBaseTree(BaseTree baseTree) {
		this.baseTree = baseTree;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

}
