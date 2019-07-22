package com.zzb.base.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.dao.BasePowerDao;
import com.zzb.base.entity.BasePower;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("basePowerService")
public class BasePowerService extends BaseService<BasePower> {
	@Resource
	private BasePowerDao basePowerDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<BasePower> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BasePower WHERE 1=1 ";
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
		if(qp.getOrderBy()==null)
		{
			System.out.print("$$$$$$$$$$$$ BasePower List");
			qp.setOrderBy("lineNo");
			qp.setOrderDirection("ASC");
		}
		QueryResult<BasePower> qr = basePowerDao.list(qp);
		return qr;
	}

	public BasePower save(BasePower power, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		power.setRecordInfo(super.GenRecordInfo(power.getRecordInfo(), request));
		power = basePowerDao.save(power);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = power.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			basePowerDao.setLeaf(tree.getParentId());
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (power.getLineNo() == 0) {
			power.setLineNo(power.getId());
		}
		return power;
	}

	/**
	 * 根据id 获取详细信息
	 * 
	 * @param id
	 * @return
	 */
	public BasePower dtl(int id) {
		BasePower power = basePowerDao.dtl(id);
		return power;
	}

	public void del(int id) {
		basePowerDao.delTree(id);
	}

	/**
	 * 排序（向上）
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		basePowerDao.sortTree(id, order);
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
		String hql = "SELECT COUNT(*) FROM BasePower WHERE 1=1";
		if (id != 0) {
			hql += " AND id <>? ";
			args.add(id);
		}
		if (sym != "") {
			hql += " AND sym=?";
			args.add(sym);
		}
		return (int) ((long) basePowerDao.uniqueResult(hql, args));
	}

	/**
	 * 从菜单同步生成权限
	 * 
	 * @param flag
	 */
	public void syncWithMenu(String flag) {
		basePowerDao.syncWithMenu(flag);
	}

}
