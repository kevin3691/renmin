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
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.service.WfInstanceService;

/**
 * 
 * @author 
 * @CreatedAt 2016年04月08日
 */

@Controller
@RequestMapping("/workflow/instance")
public class WfInstanceController extends BaseController {
	@Resource
	private WfInstanceService wfInstanceService;

	/**
	 * 构造函数
	 */
	public WfInstanceController() {

	}

	/**
	 * View 列表页 index4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	public String index4(HttpServletRequest request, ModelMap map) {
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		map.addAttribute("applyTo", applyTo);
		map.addAttribute("refNum", refNum);
		return "/workflow/instance/index4";
	}

	/**
	 * View 执行页 act
	 * 
	 * @return
	 */
	@RequestMapping(value = "/act")
	public String act(ModelMap map) {
		return "/workflow/instance/act";
	}

	/**
	 * View 简单执行页 simpleAct
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleAct")
	public String simpleAct(HttpServletRequest request, ModelMap model) {
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String stepName = request.getParameter("stepName") != null ? request
				.getParameter("stepName") : "";
		String nextStepName = request.getParameter("nextStepName") != null ? request
				.getParameter("nextStepName") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		WfInstance instance = new WfInstance();
		instance.setApplyTo(applyTo);
		instance.setRefNum(refNum);
		instance.setCategory(category);
		instance.setStepName(stepName);
		instance.setNextStepName(nextStepName);
		instance.setTitle(title);
		model.addAttribute("o", instance);
		return "/workflow/instance/simpleAct";
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
	public QueryResult<WfInstance> list(HttpServletRequest request) {
		QueryResult<WfInstance> qr = wfInstanceService.list(request);
		return qr;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param instance
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(WfInstance ins, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		ins = wfInstanceService.save(ins, request);
		map.put("entity", ins);
		return map;
	}

	/**
	 * 执行当前环节方法
	 * 
	 * @param instance
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/actCurStep", method = RequestMethod.POST)
	public Map<String, Object> actCurStep(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfInstance ins = wfInstanceService.actCurStep(request);
		map.put("WfInstance", ins);
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
		wfInstanceService.del(id);
		return map;
	}

}
