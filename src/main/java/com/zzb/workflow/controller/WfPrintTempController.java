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

import com.zzb.base.entity.BaseDict;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfPrintTemp;
import com.zzb.workflow.service.WfPrintTempService;

/**
 * Controller 打印模板
 * 
 * 
 * @CreatedAt 2016年08月01日
 */

@Controller
@RequestMapping("/workflow/printTemp")
public class WfPrintTempController extends BaseController {
	@Resource
	private WfPrintTempService wfPrintTempService;

	/**
	 * 构造函数
	 */
	public WfPrintTempController() {

	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		return "/workflow/printTemp/index";
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
		WfPrintTemp temp = new WfPrintTemp();
		if (id > 0) {
			temp = wfPrintTempService.dtl(id);
		}
		map.addAttribute("o", temp);
		return "/workflow/printTemp/edit";
	}

	/**
	 * View 打印页 print
	 * 
	 * @return
	 */
	@RequestMapping(value = "/print")
	public String print(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		WfPrintTemp temp = new WfPrintTemp();
		if (id > 0) {
			temp = wfPrintTempService.dtl(id);
		}
		map.addAttribute("o", temp);
		return "/workflow/printTemp/print";
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
	public QueryResult<WfPrintTemp> list(HttpServletRequest request) {
		QueryResult<WfPrintTemp> qr = wfPrintTempService.list(request);
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
	public Map<String, Object> save(WfPrintTemp temp, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = wfPrintTempService.checkExist(temp.getId(), temp.getSym());
		if (cnt == 0) {
			temp = wfPrintTempService.save(temp, request);
			map.put("entity", temp);
		} else {
			map.put("error", "该代号已经存在");
		}
		return map;
	}

	/**
	 * 依据参数获取实体
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/dtlBy", method = RequestMethod.POST)
	public Map<String, Object> dtlBy(HttpServletRequest request) {
		String title = request.getParameter("title") != null ? request
				.getParameter("title").toString() : "";
		String sym = request.getParameter("sym") != null ? request
				.getParameter("sym").toString() : "";
		Map<String, Object> map = new HashMap<String, Object>();
		WfPrintTemp temp = wfPrintTempService.dtl(title, sym);
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
		wfPrintTempService.del(id);
		return map;
	}

}
