package com.zzb.base.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.dao.BaseLogDao;
import com.zzb.base.entity.BaseLog;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;

@Transactional
@Service("baseLogService")
public class BaseLogService extends BaseService<BaseLog> {
	@Resource
	private BaseLogDao baseLogDao;

	public QueryResult<BaseLog> list(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String descr = request.getParameter("descr") != null ? request
				.getParameter("descr") : "";
		Date startAt = request.getParameter("startAt") != null ? DateUtils
				.parse(request.getParameter("startAt")) : DateUtils
				.parse("1900-01-01");
		Date endAt = request.getParameter("endAt") != null ? DateUtils
				.parse(request.getParameter("endAt")) : DateUtils
				.parse("1900-01-01");
		String personName = request.getParameter("personName") != null ? request
						.getParameter("personName").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseLog WHERE 1=1";
		if (!category.equals("")) {
			System.out.println("Category:"+category);
			hql += " AND category like ?";
			args.add('%' + category + '%');
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		if (!descr.equals("")) {
			hql += " AND descr like ?";
			args.add('%' + descr + '%');
		}
		if (startAt != null
				&& (startAt.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt >= ?";
			args.add(startAt);
		}
		if (endAt != null
				&& (startAt.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt <= ?";
			args.add(endAt);
		}
		if (!personName.equals("")) {
			hql += " AND createdByName like ?";
			args.add('%' + personName + '%');
		}
		qp.setHql(hql);
		qp.setArgs(args);
		return baseLogDao.list(qp);
	}

	public BaseLog save(BaseLog log, HttpServletRequest request) {
		log.setRecordInfo(super.GenRecordInfo(log.getRecordInfo(), request));
		log = baseLogDao.save(log);
		return log;
	}

	public BaseLog dtl(int id) {
		BaseLog log = baseLogDao.dtl(id);
		return log;
	}

	public void del(int id) {
		baseLogDao.del(id);
	}

	public void sort(int id, String order) {
		baseLogDao.sort(id, order);
	}

}
