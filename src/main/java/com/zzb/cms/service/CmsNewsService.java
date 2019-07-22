package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.CmsNewsDao;
import com.zzb.cms.entity.CmsNews;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;

/**
 * 实体 新闻 Service
 * 
 * @author 
 * @createdAt 2016年08月26日
 */
@Transactional
@Service("cmsNewsService")
public class CmsNewsService extends BaseService<CmsNews> {

	@Resource
	private CmsNewsDao cmsNewsDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CmsNews> list(HttpServletRequest request) {
		String template = request.getParameter("template") != null ? request.getParameter("template") : "";
		String colSym = request.getParameter("colSym") != null ? request.getParameter("colSym") : "";
		String colTitle = request.getParameter("colTitle") != null ? request.getParameter("colTitle") : "";
		String title = request.getParameter("title") != null ? request.getParameter("title") : "";
		String source = request.getParameter("source") != null ? request.getParameter("source") : "";
		String author = request.getParameter("author") != null ? request.getParameter("author") : "";
		String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
		String summary = request.getParameter("summary") != null ? request.getParameter("summary") : "";
		String content = request.getParameter("content") != null ? request.getParameter("content") : "";
		String publishStartAt = request.getParameter("publishStartAt") != null ? request.getParameter("publishStartAt")
				: "";
		String publishEndAt = request.getParameter("publishEndAt") != null ? request.getParameter("publishEndAt") : "";
		String stts = request.getParameter("stts") != null ? request.getParameter("stts") : "";
		String createdByName = request.getParameter("createdByName") != null ? request.getParameter("createdByName")
				: "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsNews WHERE 1=1";
		if (!template.equals("")) {
			//查询多个模板
			if(template.indexOf(",")>=0)
			{
				String[] ar = template.split(",");
				String twc = "";
				for(String s:ar)
				{
					if(twc=="")
					{
						twc += " template LIKE ?";
						args.add('%' + s + '%');	
					}
					else
					{
						twc += " OR template LIKE ?";
						args.add('%' + s + '%');
					}
				}
				hql += " AND ("+twc+")";
			}
			else
			{
				hql += " AND template LIKE ?";
				args.add('%' + template + '%');	
			}
		}
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
		if (!source.equals("")) {
			hql += " AND source LIKE ?";
			args.add('%' + source + '%');
		}
		if (!author.equals("")) {
			hql += " AND author LIKE ?";
			args.add('%' + author + '%');
		}
		if (!keyword.equals("")) {
			hql += " AND keyword LIKE ?";
			args.add('%' + keyword + '%');
		}
		if (!summary.equals("")) {
			hql += " AND summary LIKE ?";
			args.add('%' + summary + '%');
		}
		if (!content.equals("")) {
			hql += " AND content LIKE ?";
			args.add('%' + content + '%');
		}
		if (!stts.equals("")) {
			hql += " AND stts =?";
			args.add(stts);
		}
		if (!publishStartAt.equals("")) {
			hql += "AND publishAt >= ?";
			Date pat = DateUtils.parse(publishStartAt, DateUtils.patterns[1]);
			args.add(pat);
		}
		if (!publishEndAt.equals("")) {
			hql += "AND publishAt <=?";
			Date pat = DateUtils.parse(publishStartAt, DateUtils.patterns[1]);
			args.add(pat);
		}
		if (!createdByName.equals("")) {
			hql += " AND recordInfo.createdByName LIKE ?";
			args.add('%' + createdByName + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CmsNews> qr = cmsNewsDao.list(qp);
		return qr;
	}

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CmsNews> getTopNews(int num, String colSym) {
		
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsNews WHERE 1=1";
		
		if (!colSym.equals("")) {
			hql += " AND colSym LIKE ?";
			args.add('%' + colSym + '%');
		}
		if (num > 0){
			qp.setPageSize(num);
			qp.setPageIndex(1);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		qp.setOrderBy("lineno");
		qp.setOrderDirection("desc");
		QueryResult<CmsNews> qr = cmsNewsDao.list(qp);
		return qr;
	}
	
	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public CmsNews save(CmsNews news, HttpServletRequest request) {
		news.setRecordInfo(super.GenRecordInfo(news.getRecordInfo(), request));
		news = cmsNewsDao.save(news);
		return news;
	}
	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CmsNews> listbytitle(String title,int page,int rows) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsNews WHERE 1=1";
		
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		qp.setPageIndex(page);
		qp.setPageSize(rows);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CmsNews> qr = cmsNewsDao.list(qp);
		return qr;
	}
	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CmsNews dtl(int id) {
		CmsNews news = cmsNewsDao.dtl(id);
		return news;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CmsNews dtl(String colSym, String colTitle) {
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsNews WHERE 1=1";
		if (!colSym.equals("")) {
			hql += " AND colSym = ?";
			args.add(colSym);
		}
		if (!colTitle.equals("")) {
			hql += " AND colTitle = ?";
			args.add(colTitle);
		}
		CmsNews news = new CmsNews();
		Object object = cmsNewsDao.uniqueResult(hql, args);
		
		if (object != null) {
			news = (CmsNews) object;
		}

		return news;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		cmsNewsDao.del(id);
	}

	/**
	 * 根据请求参数更新新闻
	 * 
	 * @param request
	 * @return
	 */
	public CmsNews update(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request.getParameter("id")) : 0;
		String stts = request.getParameter("stts") != null ? request.getParameter("stts").toString() : "";
		int top = request.getParameter("top") != null ? Integer.valueOf(request.getParameter("top")) : -1;
		CmsNews news = cmsNewsDao.dtl(id);

		if (!stts.equals("")) {
			news.setStts(stts);
		}
		if (top != -1) {
			if (top != 0) {
				top = genTopNo(news.getColSym());
			}
			news.setTop(top);
		}
		news = cmsNewsDao.save(news);
		return news;
	}

	/**
	 * 排序 按栏目名称
	 * 
	 * @param id
	 * @param colSym
	 * @param order
	 */
	public void sort(int id, String colSym, String order) {
		String wc = " AND colSym = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(colSym);
		cmsNewsDao.sort(id, order, wc, args);
	}

	/**
	 * 生成最大置顶数
	 * 
	 * @param refnum
	 * @return
	 */
	public int genTopNo(String colSym) {
		String hql = "SELECT MAX(top) FROM CmsNews WHERE 1=1 AND colSym =?";
		List<Object> args = new ArrayList<Object>();
		args.add(colSym);
		int no = (int) cmsNewsDao.uniqueResult(hql, args);
		return no + 1;
	}

}
