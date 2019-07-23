/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.zo.dao.WorkPlanListDao;
import com.zzb.zo.entity.WorkPlanList;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 组织机构 Service
 * 
 * 
 * @createdAt 2016年1月29日
 */
@Transactional
@Service("workPlanListService")
public class WorkPlanListService extends BaseService<WorkPlanList> {
	@Resource
	private WorkPlanListDao workPlanListDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WorkPlanList> list(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		String startdate = request.getParameter("startdate") != null ? request
				.getParameter("startdate") : "";
		String finishdate = request.getParameter("finishdate") != null ? request
				.getParameter("finishdate") : "";

		String status = request.getParameter("status") != null ? request
				.getParameter("status") : "";
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WorkPlanList WHERE 1=1";
		if (isActive > 0) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		if (!finishdate.equals("")) {
			hql += " AND date_format(finishdate,'%Y-%m-%d') <= ?";
			args.add(finishdate);
		}
		if (!startdate.equals("")) {
			hql += " AND date_format(startdate,'%Y-%m-%d') >= ?";
			args.add(startdate);
		}

		if (!status.equals("")) {
			hql += " AND status LIKE ?";
			args.add('%' + status + '%');
		}

		if (!type.equals("")) {
			hql += " AND type LIKE ?";
			args.add('%' + type + '%');
		}

		if (!category.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + category + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WorkPlanList> qr = workPlanListDao.list(qp);
		return qr;
	}

	public QueryResult<WorkPlanList> list4sel(HttpServletRequest request) {

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WorkPlanList WHERE 1=1";

		hql += " AND status LIKE ?";
		args.add("%空闲%");



		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WorkPlanList> qr = workPlanListDao.list(qp);
		return qr;
	}
	


	public WorkPlanList save(WorkPlanList doc, HttpServletRequest request) {

		doc = workPlanListDao.save(doc);


		return doc;
	}

	public WorkPlanList dtl(int id) {
		WorkPlanList doc = workPlanListDao.dtl(id);
		return doc;
	}

	public WorkPlanList dtlByDate(int refNum,Date date){
		List<Object> args = new ArrayList<Object>();
		String hql = " FROM WorkPlanList WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);

		hql += " AND workPlanListdate = ? ";
		args.add(date);
		return  workPlanListDao.dtl(hql, args);
	}

	public void del(int id) {
		workPlanListDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		workPlanListDao.sort(id, order);
	}
	


	public QueryResult<WorkPlanList> listByWorkWorkPlanListId(int refNum,String category) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WorkPlanList WHERE 1=1";
		hql += " AND refNum = ?";
		args.add(refNum);
		hql += " AND category = ?";
		args.add(category);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WorkPlanList> qr = workPlanListDao.list(qp);
		return qr;
	}

	public QueryResult<WorkPlanList> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM WorkPlanList WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<WorkPlanList> qr = workPlanListDao.list4(qp);
		return qr;
	}


}
