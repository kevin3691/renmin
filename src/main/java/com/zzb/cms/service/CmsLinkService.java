package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.CmsLinkDao;
import com.zzb.cms.entity.CmsLink;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

/**
 * 实体 链接 Service
 * 
 * @author 
 * @createdAt 2016年08月26日
 */
@Transactional
@Service("cmsLinkService")
public class CmsLinkService extends BaseService<CmsLink> {
	@Resource
	private CmsLinkDao cmsLinkDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CmsLink> list(HttpServletRequest request) {
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsLink WHERE 1=1";
		if (!colSym.equals("")) {
			hql += " AND colSym LIKE ?";
			args.add('%' + colSym + '%');
		}
		if (!colTitle.equals("")) {
			hql += " AND colTitle LIKE ?";
			args.add('%' + colTitle + '%');
		}
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CmsLink> qr = cmsLinkDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public CmsLink save(CmsLink link, HttpServletRequest request) {
		link.setRecordInfo(super.GenRecordInfo(link.getRecordInfo(), request));
		link = cmsLinkDao.save(link);
		return link;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CmsLink dtl(int id) {
		CmsLink link = cmsLinkDao.dtl(id);
		return link;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public Object dtl(HttpServletRequest request) {
		String colSym = request.getParameter("colSym") != null ? request
				.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request
				.getParameter("colTitle") : "";
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsLink WHERE 1=1";
		if (!colSym.equals("")) {
			hql += " AND colSym = ?";
			args.add(colSym);
		}
		if (!colTitle.equals("")) {
			hql += " AND colTitle = ?";
			args.add(colTitle);
		}
		Object obj = cmsLinkDao.uniqueResult(hql, args);
		return obj;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		cmsLinkDao.del(id);
	}

}
