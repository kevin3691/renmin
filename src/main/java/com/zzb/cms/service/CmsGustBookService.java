package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.CmsGustBookDao;
import com.zzb.cms.entity.CmsGustBook;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
/**
 * 留言板
 * @author
 * @createdAt 2016年9月3日
 */
@Transactional
@Service("cmsGustBookService")
public class CmsGustBookService extends BaseService<CmsGustBook>{
	@Resource
	private CmsGustBookDao cmsGustBookDao;
	
	/**
	 * 查询
	 * @param request
	 * @return
	 */
	public QueryResult<CmsGustBook> list(HttpServletRequest request) {
		
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name") : "";
		String stts = request.getParameter("stts") != null ? request
						.getParameter("stts") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsGustBook WHERE 1=1";
		
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!name.equals("")) {
			hql += " AND name LIKE ?";
			args.add('%' + name + '%');
		}
		if (!stts.equals("")) {
			hql += " AND stts = ?";
			args.add(stts);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CmsGustBook> qr = cmsGustBookDao.list(qp);
		return qr;
	}
	/**
	 * 编辑
	 * 
	 * @param cmsGustBook
	 * @param request
	 * @return
	 */
	public CmsGustBook save(CmsGustBook cmsGustBook, HttpServletRequest request) {
		cmsGustBook.setRecordInfo(super.GenRecordInfo(cmsGustBook.getRecordInfo(), request));
		cmsGustBook = cmsGustBookDao.save(cmsGustBook);
		return cmsGustBook;
	}
	/**
	 * 详细
	 * @param id
	 * @return
	 */
	public CmsGustBook dtl(int id) {
		CmsGustBook cmsGustBook = cmsGustBookDao.dtl(id);
		return cmsGustBook;
	}
	
	
	/**
	 * 修改公开状态
	 * @param request
	 */
	public void updateDisplay(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
	
		int display = request.getParameter("display") != null ? Integer.valueOf(request
				.getParameter("display")) : -1;
		String hql = "UPDATE CmsGustBook SET display=? WHERE id=?";
		List<Object> args = new ArrayList<Object>();
		if (display != -1) {
			args.add(display);
		}
		if (id != 0) {
			args.add(id);
		}
		cmsGustBookDao.executeUpdate(hql, args);
	}

	
}
