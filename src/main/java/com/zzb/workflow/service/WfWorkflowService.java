package com.zzb.workflow.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.base.entity.BaseRole;
import com.zzb.base.entity.BaseUser;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;
import com.zzb.workflow.dao.WfWorkflowDao;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfPrintTemp;
import com.zzb.workflow.entity.WfWorkflow;

/**
 * Service 工作流
 * 
 * 
 * @createdAt 2016年08月17日
 */

@Transactional
@Service("wfWorkflowService")
public class WfWorkflowService extends BaseService<WfWorkflow> {
	@Resource
	private WfWorkflowDao wfWorkflowDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<WfWorkflow> list(HttpServletRequest request) {
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM WfWorkflow WHERE 1=1";
		String title = request.getParameter("title")!=null? request.getParameter("title"):"";
		String sym = request.getParameter("sym")!=null? request.getParameter("sym"):"";
		String category = request.getParameter("category")!=null? request.getParameter("category"):"";
		System.out.println("title:"+title);
		
		if(title!="")
		{
			hql+= " AND title like ?";
			args.add('%'+title+'%');
		}
		if(sym!="")
		{
			hql+= " AND sym like ?";
			args.add('%'+sym+'%');
		}
		if(category!="")
		{
			hql+= " AND category like ?";
			args.add('%'+category+'%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfWorkflow> qr = wfWorkflowDao.list(qp);
		return qr;
	}
	/**
	 * 详细
	 * 
	 * @param request
	 * @return
	 */
	public WfWorkflow dtl(int id) {
		WfWorkflow workflow = wfWorkflowDao.dtl(id);
		return workflow;
	}
	
	public WfWorkflow dtl(String sym) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfWorkflow WHERE 1=1";
		hql += " AND sym=?";
		args.add(sym);
		
		WfWorkflow wf = wfWorkflowDao.dtl(hql, args);
		return wf;
	}
	
	//排序
	public void sort(int id, String order) {
		wfWorkflowDao.sort(id, order);
	}
	/**
	 * 编辑
	 * 
	 * @param request
	 * @return
	 */
	public WfWorkflow save(WfWorkflow flow, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		flow.setRecordInfo(super.GenRecordInfo(flow.getRecordInfo(), request));
		flow = wfWorkflowDao.save(flow);
		
		return flow;
	}
	//删除
	public void del(int id) {
		wfWorkflowDao.del(id);
	}
}
