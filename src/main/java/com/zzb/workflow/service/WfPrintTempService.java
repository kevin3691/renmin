package com.zzb.workflow.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfPrintTempDao;
import com.zzb.workflow.entity.WfPrintTemp;

/**
 * Service 打印模板
 * 
 * 
 * @createdAt 2016年08月01日
 */

@Transactional
@Service("wfPrintTempService")
public class WfPrintTempService extends BaseService<WfPrintTemp> {
	@Resource
	private WfPrintTempDao wfPrintTempDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WfPrintTemp> list(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		int isActive = request.getParameter("isActive") != null ? Integer
				.valueOf(request.getParameter("isActive")) : -1;
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();

		String hql = "FROM WfPrintTemp WHERE 1=1";
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!sym.equals("")) {
			hql += " AND sym LIKE ?";
			args.add('%' + sym + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive = ?";
			args.add(isActive);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfPrintTemp> qr = wfPrintTempDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public WfPrintTemp save(WfPrintTemp temp, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		temp.setRecordInfo(super.GenRecordInfo(temp.getRecordInfo(), request));
		temp = wfPrintTempDao.save(temp);

		// 设置行号 如果行号为零则为刚生成数据，设置其行号为id
		if (temp.getLineNo() == 0) {
			temp.setLineNo(temp.getId());
		}
		temp = wfPrintTempDao.save(temp);
		return temp;
	}

	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public WfPrintTemp dtl(int id) {
		WfPrintTemp temp = wfPrintTempDao.dtl(id);
		return temp;
	}

	/**
	 * 根据参数获取详细信息
	 * 
	 * @param request
	 * @return
	 */
	public WfPrintTemp dtl(String title, String sym) {
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WfPrintTemp WHERE isActive=1";

		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!sym.equals("")) {
			hql += " AND sym LIKE ?";
			args.add('%' + sym + '%');
		}
		WfPrintTemp temp = wfPrintTempDao.dtl(hql, args);
		return temp;
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @return
	 */
	public void del(int id) {
		wfPrintTempDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		wfPrintTempDao.sort(id, order);
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
		String hql = "SELECT COUNT(*) FROM WfPrintTemp WHERE 1=1";
		if (id != 0) {
			hql += " AND id <>? ";
			args.add(id);
		}
		if (sym != "") {
			hql += " AND sym=?";
			args.add(sym);
		}
		return (int) ((long) wfPrintTempDao.uniqueResult(hql, args));
	}

}
