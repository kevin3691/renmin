package com.zzb.cms.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 
 * @author
 *	调查主题
 */
@Entity
public class SurveyTopics extends BaseEntity<SurveyTopics>
{
	private String topicTitle; //调查主题标题
	private String columnTitle; //栏目标题
	private String columnSym; //栏目标识
	private Date startTime; //起始时间
	private Date endTime; //终止时间
	private int isActive; //是否启用
	private String descr; //描述
	private RecordInfo recordInfo;
	
	public String getTopicTitle() {
		return topicTitle;
	}
	public void setTopicTitle(String topicTitle) {
		this.topicTitle = topicTitle;
	}
	public String getColumnTitle() {
		return columnTitle;
	}
	public void setColumnTitle(String columnTitle) {
		this.columnTitle = columnTitle;
	}
	public String getColumnSym() {
		return columnSym;
	}
	public void setColumnSym(String columnSym) {
		this.columnSym = columnSym;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
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
