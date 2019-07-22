package com.zzb.workflow.controller;

import java.text.SimpleDateFormat;
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
import com.zzb.workflow.entity.WfWorkDay;
import com.zzb.workflow.service.WfWorkDayService;

/**
 * Controller 工作日期
 * 
 * @author 
 * @CreatedAt 2016年09月13日
 */

@Controller
@RequestMapping("/workflow/workDay")
public class WfWorkDayController extends BaseController {
	@Resource
	private WfWorkDayService wfWorkDayService;

	/**
	 * 构造函数
	 */
	public WfWorkDayController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		return "/workflow/workDay/index";
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
		WfWorkDay workDay = new WfWorkDay();
		if (id > 0) {
			workDay = wfWorkDayService.dtl(id);
		}
		map.addAttribute("o", workDay);
		return "/workflow/workDay/edit";
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
	public QueryResult<WfWorkDay> list(HttpServletRequest request) {
		QueryResult<WfWorkDay> qr = wfWorkDayService.list(request);
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
	public Map<String, Object> save(WfWorkDay workDay,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		SimpleDateFormat dateFm = new SimpleDateFormat("EEEE");
		workDay.setWeekDay(dateFm.format(workDay.getWfDate()));
		workDay = wfWorkDayService.save(workDay, request);
		map.put("entity", workDay);
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
		wfWorkDayService.del(id);
		return map;
	}

}
