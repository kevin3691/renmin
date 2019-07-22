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

import com.zzb.comm.entity.CommFormFiled;
import com.zzb.comm.service.CommFormFiledService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/comm/formFiled")
public class CommFormFiledController extends BaseController {
	@Resource
	private CommFormFiledService commFormFiledService;

	/**
	 * 构造函数
	 */
	public CommFormFiledController() {

	}

	/**
	 * View 列表页(通用活动引用页) index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	private String index(HttpServletRequest request, ModelMap model) {
		String commFormName = request.getParameter("commFormName") != null ? request
				.getParameter("commFormName").toString() : "RW";
		int commFormId = request.getParameter("commFormId") != null ? Integer
				.valueOf(request.getParameter("commFormId")) : 0;		
		model.put("commFormName", commFormName);
		model.put("commFormId", commFormId);
		return "/comm/formFiled/index";
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
		String commFormName = request.getParameter("commFormName") != null ? request
				.getParameter("commFormName").toString() : "";
		int commFormId = request.getParameter("commFormId") != null ? Integer
				.valueOf(request.getParameter("commFormId")) : 0;
		CommFormFiled formFiled = new CommFormFiled();
		if (id > 0) {
			formFiled = commFormFiledService.dtl(id);
		} else {
			formFiled.setCommFormId(commFormId);
			formFiled.setCommFormName(commFormName);
		}
		model.addAttribute("o", formFiled);
		return "/comm/formFiled/edit";
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
	public QueryResult<CommFormFiled> list(HttpServletRequest request) {
		QueryResult<CommFormFiled> rslt = commFormFiledService.list(request);
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
	public Map<String, Object> save(CommFormFiled formFiled,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		formFiled = commFormFiledService.save(formFiled, request);
		map.put("entity", formFiled);
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
		commFormFiledService.del(id);
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
		commFormFiledService.sort(id, order);
		return map;
	}

}
