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

import com.zzb.base.entity.BasePerson;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BasePersonService;
import com.zzb.comm.entity.CommTask;
import com.zzb.comm.service.CommTaskService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/comm/task")
public class CommTaskController extends BaseController {
	@Resource
	private CommTaskService commTaskService;

	@Resource
	private BasePersonService basePersonService;

	/**
	 * 构造函数
	 */
	public CommTaskController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	public String index4(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		BaseUser user = (BaseUser) request.getSession()
				.getAttribute("baseUser");
		BasePerson person = basePersonService.dtl(user.getBasePersonId());
		map.addAttribute("personTitle", person.getTitle());
		System.out.println("AAAAAAAA" + user.getBasePersonId());
		System.out.println("AAAAAAAA" + person.getTitle());
		return "/comm/task/index4";
	}

	/**
	 * View 添加、编辑页 assign
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/assign")
	public String assign(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		CommTask task = new CommTask();
		if (id > 0) {
			task = commTaskService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			CommTask ptask = commTaskService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = ptask.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + ptask.getId()
					+ "." : path + ptask.getId() + ".");
			String pathname = ptask.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ ptask.getTitle() + "." : pathname + ptask.getTitle()
					+ ".");
			task.setBaseTree(tree);
		}
		model.addAttribute("o", task);
		return "/comm/task/assign";
	}

	/**
	 * View 添加、编辑页 act
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/act")
	public String act(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		CommTask task = new CommTask();
		if (id > 0) {
			task = commTaskService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			CommTask ptask = commTaskService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = ptask.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + ptask.getId()
					+ "." : path + ptask.getId() + ".");
			String pathname = ptask.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ ptask.getTitle() + "." : pathname + ptask.getTitle()
					+ ".");
			task.setBaseTree(tree);
		}
		model.addAttribute("o", task);
		return "/comm/task/act";
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
		setPara(request, model);
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int parentId = request.getParameter("parentId") != null ? Integer
				.valueOf(request.getParameter("parentId")) : 0;
		CommTask task = new CommTask();
		if (id > 0) {
			task = commTaskService.dtl(id);
		}
		// 添加记录时，处理baseTree树属性
		if (id == 0 && parentId > 0) {
			CommTask ptask = commTaskService.dtl(parentId);
			BaseTree tree = new BaseTree();
			tree.setIsLeaf(1);
			tree.setParentId(parentId);
			String path = ptask.getBaseTree().getPath();
			tree.setPath(path == null || path.equals("") ? "." + ptask.getId()
					+ "." : path + ptask.getId() + ".");
			String pathname = ptask.getBaseTree().getPathName();
			tree.setPathName(pathname == null || pathname.equals("") ? "."
					+ ptask.getTitle() + "." : pathname + ptask.getTitle()
					+ ".");
			task.setBaseTree(tree);
		}
		model.addAttribute("o", task);
		return "/comm/task/edit";
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
		return "/comm/task/sel";
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
		return "/comm/task/multiSel";
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
	public QueryResult<CommTask> list(HttpServletRequest request) {
		QueryResult<CommTask> rslt = commTaskService.list(request);
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
	public QueryResult<CommTask> listbysym(HttpServletRequest request) {
		QueryResult<CommTask> qr = commTaskService.listBySym(request);
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
	public Map<String, Object> save(CommTask task, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		task = commTaskService.save(task, request);
		map.put("entity", task);
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
		commTaskService.del(id);
		return map;
	}

	/**
	 * 
	 * @param request
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/ckByPara")
	public boolean ckByPara(HttpServletRequest request, ModelMap map) {
		return commTaskService.ckByPara(request);
	}

	/**
	 * 获取请求参数并设置ModelMap
	 * 
	 * @param request
	 * @param model
	 */
	public void setPara(HttpServletRequest request, ModelMap map) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String mode = request.getParameter("mode") != null ? request
				.getParameter("mode").toString() : "";
		map.addAttribute("category", category);
		map.addAttribute("applyTo", applyTo);
		map.addAttribute("refNum", refNum);
		map.addAttribute("mode", mode);
	}

}
