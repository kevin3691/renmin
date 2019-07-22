package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.zo.dao.DocumentDao;
import com.zzb.zo.dao.SealTypeDao;
import com.zzb.zo.entity.SealType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("sealTypeService")
public class SealTypeService extends BaseService<SealType> {
	@Resource
	private SealTypeDao sealTypeDao;
	
	@Resource
	private DocumentDao documentDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<SealType> list(HttpServletRequest request) {
		int isActive = request.getParameter("isActive") != null
				&& !request.getParameter("isActive").equals("") ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM SealType WHERE 1=1 ";

		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		qp.setHql(hql);
		qp.setArgs(args);
		QueryResult<SealType> qr = sealTypeDao.list(qp);
		return qr;
	}
	

	public SealType save(SealType org, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		org.setRecordInfo(super.GenRecordInfo(org.getRecordInfo(), request));
		org = sealTypeDao.save(org);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (org.getLineNo() == 0) {
			org.setLineNo(org.getId());
		}
		return org;
	}

	public SealType dtl(int id) {
		SealType org = sealTypeDao.dtl(id);
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
		String hql = "SELECT COUNT(*) FROM SealType WHERE 1=1";
		
		if (!name.equals("")) {
			hql += " AND name=?";
			args.add(name);
		}
		return (int) ((long) sealTypeDao.uniqueResult(hql, args));
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
		String hql = "SELECT  COUNT(*) FROM Document WHERE isActive=1";
		if (id != 0) {
			hql += " AND  goodTypeId = ?";
			args.add(id);
			count =  (int)((long)documentDao.uniqueResult(hql, args));
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
		String hql = "SELECT  COUNT(*) FROM SealType WHERE isActive=1";
		if (id != 0) {
			hql += " AND  parentId = ?";
			args.add(id);
			count =  (int)((long)sealTypeDao.uniqueResult(hql, args));
		}
		return count;
	}
	
	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		sealTypeDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		sealTypeDao.sortTree(id, order);
	}
	
}
