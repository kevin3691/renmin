package com.zzb.cms.dao;

import org.springframework.stereotype.Repository;

import com.zzb.cms.entity.CmsLink;
import com.zzb.core.baseclass.BaseDao;

/**
 * 实体 链接
 * 
 * @author 
 * @createdAt 2016年08月26日
 */
@Repository("cmsLinkDao")
public class CmsLinkDao extends BaseDao<CmsLink> {
	// 构造方法
	public CmsLinkDao() {
	}
}
