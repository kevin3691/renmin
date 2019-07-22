package com.zzb.core.baseclass;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.zzb.core.utils.ConvertUtils;

/**
 * 查询参数
 * 
 */
public class QueryPara {

	private String hql;
	private List<Object> args;
	private Map<String, Object> alias;
	// 当前页
	private int pageIndex;
	// 每页记录数
	private int pageSize;
	// 排序字段
	private String orderBy = "";
	// 排序方向
	private String orderDirection = "";

	public QueryPara() {
	}

	public QueryPara(HttpServletRequest request) {
		String page = request.getParameter("page");
		if (page != null) {
			this.setPageIndex(ConvertUtils.Convert2Int(page));
		}
		String rows = request.getParameter("rows");
		if (rows != null) {
			this.setPageSize(ConvertUtils.Convert2Int(rows));
		}
		String sidx = request.getParameter("sidx");
		if (sidx != null) {
			this.setOrderBy(ConvertUtils.Convert2String(sidx));
		}
		String sord = request.getParameter("sord");
		if (sord != null) {
			this.setOrderDirection( ConvertUtils.Convert2String(sord));
		}
	}

	public String getHql() {
		return hql;
	}

	public void setHql(String hql) {
		this.hql = hql;
	}

	public List<Object> getArgs() {
		return args;
	}

	public void setArgs(List<Object> args) {
		this.args = args;
	}

	public Map<String, Object> getAlias() {
		return alias;
	}

	public void setAlias(Map<String, Object> alias) {
		this.alias = alias;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderDirection() {
		return orderDirection;
	}

	public void setOrderDirection(String orderDirection) {
		this.orderDirection = orderDirection;
	}

}
