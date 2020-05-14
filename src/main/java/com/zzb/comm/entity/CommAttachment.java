package com.zzb.comm.entity;

import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class CommAttachment extends BaseEntity<CommAttachment> {

	private String title;// 标题 view
	private String category;// 类别
	private String applyTo;// 依附于（存储关联表名）
	private int refNum;// 依附于（存储关联表ID）
	private String filePath;// 附件路径（磁盘路径） view
	private String fileUrl;// 地址 view
	private String fileExt;// 扩展名 view
	private String icon;// 扩展名图标
	private long fileSize;// 附件大小 view
	private String share;// 共享级别 view
	private String descr;// 备注 view
	private RecordInfo recordInfo;
	private String photo;

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
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

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getShare() {
		return share;
	}

	public void setShare(String share) {
		this.share = share;
	}

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
