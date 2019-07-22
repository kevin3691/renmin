package com.zzb.workflow.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 实体 工作日
 * 
 * @author 
 * @CreatedAt 2016年09月13日
 *
 */
@Entity
public class WfWorkDay extends BaseEntity<WfWorkDay> {
	private Date wfDate;// 日期
	private String weekDay;// 星期几
	private int ifClass;// 是否班
	private String descr;// 备注
	private RecordInfo recordInfo;

	public Date getWfDate() {
		return wfDate;
	}

	public void setWfDate(Date wfDate) {
		this.wfDate = wfDate;
	}

	public String getWeekDay() {
		return weekDay;
	}

	public void setWeekDay(String weekDay) {
		this.weekDay = weekDay;
	}

	public int getIfClass() {
		return ifClass;
	}

	public void setIfClass(int ifClass) {
		this.ifClass = ifClass;
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
