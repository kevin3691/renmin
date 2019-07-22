/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseUserService;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.WorkPlanListService;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/workplanlist")
public class WorkPlanListController extends BaseController {
	@Resource
	private WorkPlanListService workPlanListService;
	

	@Resource
	private CommAttachmentService commAttachmentService;
	
	@Resource
	private BaseUserService baseUserService;

	
	String mode = "RW";
	String category = "";
	String uploadLabel = "";
	String applyTo = "";
	int refNum = 0;
	String title = "";
	String allowExt = "*.*";
	long allowSize = 1000 * 1024 * 1024L;
	String destDir = "upload/workplanlist/";
	
	/**
	 * 构造函数
	 */
	public WorkPlanListController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	//@RequiresPermissions("DOCUMENT:RO")
	public String index(ModelMap map) {

		return "/workplanlist/index";
	}



	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	//@RequiresPermissions("DOCUMENT:RW")
	public String edit(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;

		WorkPlanList workPlanList = new WorkPlanList();
		if (id > 0) {
			workPlanList = workPlanListService.dtl(id);
		}
		model.addAttribute("o", workPlanList);
		String url = "/workplanlist/edit";
		return url;
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
	public QueryResult<WorkPlanList> list(HttpServletRequest request) {
		QueryResult<WorkPlanList> rslt = workPlanListService.list(request);

		return rslt;
	}


	@ResponseBody
	@RequestMapping(value = "/list4sel")
	public QueryResult<WorkPlanList> list4sel(HttpServletRequest request) {
		QueryResult<WorkPlanList> rslt = workPlanListService.list4sel(request);

		return rslt;
	}


	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(WorkPlanList doc, CashList cashList, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		doc.setMakeday(new Date());
		doc = workPlanListService.save(doc, request);

		map.put("entity", doc);
		//map.put("ins", ins);
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
		workPlanListService.del(id);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/dtl", method = RequestMethod.POST)
	public Map<String, Object> dtl(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		WorkPlanList plan = workPlanListService.dtl(id);
		map.put("entity", plan);

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
		workPlanListService.sort(id, order);
		return map;
	}



	/**
	 * 接收并设置参数
	 *
	 * @param request
	 * @param
	 */
	public void setPara(HttpServletRequest request, ModelMap model) {
		mode = request.getParameter("mode") != null ? request.getParameter(
				"mode").toString() : mode;
		category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : category;
		uploadLabel = request.getParameter("uploadLabel") != null ? request
				.getParameter("uploadLabel").toString() : "";
		applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : applyTo;
		refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : refNum;
		title = request.getParameter("title") != null ? request.getParameter(
				"title").toString() : title;
		allowExt = request.getParameter("allowExt") != null ? request
				.getParameter("allowExt").toString() : allowExt;
		allowSize = request.getParameter("allowSize") != null ? Long
				.valueOf(request.getParameter("allowSize")) : allowSize;
		destDir = request.getParameter("destDir") != null
				&& request.getParameter("destDir") != "" ? request
				.getParameter("destDir").toString() : destDir;
		model.put("mode", mode);
		model.put("category", category);
		model.put("uploadLabel", uploadLabel);
		model.put("applyTo", applyTo);
		model.put("refNum", String.valueOf(refNum));
		model.put("allowExt", allowExt);
		model.put("allowSize", String.valueOf(allowSize));
		model.put("destDir", destDir);
	}
}
