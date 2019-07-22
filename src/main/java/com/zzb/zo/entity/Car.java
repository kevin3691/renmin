package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class Car extends BaseEntity<Car> {


	private String cardNo;
	private String pinpai;
	private String xinghao;
	private String type;
	private String fadongji;
	private Date goumairiqi;
	private String source;
	private float yiyonglicheng;
	private int xianzairenshu;
	private String shiyongxingzhi;
	private String cheliangjibie;
	private String zhuyaoshiyongdanwei;
	private String zhuyaoshiyongren;
	private String status;

	private int isActive;
	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getPinpai() {
		return pinpai;
	}

	public void setPinpai(String pinpai) {
		this.pinpai = pinpai;
	}

	public String getXinghao() {
		return xinghao;
	}

	public void setXinghao(String xinghao) {
		this.xinghao = xinghao;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFadongji() {
		return fadongji;
	}

	public void setFadongji(String fadongji) {
		this.fadongji = fadongji;
	}

	public Date getGoumairiqi() {
		return goumairiqi;
	}

	public void setGoumairiqi(Date goumairiqi) {
		this.goumairiqi = goumairiqi;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public float getYiyonglicheng() {
		return yiyonglicheng;
	}

	public void setYiyonglicheng(float yiyonglicheng) {
		this.yiyonglicheng = yiyonglicheng;
	}

	public int getXianzairenshu() {
		return xianzairenshu;
	}

	public void setXianzairenshu(int xianzairenshu) {
		this.xianzairenshu = xianzairenshu;
	}

	public String getShiyongxingzhi() {
		return shiyongxingzhi;
	}

	public void setShiyongxingzhi(String shiyongxingzhi) {
		this.shiyongxingzhi = shiyongxingzhi;
	}

	public String getCheliangjibie() {
		return cheliangjibie;
	}

	public void setCheliangjibie(String cheliangjibie) {
		this.cheliangjibie = cheliangjibie;
	}

	public String getZhuyaoshiyongdanwei() {
		return zhuyaoshiyongdanwei;
	}

	public void setZhuyaoshiyongdanwei(String zhuyaoshiyongdanwei) {
		this.zhuyaoshiyongdanwei = zhuyaoshiyongdanwei;
	}

	public String getZhuyaoshiyongren() {
		return zhuyaoshiyongren;
	}

	public void setZhuyaoshiyongren(String zhuyaoshiyongren) {
		this.zhuyaoshiyongren = zhuyaoshiyongren;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
