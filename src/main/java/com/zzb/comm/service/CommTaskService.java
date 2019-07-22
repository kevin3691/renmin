package com.zzb.comm.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.comm.dao.CommTaskDao;
import com.zzb.comm.entity.CommTask;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("commTaskService")
public class CommTaskService extends BaseService<CommTask> {
	@Resource
	private CommTaskDao commTaskDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommTask> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		String title = request.getParameter("title") != null ? request
				.getParameter("title").toString() : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommTask WHERE 1=1 ";
		if (nodeid != -1) {
			hql += " AND baseTree.parentId=?";
			args.add(nodeid);
		}
		System.out.println("AAAAAAAAA"+nodeid);
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!category.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + category + '%');
		}
		if (!applyTo.equals("")) {
			hql += " AND applyTo LIKE ?";
			args.add('%' + applyTo + '%');
		}
		if (refNum > 0) {
			hql += " AND refNum=?";
			args.add(refNum);
		}
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<CommTask> qr = commTaskDao.list(qp);
		return qr;
	}

	/**
	 * 根据代号查询子节点列表
	 * 
	 * @see根据代号查出id,然后根据id列出其下所有记录
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommTask> listBySym(HttpServletRequest request) {
		String psym = request.getParameter("parentSym") != null ? request
				.getParameter("parentSym") : "";
		if (psym == "") {
			psym = request.getParameter("sym") != null ? request
					.getParameter("sym") : "";
		}
		String container = request.getParameter("container") != null ? request
				.getParameter("container") : "";
		int nodeid = request.getParameter("id") != null
				&& !request.getParameter("id").equals("") ? Integer
				.valueOf(request.getParameter("id")) : 0;
		QueryResult<CommTask> qr = new QueryResult<CommTask>();
		if (nodeid > 0) {
			QueryPara qp = new QueryPara(request);
			String hql = "FROM CommTask WHERE baseTree.parentId = ?";
			List<Object> args = new ArrayList<Object>();
			args.add(nodeid);
			qp.setHql(hql);
			qp.setArgs(args);
			qp.setOrderBy("lineNo");
			qp.setOrderDirection("ASC");
			qr = commTaskDao.list(qp);

		} else {
			String hql = "SELECT id FROM CommTask WHERE sym LIKE ?";
			List<Object> args = new ArrayList<Object>();
			args.add(psym);
			Object obj = commTaskDao.uniqueResult(hql, args);
			if (obj != null) {
				QueryPara qp = new QueryPara(request);
				hql = "FROM CommTask WHERE baseTree.parentId = ? OR baseTree.path LIKE ?";
				args = new ArrayList<Object>();
				args.add((int) obj);
				System.out
						.println("CommTask listBySym:FROM CommTask WHERE baseTree.parentId = "
								+ String.valueOf(obj)
								+ " OR baseTree.path LIKE "
								+ "%."
								+ String.valueOf(obj) + ".%" + "");
				args.add("%." + String.valueOf(obj) + ".%");
				qp.setHql(hql);
				qp.setArgs(args);
				qp.setOrderBy("lineNo");
				qp.setOrderDirection("ASC");
				qr = commTaskDao.list(qp);
			}

		}
		qr.setContainer(container);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public CommTask save(CommTask task, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		task.setRecordInfo(super.GenRecordInfo(task.getRecordInfo(), request));
		task = commTaskDao.save(task);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = task.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			commTaskDao.setLeaf(tree.getParentId());
		}
		return task;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CommTask dtl(int id) {
		CommTask task = commTaskDao.dtl(id);
		return task;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		commTaskDao.delTree(id);
	}

	/**
	 * 根据参数获取数据
	 * 
	 * @param refnum
	 * @return
	 */
	public boolean ckByPara(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String status = request.getParameter("status") != null ? request
				.getParameter("status").toString() : "";

		String hql = " FROM CommTask WHERE refNum=? UPDATESTR";
		String updateStr = "";
		List<Object> args = new ArrayList<Object>();
		args.add(refNum);
		if (!applyTo.equals("")) {
			updateStr += " AND applyTo=?";
			args.add(applyTo);
		}
		if (!category.equals("")) {
			updateStr += " AND category=?";
			args.add(category);
		}
		if (!status.equals("")) {
			updateStr += " AND status=?";
			args.add(status);
		}
		hql = hql.replace("UPDATESTR", updateStr);
		CommTask task = commTaskDao.dtl(hql, args);
		if (task != null) {
			return false;
		}
		return true;
	}

}
