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
import com.zzb.zo.dao.DocFileDao;
import com.zzb.zo.entity.DocFile;
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
@Service("docFileService")
public class DocFileService extends BaseService<DocFile> {
	@Resource
	private DocFileDao docFileDao;
	


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<DocFile> list(HttpServletRequest request) {
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
		String hql = "FROM DocFile WHERE 1=1";
		if (!docTypeId.equals("") && !docTypeId.equals("0")) {
		    String tt = " (";
            String[] t = docTypeId.split(",");
            List<Integer> l = new ArrayList<>();
            for (int i = 0; i < t.length; i++) {
                String s = t[i];
                if(!s.equals("")){
                    tt += " docTypeId IN (SELECT id FROM DocFileType WHERE id IN ? OR baseTree.path LIKE ?) OR";
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
		QueryResult<DocFile> qr = docFileDao.list(qp);
		return qr;
	}
	
	public QueryResult<DocFile> list4Du(HttpServletRequest request) {
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
		String hql = "FROM DocFile WHERE 1=1";
		
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
		QueryResult<DocFile> qr = docFileDao.list(qp);
		return qr;
	}

	public DocFile save(DocFile doc, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		doc.setRecordInfo(super.GenRecordInfo(doc.getRecordInfo(),
				request));
		doc = docFileDao.save(doc);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (doc.getLineNo() == 0) {
			doc.setLineNo(doc.getId());
			doc = docFileDao.save(doc);
		}
		return doc;
	}

	public DocFile dtl(int id) {
		DocFile doc = docFileDao.dtl(id);
		return doc;
	}

	public void del(int id) {
		docFileDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		docFileDao.sort(id, order);
	}



	public int getDocCount(int flag) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM DocFile WHERE 1=1";
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
		return (int) ((long) docFileDao.uniqueResult(hql, args));
	}
	

	public QueryResult<DocFile> listByDocTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DocFile WHERE 1=1";
		hql += " AND docTypeId IN (SELECT id FROM DocFileType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DocFile> qr = docFileDao.list(qp);
		return qr;
	}

	public QueryResult<DocFile> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM DocFile WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<DocFile> qr = docFileDao.list4(qp);
		return qr;
	}



	public QueryResult<DocFile> listAllUser() {
		QueryPara qp = new QueryPara();
		//List<Object> args = new ArrayList<Object>();
		String hql = "FROM DocFile WHERE 1=1";
		//hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		//args.add(orgId);
		//args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		//qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<DocFile> qr = docFileDao.list4(qp);
		return qr;
	}

	public QueryResult<DocFile> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM DocFile WHERE 1=1 ";
		hql += " AND docTypeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<DocFile> qr = docFileDao.listNoTotal(qp);
		return qr;
	}

}
