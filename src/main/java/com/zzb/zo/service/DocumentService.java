/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.zo.dao.DocumentDao;
import com.zzb.zo.entity.Document;

/**
 * 组织机构 Service
 * 
 * 
 * @createdAt 2016年1月29日
 */
@Transactional
@Service("documentService")
public class DocumentService extends BaseService<Document> {
	@Resource
	private DocumentDao documentDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<Document> list(HttpServletRequest request) {
		int isPi = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int isDu = request.getParameter("isDu") != null
				&& !request.getParameter("isDu").equals("") ? Integer
				.valueOf(request.getParameter("isDu")) : -1;
		int isFinish = request.getParameter("isFinish") != null
				&& !request.getParameter("isFinish").equals("") ? Integer
				.valueOf(request.getParameter("isFinish")) : -1;
        String docTypeId = request.getParameter("docTypeId") != null ? request
                .getParameter("docTypeId") : "";
        String title = request.getParameter("title") != null ? request
                .getParameter("title") : "";

        String orgId = request.getParameter("orgId") != null ? request
                .getParameter("orgId") : "";

        String jbrId = request.getParameter("jbrId") != null ? request
                .getParameter("jbrId") : "";

        String sprId = request.getParameter("sprId") != null ? request
                .getParameter("sprId") : "";


		String lwbh = request.getParameter("lwbh") != null ? request
				.getParameter("lwbh") : "";
		String miji = request.getParameter("miji") != null ? request
				.getParameter("miji") : "";

		String starttime = request.getParameter("starttime") != null ? request
				.getParameter("starttime") : "";
		String finishtime = request.getParameter("finishtime") != null ? request
				.getParameter("finishtime") : "";

		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Document WHERE 1=1";
		if (!docTypeId.equals("") && !docTypeId.equals("0")) {
		    String tt = " (";
            String[] t = docTypeId.split(",");
            List<Integer> l = new ArrayList<>();
            for (int i = 0; i < t.length; i++) {
                String s = t[i];
                if(!s.equals("")){
                    tt += " docTypeId IN (SELECT id FROM DocType WHERE id IN ? OR baseTree.path LIKE ?) OR";
                    args.add(Integer.valueOf(s));
                    args.add('%' + "." + String.valueOf(s) + "." + '%');
                }
            }

            String sss = tt.substring(tt.length()-2,tt.length());
            if(sss.equals("OR")){
                tt = tt.substring(0,tt.length() - 3);
            }
            tt += ")";
            hql += " AND " + tt;
		}
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!colTitle.equals("")) {
			hql += " AND colTitle LIKE ?";
			args.add('%' + colTitle + '%');
		}
		if (!colSym.equals("")) {
			hql += " AND colSym LIKE ?";
			args.add('%' + colSym + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}

		if (!jbrId.equals("")) {
		    String[] t = jbrId.split(",");
		    List<Integer> l = new ArrayList<>();
		    for (String s : t){
		        if(!s.equals(""))
		            l.add(Integer.valueOf(s));
            }
			hql += " AND jbrId in ?";
			args.add(l);
		}

		if (!sprId.equals("")) {
            String[] t = orgId.split(",");
            List<Integer> l = new ArrayList<>();
            for (String s : t){
                if(!s.equals(""))
                    l.add(Integer.valueOf(s));
            }
            hql += " AND sprId in ?";
            args.add(l);
		}

        if (!orgId.equals("")) {
            String[] t = orgId.split(",");
            List<Integer> l = new ArrayList<>();
            for (String s : t){
                if(!s.equals(""))
                    l.add(Integer.valueOf(s));
            }
            hql += " AND orgId in ?";
            args.add(l);
        }

		if (!miji.equals("")) {
			hql += " AND miji LIKE ?";
			args.add('%' + miji + '%');
		}
		if (!lwbh.equals("")) {
			hql += " AND lwbh LIKE ?";
			args.add('%' + lwbh + '%');
		}

		if (!finishtime.equals("")) {
			hql += " AND date_format(lwsj,'%Y-%m-%d') <= ?";
			args.add(finishtime);
		}
		if (!starttime.equals("")) {
			hql += " AND date_format(lwsj,'%Y-%m-%d') >= ?";
			args.add(starttime);
		}


		if (isDu != -1) {
			hql += " AND isDu=?";
			args.add(isDu);
		}
		if (isPi != -1) {
			hql += " AND isPi=?";
			args.add(isPi);
		}
		if (isFinish != -1) {
			hql += " AND isFinish=?";
			args.add(isFinish);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Document> qr = documentDao.list(qp);
		return qr;
	}
	
	public QueryResult<Document> list4Du(HttpServletRequest request) {
		int type = request.getParameter("type") != null
				&& !request.getParameter("type").equals("") ? Integer
				.valueOf(request.getParameter("type")) : 0;
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Document WHERE 1=1";
		
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!colTitle.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + colTitle + '%');
		}
		if (!colSym.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + colSym + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Document> qr = documentDao.list(qp);
		return qr;
	}

	public Document save(Document doc, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		doc.setRecordInfo(super.GenRecordInfo(doc.getRecordInfo(),
				request));
		doc = documentDao.save(doc);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (doc.getLineNo() == 0) {
			doc.setLineNo(doc.getId());
			doc = documentDao.save(doc);
		}
		return doc;
	}

	public Document dtl(int id) {
		Document doc = documentDao.dtl(id);
		return doc;
	}

	public void del(int id) {
		documentDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		documentDao.sort(id, order);
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


	public int getDocCount(int flag) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM Document WHERE 1=1";
		if (flag == 1){
			hql += " AND isPi=? ";
			args.add(1);
		}
		if (flag == 2){
			hql += " AND isDu=? ";
			args.add(1);
		}
		if (flag == 3){
			hql += " AND isFinish=? ";
			args.add(1);
		}
		return (int) ((long) documentDao.uniqueResult(hql, args));
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

	public QueryResult<Document> listByDocTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Document WHERE 1=1";
		hql += " AND docTypeId IN (SELECT id FROM DocType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Document> qr = documentDao.list(qp);
		return qr;
	}

	public QueryResult<Document> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM Document WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<Document> qr = documentDao.list4(qp);
		return qr;
	}



	public QueryResult<Document> listAllUser() {
		QueryPara qp = new QueryPara();
		//List<Object> args = new ArrayList<Object>();
		String hql = "FROM Document WHERE 1=1";
		//hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		//args.add(orgId);
		//args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		//qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Document> qr = documentDao.list4(qp);
		return qr;
	}

	public QueryResult<Document> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM Document WHERE 1=1 ";
		hql += " AND docTypeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<Document> qr = documentDao.listNoTotal(qp);
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


	public QueryResult<WfInstance> getIns(int refNum,String applyTo) {
		List<Object> args = new ArrayList<Object>();
		QueryPara qp = new QueryPara();
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		hql += " AND applyTo=?";
		args.add(applyTo);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list4(qp);
		return qr;
	}

	public WfInstance getIns(int refNum,int stepId,String actorId,String applyTo) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND applyTo=?";
		args.add(applyTo);
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
