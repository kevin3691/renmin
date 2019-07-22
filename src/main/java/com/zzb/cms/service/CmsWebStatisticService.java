package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.CmsGustBookDao;
import com.zzb.cms.dao.CmsWebUserDao;

@Transactional
@Service("cmsWebStatisticService")
public class CmsWebStatisticService {
	@Resource
	private CmsWebUserDao cmsWebUserDao;
	
	@Resource
	private CmsGustBookDao cmsGustBookDao;
	
	
	/**
	 * 用户管理统计
	 * 
	 * @param request
	 * @return
	 */
	public List<Object> webuserCounttj(HttpServletRequest request) {
		String userName = request.getParameter("userName") != null ? request.getParameter("userName") : "";
		String hql = "SELECT gender,COUNT(*) FROM CmsWebUser WHERE 1=1";
		List<Object> args = new ArrayList<Object>();
		if (!userName.equals("")) {
			hql += " AND userName LIKE ?";
			args.add('%' + userName + '%');
		}
		
		hql += " GROUP BY gender";
		List<Object> ls = new ArrayList();
		ls=cmsWebUserDao.excuteQuery(hql, args);
		return ls;
	}
	
	/**
	 * 留言板统计
	 * 
	 * @param request
	 * @return
	 */
	public List<Object> gustBookCounttj(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name") : "";
		String hql = "SELECT (CASE stts  WHEN '1' THEN '已回复' WHEN '0' THEN '未回复' ELSE '已回复' END) as stts , COUNT(*) FROM CmsGustBook WHERE 1=1";
		List<Object> args = new ArrayList<Object>();
		if (!title.equals("")) {
			hql += " AND title LIKE ?";
			args.add('%' + title + '%');
		}
		if (!name.equals("")) {
			hql += " AND name LIKE ?";
			args.add('%' + name + '%');
		}
		hql += " GROUP BY stts";
		List<Object> ls = new ArrayList();
		ls=cmsWebUserDao.excuteQuery(hql, args);
		return ls;
	}
}
