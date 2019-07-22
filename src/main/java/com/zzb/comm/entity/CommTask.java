package com.zzb.comm.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class CommTask extends BaseEntity<CommTask> {
	private String applyTo;
	private int refNum;
	private String category;// 分类
	private String property;// 分类
	private String title;// 标题
	private String status;// 任务状态[进行中|已完成]
	private int progress;// 进度
	private String primaryOrg;// 负责部门
	private String primaryPerson;// 负责人
	private String assignToOrg;// 参与部门
	private String assignToPerson; // 参与人
	private String descr;// 任务内容
	private String actDescr;// 工作内容
	private String isMust;// 是否必须
	private Date schedStartAt;// 任务计划开始时间
	private Date schedEndAt;// 任务计划结束时间
	private Date actStartAt;// 任务实际开始时间
	private Date actEndAt;// 任务实际结束时间
	private BaseTree baseTree;
	private RecordInfo recordInfo;

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public String getIsMust() {
		return isMust;
	}

	public void setIsMust(String isMust) {
		this.isMust = isMust;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}

	public String getPrimaryOrg() {
		return primaryOrg;
	}

	public void setPrimaryOrg(String primaryOrg) {
		this.primaryOrg = primaryOrg;
	}

	public String getPrimaryPerson() {
		return primaryPerson;
	}

	public void setPrimaryPerson(String primaryPerson) {
		this.primaryPerson = primaryPerson;
	}

	public String getAssignToOrg() {
		return assignToOrg;
	}

	public void setAssignToOrg(String assignToOrg) {
		this.assignToOrg = assignToOrg;
	}

	public String getAssignToPerson() {
		return assignToPerson;
	}

	public void setAssignToPerson(String assignToPerson) {
		this.assignToPerson = assignToPerson;
	}

	@Column(columnDefinition = "text")
	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	@Column(columnDefinition = "text")
	public String getActDescr() {
		return actDescr;
	}

	public void setActDescr(String actDescr) {
		this.actDescr = actDescr;
	}

	public Date getSchedStartAt() {
		return schedStartAt;
	}

	public void setSchedStartAt(Date schedStartAt) {
		this.schedStartAt = schedStartAt;
	}

	public Date getSchedEndAt() {
		return schedEndAt;
	}

	public void setSchedEndAt(Date schedEndAt) {
		this.schedEndAt = schedEndAt;
	}

	public Date getActStartAt() {
		return actStartAt;
	}

	public void setActStartAt(Date actStartAt) {
		this.actStartAt = actStartAt;
	}

	public Date getActEndAt() {
		return actEndAt;
	}

	public void setActEndAt(Date actEndAt) {
		this.actEndAt = actEndAt;
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
