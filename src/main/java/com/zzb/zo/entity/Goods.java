package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class Goods extends BaseEntity<Goods> {

	private String name;
	private String spec;
	private String type;
	private int typeId;
	private String sn;
	private String unit;
	private String belong;
	private String keeper;
	private int keeperId;
	private String source;
	private String location;
	private float quanity;//当前库存量
	private float total;
	private float warn;
	private String status;
	private float price;
	private String voucherno;//凭证号
	private Date invoicedt;//发票日期
	private float invoiceval;//发票金额
	private String provider;
	private int providerId;
	private String contactperson;
	private String address;
	private String phone;
	private String email;
	private String deptype;//折旧方法
	private Date depbdt;//折旧开始年月
	private float depbase;//资产原值
	private float perofcost;//净残值率(%)即资产清理报废时可收回的残值扣除清理费用后的数额占资产原值的比率
	private float depyears;//使用年限也叫预计使用寿命或折旧年限，通常以年为单位
	private float netsalvage;//净残值
	private String img;
	private String author;
	private int authorId;
	private Date startdt;
	private String codeimg;
	private String codesrc;
	private String qrcode;
	private String barcode;
	private String org;
	private int orgId;
	private String category;
	private int categoryId;

	private int isActive;
	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

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

	public String getBelong() {
		return belong;
	}

	public void setBelong(String belong) {
		this.belong = belong;
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

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public float getQuanity() {
		return quanity;
	}

	public void setQuanity(float quanity) {
		this.quanity = quanity;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public float getWarn() {
		return warn;
	}

	public void setWarn(float warn) {
		this.warn = warn;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getVoucherno() {
		return voucherno;
	}

	public void setVoucherno(String voucherno) {
		this.voucherno = voucherno;
	}

	public Date getInvoicedt() {
		return invoicedt;
	}

	public void setInvoicedt(Date invoicedt) {
		this.invoicedt = invoicedt;
	}

	public float getInvoiceval() {
		return invoiceval;
	}

	public void setInvoiceval(float invoiceval) {
		this.invoiceval = invoiceval;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public int getProviderId() {
		return providerId;
	}

	public void setProviderId(int providerId) {
		this.providerId = providerId;
	}

	public String getContactperson() {
		return contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDeptype() {
		return deptype;
	}

	public void setDeptype(String deptype) {
		this.deptype = deptype;
	}

	public Date getDepbdt() {
		return depbdt;
	}

	public void setDepbdt(Date depbdt) {
		this.depbdt = depbdt;
	}

	public float getDepbase() {
		return depbase;
	}

	public void setDepbase(float depbase) {
		this.depbase = depbase;
	}

	public float getPerofcost() {
		return perofcost;
	}

	public void setPerofcost(float perofcost) {
		this.perofcost = perofcost;
	}

	public float getDepyears() {
		return depyears;
	}

	public void setDepyears(float depyears) {
		this.depyears = depyears;
	}

	public float getNetsalvage() {
		return netsalvage;
	}

	public void setNetsalvage(float netsalvage) {
		this.netsalvage = netsalvage;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public Date getStartdt() {
		return startdt;
	}

	public void setStartdt(Date startdt) {
		this.startdt = startdt;
	}

	public String getCodeimg() {
		return codeimg;
	}

	public void setCodeimg(String codeimg) {
		this.codeimg = codeimg;
	}

	public String getCodesrc() {
		return codesrc;
	}

	public void setCodesrc(String codesrc) {
		this.codesrc = codesrc;
	}

	public String getQrcode() {
		return qrcode;
	}

	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
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
