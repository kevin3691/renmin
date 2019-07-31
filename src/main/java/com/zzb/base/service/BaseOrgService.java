package com.zzb.base.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.base.dao.BaseOrgDao;
import com.zzb.base.dao.BaseUserDao;
import com.zzb.base.entity.BaseOrg;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("baseOrgService")
public class BaseOrgService extends BaseService<BaseOrg> {
	@Resource
	private BaseOrgDao baseOrgDao;
	
	@Resource
	private BaseUserDao baseUserDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<BaseOrg> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseOrg WHERE 1=1 ";
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
		QueryResult<BaseOrg> qr = baseOrgDao.list(qp);
		return qr;
	}
	/**
	 * 查询
	 *
	 * @param request
	 * @return
	 */
	public QueryResult<BaseOrg> listAll(HttpServletRequest request) {

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseOrg WHERE 1=1 ";

		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<BaseOrg> qr = baseOrgDao.list(qp);
		return qr;
	}
	public QueryResult<BaseOrg> listByParentId(int parentId) {
		
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM BaseOrg WHERE 1=1 ";
		if (parentId > 0) {
			hql += " AND baseTree.parentId=?";
			args.add(parentId);
		}
		
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<BaseOrg> qr = baseOrgDao.list4(qp);
		return qr;
	}

	public BaseOrg save(BaseOrg org, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		org.setRecordInfo(super.GenRecordInfo(org.getRecordInfo(), request));
		org = baseOrgDao.save(org);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = org.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			baseOrgDao.setLeaf(tree.getParentId());
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (org.getLineNo() == 0) {
			org.setLineNo(org.getId());
		}
		return org;
	}

	public BaseOrg dtl(int id) {
		BaseOrg org = baseOrgDao.dtl(id);
		return org;
	}
	
	/**
	 * 检查username是否重复
	 * 
	 * @See 如果id为零查询数据是否存在，如果id不为零则查询是否存在不是指定id的记录
	 * @param id
	 * @param sym
	 * @return
	 */
	public int checkExist(String name) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM BaseOrg WHERE 1=1";
		
		if (name != "") {
			hql += " AND name=?";
			args.add(name);
		}
		return (int) ((long) baseOrgDao.uniqueResult(hql, args));
	}

	
	/**
	 * 获取详细
	 * 
	 * @param request
	 * @return
	 */
	public int getCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM BaseUser WHERE isActive=1";
		if (id != 0) {
			hql += " AND  baseOrgId = ?";
			args.add(id);
			count =  (int)((long)baseUserDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 获取详细
	 * 
	 * @param request
	 * @return
	 */
	public int getOrgCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM BaseOrg WHERE isActive=1";
		if (id != 0) {
			hql += " AND  parentId = ?";
			args.add(id);
			count =  (int)((long)baseOrgDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		baseOrgDao.delTree(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		baseOrgDao.sortTree(id, order);
	}
	
}
