/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;


@Entity
public class Document extends BaseEntity<Document> {
	private int docTypeId;// 单位id
	private String docTypeName;// 单位名称
	private String location;
	private String title;// 标题 view
	private int type;
	private String colSym;
	private String colTitle;
	private String category;// 类别 1阅办 2批办 3自发阅办 4自发批办
	private String applyTo;
	private int refNum;
	private String content;//内容


	private int ljrId;
	private  String ljr;
	

	private String lwbh;//来文号
	private String lwfs;//来文方式
	private Date lwsj;//来文时间
	private String lwlx;//来文类型

	private String level;
	private String miji;
	private String jbr;
	private int jbrId;
	private String phone;
	private int page;
	private String org;
	private int orgId;
	private int wfWorkflowId;//流程表id
	
	private int isFinish;//1:finish
	private int isPi;//是否批转 1:批转
	private int isDu;//是否督办 1:督办

	private String filePath;// 附件路径（磁盘路径） view
	private String fileUrl;// 地址 view
	private String fileExt;// 扩展名 view
	private String icon;// 扩展名图标
	private String fileName;
	private long fileSize;// 附件大小 view

	private int fileId;
	private String descr;// 备注 view
	private int isActive;
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	public int getLjrId() {
		return ljrId;
	}

	public void setLjrId(int ljrId) {
		this.ljrId = ljrId;
	}

	public String getLjr() {
		return ljr;
	}

	public void setLjr(String ljr) {
		this.ljr = ljr;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public int getIsPi() {
		return isPi;
	}
	public void setIsPi(int isPi) {
		this.isPi = isPi;
	}
	public int getIsDu() {
		return isDu;
	}
	public void setIsDu(int isDu) {
		this.isDu = isDu;
	}
	public int getWfWorkflowId() {
		return wfWorkflowId;
	}
	public void setWfWorkflowId(int wfWorkflowId) {
		this.wfWorkflowId = wfWorkflowId;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getMiji() {
		return miji;
	}
	public void setMiji(String miji) {
		this.miji = miji;
	}
	public String getJbr() {
		return jbr;
	}
	public void setJbr(String jbr) {
		this.jbr = jbr;
	}
	public int getJbrId() {
		return jbrId;
	}
	public void setJbrId(int jbrId) {
		this.jbrId = jbrId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getOrg() {
		return org;
	}
	public void setOrg(String org) {
		this.org = org;
	}
	public int getOrgId() {
		return orgId;
	}
	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}
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

	public String getLwlx() {
		return lwlx;
	}
	public void setLwlx(String lwlx) {
		this.lwlx = lwlx;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}


	public String getLwbh() {
		return lwbh;
	}
	public void setLwbh(String lwbh) {
		this.lwbh = lwbh;
	}
	public String getLwfs() {
		return lwfs;
	}
	public void setLwfs(String lwfs) {
		this.lwfs = lwfs;
	}
	public Date getLwsj() {
		return lwsj;
	}
	public void setLwsj(Date lwsj) {
		this.lwsj = lwsj;
	}
	public int getIsFinish() {
		return isFinish;
	}
	public void setIsFinish(int isFinish) {
		this.isFinish = isFinish;
	}
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

	public int getDocTypeId() {
		return docTypeId;
	}

	public void setDocTypeId(int docTypeId) {
		this.docTypeId = docTypeId;
	}

	public String getDocTypeName() {
		return docTypeName;
	}

	public void setDocTypeName(String docTypeName) {
		this.docTypeName = docTypeName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
}
