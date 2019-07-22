package com.zzb.cms.dao;

import org.springframework.stereotype.Repository;

import com.zzb.cms.entity.CmsWebUser;
import com.zzb.core.baseclass.BaseDao;
/**
 * 外网用户
 * @author
 * @createdAt 2016年9月3日
 */
@Repository("cmsWebUserDao")
public class CmsWebUserDao extends BaseDao<CmsWebUser>{

	public CmsWebUserDao() {
	}

}
