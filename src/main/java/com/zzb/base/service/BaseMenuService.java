package com.zzb.base.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.dao.BaseMenuDao;
import com.zzb.base.entity.BaseMenu;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("baseMenuService")
public class BaseMenuService extends BaseService<BaseMenu> {
	@Resource
	private BaseMenuDao baseMenuDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<BaseMenu> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseMenu WHERE 1=1 ";
		if (nodeid != -1) {
			hql += " AND baseTree.parentId=?";
			args.add(nodeid);
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<BaseMenu> qr = baseMenuDao.list(qp);
		return qr;
	}

	public QueryResult<BaseMenu> list(String colSym) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseMenu WHERE 1=1 ";
		hql += " AND sym LIKE ?";
		args.add('%' + colSym + '%');
		hql += " AND isActive=?";
		args.add(1);
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<BaseMenu> qr = baseMenuDao.list(qp);
		return qr;
	}
	
	public BaseMenu save(BaseMenu menu, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		menu.setRecordInfo(super.GenRecordInfo(menu.getRecordInfo(), request));
		menu = baseMenuDao.save(menu);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = menu.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			baseMenuDao.setLeaf(tree.getParentId());
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (menu.getLineNo() == 0) {
			menu.setLineNo(menu.getId());
		}
		return menu;
	}

	public BaseMenu dtl(int id) {
		BaseMenu menu = baseMenuDao.dtl(id);
		return menu;
	}

	public void del( int id) {
		baseMenuDao.delTree(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		baseMenuDao.sortTree(id, order);
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
		String hql = "SELECT COUNT(*) FROM BaseMenu WHERE 1=1";
		if (id != 0) {
			hql += " AND id <>? ";
			args.add(id);
		}
		if (sym != "") {
			hql += " AND sym=?";
			args.add(sym);
		}
		return (int)((long)baseMenuDao.uniqueResult(hql, args));
	}

	public BaseMenu dtl(HttpServletRequest request) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseMenu WHERE 1=1";
		
		if (!sym.equals("")) {
			hql += " AND sym=?";
			args.add(sym);
		}
		return  baseMenuDao.dtl(hql,args);
	}

}
