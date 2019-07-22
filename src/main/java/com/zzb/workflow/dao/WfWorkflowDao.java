package com.zzb.workflow.dao;

import org.springframework.stereotype.Repository;

import com.zzb.core.baseclass.BaseDao;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfWorkflow;

/**
 * DAO 工作流
 * 
 * @author 
 * @createdAt 2016年08月17日
 */
@Repository("wfWorkflowDao")
public class WfWorkflowDao extends BaseDao<WfWorkflow> {
	/**
	 * 
	 */
	public WfWorkflowDao() {
		// TODO Auto-generated constructor stub
	}
}
