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
import com.zzb.zo.dao.DuBanDao;
import com.zzb.zo.entity.DuBan;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 组织机构 Service
 * 
 * 
 * @createdAt 2016年1月29日
 */
@Transactional
@Service("dubanService")
public class DuBanService extends BaseService<DuBan> {
	@Resource
	private DuBanDao dubanDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<DuBan> list(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int isDu = request.getParameter("isDu") != null
				&& !request.getParameter("isDu").equals("") ? Integer
				.valueOf(request.getParameter("isDu")) : -1;
		int isFinish = request.getParameter("isFinish") != null
				&& !request.getParameter("isFinish").equals("") ? Integer
				.valueOf(request.getParameter("isFinish")) : -1;
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : 0;
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String dubanren = request.getParameter("dubanren") != null ? request
				.getParameter("dubanren") : "";
		String fenguanlingdao = request.getParameter("fenguanlingdao") != null ? request
				.getParameter("fenguanlingdao") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String chengbanchushi = request.getParameter("chengbanchushi") != null ? request
				.getParameter("chengbanchushi") : "";
		String xiebanchushi = request.getParameter("xiebanchushi") != null ? request
				.getParameter("xiebanchushi") : "";
		String starttime = request.getParameter("starttime") != null ? request
				.getParameter("starttime") : "";
		String finishtime = request.getParameter("finishtime") != null ? request
				.getParameter("finishtime") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DuBan WHERE 1=1";

		if (!finishtime.equals("")) {
			hql += " AND date_format(finishtime,'%Y-%m-%d') <= ?";
			args.add(finishtime);
		}
		if (!starttime.equals("")) {
			hql += " AND date_format(starttime,'%Y-%m-%d') >= ?";
			args.add(starttime);
		}
		if (!dubanren.equals("")) {
			hql += " AND dubanren LIKE ?";
			args.add('%' + dubanren + '%');
		}
		if (!fenguanlingdao.equals("")) {
			hql += " AND fenguanlingdao LIKE ?";
			args.add('%' + fenguanlingdao + '%');
		}
		if (!colSym.equals("")) {
			hql += " AND colSym LIKE  ?";
			args.add('%' + colSym + '%');
		}
		if (!chengbanchushi.equals("")) {
			hql += " AND chengbanchushi LIKE ?";
			args.add('%' + chengbanchushi + '%');
		}
		if (!xiebanchushi.equals("")) {
			hql += " AND xiebanchushi LIKE ?";
			args.add("%" + xiebanchushi + ",%");
		}

		if (status > 0) {
			hql += " AND status=?";
			args.add(status);
		}

		if (!sym.equals("")) {
			hql += " AND sym LIKE ?";
			args.add('%' + sym + '%');
		}

		if (!type.equals("")) {
			hql += " AND type LIKE ?";
			args.add('%' + type + '%');
		}

		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}



		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list(qp);
		return qr;
	}



	public QueryResult<DuBan> list4chaoshi(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int isDu = request.getParameter("isDu") != null
				&& !request.getParameter("isDu").equals("") ? Integer
				.valueOf(request.getParameter("isDu")) : -1;
		int isFinish = request.getParameter("isFinish") != null
				&& !request.getParameter("isFinish").equals("") ? Integer
				.valueOf(request.getParameter("isFinish")) : -1;
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : 0;
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String dubanren = request.getParameter("dubanren") != null ? request
				.getParameter("dubanren") : "";
		String fenguanlingdao = request.getParameter("fenguanlingdao") != null ? request
				.getParameter("fenguanlingdao") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String chengbanchushi = request.getParameter("chengbanchushi") != null ? request
				.getParameter("chengbanchushi") : "";
		String xiebanchushi = request.getParameter("xiebanchushi") != null ? request
				.getParameter("xiebanchushi") : "";
		String starttime = request.getParameter("starttime") != null ? request
				.getParameter("starttime") : "";
		String finishtime = request.getParameter("finishtime") != null ? request
				.getParameter("finishtime") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DuBan WHERE 1=1";
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(now);
		hql += " AND date_format(finishtime,'%Y-%m-%d') >= ?";
		args.add(str);
		hql += " AND status = ?";
		args.add(1);


		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list(qp);
		return qr;
	}


	public QueryResult<DuBan> list4duban(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int isDu = request.getParameter("isDu") != null
				&& !request.getParameter("isDu").equals("") ? Integer
				.valueOf(request.getParameter("isDu")) : -1;
		int isFinish = request.getParameter("isFinish") != null
				&& !request.getParameter("isFinish").equals("") ? Integer
				.valueOf(request.getParameter("isFinish")) : -1;
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : 0;
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String dubanren = request.getParameter("dubanren") != null ? request
				.getParameter("dubanren") : "";
		String fenguanlingdao = request.getParameter("fenguanlingdao") != null ? request
				.getParameter("fenguanlingdao") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String chengbanchushi = request.getParameter("chengbanchushi") != null ? request
				.getParameter("chengbanchushi") : "";
		String xiebanchushi = request.getParameter("xiebanchushi") != null ? request
				.getParameter("xiebanchushi") : "";
		String starttime = request.getParameter("starttime") != null ? request
				.getParameter("starttime") : "";
		String finishtime = request.getParameter("finishtime") != null ? request
				.getParameter("finishtime") : "";


		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DuBan WHERE 1=1";
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(now);
		hql += " AND date_format(finishtime,'%Y-%m-%d') <= ?";
		args.add(str);
		hql += " AND status = ?";
		args.add(1);


		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list(qp);
		return qr;
	}

	public QueryResult<DuBan> list4sel(HttpServletRequest request) {

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DuBan WHERE 1=1";

		hql += " AND status LIKE ?";
		args.add("%空闲%");



		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list(qp);
		return qr;
	}
	


	public DuBan save(DuBan doc, HttpServletRequest request) {
		doc.setRecordInfo(super.GenRecordInfo(doc.getRecordInfo(), request));
		doc = dubanDao.save(doc);


		return doc;
	}

	public DuBan dtl(int id) {
		DuBan doc = dubanDao.dtl(id);
		return doc;
	}

	public void del(int id) {
		dubanDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		dubanDao.sort(id, order);
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



	public int checkExist(int refNum) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM DuBan WHERE 1=1";

		if (refNum > 0) {
			hql += " AND refNum=? ";
			args.add(refNum);
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

	public QueryResult<DuBan> listByDocTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DuBan WHERE 1=1";
		hql += " AND docTypeId IN (SELECT id FROM DocType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list(qp);
		return qr;
	}

	public QueryResult<DuBan> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM DuBan WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list4(qp);
		return qr;
	}



	public QueryResult<DuBan> listAllUser() {
		QueryPara qp = new QueryPara();
		//List<Object> args = new ArrayList<Object>();
		String hql = "FROM DuBan WHERE 1=1";
		//hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		//args.add(orgId);
		//args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		//qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DuBan> qr = dubanDao.list4(qp);
		return qr;
	}

	public QueryResult<DuBan> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM DuBan WHERE 1=1 ";
		hql += " AND docTypeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<DuBan> qr = dubanDao.listNoTotal(qp);
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
