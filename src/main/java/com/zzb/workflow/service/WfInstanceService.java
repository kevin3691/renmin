package com.zzb.workflow.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.entity.BaseUser;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.workflow.entity.WfInstance;

/**
 * 待办 Service
 * 
 * @author 
 * @createdAt 2016年04月08日
 */

@Transactional
@Service("wfInstanceService")
public class WfInstanceService extends BaseService<WfInstance> {
	@Resource
	private WfInstanceDao wfInstanceDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WfInstance> list(HttpServletRequest request) {
		int isActive = request.getParameter("isActive") != null ? Integer
				.valueOf(request.getParameter("isActive")) : 0;
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
		String actorId = request.getParameter("actorId") != null ? request
				.getParameter("actorId") : "";
		String yesno = request.getParameter("yesno") != null ? request
				.getParameter("yesno") : "";
		int createdby = request.getParameter("createdby") != null ? Integer
				.valueOf(request.getParameter("createdby")) : 0;

		int isGui = request.getParameter("isGui") != null ? Integer
				.valueOf(request.getParameter("isGui")) : -1;
		int isDu = request.getParameter("isDu") != null ? Integer
				.valueOf(request.getParameter("isDu")) : -1;

		int stepId = request.getParameter("stepId") != null ? Integer
				.valueOf(request.getParameter("stepId")) : 0;
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
		if (!applyTo.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		if (!actorId.equals("")) {
			hql += " AND actorId = ?";
			args.add(actorId);
		}
		if (!yesno.equals("")) {
			if(yesno.equals("no")){
				hql += " AND yesNo != ?";
				args.add("yes");
			}else {
				hql += " AND yesNo = ?";
				args.add("yes");
			}

		}
		if (refNum > 0) {
			hql += " AND refNum=?";
			args.add(refNum);
		}
		if (stepId > 0) {
			hql += " AND stepId=?";
			args.add(stepId);
		}
		if (isGui != -1) {
			hql += " AND isGui=?";
			args.add(isGui);
		}
		if (isDu != -1) {
			hql += " AND isDu=?";
			args.add(isDu);
		}
		if (createdby > 0) {
			hql += " AND recordInfo.createdByUser=?";
			args.add(createdby);
		}
		hql += " AND isActive=?";
		args.add(isActive);
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
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list(qp);
		return qr;
	}


	public QueryResult<WfInstance> list4(HttpServletRequest request) {
		int isActive = request.getParameter("isActive") != null ? Integer
				.valueOf(request.getParameter("isActive")) : 0;
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
		String actorId = request.getParameter("actorId") != null ? request
				.getParameter("actorId") : "";
		String yesno = request.getParameter("yesno") != null ? request
				.getParameter("yesno") : "";
		int createdby = request.getParameter("createdby") != null ? Integer
				.valueOf(request.getParameter("createdby")) : 0;

		int isGui = request.getParameter("isGui") != null ? Integer
				.valueOf(request.getParameter("isGui")) : -1;
		int isDu = request.getParameter("isDu") != null ? Integer
				.valueOf(request.getParameter("isDu")) : -1;

		int stepId = request.getParameter("stepId") != null ? Integer
				.valueOf(request.getParameter("stepId")) : 0;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		Map<String, Object> alias = new HashMap<String, Object>();

		String hql = "FROM WfInstance as a WHERE 1=1";
		if (!category.equals("")) {
			if (category.indexOf(",") >= 0) {
				String[] categorys = category.split(",");
				hql += " AND a.category IN (:categorys)";
				alias.put("categorys", categorys);
			} else {
				hql += " AND a.category LIKE ?";
				args.add('%' + category + '%');
			}
		}
		if (!applyTo.equals("")) {
			hql += " AND a.applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		if (!actorId.equals("")) {
			hql += " AND a.actorId = ?";
			args.add(actorId);
		}
		if (!yesno.equals("")) {
			if(yesno.equals("no")){
				hql += " AND a.yesNo != ?";
				args.add("yes");
			}else {
				hql += " AND a.yesNo = ?";
				args.add("yes");
			}

		}
		if (refNum > 0) {
			hql += " AND a.refNum=?";
			args.add(refNum);
		}
		if (stepId > 0) {
			hql += " AND a.stepId=?";
			args.add(stepId);
		}
		if (isGui != -1) {
			hql += " AND a.isGui=?";
			args.add(isGui);
		}
		if (isDu != -1) {
			hql += " AND a.isDu=?";
			args.add(isDu);
		}
		if (createdby > 0) {
			hql += " AND a.recordInfo.createdByUser=?";
			args.add(createdby);
		}
		hql += " AND a.isActive=?";
		args.add(isActive);
		if (!stepName.equals("")) {
			if (stepName.indexOf(",") >= 0) {
				String[] stepNames = stepName.split(",");
				hql += " AND a.stepName IN (:stepNames)";
				alias.put("stepNames", stepNames);
			} else {
				hql += " AND a.stepName LIKE ?";
				args.add('%' + stepName + '%');
			}
		}
		if (!actorName.equals("")) {
			hql += " AND a.actorName LIKE ?";
			args.add('%' + actorName + '%');
		}
		hql += " AND a.id in (select max(b.id) from WfInstance as b where 1=1";

		if (!category.equals("")) {
			if (category.indexOf(",") >= 0) {
				String[] categorys = category.split(",");
				hql += " AND b.category IN (:categorys)";
				alias.put("categorys", categorys);
			} else {
				hql += " AND b.category LIKE ?";
				args.add('%' + category + '%');
			}
		}
		if (!applyTo.equals("")) {
			hql += " AND b.applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		if (!actorId.equals("")) {
			hql += " AND b.actorId = ?";
			args.add(actorId);
		}
		if (!yesno.equals("")) {
			if(yesno.equals("no")){
				hql += " AND b.yesNo != ?";
				args.add("yes");
			}else {
				hql += " AND b.yesNo = ?";
				args.add("yes");
			}

		}
		if (refNum > 0) {
			hql += " AND b.refNum=?";
			args.add(refNum);
		}
		if (stepId > 0) {
			hql += " AND b.stepId=?";
			args.add(stepId);
		}
		if (isGui != -1) {
			hql += " AND b.isGui=?";
			args.add(isGui);
		}
		if (isDu != -1) {
			hql += " AND b.isDu=?";
			args.add(isDu);
		}
		if (createdby > 0) {
			hql += " AND b.recordInfo.createdByUser=?";
			args.add(createdby);
		}
		hql += " AND b.isActive=?";
		args.add(isActive);
		if (!stepName.equals("")) {
			if (stepName.indexOf(",") >= 0) {
				String[] stepNames = stepName.split(",");
				hql += " AND b.stepName IN (:stepNames)";
				alias.put("stepNames", stepNames);
			} else {
				hql += " AND b.stepName LIKE ?";
				args.add('%' + stepName + '%');
			}
		}
		if (!actorName.equals("")) {
			hql += " AND b.actorName LIKE ?";
			args.add('%' + actorName + '%');
		}
		hql += " group by b.refNum)";
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list(qp);
		return qr;
	}


    public QueryResult<WfInstance> listByDocId(int docId,String applyTo) {

        QueryPara qp = new QueryPara();
        List<Object> args = new ArrayList<Object>();
        Map<String, Object> alias = new HashMap<String, Object>();

        String hql = "FROM WfInstance WHERE 1=1";

		hql += " AND refNum=?";
		args.add(docId);

		hql += " AND applyTo=?";
		args.add(applyTo);
        hql += " AND isActive=?";
        args.add(5);

        qp.setArgs(args);
        qp.setHql(hql);
        QueryResult<WfInstance> qr = wfInstanceDao.list(qp);
        return qr;
    }


	public QueryResult<WfInstance> listDuInfo(int docId,int isActive) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		Map<String, Object> alias = new HashMap<String, Object>();

		String hql = "FROM WfInstance WHERE 1=1";

		hql += " AND refNum=?";
		args.add(docId);
		hql += " AND isActive=?";
		args.add(isActive);
		qp.setAlias(alias);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list4(qp);
		return qr;
	}


