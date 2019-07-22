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

import com.zzb.base.entity.BaseMenu;
import com.zzb.base.service.BaseMenuService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;


@Controller
@RequestMapping("/base/menu")
public class BaseMenuController extends BaseController {

	@Resource
	private BaseMenuService baseMenuService;

	/**
	 * 构造函数
	 */
	public BaseMenuController() {
		System.out
				.println("this is BaseOrgController constructed function... ");
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("BASE_USER:RO")
	public String index(ModelMap map) {
		return "/base/menu/index";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	//@RequiresPermissions("BASE_USER:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		BaseMenu menu = new BaseMenu();
		if (id > 0) {
			menu = baseMenuService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			BaseMenu porg = baseMenuService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = porg.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + porg.getId()
					+ "." : path + porg.getId() + ".");
			String pathname = porg.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ porg.getTitle() + "." : pathname + porg.getTitle() + ".");
			menu.setBaseTree(tree);
		}
		model.addAttribute("o", menu);
		return "/base/menu/edit";
	}
	
	
	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit2")
	//@RequiresPermissions("BASE_USER:RW")
	public String edit2(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		BaseMenu menu = new BaseMenu();
		if (id > 0) {
			menu = baseMenuService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			BaseMenu porg = baseMenuService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = porg.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + porg.getId()
					+ "." : path + porg.getId() + ".");
			String pathname = porg.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ porg.getTitle() + "." : pathname + porg.getTitle() + ".");
			menu.setBaseTree(tree);
		}
		model.addAttribute("o", menu);
		return "/base/menu/edit2";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/base/menu/sel";
	}

	/**
	 * 获取列表数据 list
	 * 
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<BaseMenu> list(HttpServletRequest request) {

		QueryResult<BaseMenu> rslt = baseMenuService.list(request);
		return rslt;
	}
	/**
	 * 获取列表数据 list
	 * 
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/dtlBySym")
	public Map<String, Object> dtlBySym(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();		
		BaseMenu menu = baseMenuService.dtl(request);
		map.put("entity", menu);		
		return map;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param menu
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(BaseMenu menu, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = baseMenuService.checkExist(menu.getId(), menu.getSym());
		if (cnt == 0) {
			menu = baseMenuService.save(menu, request);
			map.put("entity", menu);
		} else {
			map.put("error", "该代号已经存在");
		}
		return map;
	}

	/**
	 * 删除数据
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		map.put("IsSuccess", true);
		baseMenuService.del(id);
		return map;
	}

	/**
	 * 排序
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		String order = request.getParameter("order");
		map.put("IsSuccess", true);
		baseMenuService.sort(id, order);
		return map;
	}

}
