package com.zzb.core.baseclass;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * 数据表通用属性
 * 
 */
@Embeddable
public class RecordInfo implements Serializable {

	private static final long serialVersionUID = 1L;
	// 创建时间
	private Date createdAt;
	// 创建人（BasePerson）ID
	private int createdBy;
	// 创建用户（BaseUser）ID
	private int createdByUser;
	// 创建人姓名
	private String createdByName;
	// 最后更新时间
	private Date updatedAt;
	// 最后更新人（BasePerson）ID
	private int updatedBy;
	// 最后更新用户（BaseUser）ID
	private int updatedByUser;
	// 最后更新人姓名
	private String updatedByName;
	// 执行操作主机IP
	private String clientIP;

	public RecordInfo() {
		
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public int getCreatedByUser() {
		return createdByUser;
	}

	public void setCreatedByUser(int createdByUser) {
		this.createdByUser = createdByUser;
	}

	@Column(length = 50)
	public String getCreatedByName() {
		return createdByName;
	}

	public void setCreatedByName(String createdByName) {
		this.createdByName = createdByName;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public int getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(int updatedBy) {
		this.updatedBy = updatedBy;
	}

	public int getUpdatedByUser() {
		return updatedByUser;
	}

	public void setUpdatedByUser(int updatedByUser) {
		this.updatedByUser = updatedByUser;
	}

	@Column(length = 50)
	public String getUpdatedByName() {
		return updatedByName;
	}

	public void setUpdatedByName(String updatedByName) {
		this.updatedByName = updatedByName;
	}

	@Column(length = 20)
	public String getClientIP() {
		return clientIP;
	}

	public void setClientIP(String clientIP) {
		this.clientIP = clientIP;
	}

}
