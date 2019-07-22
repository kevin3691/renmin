package com.zzb.cms.dao;

import org.springframework.stereotype.Repository;

import com.zzb.cms.entity.CmsNews;
import com.zzb.core.baseclass.BaseDao;

/**
 * 实体 新闻
 * 
 * @author 
 * @createdAt 2016年08月26日
 */
@Repository("cmsNewsDao")
public class CmsNewsDao extends BaseDao<CmsNews> {
	// 构造方法
	public CmsNewsDao() {
	}
}