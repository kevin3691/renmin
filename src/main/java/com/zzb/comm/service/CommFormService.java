package com.zzb.comm.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.comm.dao.CommFormDao;
import com.zzb.comm.entity.CommForm;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Transactional
@Service("commFormService")
public class CommFormService extends BaseService<CommForm> {
	@Resource
	private CommFormDao commFormDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CommForm> list(HttpServletRequest request) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name").toString() : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CommForm WHERE 1=1";
		if (!category.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + category + '%');
		}
		if (!name.equals("")) {
			hql += " AND name LIKE ?";
			args.add('%' + name + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CommForm> qr = commFormDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public CommForm save(CommForm form, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		form.setRecordInfo(super.GenRecordInfo(form.getRecordInfo(), request));
		form = commFormDao.save(form);
		return form;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public CommForm dtl(int id) {
		CommForm form = commFormDao.dtl(id);
		return form;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		commFormDao.del(id);
	}

}
