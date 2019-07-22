package com.zzb.workflow.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfPrintHistoryDao;
import com.zzb.workflow.entity.WfPrintHistory;

/**
 * Service 打印记录
 * 
 * 
 * @createdAt 2016年08月01日
 */

@Transactional
@Service("wfPrintHistoryService")
public class WfPrintHistoryService extends BaseService<WfPrintHistory> {
	@Resource
	private WfPrintHistoryDao wfPrintHistoryDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WfPrintHistory> list(HttpServletRequest request) {
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();

		String hql = "FROM WfPrintHistory WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo = ?";
			args.add(applyTo);
		}
		if (refNum > 0) {
			hql += " AND refNum = ?";
			args.add(refNum);
		}
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfPrintHistory> qr = wfPrintHistoryDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public WfPrintHistory save(WfPrintHistory history,
			HttpServletRequest request) {
		history = wfPrintHistoryDao.save(history);
		return history;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public WfPrintHistory dtl(int id) {
		WfPrintHistory history = wfPrintHistoryDao.dtl(id);
		return history;
	}
	
	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public Object dtl(HttpServletRequest request) {
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WfPrintHistory WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		if (refNum != 0) {
			hql += " AND refNum = ?";
			args.add(refNum);
		}
		if (!category.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + category + '%');
		}
		Object obj = wfPrintHistoryDao.uniqueResult(hql, args);
		return obj;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		wfPrintHistoryDao.del(id);
	}

	/**
	 * 生成打印历史
	 * 
	 * @param request
	 * @return
	 */
	public WfPrintHistory genHistory(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		int pages = request.getParameter("pages") != null ? Integer
				.valueOf(request.getParameter("pages")) : 0;
		String html = request.getParameter("html") != null ? request
				.getParameter("html") : "";
		String descr = request.getParameter("descr") != null ? request
				.getParameter("descr") : "";
		WfPrintHistory history = new WfPrintHistory();
		history.setCategory(category);
		history.setApplyTo(applyTo);
		history.setRefNum(refNum);
		history.setTitle(title);
		history.setPages(pages);
		history.setHtml(html);
		history.setDescr(descr);
		history.setPrintAt(new Date());
		history.setRecordInfo(super.GenRecordInfo(history.getRecordInfo(), request));
		org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
		String personName = subject.getSession().getAttribute("basePersonName")
				.toString();
		history.setPrintBy(personName);
		history = wfPrintHistoryDao.save(history);
		return history;
	}
	

	/**
	 * 检查是否重复
	 * 	
	 * @param request
	 * @return
	 */
	public int checkExist(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM WfPrintHistory WHERE 1=1";		
		if (category != "") {
			hql += " AND category=?";
			args.add(category);
		}
		if (applyTo != "") {
			hql += " AND applyTo=?";
			args.add(applyTo);
		}
		if (refNum != 0) {
			hql += " AND refNum =? ";
			args.add(refNum);
		}
		return (int) ((long) wfPrintHistoryDao.uniqueResult(hql, args));
	}	
	
}
