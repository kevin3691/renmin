package com.zzb.comm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class CommFormFiled extends BaseEntity<CommFormFiled> {
	private int commFormId;
	private String commFormName;
	private String title;// 显示标题
	private String name;// 名称
	private String dataType;// 类型
	private String eleType;// 元素类型
	private String dataLength;// 长度
	private String descr;// 备注
	private int lineNo;// 序号
	private RecordInfo recordInfo;

	public int getCommFormId() {
		return commFormId;
	}

	public void setCommFormId(int commFormId) {
		this.commFormId = commFormId;
	}

	public String getCommFormName() {
		return commFormName;
	}

	public void setCommFormName(String commFormName) {
		this.commFormName = commFormName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getEleType() {
		return eleType;
	}

	public void setEleType(String eleType) {
		this.eleType = eleType;
	}

	public String getDataLength() {
		return dataLength;
	}

	public void setDataLength(String dataLength) {
		this.dataLength = dataLength;
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
