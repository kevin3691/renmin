/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.workflow.entity;

import java.util.Date;

import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 实体 待办
 * 
 * 
 * @createdAt 2016年4月7日
 */
@Entity
public class WfInstance extends BaseEntity<WfInstance> {

	private String category; // 类别
	private String applyTo;// 关联表
	private int refNum;// 关联字段
	private int stepId;// 环节Id
	private String stepName;// 环节名称
	private int nextStepId;// 下环节Id
	private String forward;
	private String nextStepName;// 下环节名称
	private String title;// 标题
	private String descr;// 描述
	private String actorId;// 执行人Id
	private String actorName;// 执行人姓名
	private Date actAt;// 执行时间
	private String yesNo;// 是否通过(是|否)
	private String actUrl;// 执行页
	private String listUrl;// 列表页
	private String dtlUrl;// 详细页
	private String okUrl;// 执行完跳转页
	private int isActive;
	private int isGui;
	private int isDu;
	private Date startTime;
	private Date finishTime;
	private String status;

	private int parentId;
	private RecordInfo recordInfo;

	public int getIsDu() {
		return isDu;
	}

	public void setIsDu(int isDu) {
		this.isDu = isDu;
	}

	public int getIsGui() {
		return isGui;
	}

	public void setIsGui(int isGui) {
		this.isGui = isGui;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}

	public String getForward() {
		return forward;
	}

	public void setForward(String forward) {
		this.forward = forward;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

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

	public int getStepId() {
		return stepId;
	}

	public void setStepId(int stepId) {
		this.stepId = stepId;
	}

	public String getStepName() {
		return stepName;
	}

	public int getNextStepId() {
		return nextStepId;
	}

	public void setNextStepId(int nextStepId) {
		this.nextStepId = nextStepId;
	}

	public String getNextStepName() {
		return nextStepName;
	}

	public void setNextStepName(String nextStepName) {
		this.nextStepName = nextStepName;
	}

	public void setStepName(String stepName) {
		this.stepName = stepName;
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

	public String getActorId() {
		return actorId;
	}

	public void setActorId(String actorId) {
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

	public String getActUrl() {
		return actUrl;
	}

	public void setActUrl(String actUrl) {
		this.actUrl = actUrl;
	}

	public String getListUrl() {
		return listUrl;
	}

	public void setListUrl(String listUrl) {
		this.listUrl = listUrl;
	}

	public String getDtlUrl() {
		return dtlUrl;
	}

	public void setDtlUrl(String dtlUrl) {
		this.dtlUrl = dtlUrl;
	}

	public String getOkUrl() {
		return okUrl;
	}

	public void setOkUrl(String okUrl) {
		this.okUrl = okUrl;
	}

}
