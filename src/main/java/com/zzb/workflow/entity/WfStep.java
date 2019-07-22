/**
 * 
 */
package com.zzb.workflow.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * @author
 */
@Entity
public class WfStep extends BaseEntity<WfStep> {
	private int wfWorkflowId;//流程表id
	private String wfWorkflowTitle;// 流程表标题
	private String title;// 标题
	private String sym;// 代号
	private String preSteps;// 上一环节
	private String nextSteps;// 下一环节
	private String actUrl;// 操作地址
	private String dtlUrl;// 详细地址
	private String okUrl;// 返回地址
	private String okMsg;// 返回提示
	private int actorId;
	private String actorName;
	private String descr;// 备注
	private int lineNo;// 顺序号
	private RecordInfo recordInfo;

	public int getActorId() {
		return actorId;
	}

	public void setActorId(int actorId) {
		this.actorId = actorId;
	}

	public String getActorName() {
		return actorName;
	}

	public void setActorName(String actorName) {
		this.actorName = actorName;
	}

	public int getWfWorkflowId() {
		return wfWorkflowId;
	}

	public void setWfWorkflowId(int wfWorkflowId) {
		this.wfWorkflowId = wfWorkflowId;
	}

	public String getWfWorkflowTitle() {
		return wfWorkflowTitle;
	}

	public void setWfWorkflowTitle(String wfWorkflowTitle) {
		this.wfWorkflowTitle = wfWorkflowTitle;
	}

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

	public String getPreSteps() {
		return preSteps;
	}

	public void setPreSteps(String preSteps) {
		this.preSteps = preSteps;
	}

	public String getNextSteps() {
		return nextSteps;
	}

	public void setNextSteps(String nextSteps) {
		this.nextSteps = nextSteps;
	}

	public String getActUrl() {
		return actUrl;
	}

	public void setActUrl(String actUrl) {
		this.actUrl = actUrl;
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

	public String getOkMsg() {
		return okMsg;
	}

	public void setOkMsg(String okMsg) {
		this.okMsg = okMsg;
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
