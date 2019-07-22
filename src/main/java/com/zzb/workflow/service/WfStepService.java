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
import com.zzb.workflow.dao.WfStepDao;
import com.zzb.workflow.entity.WfStep;

/**
 * Service 流程环节
 * 
 * @author 
 * @createdAt 2016年08月22日
 */

@Transactional
@Service("WfStep")
public class WfStepService extends BaseService<WfStep> {
	@Resource
	private WfStepDao wfStepDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WfStep> list(HttpServletRequest request) {
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WfStep WHERE 1=1";
		int wfWorkflowId = request.getParameter("wfWorkflowId") != null ? Integer
				.valueOf(request.getParameter("wfWorkflowId")) : -1;
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym") : "";
		if (wfWorkflowId != -1) {
			hql += " AND wfWorkflowId = ?";
			args.add(wfWorkflowId);
		}
		if (title != "") {
			hql += " AND title like ?";
			args.add('%' + title + '%');
		}
		if (sym != "") {
			hql += " AND sym like ?";
			args.add('%' + sym + '%');
		}
		// if(category!="")
		// {
		// hql+= " AND category like ?";
		// args.add('%'+category+'%');
		// }
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfStep> qr = wfStepDao.list(qp);
		return qr;
	}
	
	
	public QueryResult<WfStep> list(int wfWorkflowId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WfStep WHERE 1=1";
		
		if (wfWorkflowId != -1) {
			hql += " AND wfWorkflowId = ?";
			args.add(wfWorkflowId);
		}
		qp.setOrderBy("lineNo");
		qp.setOrderDirection("DESC");
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfStep> qr = wfStepDao.list4(qp);
		return qr;
	}

	/**
	 * 详细
	 * 
	 * @param
	 * @return
	 */
	public WfStep dtl(int id) {
		WfStep workflow = wfStepDao.dtl(id);
		return workflow;
	}

	// 排序
	public void sort(int id, String order) {
		wfStepDao.sort(id, order);
	}

	// 排序
	public void sort(int id, int wfWorkflowId, String order) {
		String wc = " AND wfWorkflowId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(wfWorkflowId);
		wfStepDao.sort(id, order,wc,args);
	}

	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public WfStep save(WfStep step, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		step.setRecordInfo(super.GenRecordInfo(step.getRecordInfo(), request));
		step = wfStepDao.save(step);

		return step;
	}

	// 删除
	public void del(int id) {
		wfStepDao.del(id);
	}
}
