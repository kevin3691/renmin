package com.zzb.base.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class BaseRole extends BaseEntity<BaseRole> {

	private String Category;
	private String title;// 标题
	private String sym;// 代号
	private String purPowerIds;// 权限id(多个以“,”分割)
	private String purPowerTitles;// 名称(多个以“,”分割)
	private String purPowerSyms;// 权限代号(多个以“,”分割)
	private String purMenuIds;// 权限菜单id，以","分割
	private String purMenus;// 权限菜单,菜单JSON
	private String userIds;// 用户id(多个以“,”分割)
	private String userNames;// 用户名(多个以“,”分割)
	private String personIds;// 人员id(多个以“,”分割)
	private String personNames;// 人员姓名(多个以“,”分割)
	private String homeSet;
	private String descr;// 备注
	private int isActive;// 状态
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	
	
	
	
	
	
	public String getCategory() {
		return Category;
	}

	public void setCategory(String category) {
		Category = category;
	}

	public String getHomeSet() {
		return homeSet;
	}

	public void setHomeSet(String homeSet) {
		this.homeSet = homeSet;
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

	@Column(columnDefinition = "text")
	public String getPurPowerIds() {
		return purPowerIds;
	}

	public void setPurPowerIds(String purPowerIds) {
		this.purPowerIds = purPowerIds;
	}

	@Column(columnDefinition = "text")
	public String getPurPowerTitles() {
		return purPowerTitles;
	}

	public void setPurPowerTitles(String purPowerTitles) {
		this.purPowerTitles = purPowerTitles;
	}

	@Column(columnDefinition = "text")
	public String getPurPowerSyms() {
		return purPowerSyms;
	}

	public void setPurPowerSyms(String purPowerSyms) {
		this.purPowerSyms = purPowerSyms;
	}

	@Column(columnDefinition = "text")
	public String getPurMenuIds() {
		return purMenuIds;
	}

	public void setPurMenuIds(String purMenuIds) {
		this.purMenuIds = purMenuIds;
	}

	@Column(columnDefinition = "text")
	public String getPurMenus() {
		return purMenus;
	}

	public void setPurMenus(String purMenus) {
		this.purMenus = purMenus;
	}

	@Column(columnDefinition = "text")
	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

	@Column(columnDefinition = "text")
	public String getUserNames() {
		return userNames;
	}

	public void setUserNames(String userNames) {
		this.userNames = userNames;
	}

	@Column(columnDefinition = "text")
	public String getPersonIds() {
		return personIds;
	}

	public void setPersonIds(String personIds) {
		this.personIds = personIds;
	}

	@Column(columnDefinition = "text")
	public String getPersonNames() {
		return personNames;
	}

	public void setPersonNames(String personNames) {
		this.personNames = personNames;
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

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

}
