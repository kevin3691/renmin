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

import com.zzb.comm.entity.CommForm;
import com.zzb.comm.service.CommFormService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/comm/form")
public class CommFormController extends BaseController {
	@Resource
	private CommFormService commFormService;

	/**
	 * 构造函数
	 */
	public CommFormController() {

	}

	/**
	 * View 列表页(通用活动引用页) index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	private String index(HttpServletRequest request, ModelMap model) {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String name = request.getParameter("name") != null ? request
				.getParameter("name").toString() : "";
		model.put("category", category);
		model.put("name", name);
		return "/comm/form/index";
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
		CommForm form = new CommForm();
		if (id > 0) {
			form = commFormService.dtl(id);
		}
		model.addAttribute("o", form);
		return "/comm/form/edit";
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
	public QueryResult<CommForm> list(HttpServletRequest request) {
		QueryResult<CommForm> rslt = commFormService.list(request);
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
	public Map<String, Object> save(CommForm form, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		form = commFormService.save(form, request);
		map.put("entity", form);
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
		commFormService.del(id);
		return map;
	}

}
