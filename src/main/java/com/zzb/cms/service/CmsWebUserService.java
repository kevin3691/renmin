package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.CmsWebUserDao;
import com.zzb.cms.entity.CmsWebUser;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

/**
 * 外网用户
 * 
 * @author
 * @createdAt 2016年9月3日
 */
@Transactional
@Service("cmsWebUserService")
public class CmsWebUserService extends BaseService<CmsWebUser> {

	@Resource
	private CmsWebUserDao cmsWebUserDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<CmsWebUser> list(HttpServletRequest request) {

		String userName = request.getParameter("userName") != null ? request.getParameter("userName") : "";
		int isActive = request.getParameter("isActive") != null && !request.getParameter("isActive").equals("")
				? Integer.valueOf(request.getParameter("isActive")) : -1;
		String gender = request.getParameter("gender") != null ? request.getParameter("gender") : "";
				QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM CmsWebUser WHERE 1=1";

		if (!userName.equals("")) {
			hql += " AND userName LIKE ?";
			args.add('%' + userName + '%');
		}
		if (isActive != -1) {
			hql += " AND isActive=?";
			args.add(isActive);
		}
		if (!gender.equals("")) {
			hql += " AND gender=?";
			args.add(gender);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<CmsWebUser> qr = cmsWebUserDao.list(qp);
		return qr;
	}

	/**
	 * 编辑
	 * 
	 * @param cmsWebUser
	 * @param request
	 * @return
	 */
	public CmsWebUser save(CmsWebUser cmsWebUser, HttpServletRequest request) {
		cmsWebUser.setRecordInfo(super.GenRecordInfo(cmsWebUser.getRecordInfo(), request));
		cmsWebUser = cmsWebUserDao.save(cmsWebUser);
		return cmsWebUser;
	}

	/**
	 * 详细
	 * 
	 * @param id
	 * @return
	 */
	public CmsWebUser dtl(int id) {
		CmsWebUser cmsWebUser = cmsWebUserDao.dtl(id);
		return cmsWebUser;
	}

	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		cmsWebUserDao.del(id);
	}
	
	/**
	 * 修改数据
	 * @param request
	 */
	public void updateActive(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
	
		int isActive = request.getParameter("isActive") != null ? Integer.valueOf(request
				.getParameter("isActive")) : -1;
		String hql = "UPDATE CmsWebUser SET isActive=? WHERE id=?";
		List<Object> args = new ArrayList<Object>();
		if (isActive != -1) {
			args.add(isActive);
		}
		if (id != 0) {
			args.add(id);
		}
		cmsWebUserDao.executeUpdate(hql, args);
	}

}
