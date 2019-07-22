package com.zzb.comm.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.comm.dao.CommAttachmentDao;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;

@Transactional
@Service("commAttachmentService")
public class CommAttachmentService extends BaseService<CommAttachment> {
	@Resource
	private CommAttachmentDao commattachmentDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommAttachment> list(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		int sizeFrom = request.getParameter("sizeFrom") != null ? Integer
				.valueOf(request.getParameter("sizeFrom")) : 0;
		int sizeTo = request.getParameter("sizeTo") != null ? Integer
				.valueOf(request.getParameter("sizeTo")) : 0;
		Date createdAtFrom = request.getParameter("createdAtFrom") != null ? DateUtils
				.parse(request.getParameter("createdAtFrom")) : DateUtils
				.parse("1900-01-01");
		Date createdAtTo = request.getParameter("createdAtTo") != null ? DateUtils
				.parse(request.getParameter("createdAtTo")) : DateUtils
				.parse("1900-01-01");
		String personName = request.getParameter("personName") != null ? request
				.getParameter("personName").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommAttachment WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo like ?";
			args.add('%' + applyTo + '%');
		}
		if (refNum != 0) {
			hql += " AND refNum = ?";
			args.add(refNum);
		}
		if (!category.equals("")) {
			hql += " AND category like ?";
			args.add('%' + category + '%');
		}
		if (sizeFrom > 0) {
			hql += " AND fileSize >=";
			args.add(sizeFrom);
		}
		if (sizeTo > 0) {
			hql += " AND fileSize <=";
			args.add(sizeTo);
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		if (createdAtFrom != null
				&& (createdAtFrom.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt >= ?";
			args.add(createdAtFrom);
		}
		if (createdAtTo != null
				&& (createdAtTo.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt <= ?";
			args.add(createdAtTo);
		}
		if (!personName.equals("")) {
			hql += " AND recordInfo.createdByName like ?";
			args.add('%' + personName + '%');
		}
		System.out.println("category:" + category);
		System.out.println("refNum:" + refNum);
		System.out.println("applyTo:" + applyTo);
		qp.setHql(hql);
		qp.setArgs(args);
		return commattachmentDao.list(qp);
	}

	public QueryResult<CommAttachment> list4(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : -1;
		int sizeFrom = request.getParameter("sizeFrom") != null ? Integer
				.valueOf(request.getParameter("sizeFrom")) : 0;
		int sizeTo = request.getParameter("sizeTo") != null ? Integer
				.valueOf(request.getParameter("sizeTo")) : 0;
		Date createdAtFrom = request.getParameter("createdAtFrom") != null ? DateUtils
				.parse(request.getParameter("createdAtFrom")) : DateUtils
				.parse("1900-01-01");
		Date createdAtTo = request.getParameter("createdAtTo") != null ? DateUtils
				.parse(request.getParameter("createdAtTo")) : DateUtils
				.parse("1900-01-01");
		String personName = request.getParameter("personName") != null ? request
				.getParameter("personName").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommAttachment WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo like ?";
			args.add('%' + applyTo + '%');
		}
		hql += " AND refNum = ?";
		args.add(refNum);
		if (!category.equals("")) {
			hql += " AND category like ?";
			args.add('%' + category + '%');
		}
		if (sizeFrom > 0) {
			hql += " AND fileSize >=";
			args.add(sizeFrom);
		}
		if (sizeTo > 0) {
			hql += " AND fileSize <=";
			args.add(sizeTo);
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		if (createdAtFrom != null
				&& (createdAtFrom.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt >= ?";
			args.add(createdAtFrom);
		}
		if (createdAtTo != null
				&& (createdAtTo.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt <= ?";
			args.add(createdAtTo);
		}
		if (!personName.equals("")) {
			hql += " AND recordInfo.createdByName like ?";
			args.add('%' + personName + '%');
		}
		System.out.println("category:" + category);
		System.out.println("refNum:" + refNum);
		System.out.println("applyTo:" + applyTo);
		qp.setHql(hql);
		qp.setArgs(args);
		return commattachmentDao.list(qp);
	}

	public QueryResult<CommAttachment> list5(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : -1;
		int sizeFrom = request.getParameter("sizeFrom") != null ? Integer
				.valueOf(request.getParameter("sizeFrom")) : 0;
		int sizeTo = request.getParameter("sizeTo") != null ? Integer
				.valueOf(request.getParameter("sizeTo")) : 0;
		Date createdAtFrom = request.getParameter("createdAtFrom") != null ? DateUtils
				.parse(request.getParameter("createdAtFrom")) : DateUtils
				.parse("1900-01-01");
		Date createdAtTo = request.getParameter("createdAtTo") != null ? DateUtils
				.parse(request.getParameter("createdAtTo")) : DateUtils
				.parse("1900-01-01");
		String personName = request.getParameter("personName") != null ? request
				.getParameter("personName").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommAttachment WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo like ?";
			args.add('%' + applyTo + '%');
		}
		if(refNum == 0)
			refNum = -222;
		hql += " AND refNum = ?";
		args.add(refNum);
		if (!category.equals("")) {
			hql += " AND category like ?";
			args.add('%' + category + '%');
		}
		if (sizeFrom > 0) {
			hql += " AND fileSize >=";
			args.add(sizeFrom);
		}
		if (sizeTo > 0) {
			hql += " AND fileSize <=";
			args.add(sizeTo);
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		if (createdAtFrom != null
				&& (createdAtFrom.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt >= ?";
			args.add(createdAtFrom);
		}
		if (createdAtTo != null
				&& (createdAtTo.getTime() > DateUtils.parse("1900-01-01").getTime())) {
			hql += " AND recordInfo.createdAt <= ?";
			args.add(createdAtTo);
		}
		if (!personName.equals("")) {
			hql += " AND recordInfo.createdByName like ?";
			args.add('%' + personName + '%');
		}
		System.out.println("category:" + category);
		System.out.println("refNum:" + refNum);
		System.out.println("applyTo:" + applyTo);
		qp.setHql(hql);
		qp.setArgs(args);
		return commattachmentDao.list(qp);
	}

	/**
	 * 保存
	 * 
	 * @param attachment
	 * @param request
	 * @return
	 */
	public CommAttachment save(CommAttachment attachment,
			HttpServletRequest request) {
		attachment.setRecordInfo(super.GenRecordInfo(
				attachment.getRecordInfo(), request));
		attachment = commattachmentDao.save(attachment);
		return attachment;
	}

	public CommAttachment dtl(int id) {
		CommAttachment attachment = commattachmentDao.dtl(id);
		return attachment;
	}

	public CommAttachment dtlBy(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommAttachment WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo like ?";
			args.add('%' + applyTo + '%');
		}
		if (refNum != 0) {
			hql += " AND refNum = ?";
			args.add(refNum);
		}
		if (!category.equals("")) {
			hql += " AND category like ?";
			args.add('%' + category + '%');
		}
		if (!title.equals("")) {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		hql += " ORDER BY id DESC";
		return commattachmentDao.dtl(hql, args);
	}

	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		CommAttachment att = commattachmentDao.dtl(id);
		File file = new File(att.getFilePath());
		if (file.exists()) {
			file.delete();
		}
		commattachmentDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		commattachmentDao.sort(id, order);
	}

	/**
	 * 修改refNum
	 * 
	 * @param request
	 * @return
	 */
	public boolean updateRefNumById(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommAttachment WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		hql += " AND refNum = ?";
		args.add(refNum);
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<CommAttachment> qr = commattachmentDao.list(qp);
		List<CommAttachment> att = new ArrayList<CommAttachment>();
		att = qr.getRows();
		for (CommAttachment item : att) {
			/* System.out.println(item.getId()); */
			String updateHql = "UPDATE CommAttachment SET refNum=? WHERE id=?";
			List<Object> updateArgs = new ArrayList<Object>();
			updateArgs.add(id);
			updateArgs.add(item.getId());
			commattachmentDao.executeUpdate(updateHql, updateArgs);
		}
		return true;
	}
	
	
	public boolean updateRefNumByUUID(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommAttachment WHERE 1=1 AND refNum=0";
		if (!applyTo.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}

		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<CommAttachment> qr = commattachmentDao.list(qp);
		List<CommAttachment> att = new ArrayList<CommAttachment>();
		att = qr.getRows();
		for (CommAttachment item : att) {
			/* System.out.println(item.getId()); */
			String updateHql = "UPDATE CommAttachment SET refNum=?,Category=? WHERE id=?";
			List<Object> updateArgs = new ArrayList<Object>();
			updateArgs.add(refNum);
			updateArgs.add(category);
			updateArgs.add(item.getId());
			commattachmentDao.executeUpdate(updateHql, updateArgs);
		}
		return true;
	}

}
