package com.zzb.cms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.cms.entity.CmsWebUser;
import com.zzb.cms.service.CmsWebUserService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * 外网用户
 * @author
 * @createdAt 2016年9月3日
 */
@Controller
@RequestMapping("/cms/webUser")
public class CmsWebUserController extends BaseController {
	@Resource
	private CmsWebUserService cmsWebUserService;
	/**
	 * 构造函数
	 */
	public CmsWebUserController() {
	}
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		String userName = request.getParameter("userName") != null ? request
				.getParameter("userName") : "";
		String gender = request.getParameter("gender") != null ? request
				.getParameter("gender") : "";
		map.put("userName", userName);
		map.put("gender", gender);
		return "/cms/webUser/index";
	}
	/**
	 * 获取列表数据 list 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<CmsWebUser> list(HttpServletRequest request) {
		QueryResult<CmsWebUser> rslt = cmsWebUserService.list(request);
		return rslt;
	}
	
	/**
	 * 编辑页面
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		CmsWebUser cmsWebUser = new CmsWebUser();
		if (id > 0) {
			cmsWebUser = cmsWebUserService.dtl(id);
		}
		map.addAttribute("o", cmsWebUser);
		return "/cms/webUser/edit";
	}
	
	/**
	 * 增加/编辑
	 * @param cmsWebUser
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(CmsWebUser cmsWebUser,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		cmsWebUser = cmsWebUserService.save(cmsWebUser, request);
		map.put("entity", cmsWebUser);
		return map;
	}
	/**
	 * 修改状态
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateActive", method = RequestMethod.POST)
	public Map<String, Object> updateActive(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("IsSuccess", true);
		cmsWebUserService.updateActive(request);
		return map;
	}
	/**
	 * 删除
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		map.put("IsSuccess", true);
		cmsWebUserService.del(id);
		return map;
	}
	
	/**
	 * 详情
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/dtl")
	public String dtl(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		CmsWebUser cmsWebUser = new CmsWebUser();
		if (id > 0) {
			cmsWebUser = cmsWebUserService.dtl(id);
		}
		map.addAttribute("o", cmsWebUser);
		return "/cms/webUser/dtl";
	}
	
	
}
