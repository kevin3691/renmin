package com.zzb.comm.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.comm.dao.CommFormFiledDao;
import com.zzb.comm.entity.CommFormFiled;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("commFormFiledService")
public class CommFormFiledService extends BaseService<CommFormFiled> {
	@Resource
	private CommFormFiledDao commFormFiledDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommFormFiled> list(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title").toString() : "";
		String commFormName = request.getParameter("commFormName") != null ? request
				.getParameter("commFormName").toString() : "";
		int commFormId = request.getParameter("commFormId") != null ? Integer
				.valueOf(request.getParameter("commFormId")) : 0;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommFormFiled WHERE 1=1";
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!commFormName.equals("")) {
			hql += " AND commFormName LIKE ?";
			args.add('%' + commFormName + '%');
		}
		hql += " AND commFormId = ?";
		args.add(commFormId);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CommFormFiled> qr = commFormFiledDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public CommFormFiled save(CommFormFiled formFiled,
			HttpServletRequest request) {
		formFiled.setRecordInfo(super.GenRecordInfo(formFiled.getRecordInfo(),
				request));
		formFiled = commFormFiledDao.save(formFiled);
		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (formFiled.getLineNo() == 0) {
			formFiled.setLineNo(formFiled.getId());
		}
		formFiled = commFormFiledDao.save(formFiled);
		return formFiled;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CommFormFiled dtl(int id) {
		CommFormFiled formFiled = commFormFiledDao.dtl(id);
		return formFiled;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		commFormFiledDao.del(id);
	}
	
	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		commFormFiledDao.sort(id, order);
	}
}
