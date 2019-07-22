package com.zzb.comm.service;

import java.io.File;
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

import com.zzb.comm.dao.CommNotiDao;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.entity.CommNoti;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;

@Transactional
@Service("commNotiService")
public class CommNotiService extends BaseService<CommNoti> {
	@Resource
	private CommNotiDao commNotiDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommNoti> list(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String source = request.getParameter("source") != null ? request
				.getParameter("source").toString() : "";
		String stts = request.getParameter("stts") != null ? request
				.getParameter("stts").toString() : "";
		Date start = request.getParameter("start") != null ? DateUtils
				.parse(request.getParameter("start")) : DateUtils
				.parse("1900-01-01");
		Date end = request.getParameter("end") != null ? DateUtils
				.parse(request.getParameter("end")) : DateUtils
				.parse("1900-01-01");
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		int isDel = request.getParameter("isDel") != null ? Integer
				.valueOf(request.getParameter("isDel")) : 0;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommNoti WHERE 1=1";
		org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
		if (subject != null && subject.getSession() != null) {
			System.out.println((int) subject.getSession().getAttribute(
					"basePersonId"));
			hql += " AND targetPersonId =?";
			args.add((int) subject.getSession().getAttribute("basePersonId"));
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		if (!source.equals("")) {
			hql += " AND source like ?";
			args.add('%' + source + '%');
		}
		if (!stts.equals("")) {
			hql += " AND stts =?";
			args.add(stts);
		}
		if (start != null
				&& (start.getTime() > DateUtils.parse("1900-01-01")
						.getTime())) {
			hql += " AND recordInfo.createdAt >=?";
			args.add(start);
		}
		if (end != null
				&& (end.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt <=?";
			args.add(end);
		}
		if (refNum != 0) {
			hql += " AND refNum = ?";
			args.add(refNum);
		}
		if (isDel != -1) {
			hql += " AND isDel = ?";
			args.add(isDel);
		}
		if (!category.equals("")) {
			hql += " AND category like ?";
			args.add('%' + category + '%');
		}

		qp.setHql(hql);
		qp.setArgs(args);
		return commNotiDao.list(qp);
	}

	/**
	 * 保存
	 * 
	 * @param CommNoti
	 * @param request
	 * @return
	 */
	public CommNoti save(CommNoti noti, HttpServletRequest request) {

		noti = commNotiDao.save(noti);
		return noti;
	}

	/**
	 * 保存 ps.不加验证
	 * 
	 * @param request
	 * @return
	 */
	public CommNoti save1(CommNoti noti) {

		noti = commNotiDao.save(noti);
		return noti;
	}

	/**
	 * 保存
	 * 
	 * @param request
	 * @return
	 */
	public CommNoti save(CommNoti noti) {
		int refnum = noti.getRefnum();
		String source = noti.getSource();
		CommNoti commNoti = new CommNoti();
		List<Object> args = new ArrayList<Object>();
		String hql = "From CommNoti where 1=1";
		if (refnum != 0) {
			hql += " And refnum =?";
			args.add(refnum);
		}
		if (!source.equals("")) {
			hql += " And source =?";
			args.add(source);
		}
		commNoti = commNotiDao.dtl(hql, args);
		if (commNoti != null) {
			//noti.setId(commNoti.getId());
			commNotiDao.del(commNoti);
		}
		noti = commNotiDao.save(noti);
		return noti;
	}

	public CommNoti dtl(int id) {
		CommNoti noti = commNotiDao.dtl(id);
		return noti;
	}

	public void del(int id) {
		CommNoti noti = commNotiDao.dtl(id);

		commNotiDao.del(id);
	}

	public CommNoti saveStts(CommNoti noti, HttpServletRequest request) {
		int id = Integer.valueOf(request.getParameter("id"));
		String stts = request.getParameter("stts") != null ? request
				.getParameter("stts") : "";
		noti = commNotiDao.dtl(id);
		if (noti != null) {
			noti.setStts(stts);
			if (stts.equals("已读")) {
				Date ct = new Date();
				noti.setReceiveAt(ct);
			}
			noti = commNotiDao.save(noti);
		}
		return noti;
	}

	public void delBy(CommNoti noti, HttpServletRequest request) {
		int id = Integer.valueOf(request.getParameter("id"));
		noti = commNotiDao.dtl(id);
		if (noti != null) {
			noti.setIsDel(1);
			noti = commNotiDao.save(noti);
		}

	}
}
