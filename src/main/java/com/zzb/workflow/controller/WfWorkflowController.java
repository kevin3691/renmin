package com.zzb.workflow.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfPrintTemp;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfWorkflowService;

/**
 * Contorll 工作流
 * 
 * @author 
 * @CreatedAt 2016年04月08日
 */

@Controller
@RequestMapping("/workflow/workflow")
public class WfWorkflowController extends BaseController {
	@Resource
	private WfWorkflowService wfWorkflowService;

	/**
	 * 构造函数
	 */
	public WfWorkflowController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		return "/workflow/workflow/index";
	}

	@RequestMapping(value = "/index4")
	public String index4(HttpServletRequest request, ModelMap map) {
		return "/workflow/workflow/index4";
	}

	/**
	 * View 编辑页 edit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		WfWorkflow workflow = new WfWorkflow();
		if (id > 0) {
			workflow = wfWorkflowService.dtl(id);
		}
		map.addAttribute("o", workflow);
		return "/workflow/workflow/edit";
	}

	@RequestMapping(value = "/edit4")
	public String edit4(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		WfWorkflow workflow = new WfWorkflow();
		if (id > 0) {
			workflow = wfWorkflowService.dtl(id);
		}
		map.addAttribute("o", workflow);
		return "/workflow/workflow/edit4";
	}

	/**
	 * 获取列表数据 list
	 * 
	 * @param instance
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<WfWorkflow> list(HttpServletRequest request) {
		QueryResult<WfWorkflow> qr = wfWorkflowService.list(request);
		return qr;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param temp
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(WfWorkflow flow, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		flow = wfWorkflowService.save(flow, request);
		if (flow.getLineNo() == 0) {
			flow.setLineNo(flow.getId());
			flow = wfWorkflowService.save(flow, request);
		}
		map.put("entity", flow);

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
		System.out.println("BaseRoleController del..." + id);
		map.put("IsSuccess", true);
		wfWorkflowService.del(id);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		String order = request.getParameter("order") != null ? request
				.getParameter("order") : "";
		map.put("IsSuccess", true);
		wfWorkflowService.sort(id, order);
		return map;
	}
}
