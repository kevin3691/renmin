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

import com.zzb.base.entity.BasePower;
import com.zzb.base.service.BasePowerService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/base/power")
public class BasePowerController extends BaseController {

	@Resource
	private BasePowerService basePowerService;

	/**
	 * 构造函数
	 */
	public BasePowerController() {
		System.out
				.println("this is BasePowerController constructed function... ");
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	@RequiresPermissions("BASE_USER:RO")
	public String index(ModelMap map) {
		return "/base/power/index";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	@RequiresPermissions("BASE_USER:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		BasePower power = new BasePower();
		if (id > 0) {
			power = basePowerService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			BasePower porg = basePowerService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = porg.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + porg.getId()
					+ "." : path + porg.getId() + ".");
			String pathname = porg.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ porg.getTitle() + "." : pathname + porg.getTitle() + ".");
			power.setBaseTree(tree);
		}
		model.addAttribute("o", power);
		return "/base/power/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel() {
		return "/base/power/sel";
	}

	/**
	 * View 多选页 multiSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multisel() {
		System.out.println("###########BasePowerController:");
		return "/base/power/multiSel";
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
	public QueryResult<BasePower> list(HttpServletRequest request) {
		QueryResult<BasePower> rslt = basePowerService.list(request);
		return rslt;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param org
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(BasePower power, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = basePowerService.checkExist(power.getId(), power.getSym());
		if (cnt == 0) {
			power = basePowerService.save(power, request);
			map.put("entity", power);
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
		basePowerService.del(id);
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
		basePowerService.sort(id, order);
		return map;
	}

	/**
	 * 从菜单同步生成权限
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/syncWithMenu", method = RequestMethod.POST)
	public Map<String, Object> syncWithMenu(HttpServletRequest request) {
		String flag = request.getParameter("flag") != null ? request
				.getParameter("flag") : "";
		basePowerService.syncWithMenu(flag);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("IsSuccess", true);
		return map;
	}
}
