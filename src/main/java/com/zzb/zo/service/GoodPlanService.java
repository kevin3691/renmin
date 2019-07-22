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
import com.zzb.workflow.entity.WfInstance;
import com.zzb.zo.dao.GoodPlanDao;
import com.zzb.zo.entity.GoodPlan;
import com.zzb.zo.entity.GoodPlan;
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
@Service("goodPlanService")
public class GoodPlanService extends BaseService<GoodPlan> {
	@Resource
	private GoodPlanDao goodPlanDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<GoodPlan> list(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : -1;
		int orgId = request.getParameter("orgId") != null
				&& !request.getParameter("orgId").equals("") ? Integer
				.valueOf(request.getParameter("orgId")) : -1;
		int isSel = request.getParameter("isSel") != null
				&& !request.getParameter("isSel").equals("") ? Integer
				.valueOf(request.getParameter("isSel")) : -1;
		int refNum = request.getParameter("refNum") != null
				&& !request.getParameter("refNum").equals("") ? Integer
				.valueOf(request.getParameter("refNum")) : -1;
		BaseUser user = (BaseUser)SecurityUtils.getSubject()
				.getSession().getAttribute("baseUser");
		String starttime = request.getParameter("starttime") != null ? request
				.getParameter("starttime") : "";
		String finishtime = request.getParameter("finishtime") != null ? request
				.getParameter("finishtime") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodPlan WHERE 1=1";

		if (!finishtime.equals("")) {
			hql += " AND date_format(sqrq,'%Y-%m-%d') <= ?";
			args.add(finishtime);
		}
		if (!starttime.equals("")) {
			hql += " AND date_format(sqrq,'%Y-%m-%d') >= ?";
			args.add(starttime);
		}

		if (isActive > 0) {
			hql += " AND isActive=?";
			args.add(isActive);
		}

		if (status > -1) {
			hql += " AND status=?";
			args.add(status);
		}

		if (isSel > -1) {
			hql += " AND isSel=?";
			args.add(isSel);
		}

		if (refNum > -1) {
			hql += " AND refNum=?";
			args.add(refNum);
		}

		String roleName = "管理员";
		boolean b = user.getBaseRoleName().contains(roleName);
		if (orgId > 0) {
			if(user.getBaseOrgName().equals("办公室") || b){

			}else{
				hql += " AND orgId=?";
				args.add(orgId);
			}

		}


		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<GoodPlan> qr = goodPlanDao.list(qp);
		return qr;
	}



	public GoodPlan save(GoodPlan doc, HttpServletRequest request) {

		RecordInfo info = GenRecordInfo(new RecordInfo(),request);
		doc.setRecordInfo(info);
		doc = goodPlanDao.save(doc);


		return doc;
	}

	public GoodPlan dtl(int id) {
		GoodPlan doc = goodPlanDao.dtl(id);
		return doc;
	}

	public GoodPlan dtlByDate(int refNum,Date date){
		List<Object> args = new ArrayList<Object>();
		String hql = " FROM GoodPlan WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);

		hql += " AND sqrq = ? ";
		args.add(date);
		return  goodPlanDao.dtl(hql, args);
	}

	public void del(int id) {
		goodPlanDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		goodPlanDao.sort(id, order);
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
	


	public QueryResult<GoodPlan> listByWorkGoodPlanId(int refNum,String category) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodPlan WHERE 1=1";
		hql += " AND refNum = ?";
		args.add(refNum);
		hql += " AND category = ?";
		args.add(category);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<GoodPlan> qr = goodPlanDao.list(qp);
		return qr;
	}

	public QueryResult<GoodPlan> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM GoodPlan WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<GoodPlan> qr = goodPlanDao.list4(qp);
		return qr;
	}




}
