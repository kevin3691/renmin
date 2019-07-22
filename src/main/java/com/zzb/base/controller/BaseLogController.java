package com.zzb.base.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.base.entity.BaseLog;
import com.zzb.base.service.BaseLogService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;


@Controller
@RequestMapping("/base/log")
public class BaseLogController extends BaseController {
	@Resource
	private BaseLogService baseLogService;

	/**
	 * 构造函数
	 */
	public BaseLogController() {
		System.out.println("this is constructed function... ");
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	@RequiresPermissions("BASE_LOG:RO")
	public String index(ModelMap map) {
		return "/base/log/index";
	}
	
	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/systemIndex")
	@RequiresPermissions("BASE_LOG:RO")
	public String systemIndex(ModelMap map) {
		return "/base/log/systemIndex";
	}


	/**
	 * View 详细页 dtl
	 * 
	 * @return
	 */
	@RequestMapping(value = "/dtl")
	@RequiresPermissions("BASE_LOG:RO")
	public String dtl(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? id = Integer.valueOf(request
				.getParameter("id")) : 0;
		BaseLog log = baseLogService.dtl(id);
		if (log == null) {
			log = new BaseLog();
		}
		model.addAttribute("o", log);
		return "/base/log/dtl";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/edit")
	@RequiresPermissions("BASE_LOG:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		String sid = request.getParameter("id");
		int id = 0;
		if (sid != null) {
			id = Integer.valueOf(request.getParameter("id"));
		}

		BaseLog log = baseLogService.dtl(id);
		if (log == null) {
			log = new BaseLog();
		}
		model.addAttribute("o", log);
		return "/base/log/edit";
	}

	/**
	 * Action 获取列表数据 list
	 * 
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<BaseLog> list(BaseLog log, HttpServletRequest request) {
		return baseLogService.list(request);
	}

	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(BaseLog log, HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		log = baseLogService.save(log, request);
		map.put("entity", log);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		System.out.println("BaseRoleController del..." + id);
		map.put("IsSuccess", true);
		baseLogService.del(id);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		String order = request.getParameter("order") != null ? request
				.getParameter("order") : "";
		System.out.println("BaseRoleController del..." + id);
		map.put("IsSuccess", true);
		baseLogService.sort(id, order);
		return map;
	}
}
