package com.zzb.cms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.cms.entity.SurveyTopics;
import com.zzb.cms.service.SurveyTopicsService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

/**
 * 
 * @author
 * 调查主题Controller
 */
@Controller
@RequestMapping("/cms/surveyTopics")
public class SurveyTopicsController extends BaseController {
	@Resource
	private SurveyTopicsService surveyTopicsService;

	/**
	 * 构造函数
	 */
	public SurveyTopicsController() {
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, ModelMap map) {
		return "/cms/surveyTopics/index";
	}
	
	/**
	 * View 添加、编辑页 edit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap map) {
		int id = request.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 0;
		SurveyTopics surveyTopics = new SurveyTopics();
		if (id > 0) {
			surveyTopics = surveyTopicsService.dtl(id);
		}
		map.addAttribute("o", surveyTopics);
		return "/cms/surveyTopics/edit";
	}


	/**
	 * 获取列表数据 list
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<SurveyTopics> list(SurveyTopics surveyTopics, HttpServletRequest request) {
		return surveyTopicsService.list(request);
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(SurveyTopics surveyTopics, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		surveyTopics = surveyTopicsService.save(surveyTopics, request);
		map.put("entity", surveyTopics);
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
		surveyTopicsService.del(id);
		return map;
	}
	/**
	 * sel页：使用的是jqgrid
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sel")
	public String sel(HttpServletRequest request, ModelMap map) {
		return "/cms/surveyTopics/sel";
	}
	/**
	 * list4页，使用的是ztree
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list4")
	public String list4(HttpServletRequest request, ModelMap map) {
		return "/cms/surveyTopics/list4";
	}
	/**
	 * 获取调查主题ztree的json
	 */
	@ResponseBody
	@RequestMapping("/ztreeList")
	public List<Map<String,Object>> listEnterprise(HttpServletRequest request)
	{
		QueryResult<SurveyTopics> list = surveyTopicsService.list(request);
		List<SurveyTopics> rows = list.getRows();
		List<Map<String,Object>> listMap = new ArrayList<Map<String,Object>>();
		Map<String,Object> map;
		for (SurveyTopics i : rows)
		{
			map = new HashMap<String, Object>();
			map.put("pId", 0);
			map.put("id", i.getId());
			map.put("name", i.getTopicTitle());
			listMap.add(map);
		}
		
		return listMap;
	}
}