	public QueryResult<WfInstance> listDuInfoByParent(int parentId,int isActive) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		Map<String, Object> alias = new HashMap<String, Object>();

		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND parentId=?";
		args.add(parentId);
		hql += " AND isActive=?";
		args.add(isActive);
		qp.setAlias(alias);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list4(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public WfInstance save(WfInstance ins, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		ins.setRecordInfo(super.GenRecordInfo(ins.getRecordInfo(),
						request));
		ins = wfInstanceDao.save(ins);
		return ins;
	}

	/**
	 * 初始化
	 * 
	 * @param request
	 * @return
	 */
	public WfInstance initEntity(HttpServletRequest request) {
		org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
		BaseUser user = new BaseUser();
		if (subject != null && subject.getSession() != null) {
			user = (BaseUser) subject.getSession().getAttribute("baseUser");
		}
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		int stepId = request.getParameter("stepId") != null ? Integer
				.valueOf(request.getParameter("stepId")) : 0;
		String stepName = request.getParameter("stepName") != null ? request
				.getParameter("stepName").toString() : "";
		int nextStepId = request.getParameter("nextStepId") != null ? Integer
				.valueOf(request.getParameter("nextStepId")) : 0;
		String nextStepName = request.getParameter("nextStepName") != null ? request
				.getParameter("nextStepName").toString() : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title").toString() : "";
		String descr = request.getParameter("descr") != null ? request
				.getParameter("descr").toString() : "";
		String actorId = request.getParameter("actorId") != null ? request
				.getParameter("actorId").toString() : String.valueOf(user
				.getBasePersonId());
		String actorName = request.getParameter("actorName") != null ? request
				.getParameter("actorName").toString() : user
				.getBasePersonName();
		Date actAt = request.getParameter("actAt") != null ? DateUtils
				.parse(request.getParameter("actAt")) : new Date();
		String yesNo = request.getParameter("yesNo") != null ? request
				.getParameter("yesNo").toString() : "";
		String actUrl = request.getParameter("actUrl") != null ? request
				.getParameter("actUrl").toString() : "";
		String listUrl = request.getParameter("listUrl") != null ? request
				.getParameter("listUrl").toString() : "";
		String dtlUrl = request.getParameter("dtlUrl") != null ? request
				.getParameter("dtlUrl").toString() : "";
		String okUrl = request.getParameter("okUrl") != null ? request
				.getParameter("okUrl").toString() : "";
		WfInstance ins = new WfInstance();
		ins.setCategory(category);
		ins.setApplyTo(applyTo);
		ins.setRefNum(refNum);
		ins.setStepId(stepId);
		ins.setStepName(stepName);
		ins.setNextStepId(nextStepId);
		ins.setNextStepName(nextStepName);
		ins.setTitle(title);
		ins.setDescr(descr);
		ins.setActorId(actorId);
		ins.setActorName(actorName);
		ins.setActAt(actAt);
		ins.setYesNo(yesNo);
		ins.setActUrl(actUrl);
		ins.setListUrl(listUrl);
		ins.setDtlUrl(dtlUrl);
		ins.setOkUrl(okUrl);
		return ins;
	}

	/**
	 * 执行当前环节
	 * 
	 * @param request
	 * @return
	 */
	public WfInstance actCurStep(HttpServletRequest request) {
		WfInstance ins = initEntity(request);
		// 自动完成RecordInfo数据设置
		ins.setRecordInfo(super.GenRecordInfo(ins.getRecordInfo(),
								request));
		ins = wfInstanceDao.save(ins);
		int updateStts = request.getParameter("updateStts")!=null?Integer.valueOf(request.getParameter("updateStts")):1;
		if(updateStts==1)
		{
			updateStts(ins.getApplyTo(), ins.getRefNum(), ins.getNextStepName());
		}
		return ins;
	}

	/**
	 * 更新主表状态
	 * 
	 * @param
	 * @return
	 */
	public void updateStts(String applyTo, int refNum, String stts) {
		String hql = "UPDATE " + applyTo + " SET stts='" + stts + "' WHERE id="
				+ refNum;
		wfInstanceDao.executeUpdate(hql);
	}

	/**
	 * 详细
	 * 
	 * @param
	 * @return
	 */
	public WfInstance dtl(int id) {
		WfInstance instance = wfInstanceDao.dtl(id);
		return instance;
	}

    public WfInstance getIns(int refNum,String applyTo) {
        List<Object> args = new ArrayList<Object>();
        String hql = "FROM WfInstance WHERE 1=1";
        hql += " AND refNum=?";
        args.add(refNum);
        hql += " AND applyTo=?";
        args.add(applyTo);
        WfInstance ins = wfInstanceDao.dtl(hql, args);
        return ins;
    }

    public WfInstance getLastIns(int refNum) {
        QueryPara qp = new QueryPara();
        List<Object> args = new ArrayList<Object>();
        String hql = "FROM WfInstance WHERE 1=1";
        hql += " AND refNum=?";
        args.add(refNum);
        qp.setHql(hql);
        qp.setArgs(args);
        QueryResult<WfInstance> rslt = wfInstanceDao.list4(qp);
        if (rslt.getRows().size() > 0) {
            return rslt.getRows().get(rslt.getRows().size() -1);
        } else {
            return null;
        }
    }
	
	/**
	 * 删除
	 * 
	 * @param
	 * @return
	 */
	public void del(int id) {
		wfInstanceDao.del(id);
	}

	/**
	 * 添加待办
	 * 
	 * @param request
	 * @return
	 */
	public boolean addWfInstance(HttpServletRequest request) {
		String applyto = request.getParameter("applyto") != null ? request
				.getParameter("applyto") : "";
		int refnum = request.getParameter("refnum") != null ? Integer
				.valueOf(request.getParameter("refnum")) : 0;
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		int stepid = request.getParameter("stepid") != null ? Integer
				.valueOf(request.getParameter("stepid")) : 0;
		String stepname = request.getParameter("stepname") != null ? request
				.getParameter("stepname") : "";
		String actorid = request.getParameter("actorid") != null ? request
				.getParameter("actorid") : "";
		String actorname = request.getParameter("actorname") != null ? request
				.getParameter("actorname") : "";
		String yesno = request.getParameter("yesno") != null ? request
				.getParameter("yesno") : "";
		String descr = request.getParameter("descr") != null ? request
				.getParameter("descr") : "";
		Date now = new Date();
		WfInstance instance = new WfInstance();
		instance.setCategory(category);
		instance.setApplyTo(applyto);
		instance.setRefNum(refnum);
		instance.setStepId(stepid);
		instance.setStepName(stepname);
		instance.setActorId(actorid);
		instance.setActorName(actorname);
		instance.setYesNo(yesno);
		instance.setActAt(now);
		instance.setDescr(descr);
		// 自动完成RecordInfo数据设置
		instance.setRecordInfo(super.GenRecordInfo(instance.getRecordInfo(),
								request));
		wfInstanceDao.save(instance);
		return true;
	}

}
