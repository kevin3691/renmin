package com.zzb.base.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class BaseUser extends BaseEntity<BaseUser> {
	private int baseOrgId;// 单位id
	private String baseOrgName;// 单位名称
	private int basePersonId;// 人员id
	private String basePersonName;// 人员名称
	private int baseRoleId;// 角色id
	private String baseRoleName;// 角色名称
	private String baseRoleSym;// 角色代号
	private String username;// 用户名
	private String password;// 密码
	private String purOrgIds;// 权限部门id，以","分割
	private String purOrgNames;// 权限部门名称，以","分割
	private String purPowerIds;// 权限id,以","分割
	private String purPowerSyms;// 权限代号，以","分割
	private String purPowerTitles;// 权限标题，以","分割
	private String purMenuIds;// 权限菜单id，以","分割
	private String purMenus;// 权限菜单,菜单JSON
	private String descr;// 备注
	private int isActive;// 启用状态
	private int lineNo;// 排序号
	private int onLineState;//在线
	private String keySN;// 加密锁ID
	private RecordInfo recordInfo;

	public int getOnLineState() {
		return onLineState;
	}

	public void setOnLineState(int loginState) {
		this.onLineState = loginState;
	}

	public int getBaseOrgId() {
		return baseOrgId;
	}

	

	public void setBaseOrgId(int baseOrgId) {
		this.baseOrgId = baseOrgId;
	}

	public String getBaseOrgName() {
		return baseOrgName;
	}

	public void setBaseOrgName(String baseOrgName) {
		this.baseOrgName = baseOrgName;
	}

	public int getBasePersonId() {
		return basePersonId;
	}

	public void setBasePersonId(int basePersonId) {
		this.basePersonId = basePersonId;
	}

	public String getBasePersonName() {
		return basePersonName;
	}

	public void setBasePersonName(String basePersonName) {
		this.basePersonName = basePersonName;
	}

	public int getBaseRoleId() {
		return baseRoleId;
	}

	public void setBaseRoleId(int baseRoleId) {
		this.baseRoleId = baseRoleId;
	}

	public String getBaseRoleName() {
		return baseRoleName;
	}

	public void setBaseRoleName(String baseRoleName) {
		this.baseRoleName = baseRoleName;
	}

	public String getBaseRoleSym() {
		return baseRoleSym;
	}

	public void setBaseRoleSym(String baseRoleSym) {
		this.baseRoleSym = baseRoleSym;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(columnDefinition = "text")
	public String getPurOrgIds() {
		return purOrgIds;
	}

	public void setPurOrgIds(String purOrgIds) {
		this.purOrgIds = purOrgIds;
	}

	@Column(columnDefinition = "text")
	public String getPurOrgNames() {
		return purOrgNames;
	}

	public void setPurOrgNames(String purOrgNames) {
		this.purOrgNames = purOrgNames;
	}

	@Column(columnDefinition = "text")
	public String getPurPowerIds() {
		return purPowerIds;
	}

	public void setPurPowerIds(String purPowerIds) {
		this.purPowerIds = purPowerIds;
	}

	@Column(columnDefinition = "text")
	public String getPurPowerSyms() {
		return purPowerSyms;
	}

	public void setPurPowerSyms(String purPowerSyms) {
		this.purPowerSyms = purPowerSyms;
	}

	@Column(columnDefinition = "text")
	public String getPurPowerTitles() {
		return purPowerTitles;
	}

	public void setPurPowerTitles(String purPowerTitles) {
		this.purPowerTitles = purPowerTitles;
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

	public String getKeySN() {
		return keySN;
	}

	public void setKeySN(String keySN) {
		this.keySN = keySN;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

}
