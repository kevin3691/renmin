package com.zzb.comm.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.comm.dao.CommActivityDao;
import com.zzb.comm.entity.CommActivity;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("commActivityService")
public class CommActivityService extends BaseService<CommActivity> {
	@Resource
	private CommActivityDao commActivityDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommActivity> list(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommActivity WHERE 1=1";
		System.out.println("CommActivityService applyTo:" + applyTo + "&");
		if (!applyTo.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		if (refNum > 0) {
			hql += " AND refNum = ?";
			args.add(refNum);
		}
		if (!category.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + category + '%');
		}
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CommActivity> qr = commActivityDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public CommActivity save(CommActivity activity, HttpServletRequest request) {
		activity = commActivityDao.save(activity);
		return activity;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CommActivity dtl(int id) {
		CommActivity news = commActivityDao.dtl(id);
		return news;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		commActivityDao.del(id);
	}

	/**
	 * 根据参数获取数据
	 * 
	 * @param refnum
	 * @return
	 */
	public boolean exByRefNumApplyToStts(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String stts = request.getParameter("stts") != null ? request
				.getParameter("stts").toString() : "";
		String yesNo = request.getParameter("yesNo") != null ? request
				.getParameter("yesNo").toString() : "";
		String hql = " FROM CommActivity WHERE refNum=? UPDATESTR";
		String updateStr = "";
		List<Object> args = new ArrayList<Object>();
		args.add(refNum);
		if (!applyTo.equals("")) {
			updateStr += " AND applyTo=?";
			args.add(applyTo);
		}
		if (!stts.equals("")) {
			updateStr += " AND stts=?";
			args.add(stts);
		}
		if (!category.equals("")) {
			updateStr += " AND category=?";
			args.add(category);
		}
		if (!yesNo.equals("")) {
			updateStr += " AND yesNo=?";
			args.add(yesNo);
		}		
		hql = hql.replace("UPDATESTR", updateStr);
		CommActivity activity = commActivityDao.dtl(hql, args);
		if (activity != null) {
			return false;
		}
		return true;
	}
	
	/**
	 * 根据参数获取数据
	 * 
	 * @param refnum
	 * @return
	 */
	public CommActivity dtlByPara(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String stts = request.getParameter("stts") != null ? request
				.getParameter("stts").toString() : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title").toString() : "";
		String hql = " FROM CommActivity WHERE refNum=? UPDATESTR";
		String updateStr = "";
		List<Object> args = new ArrayList<Object>();
		args.add(refNum);
		if (!applyTo.equals("")) {
			updateStr += " AND applyTo=?";
			args.add(applyTo);
		}
		if (!stts.equals("")) {
			updateStr += " AND stts=?";
			args.add(stts);
		}
		if (!category.equals("")) {
			updateStr += " AND category=?";
			args.add(category);
		}
		if (!title.equals("")) {
			updateStr += " AND title=?";
			args.add(title);
		}		
		hql = hql.replace("UPDATESTR", updateStr);
		CommActivity activity = commActivityDao.dtl(hql, args);		
		return activity;
	}

}
