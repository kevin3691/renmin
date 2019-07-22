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

import com.zzb.comm.entity.CommActivity;
import com.zzb.comm.service.CommActivityService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/comm/activity")
public class CommActivityController extends BaseController {
	@Resource
	private CommActivityService commActivityService;

	/**
	 * 构造函数
	 */
	public CommActivityController() {

	}

	/**
	 * View 列表页(通用活动引用页) index4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	private String index(HttpServletRequest request, ModelMap model) {
		String mode = request.getParameter("mode") != null ? request
				.getParameter("mode").toString() : "RW";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		model.put("mode", mode);
		model.put("category", category);
		model.put("applyTo", applyTo);
		model.put("refNum", String.valueOf(refNum));
		return "/comm/activity/index";
	}

	/**
	 * View 列表页(通用活动引用页) index4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	private String index4(HttpServletRequest request, ModelMap model) {
		String mode = request.getParameter("mode") != null ? request
				.getParameter("mode").toString() : "RW";
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String actSym = request.getParameter("actSym") != null ? request
				.getParameter("actSym").toString() : "";
		model.put("mode", mode);
		model.put("category", category);
		model.put("applyTo", applyTo);
		model.put("refNum", String.valueOf(refNum));
		model.put("actSym", actSym);
		return "/comm/activity/index4";
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
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		CommActivity act = new CommActivity();

		if (id > 0) {
			act = commActivityService.dtl(id);
		} else {
			act.setCategory(category);
			act.setApplyTo(applyTo);
			act.setRefNum(refNum);
		}

		model.addAttribute("o", act);
		return "/comm/activity/edit";
	}

	/**
	 * View 添加、编辑页 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit4")
	public String edit4(HttpServletRequest request, ModelMap model) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String actSym = request.getParameter("actSym") != null ? request
				.getParameter("actSym").toString() : "";
		String mode = request.getParameter("mode") != null ? request
				.getParameter("mode").toString() : "RW";
		CommActivity act = new CommActivity();

		if (id > 0) {
			act = commActivityService.dtl(id);
		} else {
			act.setCategory(category);
			act.setApplyTo(applyTo);
			act.setRefNum(refNum);
			act.setActSym(actSym);
		}
		model.put("actSym", actSym);
		model.put("mode", mode);
		model.addAttribute("o", act);
		return "/comm/activity/edit4";
	}

	/**
	 * 获取列表数据 list
	 * 
	 * @param person
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<CommActivity> list(HttpServletRequest request) {
		QueryResult<CommActivity> rslt = commActivityService.list(request);
		return rslt;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param person
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(CommActivity activity,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		activity = commActivityService.save(activity, request);
		map.put("entity", activity);
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
		commActivityService.del(id);
		return map;
	}

	/**
	 * 
	 * @param request
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/exByRefNumApplyToStts")
	public boolean exByRefNumApplyToStts(HttpServletRequest request,
			ModelMap map) {
		return commActivityService.exByRefNumApplyToStts(request);
	}
	
	/**
	 * 
	 * @param request
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/dtlByPara")
	public CommActivity dtlByPara(HttpServletRequest request,
			ModelMap map) {
		return commActivityService.dtlByPara(request);
	}

}
