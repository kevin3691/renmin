package com.zzb.base.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.dao.BaseDictDao;
import com.zzb.base.entity.BaseDict;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("baseDictService")
public class BaseDictService extends BaseService<BaseDict> {
	@Resource
	private BaseDictDao baseDictDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<BaseDict> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseDict WHERE 1=1 ";
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
		QueryResult<BaseDict> qr = baseDictDao.list(qp);
		return qr;
	}

	public QueryResult<BaseDict> listBySym(String sym) {
		QueryResult<BaseDict> qr = new QueryResult<BaseDict>();
		String hql = "SELECT id FROM BaseDict WHERE sym LIKE ?";
		List<Object> args = new ArrayList<Object>();
		args.add(sym);
		Object obj = baseDictDao.uniqueResult(hql, args);
		if (obj != null) {
			QueryPara qp = new QueryPara();
			hql = "FROM BaseDict WHERE baseTree.parentId = ? OR baseTree.path LIKE ?";
			args = new ArrayList<Object>();
			args.add((int) obj);
			System.out
					.println("BaseDict listBySym:FROM BaseDict WHERE baseTree.parentId = "
							+ String.valueOf(obj)
							+ " OR baseTree.path LIKE "
							+ "%."
							+ String.valueOf(obj) + ".%" + "");
			args.add("%." + String.valueOf(obj) + ".%");
			qp.setHql(hql);
			qp.setArgs(args);
			qp.setOrderBy("lineNo");
			qp.setOrderDirection("ASC");
			qr = baseDictDao.list(qp);
			return qr;
		}
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
	public QueryResult<BaseDict> listBySym(HttpServletRequest request) {
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
		QueryResult<BaseDict> qr = new QueryResult<BaseDict>();
		if (nodeid > 0) {
			QueryPara qp = new QueryPara(request);
			String hql = "FROM BaseDict WHERE baseTree.parentId = ?";
			List<Object> args = new ArrayList<Object>();
			args.add(nodeid);
			qp.setHql(hql);
			qp.setArgs(args);
			qp.setOrderBy("lineNo");
			qp.setOrderDirection("ASC");
			qr = baseDictDao.list(qp);

		} else {
			String hql = "SELECT id FROM BaseDict WHERE sym LIKE ?";
			List<Object> args = new ArrayList<Object>();
			args.add(psym);
			Object obj = baseDictDao.uniqueResult(hql, args);
			if (obj != null) {
				QueryPara qp = new QueryPara(request);
				hql = "FROM BaseDict WHERE baseTree.parentId = ? OR baseTree.path LIKE ?";
				args = new ArrayList<Object>();
				args.add((int) obj);
				System.out
						.println("BaseDict listBySym:FROM BaseDict WHERE baseTree.parentId = "
								+ String.valueOf(obj)
								+ " OR baseTree.path LIKE "
								+ "%."
								+ String.valueOf(obj) + ".%" + "");
				args.add("%." + String.valueOf(obj) + ".%");
				qp.setHql(hql);
				qp.setArgs(args);
				qp.setOrderBy("lineNo");
				qp.setOrderDirection("ASC");
				qr = baseDictDao.list(qp);
			}

		}
		qr.setContainer(container);
		return qr;
	}

	public BaseDict save(BaseDict dict, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		dict.setRecordInfo(super.GenRecordInfo(dict.getRecordInfo(), request));
		dict = baseDictDao.save(dict);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = dict.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			baseDictDao.setLeaf(tree.getParentId());
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (dict.getLineNo() == 0) {
			dict.setLineNo(dict.getId());
		}
		return dict;
	}

	public BaseDict dtl(int id) {
		BaseDict dict = baseDictDao.dtl(id);
		return dict;
	}

	public void del(int id) {
		baseDictDao.delTree(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		baseDictDao.sortTree(id, order);
	}

	public BaseDict dtlBySym(String sym){
		List<Object> args = new ArrayList<Object>();
		String hql = " FROM BaseDict WHERE 1=1";
		hql += " AND sym=?";
		args.add(sym);
		return  baseDictDao.dtl(hql, args);
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
		String hql = "SELECT COUNT(*) FROM BaseDict WHERE 1=1";
		if (id != 0) {
			hql += " AND id <>? ";
			args.add(id);
		}
		if (sym != "") {
			hql += " AND sym=?";
			args.add(sym);
		}
		return (int) ((long) baseDictDao.uniqueResult(hql, args));
	}

	public int checkExist(String title) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM BaseDict WHERE 1=1";

		if (title != "") {
			hql += " AND title=?";
			args.add(title);
		}
		return (int) ((long) baseDictDao.uniqueResult(hql, args));
	}

	public int getCount(String sym) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM BaseDict WHERE 1=1";
		hql += " AND sym like ?";
		args.add("%" + sym + "%");
		return (int) ((long) baseDictDao.uniqueResult(hql, args));
	}

	/**
	 * 获取详细
	 * 
	 * @param request
	 * @return
	 */
	public BaseDict dtl(HttpServletRequest request) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		int id = request.getParameter("id") != null ? Integer
				.valueOf(request.getParameter("id")) : 0;
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseDict WHERE 1=1";
		if (!sym.equals("")) {
			hql += " AND sym like ?";
			args.add('%' + sym + '%');
		}
		if (id != 0) {
			hql += " AND id = ?";
			args.add(id);
		}
		hql += " ORDER BY id DESC";
		return baseDictDao.dtl(hql, args);
	}
	
}
