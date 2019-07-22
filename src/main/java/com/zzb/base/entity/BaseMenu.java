package com.zzb.base.entity;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.RecordInfo;

@Entity
public class BaseMenu extends BaseEntity<BaseMenu> {
	private String category;// 类别
	private String title;// 标题
	private String sym;// 代号
	private String url;// 菜单地址
	private String img;// 菜单图标
	private String template;// 模板
	private String descr;// 备注
	private int isActive;// 启用状态
	private int lineNo;// 排序号
	private BaseTree baseTree;
	private RecordInfo recordInfo;

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

	public String getSym() {
		return sym;
	}

	public void setSym(String sym) {
		this.sym = sym;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
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

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

}
