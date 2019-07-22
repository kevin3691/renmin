package com.zzb.base.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.zzb.base.service.BaseMenuService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.base.entity.BaseRole;
import com.zzb.base.service.BaseRoleService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/base/role")
public class BaseRoleController extends BaseController {
	@Resource
	private BaseRoleService baseRoleService;



	/**
	 * 构造函数
	 */
	public BaseRoleController() {
		System.out.println("this is constructed function... ");
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	@RequiresPermissions("BASE_USER:RO")
	public String index(ModelMap map) {
		return "/base/role/index";
	}
	
	/**
	 * View 列表页 index4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	//@RequiresPermissions("BASE_USER:RO")
	public String index4(ModelMap map) {
		return "/base/role/index4";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/edit")
	@RequiresPermissions("BASE_USER:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		BaseRole role = baseRoleService.dtl(id);
		if (role == null) {
			role = new BaseRole();
		}
		model.addAttribute("o", role);
		return "/base/role/edit";
	}
	
	/**
	 * View 添加、编辑页 edit4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/edit4")
	//@RequiresPermissions("BASE_USER:RW")
	public String edit4(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		BaseRole role = baseRoleService.dtl(id);
		if (role == null) {
			role = new BaseRole();
		}
		model.addAttribute("o", role);
		return "/base/role/edit4";
	}
	
	/**
	 * View 多选页 multisel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		return "/base/role/multiSel";
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
	public QueryResult<BaseRole> list(BaseRole role, HttpServletRequest request) {
		return baseRoleService.list(request);
	}

	/**
	 * 根据ID获取实体
	 * 
	 * @param request
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public Map<String, Object> get(HttpServletRequest request) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		System.out.println("###############"+id);
		BaseRole role = baseRoleService.dtl(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("entity", role);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(BaseRole role, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		role = baseRoleService.save(role, request);
		if (role.getLineNo() == 0) {
			role.setLineNo(role.getId());
			role = baseRoleService.save(role, request);
		}
		map.put("entity", role);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		System.out.println("BaseRoleController del..." + id);
		map.put("IsSuccess", true);
		baseRoleService.del(id);
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
		baseRoleService.sort(id, order);
		return map;
	}
}
