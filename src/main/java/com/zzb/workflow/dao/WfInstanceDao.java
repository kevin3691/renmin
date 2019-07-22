package com.zzb.workflow.dao;

import org.springframework.stereotype.Repository;

import com.zzb.core.baseclass.BaseDao;
import com.zzb.workflow.entity.WfInstance;

/**
 * DAO 待办
 * 
 * @author 
 * @createdAt 2016年04月08日
 */
@Repository("wfInstanceDao")
public class WfInstanceDao extends BaseDao<WfInstance> {
	/**
	 * 
	 */
	public WfInstanceDao() {
		// TODO Auto-generated constructor stub
	}
}
