package com.zzb.core.baseclass;

import java.util.List;

/**
 * 查询返回结果类
 * 
 */
public class QueryResult<T> {
	// 记录总数
	private long total;
	// 记录集
	private List<T> rows;
	// 记录总数
	private long records;
	// 页脚数据
	private List<T> footer;
	// 容器
	private String container;


	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public List<T> getFooter() {
		return footer;
	}

	public void setFooter(List<T> footer) {
		this.footer = footer;
	}

	public String getContainer() {
		return container;
	}

	public void setContainer(String container) {
		this.container = container;
	}

	public long getRecords() {
		return records;
	}

	public void setRecords(long records) {
		this.records = records;
	}

}
