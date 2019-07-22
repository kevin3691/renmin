package com.zzb.cms.entity;

import javax.persistence.Embedded;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.BaseTree;
//模板实体类
@Entity
public class CmsTemplate extends BaseEntity<CmsTemplate> {

	private String name;		//模板名（标示）
	private String tempDiscribe;	//模板描述
	private String comFilePath;//模板压缩文件上传所在的路径
	private String uncomFilePath;//模板解压缩后所在的路径
	
	private BaseTree baseTree;
	
	public CmsTemplate() {}

	@Embedded
	public BaseTree getBaseTree() {
		// 如果为null时初始化并为其赋值
		baseTree = baseTree != null ? baseTree : new BaseTree();
		setBaseTree(baseTree);
		return baseTree;
	}

	public void setBaseTree(BaseTree baseTree) {
		this.baseTree = baseTree;
	}

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComFilePath() {
		return comFilePath;
	}

	public void setComFilePath(String comFilePath) {
		this.comFilePath = comFilePath;
	}

	public String getUncomFilePath() {
		return uncomFilePath;
	}

	public void setUncomFilePath(String uncomFilePath) {
		this.uncomFilePath = uncomFilePath;
	}

	public String getTempDiscribe() {
		return tempDiscribe;
	}

	public void setTempDiscribe(String tempDiscribe) {
		this.tempDiscribe = tempDiscribe;
	}

}
