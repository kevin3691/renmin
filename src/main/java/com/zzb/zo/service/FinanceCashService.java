/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.zo.dao.FinanceCashDao;
import com.zzb.zo.entity.FinanceCash;
import com.zzb.zo.entity.FinanceCash;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 组织机构 Service
 * 
 * 
 * @createdAt 2016年1月29日
 */
@Transactional
@Service("financeCashService")
public class FinanceCashService extends BaseService<FinanceCash> {
	@Resource
	private FinanceCashDao financeCashDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<FinanceCash> list(HttpServletRequest request) {
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : -1;
		int sqrId = request.getParameter("sqrId") != null
				&& !request.getParameter("sqrId").equals("") ? Integer
				.valueOf(request.getParameter("sqrId")) : -1;
		int orgId = request.getParameter("orgId") != null
				&& !request.getParameter("orgId").equals("") ? Integer
				.valueOf(request.getParameter("orgId")) : -1;

		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String sqr = request.getParameter("sqr") != null ? request
				.getParameter("sqr") : "";
		String org = request.getParameter("org") != null ? request
				.getParameter("org") : "";
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM FinanceCash WHERE 1=1";
		if (status > 0) {
			hql += " AND status=?";
			args.add(status);
		}
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!sqr.equals("")) {
			hql += " AND sqr LIKE ?";
			args.add('%' + sqr + '%');
		}
		if (!org.equals("")) {
			hql += " AND colSym LIKE ?";
			args.add('%' + org + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		if (sqrId != -1) {
			hql += " AND sqrId=?";
			args.add(sqrId);
		}
		if (orgId != -1) {
			hql += " AND orgId=?";
			args.add(orgId);
		}

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<FinanceCash> qr = financeCashDao.list(qp);
		return qr;
	}
	


	public FinanceCash save(FinanceCash doc, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		doc.setRecordInfo(super.GenRecordInfo(doc.getRecordInfo(),
				request));
		doc = financeCashDao.save(doc);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (doc.getLineNo() == 0) {
			doc.setLineNo(doc.getId());
			doc = financeCashDao.save(doc);
		}
		return doc;
	}

	public FinanceCash dtl(int id) {
		FinanceCash doc = financeCashDao.dtl(id);
		return doc;
	}

	public void del(int id) {
		financeCashDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		financeCashDao.sort(id, order);
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
	
	public List<WfInstance> listIns(int refNum) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		List<WfInstance> qr = wfInstanceDao.list(hql, args);
		return qr;
	}
	
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		int isActive = request.getParameter("isActive") != null ? Integer
				.valueOf(request.getParameter("isActive")) : 0;
		String actorId = request.getParameter("actorId") != null ? 
				request.getParameter("actorId") : "";
		String yesNo = request.getParameter("yesNo") != null ? request
				.getParameter("yesNo") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String stepName = request.getParameter("stepName") != null ? request
				.getParameter("stepName") : "";
		String actorName = request.getParameter("actorName") != null ? request
				.getParameter("actorName") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		Map<String, Object> alias = new HashMap<String, Object>();

		String hql = "FROM WfInstance WHERE 1=1";
		if (!category.equals("")) {
			if (category.indexOf(",") >= 0) {
				String[] categorys = category.split(",");
				hql += " AND category IN (:categorys)";
				alias.put("categorys", categorys);
			} else {
				hql += " AND category LIKE ?";
				args.add('%' + category + '%');
			}
		}
		if (yesNo.equals("yes")) {
			hql += " AND yesNo=?";
			args.add("yes");
		}else{
			hql += " AND (yesNo != ? OR yesNo is null)";
			args.add("yes");
		}
		if (!actorId.equals("")) {
			hql += " AND actorId=?";
			args.add(actorId);
		}
		if (!applyTo.equals("")) {
			hql += " AND applyTo=?";
			args.add(applyTo);
		}
		if (refNum > 0) {
			hql += " AND refNum=?";
			args.add(refNum);
		}
		if (!stepName.equals("")) {
			if (stepName.indexOf(",") >= 0) {
				String[] stepNames = stepName.split(",");
				hql += " AND stepName IN (:stepNames)";
				alias.put("stepNames", stepNames);
			} else {
				hql += " AND stepName LIKE ?";
				args.add('%' + stepName + '%');
			}
		}
		if (!actorName.equals("")) {
			hql += " AND actorName LIKE ?";
			args.add('%' + actorName + '%');
		}
		hql += " AND isActive=?";
		args.add(isActive);
		qp.setAlias(alias);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list(qp);
		return qr;
	}

	public QueryResult<FinanceCash> listByDocTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM FinanceCash WHERE 1=1";
		hql += " AND docTypeId IN (SELECT id FROM DocType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<FinanceCash> qr = financeCashDao.list(qp);
		return qr;
	}

	public QueryResult<FinanceCash> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM FinanceCash WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<FinanceCash> qr = financeCashDao.list4(qp);
		return qr;
	}



	public QueryResult<FinanceCash> listAllUser() {
		QueryPara qp = new QueryPara();
		//List<Object> args = new ArrayList<Object>();
		String hql = "FROM FinanceCash WHERE 1=1";
		//hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		//args.add(orgId);
		//args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		//qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<FinanceCash> qr = financeCashDao.list4(qp);
		return qr;
	}

	public QueryResult<FinanceCash> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM FinanceCash WHERE 1=1 ";
		hql += " AND docTypeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<FinanceCash> qr = financeCashDao.listNoTotal(qp);
		return qr;
	}
	
	
	public WfInstance getIns(int refNum,int stepId) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		hql += " AND stepId=?";
		args.add(stepId);
		WfInstance ins = wfInstanceDao.dtl(hql, args);
		return ins;
	}

	public WfInstance getIns(int refNum,int stepId,String actorId) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		hql += " AND stepId=?";
		args.add(stepId);
		hql += " AND actorId=?";
		args.add(actorId);
		WfInstance ins = wfInstanceDao.dtl(hql, args);
		return ins;
	}
}
