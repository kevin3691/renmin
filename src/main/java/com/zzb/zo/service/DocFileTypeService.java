package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.dao.DocFileDao;
import com.zzb.zo.dao.DocFileTypeDao;
import com.zzb.zo.dao.DocumentDao;
import com.zzb.zo.entity.DocFileType;
import com.zzb.zo.entity.DocFileType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("docFileTypeService")
public class DocFileTypeService extends BaseService<DocFileType> {
	@Resource
	private DocFileTypeDao docFileTypeDao;
	
	@Resource
	private DocFileDao docFileDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<DocFileType> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DocFileType WHERE 1=1 ";
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
		QueryResult<DocFileType> qr = docFileTypeDao.list(qp);
		return qr;
	}
	
	public QueryResult<DocFileType> listByParentId(int parentId) {
		
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM DocFileType WHERE 1=1 ";
		if (parentId > 0) {
			hql += " AND baseTree.parentId=?";
			args.add(parentId);
		}
		
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<DocFileType> qr = docFileTypeDao.list(qp);
		return qr;
	}

	public DocFileType save(DocFileType org, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		org.setRecordInfo(super.GenRecordInfo(org.getRecordInfo(), request));
		org = docFileTypeDao.save(org);
		// 设置最末端叶子节点 如果isLeaf为1则设置其父节点isLeaf为0
		BaseTree tree = org.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			docFileTypeDao.setLeaf(tree.getParentId());
		}
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (org.getLineNo() == 0) {
			org.setLineNo(org.getId());
		}
		return org;
	}

	public DocFileType dtl(int id) {
		DocFileType org = docFileTypeDao.dtl(id);
		return org;
	}
	
	/**
	 * 检查username是否重复
	 * 
	 * @See 如果id为零查询数据是否存在，如果id不为零则查询是否存在不是指定id的记录
	 * @param
	 * @param
	 * @return
	 */
	public int checkExist(String name) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM DocFileType WHERE 1=1";
		
		if (!name.equals("")) {
			hql += " AND name=?";
			args.add(name);
		}
		return (int) ((long) docFileTypeDao.uniqueResult(hql, args));
	}

	
	/**
	 * 获取详细
	 * 
	 * @param
	 * @return
	 */
	public int getCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM DocFile WHERE isActive=1";
		if (id != 0) {
			hql += " AND  docTypeId = ?";
			args.add(id);
			count =  (int)((long)docFileDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 获取详细
	 * 
	 * @param
	 * @return
	 */
	public int getDocCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM DocFileType WHERE isActive=1";
		if (id != 0) {
			hql += " AND  parentId = ?";
			args.add(id);
			count =  (int)((long)docFileTypeDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		docFileTypeDao.delTree(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		docFileTypeDao.sortTree(id, order);
	}
	
}
