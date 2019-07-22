/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.service;

import com.zzb.base.entity.BaseUser;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.zo.dao.GoodPlanListDao;
import com.zzb.zo.entity.GoodPlanList;
import org.apache.shiro.SecurityUtils;
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
@Service("goodPlanListService")
public class GoodPlanListService extends BaseService<GoodPlanList> {
	@Resource
	private GoodPlanListDao goodPlanListDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<GoodPlanList> list(HttpServletRequest request) {
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : -1;
		int orgId = request.getParameter("orgId") != null
				&& !request.getParameter("orgId").equals("") ? Integer
				.valueOf(request.getParameter("orgId")) : -1;
		BaseUser user = (BaseUser)SecurityUtils.getSubject()
				.getSession().getAttribute("baseUser");
		String starttime = request.getParameter("starttime") != null ? request
				.getParameter("starttime") : "";
		String finishtime = request.getParameter("finishtime") != null ? request
				.getParameter("finishtime") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodPlanList WHERE 1=1";

		if (!finishtime.equals("")) {
			hql += " AND date_format(sqrq,'%Y-%m-%d') <= ?";
			args.add(finishtime);
		}
		if (!starttime.equals("")) {
			hql += " AND date_format(sqrq,'%Y-%m-%d') >= ?";
			args.add(starttime);
		}

		if (isActive > -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}

		if (status > 0) {
			hql += " AND status=?";
			args.add(status);
		}

		if (orgId > 0) {
			if(user.getBaseOrgName().equals("办公室") || user.getBaseRoleName().contains("管理员")){

			}else{
				hql += " AND orgId=?";
				args.add(orgId);
			}

		}


		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<GoodPlanList> qr = goodPlanListDao.list(qp);
		return qr;
	}



	public GoodPlanList save(GoodPlanList doc, HttpServletRequest request) {

		RecordInfo info = GenRecordInfo(new RecordInfo(),request);
		doc.setRecordInfo(info);
		doc = goodPlanListDao.save(doc);


		return doc;
	}

	public GoodPlanList dtl(int id) {
		GoodPlanList doc = goodPlanListDao.dtl(id);
		return doc;
	}

	public GoodPlanList dtlByDate(int refNum,Date date){
		List<Object> args = new ArrayList<Object>();
		String hql = " FROM GoodPlanList WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);

		hql += " AND sqrq = ? ";
		args.add(date);
		return  goodPlanListDao.dtl(hql, args);
	}

	public void del(int id) {
		goodPlanListDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		goodPlanListDao.sort(id, order);
	}
	
	public int checkInsExist(String applyTo,int refNum,int stepId, String actorId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM WfInstance WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo=?";
			args.add(applyTo);
		}
		if (refNum > 0) {
			hql += " AND refNum=? ";
			args.add(refNum);
		}
		if (stepId > 0) {
			hql += " AND stepId=? ";
			args.add(stepId);
		}
		if (!actorId.equals("")) {
			hql += " AND actorId=?";
			args.add(actorId);
		}
		return (int) ((long) wfInstanceDao.uniqueResult(hql, args));
	}
	
	public int delByRefNum(int refNum) {
		List<Object> args = new ArrayList<Object>();

		String hql = "DELETE * FROM WfInstance WHERE refNum=?";
		args.add(refNum);
		
		return (int) ((long) wfInstanceDao.uniqueResult(hql, args));
	}
	


	public QueryResult<GoodPlanList> listByWorkGoodPlanListId(int refNum,String category) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodPlanList WHERE 1=1";
		hql += " AND refNum = ?";
		args.add(refNum);
		hql += " AND category = ?";
		args.add(category);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<GoodPlanList> qr = goodPlanListDao.list(qp);
		return qr;
	}

	public QueryResult<GoodPlanList> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM GoodPlanList WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<GoodPlanList> qr = goodPlanListDao.list4(qp);
		return qr;
	}




}
