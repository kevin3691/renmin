package com.zzb.cms.service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.CmsTemplateDao;
import com.zzb.cms.entity.CmsTemplate;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

@Service("cmsTemplateService")
public class CmsTemplateService extends BaseService<CmsTemplate> {

	@Resource
	private CmsTemplateDao cmsTemplateDao;

	// 查询模板方法
	@Transactional
	public QueryResult<CmsTemplate> list(HttpServletRequest request) {
		QueryPara qp = new QueryPara(request);
		String hql = " FROM CmsTemplate  ";
		qp.setHql(hql);
		qp.setOrderBy("Id");
		qp.setOrderDirection("desc");
		QueryResult<CmsTemplate> qr = cmsTemplateDao.list(qp);
		return qr;
	}

	public CmsTemplate saveOrUpdate(CmsTemplate cmsTemplate) {
		return cmsTemplateDao.save(cmsTemplate);
	}
	public CmsTemplate dtl(int id) {
		return cmsTemplateDao.dtl(id);
	}

	public void del(int id) {
		cmsTemplateDao.del(id);
	}
	
}
