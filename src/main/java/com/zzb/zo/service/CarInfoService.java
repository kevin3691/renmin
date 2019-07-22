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
import com.zzb.zo.dao.CarInfoDao;
import com.zzb.zo.entity.CarInfo;
import com.zzb.zo.entity.CarInfo;
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
@Service("carInfoService")
public class CarInfoService extends BaseService<CarInfo> {
	@Resource
	private CarInfoDao carInfoDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CarInfo> list(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int carId = request.getParameter("carId") != null
				&& !request.getParameter("carId").equals("") ? Integer
				.valueOf(request.getParameter("carId")) : -1;
		int isFinish = request.getParameter("isFinish") != null
				&& !request.getParameter("isFinish").equals("") ? Integer
				.valueOf(request.getParameter("isFinish")) : -1;
		int docTypeId = request.getParameter("docTypeId") != null
				&& !request.getParameter("docTypeId").equals("") ? Integer
				.valueOf(request.getParameter("docTypeId")) : 0;
		String carInfodNo = request.getParameter("carInfodNo") != null ? request
				.getParameter("carInfodNo") : "";
		String status = request.getParameter("status") != null ? request
				.getParameter("status") : "";
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CarInfo WHERE 1=1";
		if (isActive > 0) {
			hql += " AND isActive=?";
			args.add(isActive);
		}

		if (carId > 0) {
			hql += " AND carId=?";
			args.add(carId);
		}

		if (!carInfodNo.equals("")) {
			hql += " AND carInfodNo LIKE ?";
			args.add('%' + carInfodNo + '%');
		}

		if (!status.equals("")) {
			hql += " AND status LIKE ?";
			args.add('%' + status + '%');
		}

		if (!type.equals("")) {
			hql += " AND type LIKE ?";
			args.add('%' + type + '%');
		}



		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CarInfo> qr = carInfoDao.list(qp);
		return qr;
	}
	


	public CarInfo save(CarInfo doc, HttpServletRequest request) {

		doc = carInfoDao.save(doc);


		return doc;
	}

	public CarInfo dtl(int id) {
		CarInfo doc = carInfoDao.dtl(id);
		return doc;
	}

	public void del(int id) {
		carInfoDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		carInfoDao.sort(id, order);
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

	public QueryResult<CarInfo> listByDocTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CarInfo WHERE 1=1";
		hql += " AND docTypeId IN (SELECT id FROM DocType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CarInfo> qr = carInfoDao.list(qp);
		return qr;
	}

	public QueryResult<CarInfo> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM CarInfo WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<CarInfo> qr = carInfoDao.list4(qp);
		return qr;
	}



	public QueryResult<CarInfo> listAllInfor() {
		QueryPara qp = new QueryPara();
		//List<Object> args = new ArrayList<Object>();
		String hql = "FROM CarInfo WHERE 1=1";
		//hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		//args.add(orgId);
		//args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		//qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CarInfo> qr = carInfoDao.list4(qp);
		return qr;
	}

	public QueryResult<CarInfo> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM CarInfo WHERE 1=1 ";
		hql += " AND docTypeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<CarInfo> qr = carInfoDao.listNoTotal(qp);
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
