package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.dao.GoodTypeDao;
import com.zzb.zo.dao.DocumentDao;
import com.zzb.zo.entity.GoodType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("goodTypeService")
public class GoodTypeService extends BaseService<GoodType> {
	@Resource
	private GoodTypeDao goodTypeDao;
	
	@Resource
	private DocumentDao documentDao;

	/**
	 * ��ѯ
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<GoodType> list(HttpServletRequest request) {
		int nodeid = request.getParameter("nodeid") != null
				&& !request.getParameter("nodeid").equals("") ? Integer
				.valueOf(request.getParameter("nodeid")) : 0;
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodType WHERE 1=1 ";
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
		QueryResult<GoodType> qr = goodTypeDao.list(qp);
		return qr;
	}
	
	public QueryResult<GoodType> listByParentId(int parentId) {
		
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM GoodType WHERE 1=1 ";
		if (parentId > 0) {
			hql += " AND baseTree.parentId=?";
			args.add(parentId);
		}
		
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<GoodType> qr = goodTypeDao.list(qp);
		return qr;
	}

	public GoodType save(GoodType org, HttpServletRequest request) {
		// �Զ����RecordInfo��������
		org.setRecordInfo(super.GenRecordInfo(org.getRecordInfo(), request));
		org = goodTypeDao.save(org);
		// ������ĩ��Ҷ�ӽڵ� ���isLeafΪ1�������丸�ڵ�isLeafΪ0
		BaseTree tree = org.getBaseTree();
		if (tree.getParentId() != 0 && tree.getIsLeaf() == 1) {
			goodTypeDao.setLeaf(tree.getParentId());
		}
		// �����к� ����к�Ϊ����Ϊ���������ݣ��������к�Ϊid
		if (org.getLineNo() == 0) {
			org.setLineNo(org.getId());
		}
		return org;
	}

	public GoodType dtl(int id) {
		GoodType org = goodTypeDao.dtl(id);
		return org;
	}
	
	/**
	 * ���username�Ƿ��ظ�
	 * 
	 * @See ���idΪ���ѯ�����Ƿ���ڣ����id��Ϊ�����ѯ�Ƿ���ڲ���ָ��id�ļ�¼
	 * @param
	 * @param
	 * @return
	 */
	public int checkExist(String name) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM GoodType WHERE 1=1";
		
		if (!name.equals("")) {
			hql += " AND name=?";
			args.add(name);
		}
		return (int) ((long) goodTypeDao.uniqueResult(hql, args));
	}

	
	/**
	 * ��ȡ��ϸ
	 * 
	 * @param
	 * @return
	 */
	public int getCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM Document WHERE isActive=1";
		if (id != 0) {
			hql += " AND  goodTypeId = ?";
			args.add(id);
			count =  (int)((long)documentDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * ��ȡ��ϸ
	 * 
	 * @param
	 * @return
	 */
	public int getDocCount(int id) {
		id = id | 0;
		List<Object> args = new ArrayList<Object>();
		int count = 0;
		String hql = "SELECT  COUNT(*) FROM GoodType WHERE isActive=1";
		if (id != 0) {
			hql += " AND  parentId = ?";
			args.add(id);
			count =  (int)((long)goodTypeDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * ɾ��
	 * 
	 * @param id
	 */
	public void del(int id) {
		goodTypeDao.delTree(id);
	}

	/**
	 * ����
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		goodTypeDao.sortTree(id, order);
	}
	
}
