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

import com.zzb.base.entity.BaseDict;
import com.zzb.base.service.BaseDictService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;


@Controller
@RequestMapping("/base/dict")
public class BaseDictController extends BaseController {

	@Resource
	private BaseDictService baseDictService;

	/**
	 * 构造函数
	 */
	public BaseDictController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	@RequiresPermissions("BASE_DICT:RO")
	public String index(ModelMap map) {
		return "/base/dict/index";
	}

	/**
	 * View list4 简单列表 为其它模块提供侧栏导航
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4(HttpServletRequest request, ModelMap model) {
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		model.addAttribute("sym", sym);
		return "/base/dict/list4";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	@RequiresPermissions("BASE_DICT:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		BaseDict dict = new BaseDict();
		if (id > 0) {
			dict = baseDictService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			BaseDict pdict = baseDictService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = pdict.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + pdict.getId()
					+ "." : path + pdict.getId() + ".");
			String pathname = pdict.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ pdict.getTitle() + "." : pathname + pdict.getTitle()
					+ ".");
			dict.setBaseTree(tree);
		}
		model.addAttribute("o", dict);
		return "/base/dict/edit";
	}

	/**
	 * View 选择页 sel
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel(HttpServletRequest request, ModelMap model) {
		// 父代号
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		// 是否只允许选择叶子节点 1是0否
		String leafOnly = request.getParameter("leafOnly") != null ? request
				.getParameter("leafOnly").toString() : "0";
		model.addAttribute("sym", sym);
		model.addAttribute("leafOnly", leafOnly);
		return "/base/dict/sel";
	}

	/**
	 * View 多选页 multiSel
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/multiSel")
	public String multiSel(HttpServletRequest request, ModelMap model) {
		// 父代号
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		// 是否只允许选择叶子节点 1是0否
		String leafOnly = request.getParameter("leafOnly") != null ? request
				.getParameter("leafOnly").toString() : "0";
		model.addAttribute("sym", sym);
		model.addAttribute("leafOnly", leafOnly);
		return "/base/dict/multiSel";
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
	public QueryResult<BaseDict> list(HttpServletRequest request) {
		QueryResult<BaseDict> rslt = baseDictService.list(request);
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
	public QueryResult<BaseDict> listbysym(HttpServletRequest request) {
		QueryResult<BaseDict> qr = baseDictService.listBySym(request);
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
	public Map<String, Object> save(BaseDict dict, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = baseDictService.checkExist(dict.getId(), dict.getSym());
		if (cnt == 0) {
			dict = baseDictService.save(dict, request);
			map.put("entity", dict);
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
		baseDictService.del(id);
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
		baseDictService.sort(id, order);
		return map;
	}

	/**
	 * 详细 dtl
	 * 
	 * @param dict
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/dtl", method = RequestMethod.POST)
	public Map<String, Object> dtl(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		BaseDict dict = new BaseDict();
		dict = baseDictService.dtl(request);
		map.put("entity", dict);
		return map;
	}

}
