package com.zzb.comm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.comm.entity.CommArea;
import com.zzb.comm.service.CommAreaService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.SiteConfig;

@Controller
@RequestMapping("/comm/area")
public class CommAreaController extends BaseController {
	// 构造方法
	public CommAreaController() {

	}

	@Resource
	private CommAreaService commAreaService;

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		
		return "/comm/area/index";
	}

	/**
	 * View 树状列表页 treeIndex
	 * 
	 * @return
	 */
	@RequestMapping(value = "/indexTree")
	public String indexTree(HttpServletRequest request, ModelMap map) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		map.addAttribute("sym", sym);
		return "/comm/area/indexTree";
	}
	
	/**
	 * View 树状列表页 index4  为其它项目引用
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	public String index4(HttpServletRequest request, ModelMap map) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		map.addAttribute("sym", sym);
		return "/comm/area/index4";
	}

	/**
	 * View 单选页 sel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel(HttpServletRequest request, ModelMap map) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		map.addAttribute("sym", sym);
		return "/comm/area/sel";
	}
	
	/**
	 * View 多选选页 multiSel
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multiSel(HttpServletRequest request, ModelMap map) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		map.addAttribute("sym", sym);
		return "/comm/area/multiSel";
	}
	
	/**
	 * View 树状单选页 selTree
	 * 
	 * @return
	 */
	@RequestMapping(value = "/selTree")
	public String selTree(HttpServletRequest request, ModelMap map) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		map.addAttribute("sym", sym);
		return "/comm/area/selTree";
	}
	
	/**
	 * View 树状多选页 multiSelTree
	 * 
	 * @return
	 */
	@RequestMapping(value = "/multiSelTree")
	public String multiSelTree(HttpServletRequest request, ModelMap map) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		map.addAttribute("sym", sym);
		return "/comm/area/multiSelTree";
	}


	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		CommArea area = new CommArea();
		if (id > 0) {
			area = commAreaService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			CommArea parea = commAreaService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = parea.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + parea.getId()
					+ "." : path + parea.getId() + ".");
			String pathname = parea.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ parea.getName() + "." : pathname + parea.getName()
					+ ".");
			area.setBaseTree(tree);
		}
		model.addAttribute("o", area);
		return "/comm/area/edit";
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
	public QueryResult<CommArea> list(HttpServletRequest request) {
		QueryResult<CommArea> rslt = commAreaService.list(request);
		return rslt;
	}

	/**
	 * 根据代号获取其下子节点
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/listBySym")
	public QueryResult<CommArea> listbysym(HttpServletRequest request) {
		QueryResult<CommArea> qr = commAreaService.listBySym(request);
		return qr;
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
	public Map<String, Object> save(CommArea area, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = commAreaService.checkExist(area.getId(), area.getSym());
		if (cnt == 0) {
			area = commAreaService.save(area, request);
			map.put("entity", area);
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
		commAreaService.del(id);
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
		commAreaService.sort(id, order);
		return map;
	}

}
