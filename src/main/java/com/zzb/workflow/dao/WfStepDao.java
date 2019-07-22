package com.zzb.workflow.dao;

import org.springframework.stereotype.Repository;

import com.zzb.core.baseclass.BaseDao;
import com.zzb.workflow.entity.WfStep;

/**
 * DAO 工作流
 * 
 * @author
 * @createdAt 2016年08月22日
 */
@Repository("WfStepDao")
public class WfStepDao extends BaseDao<WfStep> {
	/**
	 * 
	 */
	public WfStepDao() {
		// TODO Auto-generated constructor stub
	}
}
