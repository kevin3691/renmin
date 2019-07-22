package com.zzb.core.baseclass;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Transient;

/**
 * 树数据的通用属性 实体引用
 * 
 */
@Embeddable
public class BaseTree implements Serializable {

	private static final long serialVersionUID = 1L;
	private int parentId;
	private String path;
	private String pathName;
	private int isLeaf;

	@SuppressWarnings("unused")
	private int level;// JqGrid用，不映射数据库字段
	@SuppressWarnings("unused")
	private boolean leaf;// JqGrid用，不映射数据库字段

	/**
	 * 构造函数
	 */
	public BaseTree() {
		this.setPath("");
		this.setPathName("");
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	@Column(columnDefinition="text")
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getPathName() {
		return pathName;
	}

	@Column(columnDefinition="text")
	public void setPathName(String pathName) {
		this.pathName = pathName;
	}

	public int getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(int isLeaf) {
		this.isLeaf = isLeaf;
	}

	@Transient
	public int getLevel() {
		int l = 0;
		if (path != null && !path.equals("") && path.indexOf(".") >= 0) {
			l = path.length() - 2;
		}
		return l;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Transient
	public boolean isLeaf() {
		if (isLeaf == 0) {
			return false;
		}
		return true;
	}

	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
}
