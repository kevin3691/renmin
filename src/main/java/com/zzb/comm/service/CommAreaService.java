package com.zzb.comm.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.comm.dao.CommAreaDao;
import com.zzb.comm.entity.CommArea;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("commAreaService")
public class CommAreaService extends BaseService<CommArea> {
	@Resource
	private CommAreaDao commAreaDao;

	/**
	 * 查询方法
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommArea> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name").toString() : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommArea WHERE 1=1";
		if (nodeid != -1) {
			hql += " AND baseTree.parentId=?";
			args.add(nodeid);
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		if (!category.equals("")) {
			hql += " AND category = ?";
			args.add(category);
		}
		if (!name.equals("")) {
			hql += " AND name LIKE ?";
			args.add('%' + name + '%');
		}
		if (!sym.equals("")) {
			hql += " AND sym = ?";
			args.add(sym);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CommArea> qr = commAreaDao.list(qp);
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
	public QueryResult<CommArea> listBySym(HttpServletRequest request) {
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
		QueryResult<CommArea> qr = new QueryResult<CommArea>();
		String hql = "";
		if (nodeid > 0) {
			QueryPara qp = new QueryPara(request);
			hql = "FROM CommArea WHERE isActive=1 AND baseTree.parentId = ?";
			List<Object> args = new ArrayList<Object>();
			args.add(nodeid);
			qp.setHql(hql);
			qp.setArgs(args);
			qr = commAreaDao.list(qp);

		} else {
			if(psym!="")
			{
				hql = "SELECT id FROM CommArea WHERE isActive=1";
				List<Object> args = new ArrayList<Object>();
				args.add(psym);
				Object obj = commAreaDao.uniqueResult(hql, args);
				if (obj != null) {
					QueryPara qp = new QueryPara(request);
					hql = "FROM CommArea WHERE isActive=1 AND baseTree.parentId = ? OR baseTree.path LIKE ?";
					args = new ArrayList<Object>();
					args.add((int) obj);
					args.add("%." + String.valueOf(obj) + ".%");
					qp.setHql(hql);
					qp.setArgs(args);
					qr = commAreaDao.list(qp);
				}
			}
			else
			{
				hql = "FROM CommArea WHERE isActive=1";
				QueryPara qp = new QueryPara(request);
				qp.setHql(hql);
				qr = commAreaDao.list(qp);
			}
		}
		qr.setContainer(container);
		return qr;
	}

	public CommArea save(CommArea area, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		area.setRecordInfo(super.GenRecordInfo(area.getRecordInfo(), request));
		area = commAreaDao.save(area);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = area.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			commAreaDao.setLeaf(tree.getParentId());
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (area.getLineNo() == 0) {
			area.setLineNo(area.getId());
			area = commAreaDao.save(area);
		}
		return area;
	}

	public CommArea dtl(int id) {
		CommArea area = commAreaDao.dtl(id);
		return area;
	}

	public void del(int id) {
		commAreaDao.delTree(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		commAreaDao.sortTree(id, order);
	}

	/**
	 * 检查是否重复
	 * 
	 * @See 如果id为零查询数据是否存在，如果id不为零则查询是否存在不是指定id的记录
	 * @param id
	 * @param sym
	 * @return
	 */
	public int checkExist(int id, String sym) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM CommArea WHERE 1=1";
		if (id != 0) {
			hql += " AND id <>? ";
			args.add(id);
		}
		if (sym != "") {
			hql += " AND sym=?";
			args.add(sym);
		}
		return (int) ((long) commAreaDao.uniqueResult(hql, args));
	}

}
