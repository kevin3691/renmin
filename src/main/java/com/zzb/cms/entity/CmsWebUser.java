package com.zzb.cms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 外网用户
 * @author
 * @createdAt 2016年9月3日
 */
@Entity
public class CmsWebUser extends BaseEntity<CmsWebUser>{

	private String userName;//用户名
	private String realName;//真实姓名
	private String password;//密码
	private String gender;//性别
	private String idtype;//身份类型
	private String idCardNo;//身份证号码
	private String mobile;//手机号码
	private String phone;//联系电话
	private String fax;//传真
	private String email;//邮箱地址
	private int isVerfiy;//是否核实 0否，1是
	private int isActive;//是否启用 ,0否，1是
	private String descr;// 备注
	
	private RecordInfo recordInfo;
	
	public CmsWebUser() {}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getIdtype() {
		return idtype;
	}
	public void setIdtype(String idtype) {
		this.idtype = idtype;
	}
	public String getIdCardNo() {
		return idCardNo;
	}
	public void setIdCardNo(String idCardNo) {
		this.idCardNo = idCardNo;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public int getIsVerfiy() {
		return isVerfiy;
	}
	public void setIsVerfiy(int isVerfiy) {
		this.isVerfiy = isVerfiy;
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
