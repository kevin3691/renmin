package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class GoodsRecord extends BaseEntity<GoodsRecord> {
//名称 规格信号 设备编号 价格 领用人 领用部门 使用地点 类别 单位 领用日期
	private int goosId;
	private String name;//名称
	private String spec;//规格型号
	private String type;//类别
	private int typeId;//类别
	private String sn;//设备编号
	private String unit;//单位
	private String keeper;//领用人
	private int keeperId;//领用人
	private String location;//使用地
	private float price;//价格
	private String org;//部门
	private int orgId;//部门
	private String category;
	private int categoryId;
	private Date startdt;//领用日期

	private int isActive;
	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	public GoodsRecord() {
	}

	public GoodsRecord(int goosId, String name, String spec, String type, int typeId, String sn, String unit, String keeper,
					   int keeperId, String location, float price, String org, int orgId, String category, int categoryId, Date startdt) {
		this.goosId = goosId;
		this.name = name;
		this.spec = spec;
		this.type = type;
		this.typeId = typeId;
		this.sn = sn;
		this.unit = unit;
		this.keeper = keeper;
		this.keeperId = keeperId;
		this.location = location;
		this.price = price;
		this.org = org;
		this.orgId = orgId;
		this.category = category;
		this.categoryId = categoryId;
		this.startdt = startdt;
	}

	public int getGoosId() {
		return goosId;
	}

	public void setGoosId(int goosId) {
		this.goosId = goosId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getTypeId() {
		return typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getKeeper() {
		return keeper;
	}

	public void setKeeper(String keeper) {
		this.keeper = keeper;
	}

	public int getKeeperId() {
		return keeperId;
	}

	public void setKeeperId(int keeperId) {
		this.keeperId = keeperId;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public Date getStartdt() {
		return startdt;
	}

	public void setStartdt(Date startdt) {
		this.startdt = startdt;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
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
}
