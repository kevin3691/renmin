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
import com.zzb.workflow.entity.WfPrintHistory;
import com.zzb.workflow.service.WfPrintHistoryService;

/**
 * Controller 打印记录
 * 
 * 
 * @CreatedAt 2016年08月01日
 */

@Controller
@RequestMapping("/workflow/printHistory")
public class WfPrintHistoryController extends BaseController {
	@Resource
	private WfPrintHistoryService wfPrintHistoryService;

	/**
	 * 构造函数
	 */
	public WfPrintHistoryController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		return "/workflow/printHistory/index";
	}

	/**
	 * View 列表页 index4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	public String index4(HttpServletRequest request, ModelMap map) {
		return "/workflow/printHistory/index4";
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
		WfPrintHistory temp = new WfPrintHistory();
		if (id > 0) {
			temp = wfPrintHistoryService.dtl(id);
		}
		map.addAttribute("o", temp);
		return "/workflow/printHistory/edit";
	}

	/**
	 * View 打印页 print
	 * 
	 * @return
	 */
	@RequestMapping(value = "/print")
	public String print(HttpServletRequest request, ModelMap map) {
		setPara(request, map);
		Object obj = wfPrintHistoryService.dtl(request);
		map.addAttribute("o", obj);
		return "/workflow/printHistory/print";
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
	public QueryResult<WfPrintHistory> list(HttpServletRequest request) {
		QueryResult<WfPrintHistory> qr = wfPrintHistoryService.list(request);
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
	public Map<String, Object> save(WfPrintHistory temp,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		temp = wfPrintHistoryService.save(temp, request);
		map.put("entity", temp);
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
		wfPrintHistoryService.del(id);
		return map;
	}

	/**
	 * 保存数据方法
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/genHistory", method = RequestMethod.POST)
	public Map<String, Object> genHistory(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		WfPrintHistory history = wfPrintHistoryService.genHistory(request);
		map.put("entity", history);
		return map;
	}

	/**
	 * 接收并设置参数
	 * 
	 * @param request
	 * @param map
	 */
	public void setPara(HttpServletRequest request, ModelMap map) {
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title") : "";
		map.addAttribute("applyTo", applyTo);
		map.addAttribute("refNum", refNum);
		map.addAttribute("category", category);
		map.addAttribute("title", title);
	}

}
