package com.zzb.workflow.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.zzb.base.entity.BasePerson;
import com.zzb.base.service.BasePersonService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfStep;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfStepService;

/**
 * Contorll 流程图
 * 
 * @author
 * @CreatedAt 2016年08月22日
 */

@Controller
@RequestMapping("/workflow/step")
public class WfStepController extends BaseController {
	@Resource
	private WfStepService wfStepService;

	@Resource
	private BasePersonService basePersonService;

	/**
	 * 构造函数
	 */
	public WfStepController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		return "/workflow/step/index";
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
		int wfWorkflowId = request.getParameter("wfWorkflowId") != null ? Integer
				.valueOf(request.getParameter("wfWorkflowId")) : 0;
		String wfWorkflowTitle = request.getParameter("wfWorkflowTitle") != null ? request
				.getParameter("wfWorkflowTitle") : "";
		WfStep step = new WfStep();
		step.setWfWorkflowId(wfWorkflowId);
		step.setWfWorkflowTitle(wfWorkflowTitle);
		if (id > 0) {
			step = wfStepService.dtl(id);
		}
		map.addAttribute("o", step);
		return "/workflow/step/edit";
	}

	/**
	 * 获取列表数据 list
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<WfStep> list(HttpServletRequest request) {
		QueryResult<WfStep> qr = wfStepService.list(request);
		return qr;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(WfStep step, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		step = wfStepService.save(step, request);
		if (step.getLineNo() == 0) {
			step.setLineNo(step.getId());
			step = wfStepService.save(step, request);
		}
		map.put("entity", step);

		return map;
	}


	@ResponseBody
	@RequestMapping(value = "/saveActor", method = RequestMethod.POST)
	public Map<String, Object> saveActor(int personId, int stepId, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfStep step = wfStepService.dtl(stepId);
		BasePerson person = basePersonService.dtl(personId);
		step.setActorId(person.getId());
		step.setActorName(person.getName());
		step = wfStepService.save(step, request);
		map.put("entity", step);

		return map;
	}

	// 删除
	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		System.out.println("BaseRoleController del..." + id);
		map.put("IsSuccess", true);
		wfStepService.del(id);
		return map;
	}

	// 排序
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		int wfWorkflowId = request.getParameter("wfWorkflowId") != null ? Integer
				.valueOf(request.getParameter("wfWorkflowId")) : 0;
		String order = request.getParameter("order") != null ? request
				.getParameter("order") : "";
		map.put("IsSuccess", true);
		if(wfWorkflowId==0)
		{
			wfStepService.sort(id,order);
		}
		else
		{
			wfStepService.sort(id,wfWorkflowId, order);	
		}
		return map;
	}
}
